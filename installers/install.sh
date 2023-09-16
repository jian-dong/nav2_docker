#!/usr/bin/env bash
set -e
CURR_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd -P)"

mkdir /etc/gcrypt
echo all >> /etc/gcrypt/hwf.deny
bash ${CURR_DIR}/install_deps.sh
bash ${CURR_DIR}/install_dev_tools.sh
bash ${CURR_DIR}/install_nav2_deps.sh
bash ${CURR_DIR}/install_camera_deps.sh


