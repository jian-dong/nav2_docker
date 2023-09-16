#!/usr/bin/env bash
set -e
CURR_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd -P)"

apt-get update -y &&
  apt-get install -y --no-install-recommends \
    curl wget gnupg2 build-essential ca-certificates \
    software-properties-common git bash-completion \
    openssh-server zsh python3-pip unzip zip apt-utils \
    tmux libusb-1.0-0-dev cmake libuvc-dev gdb libyaml-cpp-dev --fix-missing

python3 -m pip install -i http://mirrors.cloud.tencent.com/pypi/simple --upgrade pip
pip config set global.index-url http://mirrors.cloud.tencent.com/pypi/simple

apt-get update -y &&
  apt-get install -y --no-install-recommends \
    libgflags-dev libgoogle-glog-dev --fix-missing


cd /tmp/archives
unzip libuvc-master.zip &&
  cd libuvc-master &&
  mkdir build && cd build &&
  cmake .. && make -j4
sudo make install &&
  sudo ldconfig &&
  cd "${CURR_DIR}"

apt-get clean &&
  rm -rf /var/lib/apt/lists/*
# Clean up cache to reduce layer size.
apt-get clean &&
  rm -rf /var/lib/apt/lists/*
