# TRIM and Filesystem-Level Data Recoverability

## Objective

Investigate whether deleted file information remains recoverable
from ext4 filesystem metadata, inode structures, journal information,
and associated data blocks after TRIM.

## Environment

- Device: /dev/sda1
- Filesystem: ext4
- Block size: 4096 bytes
- Recovery tool: ext4magic
- Filesystem analysis: debugfs
- Block inspection: dd + xxd

## Procedure

1. Create test file containing known data.
2. Record inode and extent information.
3. Delete the file.
4. Issue TRIM.
5. Examine inode and journal structures.
6. Attempt recovery using ext4magic.
7. Examine inode using debugfs.
8. Examine previously allocated blocks directly.

## Results

- Target inode reported as unallocated.
- Inode size and block count were zero.
- debugfs returned no pathname.
- ext4magic did not recover the file.
- Examined data blocks contained zero bytes.

## Conclusion

The experiment demonstrated loss of filesystem-level recoverability
following deletion and TRIM.
