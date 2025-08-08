#!/usr/bin/env bash

install_speedtest-cli() {
    case "$DISTRO_NAME" in
        "ubuntu"|"debian")
            $SUDO apt-get update
            $SUDO apt-get install -y speedtest-cli
            ;;
        "alpine")
            $SUDO apk add --no-cache speedtest-cli
            ;;
        *)
            echo "[ERROR] Unsupported distribution: $DISTRO_NAME"
            exit 1
            ;;
    esac
}
