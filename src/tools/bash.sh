#!/usr/bin/env bash

set -e

install_bash() {
  case "$DISTRO_FAMILY" in
    debian)
      $SUDO $PACKAGE_MANAGER install -y bash
      ;;
    alpine)
      $SUDO $PACKAGE_MANAGER add bash
      ;;
    redhat)
      case "$PACKAGE_MANAGER" in
        dnf)
          $SUDO $PACKAGE_MANAGER install -y bash
          ;;
        yum)
          $SUDO $PACKAGE_MANAGER install -y bash
          ;;
        *)
          echo "[ERROR] Bash install not supported on this distro: $DISTRO_FAMILY"
          exit 1
      esac
      ;;
    *)
      echo "[ERROR] Bash install not supported on this distro: $DISTRO_FAMILY"
      exit 1
      ;;
  esac
}
