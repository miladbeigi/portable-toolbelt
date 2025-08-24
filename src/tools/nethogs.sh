#!/usr/bin/env bash

set -e

install_nethogs() {
  case "$DISTRO_FAMILY" in
    debian)
      $SUDO $PACKAGE_MANAGER install -y nethogs
      ;;
    alpine)
      $SUDO $PACKAGE_MANAGER add nethogs
      ;;
    redhat)
      case "$PACKAGE_MANAGER" in
        dnf)
          $SUDO $PACKAGE_MANAGER install -y nethogs
          ;;
        yum)
          $SUDO $PACKAGE_MANAGER install -y nethogs
          ;;
        *)
          echo "[ERROR] Nethogs install not supported on this distro: $DISTRO_FAMILY"
          exit 1
      esac
      ;;
    *)
      echo "[ERROR] Nethogs install not supported on this distro: $DISTRO_FAMILY"
      exit 1
      ;;
  esac
}
