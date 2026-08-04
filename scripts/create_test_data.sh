#!/bin/bash

MOUNT_POINT=$1
DATASET_NUM=$2
UNIQUE_ID=$(openssl rand -hex 8)

FOLDER_NAME="TEST_DATA_${DATASET_NUM}_${UNIQUE_ID}"
mkdir -p "${MOUNT_POINT}/${FOLDER_NAME}"

# File 1: Small text file
cat > "${MOUNT_POINT}/${FOLDER_NAME}/small.txt" << ENDTEXT
UNIQUE_SIGNATURE_DS${DATASET_NUM}_SMALL
$(for i in {1..50}; do echo "UNIQUE_SIGNATURE_DS${DATASET_NUM}_SMALL"; done)
ENDTEXT

# File 2: Medium text file
cat > "${MOUNT_POINT}/${FOLDER_NAME}/medium.txt" << ENDTEXT
UNIQUE_SIGNATURE_DS${DATASET_NUM}_MEDIUM
$(for i in {1..5000}; do echo "UNIQUE_SIGNATURE_DS${DATASET_NUM}_MEDIUM"; done)
ENDTEXT

# File 3: Large file (10MB)
dd if=/dev/urandom of="${MOUNT_POINT}/${FOLDER_NAME}/large.bin" bs=1M count=10 status=none
echo "UNIQUE_SIGNATURE_DS${DATASET_NUM}_LARGE" >> "${MOUNT_POINT}/${FOLDER_NAME}/large.bin"

# File 4: Many small files
for i in {1..500}; do
    echo "UNIQUE_SIGNATURE_DS${DATASET_NUM}_SMALL_${i}" > "${MOUNT_POINT}/${FOLDER_NAME}/tiny_${i}.txt"
done

# File 5: Different file types
dd if=/dev/urandom of="${MOUNT_POINT}/${FOLDER_NAME}/image.jpg" bs=1K count=50 status=none
dd if=/dev/urandom of="${MOUNT_POINT}/${FOLDER_NAME}/document.pdf" bs=1K count=30 status=none

# Create checksum file for verification
md5sum "${MOUNT_POINT}/${FOLDER_NAME}"/* > "${MOUNT_POINT}/${FOLDER_NAME}/checksums_${DATASET_NUM}.md5"

echo "Created dataset $DATASET_NUM in ${MOUNT_POINT}/${FOLDER_NAME}"
