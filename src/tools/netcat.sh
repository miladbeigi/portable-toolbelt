#!/usr/bin/env bash

set -e

install_netcat() {
  case "$DISTRO_FAMILY" in
    debian)
      $SUDO $PACKAGE_MANAGER install -y netcat-traditional
      ;;
    alpine)
      $SUDO $PACKAGE_MANAGER add netcat-openbsd
      ;;
    redhat)
      case "$PACKAGE_MANAGER" in
        dnf)
          $SUDO $PACKAGE_MANAGER install -y nmap-ncat
          ;;
        yum)
          $SUDO $PACKAGE_MANAGER install -y nmap-ncat
          ;;
        *)
          echo "[ERROR] Netcat install not supported on this distro: $DISTRO_FAMILY"
          exit 1
      esac
      ;;
    *)
      echo "[ERROR] Netcat install not supported on this distro: $DISTRO_FAMILY"
      exit 1
      ;;
  esac
}
