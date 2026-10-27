# rclone

Crypt mount `<CRYPT_REMOTE>:` at `<CRYPT_MOUNT>` before Docker. `<BACKUP_REMOTE>:` stores Vaultwarden backups. Keep crypt passwords offline. A runtime remount recreates `<APP_SERVICE>` in `<APP_DIR>`.

```sh
cp rclone.conf.example <RCLONE_CONFIG> && chmod 600 <RCLONE_CONFIG>
install -m 755 mount-crypt.sh crypt-mount-ready.sh <SCRIPT_DIR>/
cp systemd/rclone-crypt.service /etc/systemd/system/
systemctl enable --now rclone-crypt
```
