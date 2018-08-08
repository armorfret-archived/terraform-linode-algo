#!/usr/bin/env bash

set -euo pipefail

server_ip="$1"
config_dir="configs/${server_ip}"

scp \
    -oStrictHostKeyChecking=no \
    "root@${server_ip}:/opt/algo/${config_dir}/*.mobileconfig" \
    "${config_dir}/"

