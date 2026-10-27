# lan-guard

Drop new connections from `<LAN_IFACE>` to the ports in `LAN_GUARD_PORTS`. Rules sit in `DOCKER-USER` (pre-DNAT) because Docker bypasses the host firewall.

```sh
cp .env.example /etc/docker-lan-guard.env && chmod 600 /etc/docker-lan-guard.env
install -m 755 docker-lan-guard.sh /usr/local/sbin/docker-lan-guard.sh
cp systemd/docker-lan-guard.service /etc/systemd/system/
systemctl enable --now docker-lan-guard
```
