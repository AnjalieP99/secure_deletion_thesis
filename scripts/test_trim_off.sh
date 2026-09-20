#!/bin/bash
# MINI TEST - Quick verification of all phases
# Tests only 50% fill with 3 iterations

echo "======================================================"
echo "Main Experiment - Latency and Recovery Time Analysis"
echo "======================================================"

# ============================================
# PHASE 1: wipe drive
# ============================================

TEST_DEVICE="/dev/sda"
MOUNT_POINT="/mnt/test_ssd"

echo ""
echo "=== PHASE 1: Wipe Drive ==="
echo "WARNING: This will erase ALL data on $TEST_DEVICE"
read -p "Type 'y' to continue: " confirm

if [ "$confirm" != "y" ]; then
    echo "Aborted."
    exit 1
fi


sudo umount $MOUNT_POINT 2>/dev/null
echo "Overwriting $TEST_DEVICE with zeros..."
sudo dd if=/dev/zero of=$TEST_DEVICE bs=1M count=100 status=progress

echo "Creating partition table..."
sudo parted -s $TEST_DEVICE mklabel gpt
sudo parted -s $TEST_DEVICE mkpart primary ext4 0% 100%
sudo mkfs.ext4 -F ${TEST_DEVICE}1

sudo mkdir -p $MOUNT_POINT
sudo mount -o nodiscard ${TEST_DEVICE}1 $MOUNT_POINT
sudo chmod 777 $MOUNT_POINT
echo "Wipe complete"


# ============================================
# SIMPLE CONFIGURATION
# ============================================

LOG_DIR="$HOME/trim_experiment/logs_nvme_trim_off"
TEST_DIR="$MOUNT_POINT/test_data"
FILLER_DIR="$MOUNT_POINT/filler_data"

echo "Input Fill Level:"
read -p "Fill level (%): " FILL_LEVEL_INPUT

# test parameters
FILL_LEVEL=$FILL_LEVEL_INPUT                 # Only test 50% fill
TEST_DATA_SIZE_MB=5000            # 5GB test data

