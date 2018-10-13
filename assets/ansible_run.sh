#!/usr/bin/env bash

set -euo pipefail

cd /opt/algo
export PS1=""
source env/bin/activate

ip_addr="$(ip -4 addr show eth0 | awk '/inet/ {print $2}' | sed 's|/[0-9]*$||')"
password="$(cat /dev/shm/algo_password)"
shred -u /dev/shm/algo_password

ansible-playbook main.yml -e "
    provider=local
    ondemand_cellular=true
    ondemand_wifi=true
    ondemand_wifi_exclude=''
    local_dns=false
    ssh_tunneling=true
    windows=false
    store_cakey=false
    p12_password='${password}'"
