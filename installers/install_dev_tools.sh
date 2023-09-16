#!/usr/bin/env bash
set -e
CURR_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd -P)"

pushd /tmp/archives &&
    tar xzvf tmux.tar.gz &&
    cp -frd .tmux /etc/skel &&
    cd /etc/skel && ln -s -f .tmux/.tmux.conf &&
    cp .tmux/.tmux.conf.local . &&
    cd /tmp/archives
    popd


pushd /tmp/archives &&
    tar xzvf oh-my-zsh.tar.gz &&
    cp -frd .oh-my-zsh /etc/skel &&
    popd
