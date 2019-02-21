#!/usr/bin/env bash

set -euo pipefail

ALGO_DIR=/opt/algo
[[ -e "$ALGO_DIR" ]] && rm -rf "$ALGO_DIR"
git clone "${algo_repo}" "$ALGO_DIR"

(
    cd "$ALGO_DIR"

    if [[ "$(git remote get-url origin)" != "${algo_repo}" ]] ; then
        echo "Repo in image is not the expected repo"
        exit 1
    fi

    git pull

    mv /opt/config.cfg ./config.cfg

    [[ -e env ]] && rm -rf env
    virtualenv env

    export PS1=""
    source env/bin/activate
    pip install --force-reinstall --no-cache-dir -r requirements.txt
    ansible-playbook main.yml
)
