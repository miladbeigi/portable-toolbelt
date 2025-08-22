#!/usr/bin/env bash

install_net-tools() {
    case "$DISTRO_NAME" in
        "ubuntu"|"debian")
            $SUDO apt-get update
            $SUDO apt-get install -y net-tools
            ;;
        "alpine")
            $SUDO apk add --no-cache net-tools
            ;;
        "fedora")
            $SUDO ${PACKAGE_MANAGER:-dnf} install -y net-tools
            ;;
        *)
            echo "[ERROR] Unsupported distribution: $DISTRO_NAME"
            exit 1
            ;;
    esac
}
