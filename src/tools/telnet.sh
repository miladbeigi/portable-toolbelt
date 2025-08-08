#!/usr/bin/env bash

install_telnet() {
    case "$DISTRO_NAME" in
        "ubuntu"|"debian")
            $SUDO apt-get update
            $SUDO apt-get install -y telnet
            ;;
        "alpine")
            $SUDO apk add --no-cache busybox-extras
            ;;
        *)
            echo "[ERROR] Unsupported distribution: $DISTRO_NAME"
            exit 1
            ;;
    esac
}
