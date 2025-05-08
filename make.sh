#!/bin/bash
VERSION="${1:-1}"
echo "Building Bottlerocket version: $VERSION"

if [[ "$(docker images -q builder:$VERSION 2> /dev/null)" == "" ]]; then
  docker build --progress=plain -t builder:$VERSION .
fi

docker run --init --privileged --rm -v $(pwd)/build:/bottlerocket/build \
    -v $(pwd)/target:/bottlerocket/target \
    -v /var/run/docker.sock:/var/run/docker.sock \
    -v /tmp:/var/lib/desktop-containerd/daemon/tmpmounts builder:$VERSION
