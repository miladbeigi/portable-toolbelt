#!/usr/bin/env bash
set -e

install_pytest() {
  case "$DISTRO_FAMILY" in
    debian)
      $SUDO $PACKAGE_MANAGER install -y python3-pytest
      ;;
    alpine)
      $SUDO $PACKAGE_MANAGER add py3-pytest
      ;;
    redhat)
      case "$PACKAGE_MANAGER" in
        dnf)
          $SUDO $PACKAGE_MANAGER install -y python3-pytest
          ;;
        yum)
          $SUDO $PACKAGE_MANAGER install -y python3-pytest
          ;;
        *)
          echo "[ERROR] Pytest install not supported on this distro: $DISTRO_FAMILY"
          exit 1
      esac
      ;;
    *)
      echo "[ERROR] Pytest install not supported on this distro: $DISTRO_FAMILY"
      exit 1
      ;;
  esac
}