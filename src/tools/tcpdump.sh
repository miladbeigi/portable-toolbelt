#!/usr/bin/env bash
set -e

install_tcpdump() {
  case "$DISTRO_FAMILY" in
    debian)
      $SUDO $PACKAGE_MANAGER install -y tcpdump
      ;;
    alpine)
      $SUDO $PACKAGE_MANAGER add tcpdump
      ;;
    redhat)
      case "$PACKAGE_MANAGER" in
        dnf)
          $SUDO $PACKAGE_MANAGER install -y tcpdump
          ;;
        yum)
          $SUDO $PACKAGE_MANAGER install -y tcpdump
          ;;
        *)
          echo "[ERROR] Tcpdump install not supported on this distro: $DISTRO_FAMILY"
          exit 1
      esac
      ;;
    *)
      echo "[ERROR] Tcpdump install not supported on this distro: $DISTRO_FAMILY"
      exit 1
      ;;
  esac
}