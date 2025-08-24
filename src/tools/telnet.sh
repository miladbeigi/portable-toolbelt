#!/usr/bin/env bash

set -e

install_telnet() {
  case "$DISTRO_FAMILY" in
    debian)
      $SUDO $PACKAGE_MANAGER install -y telnet
      ;;
    alpine)
      $SUDO $PACKAGE_MANAGER add busybox-extras
      ;;
    redhat)
      case "$PACKAGE_MANAGER" in
        dnf)
          $SUDO $PACKAGE_MANAGER install -y telnet
          ;;
        yum)
          $SUDO $PACKAGE_MANAGER install -y telnet
          ;;
        *)
          echo "[ERROR] Telnet install not supported on this distro: $DISTRO_FAMILY"
          exit 1
      esac
      ;;
    *)
      echo "[ERROR] Telnet install not supported on this distro: $DISTRO_FAMILY"
      exit 1
      ;;
  esac
}
