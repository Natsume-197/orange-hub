# orange-hub

Generic home-server templates. Fill `<PLACEHOLDERS>` and copy `${VAR}` into untracked env files.

Public apps go through the tunnel to the proxy. Private apps stay on loopback and Tailscale (no Funnel). `system/lan-guard` drops selected ports on `<LAN_IFACE>`.

| Service | Folder | Reached via | Port |
|---|---|---|---|
| Library app | `docker/nanahoshi` | tunnel → proxy | `${APP_HTTP_PORT}` |
| Nginx Proxy Manager | `docker/nginx-proxy-manager` | tunnel / tailnet | `${NPM_HTTP_PORT}` |
| Vaultwarden | `docker/vaultwarden` | tailnet | `${VAULTWARDEN_PORT}` |
| Hindsight | `docker/hindsight` | local | `${HINDSIGHT_API_PORT}` |
| Hermes | `hermes` | tailnet | `${HERMES_DASHBOARD_PORT}` |
| cloudflared | `system/cloudflared` | outbound | — |
| rclone crypt | `system/rclone` | library mount | `<CRYPT_MOUNT>` |
| lan-guard | `system/lan-guard` | firewall | — |
| network, ssh | `system/network`, `system/ssh` | LAN | 22 |

```
docker/   hindsight  nanahoshi  nginx-proxy-manager  vaultwarden
hermes/
system/   cloudflared  lan-guard  network  rclone  ssh
```
