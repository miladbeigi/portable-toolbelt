#!/usr/bin/env bash

set -e

install_curl() {
  case "$DISTRO_FAMILY" in
    debian)
      $SUDO $PACKAGE_MANAGER install -y curl
      ;;
    alpine)
      $SUDO $PACKAGE_MANAGER add curl
      ;;
    redhat)
      case "$PACKAGE_MANAGER" in
        dnf)
          $SUDO $PACKAGE_MANAGER install -y curl
          ;;
        yum)
          $SUDO $PACKAGE_MANAGER install -y curl
          ;;
        *)
          echo "[ERROR] Curl install not supported on this distro: $DISTRO_FAMILY"
          exit 1
      esac
      ;;
    *)
      echo "[ERROR] Curl install not supported on this distro: $DISTRO_FAMILY"
      exit 1
      ;;
  esac
}
