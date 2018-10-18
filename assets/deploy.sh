#!/usr/bin/env bash

set -euo pipefail

cd /opt/algo
export PS1=""
source env/bin/activate
ansible-playbook main.yml
