#!/bin/bash
# Install to /usr/local/sbin (mode 700). Keep 7 local copies and 30 days on <BACKUP_REMOTE>.
set -euo pipefail
umask 077
export RCLONE_CONFIG="<RCLONE_CONFIG>"
DATA="<VAULTWARDEN_DIR>/data"
LOCAL="<VAULTWARDEN_DIR>/backups"
REMOTE="<BACKUP_REMOTE>:daily"
TS=$(date +%Y%m%d-%H%M)
WORK=$(mktemp -d /tmp/vwbackup.XXXXXX)
trap 'rm -rf "$WORK"' EXIT
mkdir -p "$LOCAL" "$WORK/vaultwarden"
sqlite3 "$DATA/db.sqlite3" ".backup '$WORK/vaultwarden/db.sqlite3'"
[ "$(sqlite3 "$WORK/vaultwarden/db.sqlite3" 'PRAGMA integrity_check;')" = ok ]
for f in rsa_key.pem rsa_key.pub.pem rsa_key.der rsa_key.pub.der config.json; do [ -e "$DATA/$f" ] && cp -p "$DATA/$f" "$WORK/vaultwarden/"; done
for d in attachments sends icon_cache; do [ -d "$DATA/$d" ] && [ "$d" != icon_cache ] && cp -a "$DATA/$d" "$WORK/vaultwarden/"; done
OUT="$LOCAL/vaultwarden-$TS.tar.gz"
tar -C "$WORK" -czf "$OUT" vaultwarden
rclone copy "$OUT" "$REMOTE" --retries 5 --low-level-retries 10
rclone check "$LOCAL" "$REMOTE" --one-way --include "vaultwarden-$TS.tar.gz" --download
rclone delete "$REMOTE" --min-age 30d
ls -1t "$LOCAL"/vaultwarden-*.tar.gz | tail -n +8 | xargs -r rm -f
echo "backup ok: vaultwarden-$TS.tar.gz $(stat -c %s "$OUT") bytes"
