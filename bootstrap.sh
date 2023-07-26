#!/bin/sh

mkdir -p /tmp/tailscale
/var/runtime/tailscaled --tun=userspace-networking --socks5-server=localhost:1055 &
/var/runtime/tailscale up --authkey="$1" --hostname="$2"
echo Tailscale started
ALL_PROXY=socks5://localhost:1055/

