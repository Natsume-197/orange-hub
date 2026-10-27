# Nginx Proxy Manager

Proxy in front of internal apps. `nginx-data/` and `nginx-letsencrypt/` are not committed. Reach the admin port over the tailnet or an SSH tunnel.

| Host | Upstream |
|---|---|
| `<WEB_HOST>`, `<WEB_HOST_ALT>` | `http://<UPSTREAM_HOST>:${APP_HTTP_PORT}` (`trust_forwarded_proto=1`) |
| `<API_HOST>`, `<API_HOST_ALT>` | `http://<UPSTREAM_HOST>:${APP_HTTP_PORT}` |

Set `trust_forwarded_proto=1` on NPM ≥ 2.13 when the edge terminates TLS.

```sh
cp .env.example .env
docker compose up -d
```
