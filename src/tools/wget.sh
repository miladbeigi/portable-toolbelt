#!/usr/bin/env bash
set -e

install_wget() {
  case "$DISTRO_FAMILY" in
    debian)
      $SUDO $PACKAGE_MANAGER install -y wget
      ;;
    alpine)
      $SUDO $PACKAGE_MANAGER add wget
      ;;
    redhat)
      case "$PACKAGE_MANAGER" in
        dnf)
          $SUDO $PACKAGE_MANAGER install -y wget
          ;;
        yum)
          $SUDO $PACKAGE_MANAGER install -y wget
          ;;
        *)
          echo "[ERROR] Wget install not supported on this distro: $DISTRO_FAMILY"
          exit 1
      esac
      ;;
    *)
      echo "[ERROR] Wget install not supported on this distro: $DISTRO_FAMILY"
      exit 1
      ;;
  esac
}
