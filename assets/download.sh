#!/usr/bin/env bash

set -euo pipefail

server_ip="$1"
server_name="$2"
src_path="/opt/algo/configs/${server_ip}/*.mobileconfig"
target_dir="configs/${server_name}"

mkdir -p "$config_dir"
scp \
    -oStrictHostKeyChecking=no \
    "root@${server_ip}:${src_path}" \
    "${target_dir}/"

