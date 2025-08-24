#!/usr/bin/env bash

set -e

install_iftop() {
  case "$DISTRO_FAMILY" in
    debian)
      $SUDO $PACKAGE_MANAGER install -y iftop
      ;;
    alpine)
      $SUDO $PACKAGE_MANAGER add iftop
      ;;
    redhat)
      case "$PACKAGE_MANAGER" in
        dnf)
          $SUDO $PACKAGE_MANAGER install -y iftop
          ;;
        yum)
          $SUDO $PACKAGE_MANAGER install -y iftop
          ;;
        *)
          echo "[ERROR] Iftop install not supported on this distro: $DISTRO_FAMILY"
          exit 1
      esac
      ;;
    *)
      echo "[ERROR] Iftop install not supported on this distro: $DISTRO_FAMILY"
      exit 1
      ;;
  esac
}
