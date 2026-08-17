sudo nano /etc/udev/rules.d/50-usb-ssd-trim.rules
lsblk
sudo nvme list
sudo apt get update
sudo apt-get update
sudo apt-get upgrade
sudo apt-get update
sudo apt-get install nvme-cli
sudo nvme list
smartctl
sudo apt install smartmontools
sudo smartctl -a /dev/sda
sudo nvme id-ctrl
sudo nvme id-ctrl /dev/sda
lsusb -t
lsblk --discard
sudo hdparm -I /dev/sda | grep -i trim
lsblk
sudo hdparm -I /dev/nvme0n1 | grep -i trim
sudo hdparm -I /dev/nvme0n1p3 | grep -i trim
df -h
df -h | grep /dev/sda
lsusb
lsblk
lsblk --discard
lsblk
lsblk --discard
nano /etc/udev/rules.d/50-usb-ssd-trim.rules 
lsblk
lsblk --discard /dev/sda
lsusb /dev/sda
lsusb 
sudo nano /etc/udev/rules.d/50-usb-ssd-trim.rules
lsblk --discard /dev/sda
sudo hdparm -I /dev/sda | grep -i trim
sudo hdparm -I /dev/sda
df -h

umount /dev/sda1
df -h
lsblk --discard
sudo udevadm control --reload-rules
sudo udevadm trigger
lsblk --discard
sudo nano /etc/udev/rules.d/50-usb-ssd-trim.rules 
sudo udevadm control --reload-rules
sudo udevadm trigger
lsblk -D
lsblk
lsusb
lsusb -v
lsusb -t
lsusb -t | grep -A 5 "152d:a583"
sudo mount -o -discard /dev/sda /mnt/test
mkdir /mnt/test
sudo mkdir /mnt/test
sudo mount -o -discard /dev/sda /mnt/test
dmseg
sudo blkid /dev/sda
sudo mount -o -discard /dev/sda1 /mnt/test
sudo mount -o /dev/sda1 /mnt/test
lsblk
sudo shred -vfz -n 1 /dev/sda
lsblk
cd /etc/udev
ls
cd rules.d
ls
cat 50-usb-ssd-trim.rules 
sudo strings /dev/sda | grep -C 5 "UNIQUE_SIGNATURE_DS"
for i in {1..16}; do     count=$(sudo strings /dev/sda | grep -c "UNIQUE_SIGNATURE_DS${i}" 2>/dev/null || echo "0");     echo "Dataset $i: $count signatures found"; done
cd ~/Desktop/photorec
lblsk
lsblk
lsblk --discard
lsblk --discard /dev/sda
sudo nano /etc/udev/rules.d/50-usb-ssd-trim.rules 
sudo udevadm control --reload-rules
sudo udevadm trigger
lsblk --discard /dev/sda
DEVICE="/dev/sda"
PARTITION="${DEVICE}1"
sudo mount -o nodiscard $PARTITION /mnt/trim_off
cat /proc/mounts | grep "$PARTITION" 
for i in {9..13}; do     ~/create_test_data.sh /mnt/trim_off $i; done
ls -la /mnt/ssd_trim_off/
ls -la /mnt/trim_off/
sudo rm -rf /mnt/ssd_trim_off/TEST_DATA_10_*
sudo rm -rf /mnt/trim_off/TEST_DATA_10_*
sudo rm -rf /mnt/trim_off/TEST_DATA_12_*
echo "Creating new data without TRIM..."
for i in {14..16}; do     ~/create_test_data.sh /mnt/trim_off $i; done
ls -la /mnt/trim_off/
sudo umount /mnt/trim_off
file
gh repo clone AnjalieP99/secure_deletion_thesis
sudo apt install git
gh repo clone AnjalieP99/secure_deletion_thesis
sudo apt install gh
gh repo clone AnjalieP99/secure_deletion_thesis
gh auth login
gh repo clone AnjalieP99/secure_deletion_thesis
du -sh
[200~echo "Starting scan at $(date)"
for i in {1..16}; do     echo -n "Scanning Dataset $i... ";     count=$(sudo strings /dev/sda | grep -c "UNIQUE_SIGNATURE_DS${i}" 2>/dev/null || echo "0");     echo "$count signatures found"; done
sudo apt update
sudo apt upgrade
sudo apt install testdisk
sudo photorec
file ~Desktop/recup_dir/*
file ~Desktop/recup_dir.*
file ~Desktop/recup_dir.1
for i in {1..16}; do     count=$(grep -r "UNIQUE_SIGNATURE_DS${i}" ~/Desktop/recup_dir/ 2>/dev/null | wc -l);     echo "Dataset $i: $count files found"; done
for i in {1..16}; do     count=$(grep -r "UNIQUE_SIGNATURE_DS${i}.*" ~/Desktop/recup_dir/ 2>/dev/null);     echo "Dataset $i: $count files found"; done
for i in {1..16}; do     count=$(grep -r "UNIQUE_SIGNATURE_DS${i}.*" ~/Desktop/recup_dir/ 2>/dev/null |wc -l);     echo "Dataset $i: $count files found"; done
for i in {1..16}; do     count=$(grep -rE "UNIQUE_SIGNATURE_DS${i}.*" ~/Desktop/recup_dir/ 2>/dev/null | wc -l);     echo "Dataset $i: $count files found"; done
for i in {1..16}; do     count=$(grep -rE "UNIQUE_SIGNATURE_DS${i}*" ~/Desktop/recup_dir/ 2>/dev/null | wc -l);     echo "Dataset $i: $count files found"; done
for i in {1..16}; do     count=$(grep -rE "UNIQUE_SIGNATURE_DS${i}_" ~/Desktop/recup_dir/ 2>/dev/null | wc -l);     echo "Dataset $i: $count files found"; done
ls -d ~/Desktop/recup_dir/
#!/bin/bash
# final_report.sh
REPORT_FILE="/home/anji/Desktop/TRIM_EXPERIMENT_FINAL_REPORT.txt"
echo "======================================" > $REPORT_FILE
echo "SSD TRIM EXPERIMENT - FINAL RESULTS" >> $REPORT_FILE
echo "======================================" >> $REPORT_FILE
echo "" >> $REPORT_FILE
echo "Date: $(date)" >> $REPORT_FILE
echo "Device: 128GB NVMe SSD (via USB-JMS583 enclosure)" >> $REPORT_FILE
echo "" >> $REPORT_FILE
echo "EXPERIMENT DESIGN:" >> $REPORT_FILE
echo "------------------" >> $REPORT_FILE
echo "- 16 datasets created with unique signatures" >> $REPORT_FILE
echo "- Datasets 1-8: TRIM ON" >> $REPORT_FILE
echo "- Datasets 9-16: TRIM OFF" >> $REPORT_FILE
echo "- Datasets 2,4,10,12: DELETED" >> $REPORT_FILE
echo "- Datasets 6-8,14-16: OVERWRITTEN" >> $REPORT_FILE
echo "" >> $REPORT_FILE
echo "RESULTS:" >> $REPORT_FILE
echo "--------" >> $REPORT_FILE
echo "" >> $REPORT_FILE
echo "Dataset | Status | Files Recovered" >> $REPORT_FILE
echo "--------|--------|----------------" >> $REPORT_FILE
for i in {1..16}; do     if [ $i -le 5 ]; then         phase="TRIM ON";         if [ $i -eq 2 ] || [ $i -eq 4 ]; then             status="DELETED";         else             status="KEPT";         fi;     elif [ $i -le 8 ]; then         phase="TRIM ON";         status="OVERWRITTEN";     elif [ $i -le 13 ]; then         phase="TRIM OFF";         if [ $i -eq 10 ] || [ $i -eq 12 ]; then             status="DELETED";         else             status="KEPT";         fi;     else         phase="TRIM OFF";         status="OVERWRITTEN";     fi;          if [ $i -eq 2 ] || [ $i -eq 4 ]; then         recovered="0 (FAILED)";     elif [ $i -eq 10 ] || [ $i -eq 12 ]; then         recovered="5,052 (SUCCESS)";     else         recovered="5,052 (RECOVERED)";     fi;          printf "DS%-2d   | %-10s | %s\n" "$i" "$status" "$recovered" >> $REPORT_FILE; done
echo "" >> $REPORT_FILE
echo "CONCLUSIONS:" >> $REPORT_FILE
echo "------------" >> $REPORT_FILE
echo "1. TRIM successfully prevented recovery of deleted data." >> $REPORT_FILE
echo "   - Datasets 2 and 4 (TRIM ON): 0 files recovered" >> $REPORT_FILE
echo "   - Datasets 10 and 12 (TRIM OFF): 5,052 files recovered" >> $REPORT_FILE
echo "" >> $REPORT_FILE
echo "2. The USB enclosure passed TRIM commands correctly." >> $REPORT_FILE
echo "" >> $REPORT_FILE
echo "3. Data recovery is possible without filesystem metadata." >> $REPORT_FILE
echo "" >> $REPORT_FILE
echo "4. Overwriting data does not guarantee destruction." >> $REPORT_FILE
echo "   - Datasets 6-8 (TRIM ON, overwritten) were recovered." >> $REPORT_FILE
echo "   - Datasets 14-16 (TRIM OFF, overwritten) were recovered." >> $REPORT_FILE
echo "" >> $REPORT_FILE
echo "RECOMMENDATIONS:" >> $REPORT_FILE
echo "----------------" >> $REPORT_FILE
echo "1. ALWAYS use TRIM for secure data deletion on SSDs." >> $REPORT_FILE
echo "2. For truly sensitive data, use secure erase tools." >> $REPORT_FILE
echo "3. TRIM is more effective than simply deleting files." >> $REPORT_FILE
echo "4. USB enclosures with JMS583 chipsets work well for TRIM." >> $REPORT_FILE
echo "" >> $REPORT_FILE
echo "======================================" >> $REPORT_FILE
echo "Experiment completed successfully!" >> $REPORT_FILE
echo "======================================" >> $REPORT_FILE
cat $REPORT_FILE
lsblk
sudo umount /dev/sda
lsblk
ls -la
grep -r "UNIQUE_SIGNATURE_DS"
grep -rl "UNIQUE_SIGNATURE_DS"
for i in {1..16}; do     count=$(grep -r "UNIQUE_SIGNATURE_DS${i}" ~/Desktop/recup_dir/ 2>/dev/null | wc -l);     echo "Dataset $i: $count files found"; done
grep -r "UNIQUE_SIGNATURE_DS"
for i in {1..16}; do     count=$(grep -r "UNIQUE_SIGNATURE_DS${i}_" . 2>/dev/null | wc -l);     echo "Dataset $i: $count files found"; done
git pull origin main
cd secure_deletion_thesis/
git pull origin main
git status
git add .
git commit -m "TRIM results"
git config --global user.email "s323827@studenti.polito.it"
git config --global user.name "AnjalieP99"
git commit -m "TRIM results"
git push origin main
cd ~
lsblk
lsusb
lsblk -D
lsblk
lsusb
lsblk -D
nvme-cli
sudo apt install nvme-cli
nvme list
sudo smartctl -a /dev/sda
sudo smartctl -a /dev/sdb
sudo hdparm -I /dev/sdb | grep -i trim
sudo hdparm -I /dev/sdb
sudo hdparm -I /dev/sda
smartctl -a -d sntjmicron /dev/sda
sudo smartctl -a -d sntjmicron /dev/sda
sudo smartctl -a -d /dev/sda
sudo smartctl -a /dev/sda
sudo dd if=/dev/zero of=/dev/sda bs=512 count=1 oflag=dsync
sudo smartctl -a -d sntjmicron /dev/sda
hostnamectl
git pull origin main
lsblk
cd ~/mnt
cd /mnt
ls
lsblk /dev/sda
sudo mount /dev/sda /mnt/ssd_test
lsblk -o NAME,SIZE,FSTYPE,TYPE,MOUNTPOINTS,MODEL
sudo fdisk -l /dev/sda
sudo blkid /dev/sda
sudo file -s /dev/sda
sudo dmesg | tail -30
sudo fdisk /dev/sda
lsblk /dev/sda
sudo mount /dev/sda /mnt/ssd_test
sudo mount /dev/sda1 /mnt/ssd_test
lsblk -o NAME,SIZE,FSTYPE,TYPE,MOUNTPOINTS,MODEL
sudo rm -rf /mnt/ssd_test/*
sudo cp -r ~/experiment1/dataset/* /mnt/ssd_test/
sudo cp -r /experiment1/dataset/* /mnt/ssd_test/
sudo cp -r ~/Desktop/experiment1/dataset/* /mnt/ssd_test/
cd /mnt/ssd_test
sudo find . -type f -exec sha256sum {} \; | sort > /tmp/copied_hashes.txt
echo "=== Verifying copied dataset ==="
diff ~/experiment1/dataset/dataset_hashes.txt /tmp/copied_hashes.txt
if [ $? -eq 0 ]; then     echo "✅ All files copied successfully!"; else     echo "❌ Hash mismatch - check the copy!";     exit 1; fi
cd ~
diff ~/experiment1/dataset/dataset_hashes.txt /tmp/copied_hashes.txt
diff ~/Desktop/experiment1/dataset/dataset_hashes.txt /tmp/copied_hashes.txt
diff ~/Desktop/experiment1/dataset/hashes.txt /tmp/copied_hashes.txt
diff ~/Desktop/experiment1/dataset/hashes.txt /tmp/copied_hashes.txt if [ $? -eq 0 ]; then
else
cd ..
diff ~/Desktop/experiment1/dataset/hashes.txt /tmp/copied_hashes.txt
sudo cd recup.dir
sudo report.xml
sudo cat report.xml
sudo mount -o discard /dev/sda1 /mnt/ssd_test
make_filler() {     local num=$1;     local folder="FILLER_${num}";     sudo mkdir -p "/mnt/ssd_test/${folder}";     sudo dd if=/dev/urandom of="/mnt/ssd_test/${folder}/data.bin" bs=1M count=50 status=none;     sudo bash -c "echo 'FILLER_SIGNATURE_${num}' >> /mnt/ssd_test/${folder}/data.bin"; }
count=1
while true; do     current=$(df -h /mnt/ssd_test | tail -1 | awk '{print $5}' | sed 's/%//');     echo "Current usage: ${current}%";          if [ $current -ge 25 ]; then         echo "✅ Reached 25% fill!";         break;     fi;          make_filler $count;     count=$((count + 1));          if [ $((count % 10)) -eq 0 ]; then         echo "Created $count filler datasets";         df -h /mnt/ssd_test;     fi; done
for i in {1..3}; do     folder="TEST_DATA_${i}";     sudo mkdir -p "/mnt/ssd_test/${folder}";     
    sudo bash -c "cat > /mnt/ssd_test/${folder}/signature.txt << EOF
UNIQUE_SIGNATURE_TEST_${i}
$(yes "UNIQUE_SIGNATURE_TEST_${i}" | head -100)
EOF"
for i in {1..3}; do     folder="TEST_DATA_${i}";     sudo mkdir -p "/mnt/ssd_test/${folder}";     
    sudo bash -c "cat > /mnt/ssd_test/${folder}/signature.txt << EOF
UNIQUE_SIGNATURE_TEST_${i}
$(yes "UNIQUE_SIGNATURE_TEST_${i}" | head -100)
EOF";     
    sudo dd if=/dev/urandom of="/mnt/ssd_test/${folder}/random.bin" bs=1M count=5 status=none;     sudo bash -c "echo 'UNIQUE_SIGNATURE_TEST_${i}_BIN' >> /mnt/ssd_test/${folder}/random.bin";     
    for j in {1..50}; do         sudo bash -c "echo 'UNIQUE_SIGNATURE_TEST_${i}_small_${j}' > /mnt/ssd_test/${folder}/small_${j}.txt";     done;          echo "Created TEST_DATA_${i}"; done
sudo find /mnt/ssd_test -type f > ~/files_before_delete.txt
echo "Files before deletion: $(sudo find /mnt/ssd_test -type f | wc -l)"
sudo rm -rf /mnt/ssd_test/TEST_DATA_*
sync
sudo fstrim -v /mnt/ssd_test
sudo find /mnt/ssd_test -type f > ~/files_after_delete.txt
echo "Files after deletion: $(sudo find /mnt/ssd_test -type f | wc -l)"
mkdir -p ~/search_results/trim_on_25
search_live_drive() {     local time_label=$1;     local output_file="~/search_results/trim_on_25/search_${time_label}.txt";          echo "========================================" | tee -a $output_file;     echo "Search Results - ${time_label}" | tee -a $output_file;     echo "Time: $(date)" | tee -a $output_file;     echo "========================================" | tee -a $output_file;     echo "" | tee -a $output_file;     
    echo "=== TEST DATA SIGNATURES ===" | tee -a $output_file;     for i in {1..3}; do         count=$(sudo strings /dev/sda | grep -c "UNIQUE_SIGNATURE_TEST_${i}" 2>/dev/null);         echo "TEST_DATA_${i}: ${count:-0} signatures found" | tee -a $output_file;     done;          echo "" | tee -a $output_file
search_live_drive() {     local time_label=$1;     local output_file="~/search_results/trim_on_25/search_${time_label}.txt";          echo "========================================" | tee -a $output_file;     echo "Search Results - ${time_label}" | tee -a $output_file;     echo "Time: $(date)" | tee -a $output_file;     echo "========================================" | tee -a $output_file;     echo "" | tee -a $output_file;     
    echo "=== TEST DATA SIGNATURES ===" | tee -a $output_file;     for i in {1..3}; do         count=$(sudo strings /dev/sda | grep -c "UNIQUE_SIGNATURE_TEST_${i}" 2>/dev/null);         echo "TEST_DATA_${i}: ${count:-0} signatures found" | tee -a $output_file;     done;          echo "" | tee -a $output_file;     
    echo "=== FILLER DATA SIGNATURES (Control) ===" | tee -a $output_file;     filler_count=$(sudo strings /dev/sda | grep -c "FILLER_SIGNATURE" 2>/dev/null);     echo "Total filler signatures: ${filler_count:-0}" | tee -a $output_file;     
    echo "" | tee -a $output_file;     echo "=== SAMPLE SIGNATURES FOUND ===" | tee -a $output_file;     sudo strings /dev/sda | grepUNIQUE_SIGNATURE" | head -10 | tee -a $output_file;          echo "" | tee -a $output_file;     echo "Search complete. Results saved to: $output_file"; }
search_live_drive "0min"
ls
cd search_results/
ls
cd ~
search_live_drive() {     local time_label=$1;     local output_dir="$HOME/search_results/trim_on_25";     local output_file="$output_dir/search_${time_label}.txt";      mkdir -p "$output_dir";      echo "========================================" | tee -a "$output_file";     echo "Search Results - ${time_label}" | tee -a "$output_file";     echo "Time: $(date)" | tee -a "$output_file";     echo "========================================" | tee -a "$output_file";     echo "" | tee -a "$output_file"; 
    echo "=== TEST DATA SIGNATURES ===" | tee -a "$output_file";      for i in {1..3}; do         count=$(sudo strings /dev/sda | grep -c "UNIQUE_SIGNATURE_TEST_${i}" 2>/dev/null);         echo "TEST_DATA_${i}: ${count:-0} signatures found" | tee -a "$output_file";     done;      echo "" | tee -a "$output_file"; 
    echo "=== FILLER DATA SIGNATURES (Control) ===" | tee -a "$output_file";      filler_count=$(sudo strings /dev/sda | grep -c "FILLER_SIGNATURE" 2>/dev/null);     echo "Total filler signatures: ${filler_count:-0}" | tee -a "$output_file";      echo "" | tee -a "$output_file"; 
    echo "=== SAMPLE SIGNATURES FOUND ===" | tee -a "$output_file";      sudo strings /dev/sda | grep "UNIQUE_SIGNATURE" | head -10 | tee -a "$output_file";      echo "" | tee -a "$output_file";     echo "Search complete. Results saved to: $output_file"; }
search_live_drive "0min
search_live_drive "0min"
search_live_drive() { local time_label="$1" local output_dir="$HOME/search_results/trim_on_25" local output_file="$output_dir/search_${time_label}.txt" local strings_file="$output_dir/strings_${time_label}.txt" # Create output directory mkdir -p "$output_dir" echo "========================================" | tee "$output_file" echo "SSD RAW DATA SEARCH" | tee -a "$output_file" echo "========================================" | tee -a "$output_file" echo "Time label: ${time_label}" | tee -a "$output_file" echo "Timestamp: $(date '+%Y-%m-%d %H:%M:%S %Z')" | tee -a "$output_file" echo "Device: /dev/sda" | tee -a "$output_file" echo "Device model: EDILOCA ES106 128GB" | tee -a "$output_file" echo "========================================" | tee -a "$output_file" echo "" | tee -a "$output_file" # -------------------------------------------------- # ONE RAW READ OF THE ENTIRE SSD # -------------------------------------------------- echo "Reading /dev/sda once and extracting printable strings..." | tee -a "$output_file" echo "This may take several minutes." | tee -a "$output_file" echo "" | tee -a "$output_file" sudo strings -a /dev/sda > "$strings_file" if [ $? -ne 0 ]; then echo "ERROR: Raw device read failed." | tee -a "$output_file" return 1 fi echo "Raw read completed." | tee -a "$output_file" echo "Strings saved to: $strings_file" | tee -a "$output_file" echo "" | tee -a "$output_file" # -------------------------------------------------- # TEST DATA SIGNATURES # -------------------------------------------------- echo "========================================" | tee -a "$output_file" echo "TEST DATA SIGNATURES" | tee -a "$output_file" echo "========================================" | tee -a "$output_file" for i in {1..3}; do signature="UNIQUE_SIGNATURE_TEST_${i}" count=$(grep -Fc "$signature" "$strings_file") echo "${signature}: ${count} occurrence(s)" | tee -a "$output_file" done echo "" | tee -a "$output_file" # -------------------------------------------------- # FILLER DATA CONTROL # -------------------------------------------------- echo "========================================" | tee -a "$output_file" echo "FILLER DATA SIGNATURES (CONTROL)" | tee -a "$output_file" echo "========================================" | tee -a "$output_file" filler_count=$(grep -Fc "FILLER_SIGNATURE" "$strings_file") echo "FILLER_SIGNATURE: ${filler_count} occurrence(s)" | tee -a "$output_file" echo "" | tee -a "$output_file" # -------------------------------------------------- # SAMPLE MATCHES # -------------------------------------------------- echo "========================================" | tee -a "$output_file" echo "SAMPLE UNIQUE SIGNATURES FOUND" | tee -a "$output_file" echo "========================================" | tee -a "$output_file" grep "UNIQUE_SIGNATURE" "$strings_file" | head -10 | tee -a "$output_file" echo "" | tee -a "$output_file" # -------------------------------------------------- # SUMMARY # -------------------------------------------------- echo "========================================" | tee -a "$output_file" echo "SUMMARY" | tee -a "$output_file" echo "========================================" | tee -a "$output_file" echo "Time label: ${time_label}" | tee -a "$output_file" echo "Search completed: $(date '+%Y-%m-%d %H:%M:%S %Z')" | tee -a "$output_file" echo "" | tee -a "$output_file" for i in {1..3}; do signature="UNIQUE_SIGNATURE_TEST_${i}" count=$(grep -Fc "$signature" "$strings_file") if [ "$count" -gt 0 ]; then echo "TEST_DATA_${i}: PRESENT (${count} occurrence(s))" | tee -a "$output_file" else echo "TEST_DATA_${i}: NOT FOUND" | tee -a "$output_file" fi done echo "" | tee -a "$output_file" if [ "$filler_count" -gt 0 ]; then echo "FILLER_DATA: PRESENT (${filler_count} occurrence(s))" | tee -a "$output_file" else echo "FILLER_DATA: NOT FOUND" | tee -a "$output_file" fi echo "" | tee -a "$output_file" echo "Detailed strings file: $strings_file" | tee -a "$output_file" echo "Search results file: $output_file" | tee -a "$output_file" echo "========================================" | tee -a "$output_file"
search_live_drive() { local time_label="$1" local output_dir="$HOME/search_results/trim_on_25" local output_file="$output_dir/search_${time_label}.txt" local strings_file="$output_dir/strings_${time_label}.txt" # Create output directory mkdir -p "$output_dir" echo "========================================" | tee "$output_file" echo "SSD RAW DATA SEARCH" | tee -a "$output_file" echo "========================================" | tee -a "$output_file" echo "Time label: ${time_label}" | tee -a "$output_file" echo "Timestamp: $(date '+%Y-%m-%d %H:%M:%S %Z')" | tee -a "$output_file" echo "Device: /dev/sda" | tee -a "$output_file" echo "Device model: EDILOCA ES106 128GB" | tee -a "$output_file" echo "========================================" | tee -a "$output_file" echo "" | tee -a "$output_file" # -------------------------------------------------- # ONE RAW READ OF THE ENTIRE SSD # -------------------------------------------------- echo "Reading /dev/sda once and extracting printable strings..." | tee -a "$output_file" echo "This may take several minutes." | tee -a "$output_file" echo "" | tee -a "$output_file" sudo strings -a /dev/sda > "$strings_file" if [ $? -ne 0 ]; then echo "ERROR: Raw device read failed." | tee -a "$output_file" return 1 fi echo "Raw read completed." | tee -a "$output_file" echo "Strings saved to: $strings_file" | tee -a "$output_file" echo "" | tee -a "$output_file" # -------------------------------------------------- # TEST DATA SIGNATURES # -------------------------------------------------- echo "========================================" | tee -a "$output_file" echo "TEST DATA SIGNATURES" | tee -a "$output_file" echo "========================================" | tee -a "$output_file" for i in {1..3}; do signature="UNIQUE_SIGNATURE_TEST_${i}" count=$(grep -Fc "$signature" "$strings_file") echo "${signature}: ${count} occurrence(s)" | tee -a "$output_file" done echo "" | tee -a "$output_file" # -------------------------------------------------- # FILLER DATA CONTROL # -------------------------------------------------- echo "========================================" | tee -a "$output_file" echo "FILLER DATA SIGNATURES (CONTROL)" | tee -a "$output_file" echo "========================================" | tee -a "$output_file" filler_count=$(grep -Fc "FILLER_SIGNATURE" "$strings_file") echo "FILLER_SIGNATURE: ${filler_count} occurrence(s)" | tee -a "$output_file" echo "" | tee -a "$output_file" # -------------------------------------------------- # SAMPLE MATCHES # -------------------------------------------------- echo "========================================" | tee -a "$output_file" echo "SAMPLE UNIQUE SIGNATURES FOUND" | tee -a "$output_file" echo "========================================" | tee -a "$output_file" grep "UNIQUE_SIGNATURE" "$strings_file" | head -10 | tee -a "$output_file" echo "" | tee -a "$output_file" # -------------------------------------------------- # SUMMARY # -------------------------------------------------- echo "========================================" | tee -a "$output_file" echo "SUMMARY" | tee -a "$output_file" echo "========================================" | tee -a "$output_file" echo "Time label: ${time_label}" | tee -a "$output_file" echo "Search completed: $(date '+%Y-%m-%d %H:%M:%S %Z')" | tee -a "$output_file" echo "" | tee -a "$output_file" for i in {1..3}; do signature="UNIQUE_SIGNATURE_TEST_${i}" count=$(grep -Fc "$signature" "$strings_file") if [ "$count" -gt 0 ]; then echo "TEST_DATA_${i}: PRESENT (${count} occurrence(s))" | tee -a "$output_file" else echo "TEST_DATA_${i}: NOT FOUND" | tee -a "$output_file" fi done echo "" | tee -a "$output_file" if [ "$filler_count" -gt 0 ]; then echo "FILLER_DATA: PRESENT (${filler_count} occurrence(s))" | tee -a "$output_file" else echo "FILLER_DATA: NOT FOUND" | tee -a "$output_file" fi echo "" | tee -a "$output_file" echo "Detailed strings file: $strings_file" | tee -a "$output_file" echo "Search results file: $output_file" | tee -a "$output_file" echo "========================================" | tee -a "$output_file" }
exit
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
if [ -z "$TARGET" ] || [[ ! "$TARGET" =~ ^(25|50|75|100)$ ]]; then     echo -e "${RED}Usage: ./fill_drive.sh [25|50|75|100]${NC}";     exit 1; fi
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
if [ -z "$TARGET" ] || [[ ! "$TARGET" =~ ^(25|50|75|100)$ ]]; then     echo -e "${RED}Usage: ./fill_drive.sh [25|50|75|100]${NC}";     exit 1; fi
nano fill_drive.sh
chmod +x fill_drive.sh
./fill_drive.sh 50
lsblk -D
sudo udevadm control --reload-rules
sudo udevadm trigger
lsblk -D
sudo photorec /dev/sda1
nano /etc/udev/rules.d/50-usb-ssd-trim.rules 
sudo nano /etc/udev/rules.d/50-usb-ssd-trim.rules 
sudo udevadm control --reload-rules
sudo udevadm trigger
lsblk -D
lsblk
lsblk -D
sudo mount -o nodiscard /dev/sda1 /mnt/ssd_test
grep -i discard /etc/fstab
systemctl status fstrim.timer
sudo systemctl stop fstrim.timer
sudo systemctl disable fstrim.timer
sudo systemctl mask fstrim.timer
systemctl status fstrim.timer
lsblk -D
sudo mount -o nodiscard /dev/sda1 /mnt/ssd_test
df -h /dev/sda1
df -h /dev/sda
sudo umount /dev/sda
sudo umount /dev/sda1
sudo mount /dev/sda1 /mnt/ssd_test
sudo umount /dev/sda1
sudo fuser -vm /mnt/ssd_test
ps -fp 39247
sudo kill -9 39247
sudo fuser -vm /mnt/ssd_test
sudo umount /dev/sda1
sudo nano /etc/udev/rules.d/50-usb-ssd-trim.rules 
sudo udevadm control --reload-rules
sudo udevadm trigger
sudo systemctl unmask fstrim.timer
sudo systemctl enable fstrim.timer
sudo systemctl start fstrim.timer
systemctl status fstrim.timer
lsblk
lsblk -D
sudo nano /etc/udev/rules.d/50-usb-ssd-trim.rules 
sudo udevadm control --reload-rules
sudo udevadm trigger
lsblk -D
sudo dd if=/dev/zero of=/dev/sda bs=1M count=100 status=progress
sudo parted /dev/sda mklabel gpt
sudo parted /dev/sda mkpart primary ext4 0% 100%
sudo partprobe /dev/sda
sleep 2
sudo mkfs.ext4 -F /dev/sda1
sudo mount -o discard /dev/sda1 /mnt/ssd_test
sudo umount /mnt/ssd_test 
script -a experiment.log
sudo umount /mnt/ssd_test 
ls /mnt/ssd
ls /mnt/ssd_test/
df -h /dev/sda
df -h /dev/sda1
sudo umount /dev/sda1
sudo photorec /dev/sda1
clear
for i in {1..3}; do     folder="TEST_DATA_${i}";     sudo mkdir -p "/mnt/ssd_test/${folder}";     
    sudo bash -c "cat > /mnt/ssd_test/${folder}/signature.txt << EOF
UNIQUE_SIGNATURE_TEST_${i}
$(yes "UNIQUE_SIGNATURE_TEST_${i}" | head -100)
EOF";     
    sudo dd if=/dev/urandom of="/mnt/ssd_test/${folder}/random.bin" bs=1M count=5 status=none;     sudo bash -c "echo 'UNIQUE_SIGNATURE_TEST_${i}_BIN' >> /mnt/ssd_test/${folder}/random.bin";     
    for j in {1..50}; do         sudo bash -c "echo 'UNIQUE_SIGNATURE_TEST_${i}_small_${j}' > /mnt/ssd_test/${folder}/small_${j}.txt";     done;          echo "Created TEST_DATA_${i}"; done
sudo rm -rf /mnt/ssd_test/TEST_DATA_*
sync
sudo umount /mnt/ssd_test 
sudo photorec /dev/sda1
df -h /dev/sda
df -h /dev/sda1
for i in {1..3}; do     folder="TEST_DATA_${i}";     sudo mkdir -p "/mnt/ssd_test/${folder}";     
    sudo bash -c "cat > /mnt/ssd_test/${folder}/signature.txt << EOF
UNIQUE_SIGNATURE_TEST_${i}
$(yes "UNIQUE_SIGNATURE_TEST_${i}" | head -100)
EOF";          sudo dd if=/dev/urandom of="/mnt/ssd_test/${folder}/random.bin" bs=1M count=5 status=none;     sudo bash -c "echo 'UNIQUE_SIGNATURE_TEST_${i}_BIN' >> /mnt/ssd_test/${folder}/random.bin";          for j in {1..50}; do         sudo bash -c "echo 'UNIQUE_SIGNATURE_TEST_${i}_small_${j}' > /mnt/ssd_test/${folder}/small_${j}.txt";     done;          echo "Created TEST_DATA_${i}"; done
sudo rm -rf /mnt/ssd_test/TEST_DATA_*
sync
sudo umount /mnt/ssd_test 
sudo photorec /dev/sda1
sudo testdisk /dev/sda1
lsblk
sudo mount /dev/sda /mnt/ssd_test
lsblk
sudo mount /dev/sda /mnt/ssd_test
sudo mount /dev/sda1 /mnt/ssd_test
df -h /dev/sda1
sudo testdisk /dev/sda1
lsblk
lsblk -D
sudo hdparm -I /dev/sda | grep -i "TRIM"
count=1
while true; do     current=$(df -h /mnt/ssd_test | tail -1 | awk '{print $5}' | sed 's/%//');     echo "Current usage: ${current}%";          if [ $current -ge 50 ]; then         echo "✅ Reached 50% fill!";         break;     fi;          make_filler $count;     count=$((count + 1));          if [ $((count % 10)) -eq 0 ]; then         echo "Created $count filler datasets";         df -h /mnt/ssd_test;     fi; done
make_filler() {     local num=$1;     local folder="FILLER_${num}";     sudo mkdir -p "/mnt/ssd_test/${folder}";     sudo dd if=/dev/urandom of="/mnt/ssd_test/${folder}/data.bin" bs=1M count=50 status=none;     sudo bash -c "echo 'FILLER_SIGNATURE_${num}' >> /mnt/ssd_test/${folder}/data.bin"; }
while true; do     current=$(df -h /mnt/ssd_test | tail -1 | awk '{print $5}' | sed 's/%//');     echo "Current usage: ${current}%";          if [ $current -ge 50 ]; then         echo "✅ Reached 50% fill!";         break;     fi;          make_filler $count;     count=$((count + 1));          if [ $((count % 10)) -eq 0 ]; then         echo "Created $count filler datasets";         df -h /mnt/ssd_test;     fi; done
df -h /dev/sda1
sudo dd if=/dev/urandom of=/mnt/ssd_test/test.bin bs=1M count=1024 status=progress
df -h /dev/sda1
df -h /dev/sda
