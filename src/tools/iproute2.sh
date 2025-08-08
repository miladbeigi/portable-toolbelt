#!/usr/bin/env bash

install_iproute2() {
    case "$DISTRO_NAME" in
        "ubuntu"|"debian")
            $SUDO apt-get update
            $SUDO apt-get install -y iproute2
            ;;
        "alpine")
            $SUDO apk add --no-cache iproute2
            ;;
        *)
            echo "[ERROR] Unsupported distribution: $DISTRO_NAME"
            exit 1
            ;;
    esac
}
