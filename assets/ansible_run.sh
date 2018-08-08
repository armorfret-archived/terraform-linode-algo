#!/usr/bin/env bash

set -euo pipefail

cd /opt/algo
export PS1=""
source env/bin/activate

ip_addr="$(ip -4 addr show eth0 | awk '/inet/ {print $2}' | sed 's|/[0-9]*$||')"
password="$(cat /dev/shm/algo_password)"
shred /dev/shm/algo_password

ansible-playbook \
    deploy.yml \
    -t 'local,vpn' \
    --skip-tags '_null,encrypted,cloud,update-alternatives' \
    -e "server_ip=localhost
        server_user=root
        IP_subject_alt_name=${ip_addr}
        OnDemandEnabled_Cellular=Y
        OnDemandEnabled_WIFI=Y
        OnDemandEnabled_WIFI_EXCLUDE='_null'
        Store_CAKEY=N
        p12_export_password='${password}'"
