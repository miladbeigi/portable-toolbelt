#!/usr/bin/env bash

set -e

install_wireshark-cli() {
  case "$DISTRO_FAMILY" in
    debian)
      $SUDO $PACKAGE_MANAGER install -y tshark
      ;;
    alpine)
      $SUDO $PACKAGE_MANAGER add wireshark
      ;;
    redhat)
      case "$PACKAGE_MANAGER" in
        dnf)
          $SUDO $PACKAGE_MANAGER install -y wireshark-cli
          ;;
        yum)
          $SUDO $PACKAGE_MANAGER install -y wireshark-cli
          ;;
        *)
          echo "[ERROR] Wireshark-cli install not supported on this distro: $DISTRO_FAMILY"
          exit 1
      esac
      ;;
    *)
      echo "[ERROR] Wireshark-cli install not supported on this distro: $DISTRO_FAMILY"
      exit 1
      ;;
  esac
}
