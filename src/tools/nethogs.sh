#!/usr/bin/env bash

install_nethogs() {
    case "$DISTRO_NAME" in
        "ubuntu"|"debian")
            $SUDO apt-get update
            $SUDO apt-get install -y nethogs
            ;;
        "alpine")
            $SUDO apk add --no-cache nethogs
            ;;
        "fedora")
            $SUDO ${PACKAGE_MANAGER:-dnf} install -y nethogs
            ;;
        *)
            echo "[ERROR] Unsupported distribution: $DISTRO_NAME"
            exit 1
            ;;
    esac
}
