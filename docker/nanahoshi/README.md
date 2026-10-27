# Nanahoshi

Library app (`ghcr.io/<OWNER>/nanahoshi`). Upstream compose stays in `<APP_DIR>`. This folder is the host override.

```sh
cp docker-compose.override.yml <APP_DIR>/
cp .env.example <APP_DIR>/.env
docker compose --project-directory <APP_DIR> up -d
```

Mount `<CRYPT_MOUNT>`, `<PUBLIC_LIBRARY_DIR>`, and read-only media under `<MEDIA_DIR>`. External database volume: `${POSTGRES_VOLUME}`. Backup with the upstream `scripts/backup.sh`.
