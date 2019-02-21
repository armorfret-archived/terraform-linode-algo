#!/usr/bin/env bash

set -euo pipefail

ALGO_DIR=/opt/algo
if [[ ! -e "$ALGO_DIR" ]] ; then
    git clone "${algo_repo}" "$ALGO_DIR"
fi

(
    cd "$ALGO_DIR"

    if [[ "$(git remote get-url origin)" != "${algo_repo}" ]] ; then
        echo "Repo in image is not the expected repo"
        exit 1
    fi

    git pull

    [[ -e env ]] && rm -rf env
    virtualenv env
    export PS1=""
    source env/bin/activate
    pip install --force-reinstall --no-cache-dir -r requirements.txt
    ansible-playbook main.yml
)
