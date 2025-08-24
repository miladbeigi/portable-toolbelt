#!/usr/bin/env bash

set -e

install_mtr() {
  case "$DISTRO_FAMILY" in
    debian)
      $SUDO $PACKAGE_MANAGER install -y mtr
      ;;
    alpine)
      $SUDO $PACKAGE_MANAGER add mtr
      ;;
    redhat)
      case "$PACKAGE_MANAGER" in
        dnf)
          $SUDO $PACKAGE_MANAGER install -y mtr
          ;;
        yum)
          $SUDO $PACKAGE_MANAGER install -y mtr
          ;;
        *)
          echo "[ERROR] Mtr install not supported on this distro: $DISTRO_FAMILY"
          exit 1
      esac
      ;;
    *)
      echo "[ERROR] Mtr install not supported on this distro: $DISTRO_FAMILY"
      exit 1
      ;;
  esac
}
