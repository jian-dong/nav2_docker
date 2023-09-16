#!/usr/bin/env bash
set -e
CURR_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd -P)"

apt-get update -y &&
  apt-get install -y --no-install-recommends \
    ros-humble-cv-bridge \
    ros-humble-image-transport ros-humble-image-geometry \
    ros-humble-tf2 ros-humble-tf2-ros \
    ros-humble-image-publisher --fix-missing
