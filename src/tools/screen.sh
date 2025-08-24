#!/usr/bin/env bash
set -e

install_screen() {
  case "$DISTRO_FAMILY" in
    debian)
      $SUDO $PACKAGE_MANAGER install -y screen
      ;;
    alpine)
      $SUDO $PACKAGE_MANAGER add screen
      ;;
    redhat)
      case "$PACKAGE_MANAGER" in
        dnf)
          $SUDO $PACKAGE_MANAGER install -y screen
          ;;
        yum)
          $SUDO $PACKAGE_MANAGER install -y screen
          ;;
        *)
          echo "[ERROR] Screen install not supported on this distro: $DISTRO_FAMILY"
          exit 1
      esac
      ;;
    *)
      echo "[ERROR] Screen install not supported on this distro: $DISTRO_FAMILY"
      exit 1
      ;;
  esac
}