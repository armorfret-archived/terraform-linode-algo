#!/usr/bin/env bash

set -euo pipefail

ALGO_DIR=/opt/algo
(
    cd "$ALGO_DIR"
    git pull

    [[ -e env ]] && rm -rf env
    virtualenv env

    export PS1=""
    source env/bin/activate
    pip install --force-reinstall --no-cache-dir -r requirements.txt
    ansible-playbook main.yml
)
