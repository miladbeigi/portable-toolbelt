#!/usr/bin/env bash
set -e

install_gpg() {
  case "$DISTRO_FAMILY" in
    debian)
      $SUDO $PACKAGE_MANAGER install -y gnupg
      ;;
    alpine)
      $SUDO $PACKAGE_MANAGER add gnupg
      ;;
    redhat)
      case "$PACKAGE_MANAGER" in
        dnf)
          $SUDO $PACKAGE_MANAGER install -y gnupg2
          ;;
        yum)
          $SUDO $PACKAGE_MANAGER install -y gnupg2
          ;;
        *)
          echo "[ERROR] GPG install not supported on this distro: $DISTRO_FAMILY"
          exit 1
      esac
      ;;
    *)
      echo "[ERROR] GPG install not supported on this distro: $DISTRO_FAMILY"
      exit 1
      ;;
  esac
}