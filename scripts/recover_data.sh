#!/bin/bash

DEVICE=$1
OUTPUT_DIR=$2

mkdir -p $OUTPUT_DIR

echo "=== Starting Recovery on $DEVICE ==="
echo "Results will be saved to $OUTPUT_DIR"

# Method 1: Search for unique signatures using grep
echo "Searching for unique signatures..."
for i in {1..16}; do
    echo "Searching for Dataset $i..."
    sudo grep -a "UNIQUE_SIGNATURE_DS${i}" $DEVICE > ${OUTPUT_DIR}/signature_ds${i}.txt 2>/dev/null
    COUNT=$(wc -l < ${OUTPUT_DIR}/signature_ds${i}.txt)
    echo "Found $COUNT matches for Dataset $i"
done

# Method 2: Create full image (if you have space)
echo "Creating full device image (this takes time)..."
sudo dd if=$DEVICE of=${OUTPUT_DIR}/full_image.img bs=4M status=progress

# Method 3: Search in the image file
echo "Searching in the image file..."
for i in {1..16}; do
    grep -a "UNIQUE_SIGNATURE_DS${i}" ${OUTPUT_DIR}/full_image.img > ${OUTPUT_DIR}/image_signature_ds${i}.txt 2>/dev/null
done

# Method 4: Check for file metadata
echo "Looking for folder names..."
sudo grep -a "TEST_DATA_" $DEVICE > ${OUTPUT_DIR}/folder_names.txt 2>/dev/null

echo "=== Recovery Complete ==="
