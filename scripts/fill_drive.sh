#!/bin/bash

# ============================================
# SSD Filler Data Creator
# Usage: ./fill_drive.sh 25|50|75|100
# ============================================

MOUNT_POINT="/mnt/ssd_test"
TARGET=$1

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

# Check arguments
if [ -z "$TARGET" ] || [[ ! "$TARGET" =~ ^(25|50|75|100)$ ]]; then
    echo -e "${RED}Usage: ./fill_drive.sh [25|50|75|100]${NC}"
    exit 1
fi

# Check mount
if ! mount | grep -q ${MOUNT_POINT}; then
    echo -e "${RED}Error: ${MOUNT_POINT} not mounted${NC}"
    exit 1
fi

echo -e "${GREEN}=== Filling SSD to ${TARGET}% ===${NC}"
echo "Started at: $(date)"
echo ""

# Function: Create filler chunk
make_filler() {
    local num=$1
    local folder="FILLER_${num}"
    sudo mkdir -p "${MOUNT_POINT}/${folder}"
    sudo dd if=/dev/urandom of="${MOUNT_POINT}/${folder}/data.bin" bs=1M count=50 status=none
    sudo bash -c "echo 'FILLER_${num}' >> ${MOUNT_POINT}/${folder}/data.bin"
}

# Get current fill
get_fill() {
    df -h ${MOUNT_POINT} | tail -1 | awk '{print $5}' | sed 's/%//'
}

# Main loop
count=1
while true; do
    current=$(get_fill)
    
    # Check if target reached
    if [ $current -ge $TARGET ]; then
        echo -e "\n${GREEN}✅ Target ${TARGET}% reached! Current: ${current}%${NC}"
        break
    fi
    
    # Create filler
    make_filler $count
    
    # Progress update every 10 files
    if [ $((count % 10)) -eq 0 ]; then
        echo -e "${YELLOW}Created ${count} filler files... Current usage: ${current}%${NC}"
        df -h ${MOUNT_POINT}
    fi
    
    count=$((count + 1))
    
    # Safety limit
    if [ $count -gt 200 ]; then
        echo -e "${RED}Safety limit reached (200 files)${NC}"
        break
    fi
done

# Summary
echo ""
echo -e "${GREEN}=== SUMMARY ===${NC}"
echo "Target: ${TARGET}%"
echo "Current: $(get_fill)%"
echo "Filler files created: $((count - 1))"
echo "Location: ${MOUNT_POINT}/FILLER_*"
echo "Finished at: $(date)"
