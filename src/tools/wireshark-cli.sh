#!/usr/bin/env bash

install_wireshark-cli() {
    case "$DISTRO_NAME" in
        "ubuntu"|"debian")
            $SUDO apt-get update
            $SUDO apt-get install -y tshark
            ;;
        "alpine")
            $SUDO apk add --no-cache wireshark
            ;;
        *)
            echo "[ERROR] Unsupported distribution: $DISTRO_NAME"
            exit 1
            ;;
    esac
}
