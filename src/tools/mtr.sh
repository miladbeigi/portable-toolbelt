#!/usr/bin/env bash

install_mtr() {
    case "$DISTRO_NAME" in
        "ubuntu"|"debian")
            $SUDO apt-get update
            $SUDO apt-get install -y mtr
            ;;
        "alpine")
            $SUDO apk add --no-cache mtr
            ;;
        "fedora")
            $SUDO ${PACKAGE_MANAGER:-dnf} install -y mtr
            ;;
        *)
            echo "[ERROR] Unsupported distribution: $DISTRO_NAME"
            exit 1
            ;;
    esac
}
