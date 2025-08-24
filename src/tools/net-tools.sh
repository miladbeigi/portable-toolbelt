#!/usr/bin/env bash

set -e

install_net-tools() {
  case "$DISTRO_FAMILY" in
    debian)
      $SUDO $PACKAGE_MANAGER install -y net-tools
      ;;
    alpine)
      $SUDO $PACKAGE_MANAGER add net-tools
      ;;
    redhat)
      case "$PACKAGE_MANAGER" in
        dnf)
          $SUDO $PACKAGE_MANAGER install -y net-tools
          ;;
        yum)
          $SUDO $PACKAGE_MANAGER install -y net-tools
          ;;
        *)
          echo "[ERROR] Net-tools install not supported on this distro: $DISTRO_FAMILY"
          exit 1
      esac
      ;;
    *)
      echo "[ERROR] Net-tools install not supported on this distro: $DISTRO_FAMILY"
      exit 1
      ;;
  esac
}
