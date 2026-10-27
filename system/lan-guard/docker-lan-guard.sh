#!/bin/sh
# Drop NEW flows from $LAN_IFACE to $LAN_GUARD_PORTS in DOCKER-USER (pre-DNAT).
set -e
IPT=/usr/sbin/iptables
: "${LAN_IFACE:?set LAN_IFACE}"
: "${LAN_GUARD_PORTS:?set LAN_GUARD_PORTS}"
$IPT -N LAN-GUARD 2>/dev/null || true
$IPT -F LAN-GUARD
for p in $LAN_GUARD_PORTS; do
  $IPT -A LAN-GUARD -i "$LAN_IFACE" -p tcp -m conntrack --ctstate NEW --ctorigdstport "$p" -j DROP
done
$IPT -A LAN-GUARD -j RETURN
$IPT -C DOCKER-USER -j LAN-GUARD 2>/dev/null || $IPT -I DOCKER-USER 1 -j LAN-GUARD
