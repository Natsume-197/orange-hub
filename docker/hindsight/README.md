# Hindsight

Local memory API, loopback only.

```sh
cp .env.example .env
docker volume create hindsight-data
docker compose up -d
```

```sh
docker run -d --name hindsight --restart unless-stopped \
  --env-file .env \
  -p 127.0.0.1:${HINDSIGHT_API_PORT}:${HINDSIGHT_API_PORT} \
  -p 127.0.0.1:${HINDSIGHT_CP_PORT}:${HINDSIGHT_CP_PORT} \
  -v hindsight-data:/home/hindsight/.pg0 \
  ghcr.io/vectorize-io/hindsight:latest
```
