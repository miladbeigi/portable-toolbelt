#!/usr/bin/env bash
set -e

install_htop() {
  case "$DISTRO_FAMILY" in
    debian)
      $SUDO $PACKAGE_MANAGER install -y htop
      ;;
    alpine)
      $SUDO $PACKAGE_MANAGER add htop
      ;;
    redhat)
      case "$PACKAGE_MANAGER" in
        dnf)
          $SUDO $PACKAGE_MANAGER install -y htop
          ;;
        yum)
          $SUDO $PACKAGE_MANAGER install -y htop
          ;;
        *)
          echo "[ERROR] Htop install not supported on this distro: $DISTRO_FAMILY"
          exit 1
      esac
      ;;
    *)
      echo "[ERROR] Htop install not supported on this distro: $DISTRO_FAMILY"
      exit 1
      ;;
  esac
}
