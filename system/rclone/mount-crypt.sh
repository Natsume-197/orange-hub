#!/usr/bin/env bash
# <SCRIPT_DIR>/mount-crypt.sh — full VFS cache, cap <VFS_CACHE_SIZE>.
set -euo pipefail
mkdir -p "<CRYPT_MOUNT>" "<LOG_DIR>"
exec rclone mount "<CRYPT_REMOTE>:" "<CRYPT_MOUNT>" \
  --allow-other \
  --dir-cache-time 24h \
  --poll-interval 1m \
  --vfs-cache-mode full \
  --vfs-cache-max-size <VFS_CACHE_SIZE> \
  --vfs-cache-max-age 72h \
  --buffer-size 32M \
  --vfs-read-ahead 64M \
  --transfers 8 \
  --checkers 16 \
  --log-file "<LOG_DIR>/rclone-crypt.log" \
  --log-level INFO
