#!/bin/bash

# run script in archlinux docker

docker run --rm \
    --name archlinux_test \
    -v "$(pwd)":/work \
    -it \
    archlinux-test:latest \
    bash -c "/work/bootstrap.sh ; zsh"

