#!/usr/bin/env bash

set -euo pipefail

server_ip="$VPN_IP_ADDRESS"
server_name="$VPN_NAME"
server_region="$VPN_REGION"

src_root_path="/opt/algo/configs/${server_ip}"
src_objects="wireguard/*.png wireguard/*.conf"
target_dir="configs/${server_name}"

mkdir -p "$target_dir"
for src_object in $src_objects ; do
    scp \
        -oStrictHostKeyChecking=no \
        "root@${server_ip}:${src_root_path}/${src_object}" \
        "${target_dir}/"
done
echo "${server_region}" > "${target_dir}/region"