RECOVERY_WAITS=(0 5 15 30)            # Only 0 and 5 minutes
ITERATIONS=${#RECOVERY_WAITS[@]}

echo ""
echo "Configuration:"
echo "  Fill level: ${FILL_LEVEL}%"
echo "  Test data: ${TEST_DATA_SIZE_MB}MB"
echo "  Recovery waits: ${RECOVERY_WAITS[@]} minutes"
echo "  Total iterations: ${ITERATIONS}"
echo ""

mkdir -p $LOG_DIR
sudo mkdir -p $TEST_DIR $FILLER_DIR 


# ============================================
# PHASE 2: Fill Drive to 50%
# ============================================

echo ""
echo "=== PHASE 2: Fill Drive to ${FILL_LEVEL}% ==="

# Calculate how much to fill
TOTAL_KB=$(df --output=size "$MOUNT_POINT" | tail -1)
USED_KB=$(df --output=used "$MOUNT_POINT" | tail -1)
TARGET_KB=$((TOTAL_KB * FILL_LEVEL / 100))
FILL_KB=$((TARGET_KB - USED_KB))

echo "Need to write $((FILL_KB / 1024)) MB to reach ${FILL_LEVEL}%"

# Create filler files
written_kb=0
file_count=0
while [ $written_kb -lt $FILL_KB ]; do
    file_name="$FILLER_DIR/filler_$(printf "%04d" $file_count).dat"
    this_size=$((FILL_KB - written_kb))
    if [ $this_size -gt $((1024 * 100)) ]; then  # 100MB chunks
        this_size=$((1024 * 100))
    fi
    
    sudo dd if=/dev/urandom of="$file_name" bs=1K count=$this_size status=none
    written_kb=$((written_kb + this_size))
    file_count=$((file_count + 1))
    
    echo -ne "\r  Progress: $((written_kb * 100 / FILL_KB))%"
done
echo ""
echo "✓ Created $file_count filler files"

# Check actual fill level
NEW_USED=$(df --output=used "$MOUNT_POINT" | tail -1)
NEW_PERCENT=$((NEW_USED * 100 / TOTAL_KB))
echo "✓ Actual fill level: ${NEW_PERCENT}%"

# ============================================
# MAIN EXPERIMENT LOOP - Each iteration tests complete cycle
# ============================================

echo ""
echo "=== PHASE 3-6: MAIN EXPERIMENT ($ITERATIONS iterations) ==="
echo "Each iteration: Create → Delete → TRIM → Recover"
echo ""

# Initialize results files
if [ ! -f "$LOG_DIR/experiment_results.csv" ]; then
    echo "run_timestamp,iteration,wait_minutes,fill_level,recovered_files" > $LOG_DIR/experiment_results.csv
fi

# Main loop - one iteration per recovery wait time
for ITER in $(seq 1 $ITERATIONS); do
    # Get the wait time for THIS iteration (0-indexed array)
    WAIT_INDEX=$((ITER - 1))
    CURRENT_WAIT=${RECOVERY_WAITS[$WAIT_INDEX]}
    
    echo "=========================================="
    echo "ITERATION $ITER of $ITERATIONS - Wait: ${CURRENT_WAIT} minutes"
    echo "=========================================="
    
# ============================================
# PHASE 3: Create Test Data
# ============================================

echo ""
echo "=== [ITER $ITER - PHASE 3]: Create Test Data ==="

# Create UNIQUE test data for THIS iteration
UNIQUE_ID=$(openssl rand -hex 8)
ITER_TEST_DIR="$TEST_DIR/TEST_DATA_${ITER}_${UNIQUE_ID}"
sudo mkdir -p "$ITER_TEST_DIR"

echo "Creating dataset in: $ITER_TEST_DIR"
echo ""

# ============================================
# FILE 1: Small text file
# ============================================

echo "Creating small text file..."

{
    echo "UNIQUE_SIGNATURE_DS${ITER}_SMALL"
    for i in {1..50}; do
        echo "UNIQUE_SIGNATURE_DS${ITER}_SMALL"
    done
} | sudo tee "$ITER_TEST_DIR/small.txt" > /dev/null

echo "✓ small.txt created"


# ============================================
# FILE 2: Medium text file
# ============================================

echo "Creating medium text file..."

{
    echo "UNIQUE_SIGNATURE_DS${ITER}_MEDIUM"
    for i in {1..5000}; do
        echo "UNIQUE_SIGNATURE_DS${ITER}_MEDIUM"
    done
} | sudo tee "$ITER_TEST_DIR/medium.txt" > /dev/null
echo "✓ medium.txt created"


# ============================================
# FILE 3: LARGE VALID ZIP FILE
# ============================================

echo ""
echo "Creating large ZIP dataset (~2.5 GiB)..."


    TEMP_FILE="$ITER_TEST_DIR/.temporary_data.bin"
    ZIP_FILE="$ITER_TEST_DIR/large_archive.zip"

    sudo dd if=/dev/urandom \
        of="$TEMP_FILE" \
        bs=1M \
        count=2560 \
        status=progress

  
    echo "UNIQUE_SIGNATURE_DS${ITER}_LARGE" | \
        sudo tee -a "$TEMP_FILE" > /dev/null

    sudo zip -0 -q "$ZIP_FILE" "$TEMP_FILE"

    # Remove the temporary uncompressed file.
    sudo rm -f "$TEMP_FILE"


echo ""
echo "✓ Created large ZIP archive"

# ============================================
# FILE 4: VALID JPEG IMAGE
# ============================================

echo ""
echo "Creating JPEG file..."

# Minimal valid 1x1 JPEG image.
JPEG_BASE64="/9j/4AAQSkZJRgABAQAAAQABAAD/2wBDAP//////////////////////////////////////////////////////////////////////////////////////2wBDAf//////////////////////////////////////////////////////////////////////////////////////wAARCAABAAEDASIAAhEBAxEB/8QAFQABAQAAAAAAAAAAAAAAAAAAAAX/xAAUEAEAAAAAAAAAAAAAAAAAAAAA/9oADAMBAAIQAxAAAAH/AP/EABQQAQAAAAAAAAAAAAAAAAAAACD/2gAIAQEAAT8Af//EABQRAQAAAAAAAAAAAAAAAAAAABD/2gAIAQIBAT8Af//EABQRAQAAAAAAAAAAAAAAAAAAABD/2gAIAQMBAT8Af//Z"

echo "$JPEG_BASE64" | base64 -d | sudo tee "$ITER_TEST_DIR/image.jpg" > /dev/null

# Add a dataset-specific text signature after the JPEG.
# This does not affect the JPEG header and gives us a searchable
# experiment-specific marker.
echo "UNIQUE_SIGNATURE_DS${ITER}_IMAGE" | \
    sudo tee -a "$ITER_TEST_DIR/image.jpg" > /dev/null

echo "✓ image.jpg created"


# ============================================
# FILE 5: VALID PDF
# ============================================

echo ""
echo "Creating PDF file..."

sudo bash -c "cat > '$ITER_TEST_DIR/document.pdf' << ENDPDF
%PDF-1.4
1 0 obj
<< /Type /Catalog /Pages 2 0 R >>
endobj
2 0 obj
<< /Type /Pages /Kids [3 0 R] /Count 1 >>
endobj
3 0 obj
<< /Type /Page /Parent 2 0 R /MediaBox [0 0 612 792] /Contents 4 0 R >>
endobj
4 0 obj
<< /Length 120 >>
stream
BT
/F1 24 Tf
100 700 Td
(UNIQUE_SIGNATURE_DS${ITER}_PDF) Tj
0 -40 Td
(Experimental secure deletion dataset) Tj
ET
endstream
endobj
xref
0 5
0000000000 65535 f
0000000009 00000 n
0000000058 00000 n
0000000115 00000 n
0000000210 00000 n
trailer
<< /Size 5 /Root 1 0 R >>
startxref
380
%%EOF
ENDPDF"

echo "✓ document.pdf created"

# ============================================
# FILE 6: CHECKSUMS
# ============================================

echo ""
echo "Computing MD5 checksums..."

sudo bash -c "find '$ITER_TEST_DIR' -maxdepth 1 -type f \
    ! -name 'checksums_${ITER}.md5' \
    -exec md5sum {} \; | sort > '$ITER_TEST_DIR/checksums_${ITER}.md5'"

echo "✓ MD5 checksums saved"

# ============================================
# DATASET SIZE / FILE COUNT
# ============================================

FILE_COUNT=$(sudo find "$ITER_TEST_DIR" -type f | wc -l)
DATASET_SIZE=$(sudo du -sh "$ITER_TEST_DIR" | cut -f1)

echo ""
echo "=========================================="
echo "✓ DATASET ${ITER} CREATED"
echo "=========================================="
echo "Location:     $ITER_TEST_DIR"
echo "Dataset size: $DATASET_SIZE"
echo "File count:   $FILE_COUNT"
echo "=========================================="

# ============================================
# PHASE 4: Delete Test Data
# ============================================

echo ""
echo "=== [ITER $ITER - PHASE 4]: Delete Test Data ==="

BEFORE=$(find "$ITER_TEST_DIR" -type f | wc -l)
echo "Deleting $BEFORE test files..."
sudo rm -rf "$ITER_TEST_DIR"/*
sync
sleep 5
echo "✓ Test data deleted"



# ============================================
# PHASE 6: Attempt Recovery at CURRENT_WAIT
# ============================================

echo ""
echo "=== [ITER $ITER - PHASE 6]: Recovery Attempts ==="
echo "  Waiting ${CURRENT_WAIT} minutes before recovery..."


    # Wait the specified time
    if [ $CURRENT_WAIT -gt 0 ]; then
        echo "    Waiting ${CURRENT_WAIT} minutes..."
        sleep $((CURRENT_WAIT * 60))
    fi
    
    # Try recovery with foremost
    RECOVERY_DIR="$LOG_DIR/recovered_${FILL_LEVEL}_iter${ITER}_${CURRENT_WAIT}min"
    mkdir -p "$RECOVERY_DIR"
    
    # Use foremost to recover deleted files (quick)
    echo "    Running foremost analysis..."
    sudo foremost -i /dev/sda1 -o "$RECOVERY_DIR" -t all 
    
    # Count recovered files (simplified - check if any files appear)
    RECOVERED=0
    if [ -d "$RECOVERY_DIR" ]; then
        RECOVERED=$(find "$RECOVERY_DIR" -type f ! -name "audit.txt" 2>/dev/null | wc -l)
    fi
    
    echo "    Recovered: $RECOVERED files"
    
# Capture timestamp for this run
    RUN_TIMESTAMP=$(date +%Y%m%d_%H%M%S)


echo "$RUN_TIMESTAMP,$ITER,$CURRENT_WAIT,$FILL_LEVEL,$RECOVERED" >> $LOG_DIR/experiment_results.csv


    echo ""
    echo "✓ Iteration $ITER complete (waited ${CURRENT_WAIT} minutes)"
    echo "---"
    
    # Small delay between iterations
    sleep 2
done

# ============================================
# PHASE 7: Quick Summary
# ============================================

echo ""
echo "=========================================="
echo "EXPERIMENT COMPLETE!"
echo "=========================================="

echo ""
echo "RESULTS SUMMARY:"
echo "----------------"
cat $LOG_DIR/experiment_results.csv

echo ""
echo "=========================================="
echo "✓ Results saved to: $LOG_DIR/experiment_results.csv"
echo ""
echo "To analyze results, run:"
echo "  python3 analyze_results.py"
echo "=========================================="
