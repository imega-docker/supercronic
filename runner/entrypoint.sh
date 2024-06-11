#!/usr/bin/env bash

ARCH=$(uname -m)
if [ "$ARCH" == "x86_64" ]; then
    echo apk add --no-cache upx@community
    echo upx -v --brute $ROOTFS/supercronic
fi
