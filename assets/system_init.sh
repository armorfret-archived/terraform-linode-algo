#!/usr/bin/env bash

set -euo pipefail

export DEBIAN_FRONTEND=noninteractive

apt update -qq
apt upgrade -y -qq
apt install -y -qq ansible python-pip build-essential python-dev python-virtualenv

git clone https://github.com/trailofbits/algo /opt/algo

cd /opt/algo

python -m virtualenv env
export PS1=""
source env/bin/activate
pip install -r requirements.txt -q
