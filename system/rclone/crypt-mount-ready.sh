#!/usr/bin/env bash
# ExecStartPost of rclone-crypt.service. Wait for the mount, then recreate the app on a runtime remount.
set -euo pipefail

for _ in $(seq 1 60); do
  if findmnt -rn -T "<CRYPT_MOUNT>" -S '<CRYPT_REMOTE>:' >/dev/null 2>&1 \
     && [[ -d "<CRYPT_MOUNT>/<CHECK_DIR>" ]]; then
    break
  fi
  sleep 2
done

findmnt -rn -T "<CRYPT_MOUNT>" -S '<CRYPT_REMOTE>:' >/dev/null
[[ -d "<CRYPT_MOUNT>/<CHECK_DIR>" ]]

# Runtime remount: recreate the app so it drops a stale rprivate mount.
if systemctl is-active --quiet docker.service \
   && [[ -f "<APP_DIR>/docker-compose.yml" ]]; then
  docker compose --project-directory "<APP_DIR>" \
    up -d --force-recreate --no-deps "<APP_SERVICE>"
fi
