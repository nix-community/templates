#!/usr/bin/env bash

find . -type d -maxdepth 1 \( -iname "*" ! -iname ".*" \) | while read line; do
    pushd $line
    nix flake check || { echo 'Check Failed!' ; exit 1; }
    popd
done
