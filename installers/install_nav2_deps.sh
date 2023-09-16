#!/usr/bin/env bash
set -e
CURR_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd -P)"

apt-get update -y &&
    apt-get install -y --no-install-recommends \
        ros-humble-nav2-bringup \
        ros-humble-rmw-cyclonedds-cpp \
        ros-humble-navigation2 \
        ros-humble-turtlebot3*
