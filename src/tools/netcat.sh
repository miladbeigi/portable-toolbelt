#!/usr/bin/env bash

install_netcat() {
    case "$DISTRO_NAME" in
        "ubuntu"|"debian")
            $SUDO apt-get update
            $SUDO apt-get install -y netcat-traditional
            ;;
        "alpine")
            $SUDO apk add --no-cache netcat-openbsd
            ;;
        *)
            echo "[ERROR] Unsupported distribution: $DISTRO_NAME"
            exit 1
            ;;
    esac
}
