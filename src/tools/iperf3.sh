#!/usr/bin/env bash

install_iperf3() {
    case "$DISTRO_NAME" in
        "ubuntu"|"debian")
            $SUDO apt-get update
            $SUDO apt-get install -y iperf3
            ;;
        "alpine")
            $SUDO apk add --no-cache iperf3
            ;;
        "fedora")
            $SUDO ${PACKAGE_MANAGER:-dnf} install -y iperf3
            ;;
        *)
            echo "[ERROR] Unsupported distribution: $DISTRO_NAME"
            exit 1
            ;;
    esac
}
