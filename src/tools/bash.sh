#!/usr/bin/env bash

install_bash() {
    case "$DISTRO_NAME" in
        "ubuntu"|"debian")
            $SUDO apt-get update
            $SUDO apt-get install -y bash
            ;;
        "alpine")
            $SUDO apk add --no-cache bash
            ;;
        "fedora")
            $SUDO ${PACKAGE_MANAGER:-dnf} install -y bash
            ;;
        *)
            echo "[ERROR] Unsupported distribution: $DISTRO_NAME"
            exit 1
            ;;
    esac
}
