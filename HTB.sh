#!/bin/sh

IFACE=$(ip address| grep tun0 | awk '{print $1}' | tr -d ':')

if [ "$IFACE" = "tun0" ]; then
   echo "VPN:$(ip address tun0 | grep "inet " | awk '{print $2}')${u-}"
else
   echo "VPN:Disconnected"
fi
