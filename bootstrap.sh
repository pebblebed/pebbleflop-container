#!/bin/sh

echo "$@"
if [ "$#" -ne 2 ]; then
	echo "$@" | tee 1>&2
	echo "usage: $0 <TAILSCALE_AUTH> <TAILSCALE_HOSTNAME>" | tee 1>&2
	exit
fi

mkdir -p /tmp/tailscale
tailscaled --tun=userspace-networking --socks5-server=localhost:1055 &
tailscale up --ssh --authkey="$1" --hostname="$2"
echo Tailscale started
while true; do
	sleep 43
done
