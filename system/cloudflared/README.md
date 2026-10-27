# cloudflared

Outbound tunnel. Keep the token in the env file. Point public hostnames at `http://127.0.0.1:${NPM_HTTP_PORT}`.

```sh
cp .env.example /etc/cloudflared/tunnel.env && chmod 600 /etc/cloudflared/tunnel.env
cp systemd/cloudflared.service /etc/systemd/system/
systemctl enable --now cloudflared
```
