#!/usr/bin/env bash
set -e

install_jq() {
  case "$DISTRO_FAMILY" in
    debian)
      $SUDO $PACKAGE_MANAGER install -y jq
      ;;
    alpine)
      $SUDO $PACKAGE_MANAGER add jq
      ;;
    redhat)
      case "$PACKAGE_MANAGER" in
        dnf)
          $SUDO $PACKAGE_MANAGER install -y jq
          ;;
        yum)
          $SUDO $PACKAGE_MANAGER install -y jq
          ;;
        *)
          echo "[ERROR] Jq install not supported on this distro: $DISTRO_FAMILY"
          exit 1
      esac
      ;;
    *)
      echo "[ERROR] Jq install not supported on this distro: $DISTRO_FAMILY"
      exit 1
      ;;
  esac
}