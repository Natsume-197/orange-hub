# Vaultwarden

Loopback `127.0.0.1:${VAULTWARDEN_PORT}` in `<VAULTWARDEN_DIR>` (mode 700). Tailnet only, no Funnel. The container listens on port 80.

```sh
cp .env.example vaultwarden.env && chmod 600 vaultwarden.env
docker compose up -d
tailscale serve --bg --https=${VAULTWARDEN_SERVE_PORT} http://127.0.0.1:${VAULTWARDEN_PORT}
# https://<HOSTNAME>.<TAILNET>.ts.net:${VAULTWARDEN_SERVE_PORT}
# tailscale serve --https=${VAULTWARDEN_SERVE_PORT} off
```

Client server URL: `https://<HOSTNAME>.<TAILNET>.ts.net:${VAULTWARDEN_SERVE_PORT}` (same tailnet, or a shared node).

Backup (`systemd/vaultwarden-backup.timer`): database, RSA key, attachments, sends. Keep 7 local copies and 30 days on `<BACKUP_REMOTE>:`. Crypt password and salt stay offline.

```sh
install -m 700 vaultwarden-backup.sh /usr/local/sbin/vaultwarden-backup.sh
cp systemd/vaultwarden-backup.* /etc/systemd/system/ && systemctl enable --now vaultwarden-backup.timer
```

Restore (recreate `<BACKUP_REMOTE>` from the offline password and salt if the disk is gone):

```sh
rclone copy <BACKUP_REMOTE>:daily/vaultwarden-YYYYmmdd-HHMM.tar.gz /tmp/restore/
tar -C /tmp/restore -xzf /tmp/restore/vaultwarden-*.tar.gz
sqlite3 /tmp/restore/vaultwarden/db.sqlite3 'PRAGMA integrity_check;'   # expect: ok
docker compose -f <VAULTWARDEN_DIR>/docker-compose.yml down
cp -a /tmp/restore/vaultwarden/. <VAULTWARDEN_DIR>/data/
rm -f <VAULTWARDEN_DIR>/data/db.sqlite3-wal <VAULTWARDEN_DIR>/data/db.sqlite3-shm
docker compose -f <VAULTWARDEN_DIR>/docker-compose.yml up -d
```
