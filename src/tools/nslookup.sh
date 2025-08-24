#!/usr/bin/env bash

set -e

install_nslookup() {
  case "$DISTRO_FAMILY" in
    debian)
      $SUDO $PACKAGE_MANAGER install -y dnsutils
      ;;
    alpine)
      $SUDO $PACKAGE_MANAGER add bind-tools
      ;;
    redhat)
      case "$PACKAGE_MANAGER" in
        dnf)
          $SUDO $PACKAGE_MANAGER install -y bind-utils
          ;;
        yum)
          $SUDO $PACKAGE_MANAGER install -y bind-utils
          ;;
        *)
          echo "[ERROR] Nslookup install not supported on this distro: $DISTRO_FAMILY"
          exit 1
      esac
      ;;
    *)
      echo "[ERROR] Nslookup install not supported on this distro: $DISTRO_FAMILY"
      exit 1
      ;;
  esac
}
