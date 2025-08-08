#!/usr/bin/env bash

install_nslookup() {
    case "$DISTRO_NAME" in
        "ubuntu"|"debian")
            $SUDO apt-get update
            $SUDO apt-get install -y dnsutils
            ;;
        "alpine")
            $SUDO apk add --no-cache bind-tools
            ;;
        *)
            echo "[ERROR] Unsupported distribution: $DISTRO_NAME"
            exit 1
            ;;
    esac
}
