#!/usr/bin/env bash

install_dig() {
    case "$DISTRO_NAME" in
        "ubuntu"|"debian")
            $SUDO apt-get update
            $SUDO apt-get install -y dnsutils
            ;;
        "alpine")
            $SUDO apk add --no-cache bind-tools
            ;;
        "fedora")
            # RHEL/Fedora uses 'bind-utils' package for dig command
            $SUDO ${PACKAGE_MANAGER:-dnf} install -y bind-utils
            ;;
        *)
            echo "[ERROR] Unsupported distribution: $DISTRO_NAME"
            exit 1
            ;;
    esac
}
