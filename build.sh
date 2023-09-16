#! /usr/bin/env bash
docker build\
    -f dockerfile . -t nav2-docker-env:aarch64-humble \
    --label ade_image_commit_sha="$(git rev-parse HEAD)" \
    --label ade_image_commit_tag="$(date  +'%Y%m%d.%H%M%S')"
