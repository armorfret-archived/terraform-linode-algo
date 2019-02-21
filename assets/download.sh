#!/usr/bin/env bash

set -euo pipefail

server_ip="$1"
server_name="$2"
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

