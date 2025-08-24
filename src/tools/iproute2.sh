#!/usr/bin/env bash

set -e

install_iproute2() {
  case "$DISTRO_FAMILY" in
    debian)
      $SUDO $PACKAGE_MANAGER install -y iproute2
      ;;
    alpine)
      $SUDO $PACKAGE_MANAGER add iproute2
      ;;
    redhat)
      case "$PACKAGE_MANAGER" in
        dnf)
          $SUDO $PACKAGE_MANAGER install -y iproute
          ;;
        yum)
          $SUDO $PACKAGE_MANAGER install -y iproute
          ;;
        *)
          echo "[ERROR] Iproute2 install not supported on this distro: $DISTRO_FAMILY"
          exit 1
      esac
      ;;
    *)
      echo "[ERROR] Iproute2 install not supported on this distro: $DISTRO_FAMILY"
      exit 1
      ;;
  esac
}
