# Network

- `<LAN_IFACE>` on `<BRIDGE_PORT>`: `<SERVER_LAN_IP>/<PREFIX>`, gateway `<GATEWAY_IP>`. Hosts: `<SERVER_LAN_IP> <HOSTNAME>`.
- `<UNUSED_IFACE>` is unused. Mark both NICs unmanaged if another manager would configure them.
- wait-online watches `<LAN_IFACE>`.
- Tailscale `<HOSTNAME>.<TAILNET>.ts.net` (`<TAILSCALE_IP>`).
- Firewall: SSH from `<LAN_CIDR>`. Published app ports: `system/lan-guard`.

```sh
cp interfaces /etc/network/interfaces
cp 05-ifupdown2-owned-unmanaged.network /etc/systemd/network/
cp systemd/systemd-networkd-wait-online.service.d/20-lan.conf \
  /etc/systemd/system/systemd-networkd-wait-online.service.d/
```
