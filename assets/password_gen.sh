#!/usr/bin/env bash

set -euo pipefail

server_ip="$1"
config_dir="configs/${server_ip}"
password_file="${config_dir}/password"

mkdir -p -m 0700 "${config_dir}"
touch "${password_file}"
chmod 600 "${password_file}"

shuf -n3 /usr/share/dict/words | tr '\n' '-' > "${password_file}"

scp \
    -oStrictHostKeyChecking=no \
    "${password_file}" \
    "root@${server_ip}:/dev/shm/algo_password" \

