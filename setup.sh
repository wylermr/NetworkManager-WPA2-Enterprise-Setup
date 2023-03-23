#!/bin/bash
# Setup script for NetworkManager WPA2-Enterprise workaround

#? safer bash options
set -euo pipefail
export IFS=$'\n'

#? function to edit config
configure() {
    sed -i "s/^$1=.*$/$1=$2/g" "$id"
}

#? use best available privilege elevator
which doas &>/dev/null && alias sudo='doas' \
|| which sudo &>/dev/null && alias sudo='sudo' \
|| alias sudo='su -c'

#? variables
uuid="$(uuidgen)"
read -p 'Network name: ' ssid
id="$ssid-"
read -p 'ID/Username: ' identity
read -sp 'Password: ' password && echo
read -p 'Authentication method (blank for default): ' phase2_auth

[ -z "$phase2_auth" ] && phase2_auth='mschapv2'

#? set up connection config
cp skeleton "$id"
configure id "$id"
configure uuid "$uuid"
configure ssid "$ssid"
configure identity "$identity"
configure password "$password"
configure phase2-auth "$phase2_auth"

#? set permissions and ownership
chmod 600 "$id"
sudo chown root:root "$id"

#? install connection config
sudo mv "$id" "/etc/NetworkManager/system-connections/$id"
