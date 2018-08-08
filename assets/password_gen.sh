#!/usr/bin/env bash

set -euo pipefail

server_ip="$1"
config_dir="configs/${server_ip}"
password_file="${config_dir}/password"

mkdir -p -m 0700 "${config_dir}"
touch "${password_file}"
chmod 600 "${password_file}"

openssl rand 24 | python2 -c "
import sys,string
chars=string.ascii_letters + string.digits + '_@'
print ''.join([chars[ord(c) % 64] for c in list(sys.stdin.read())])" \
> "${password_file}"

scp \
    -oStrictHostKeyChecking=no \
    "${password_file}" \
    "root@${server_ip}:/dev/shm/algo_password" \

