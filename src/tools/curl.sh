#!/usr/bin/env bash

install_curl() {
    case "$DISTRO_NAME" in
        "ubuntu"|"debian")
            $SUDO apt-get update
            $SUDO apt-get install -y curl
            ;;
        "alpine")
            $SUDO apk add --no-cache curl
            ;;
        "fedora")
            $SUDO ${PACKAGE_MANAGER:-dnf} install -y curl
            ;;
        *)
            echo "[ERROR] Unsupported distribution: $DISTRO_NAME"
            exit 1
            ;;
    esac
}
