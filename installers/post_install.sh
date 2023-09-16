#!/usr/bin/env bash
set -e

CURR_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd -P)"
# pip install --no-cache-dir  -r ${CURR_DIR}/py3_requirements.txt
#sed -i 's/my $ignore_missing_info = 0;/my $ignore_missing_info = 1;/g' /usr/bin/dpkg-shlibdeps
#change default shell to zsh
#chsh -s $(which zsh)
# Clean up cache to reduce layer size.
apt-get clean &&
    rm -rf /var/lib/apt/lists/*
rm -fr /tmp/*
