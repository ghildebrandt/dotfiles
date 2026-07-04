#!/usr/bin/env bash
set -euo pipefail

sudo apt update
sudo apt install -y git ansible

cd "$(dirname "$0")"
ansible-playbook -i ansible/inventory ansible/playbook.yaml --ask-become-pass