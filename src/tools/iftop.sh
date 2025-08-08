#!/usr/bin/env bash

install_iftop() {
    case "$DISTRO_NAME" in
        "ubuntu"|"debian")
            $SUDO apt-get update
            $SUDO apt-get install -y iftop
            ;;
        "alpine")
            $SUDO apk add --no-cache iftop
            ;;
        *)
            echo "[ERROR] Unsupported distribution: $DISTRO_NAME"
            exit 1
            ;;
    esac
}
