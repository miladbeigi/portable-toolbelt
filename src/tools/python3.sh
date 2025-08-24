#!/usr/bin/env bash
set -e

install_python3() {
  case "$DISTRO_FAMILY" in
    debian)
      $SUDO $PACKAGE_MANAGER install -y python3 python3-venv python3-pip
      ;;
    alpine)
      $SUDO $PACKAGE_MANAGER add python3 py3-pip
      ;;
    redhat)
      case "$PACKAGE_MANAGER" in
        dnf)
          $SUDO $PACKAGE_MANAGER install -y python3 python3-pip
          ;;
        yum)
          $SUDO $PACKAGE_MANAGER install -y python3 python3-pip
          ;;
        *)
          echo "[ERROR] Python3 install not supported on this distro: $DISTRO_FAMILY"
          exit 1
      esac
      ;;
    *)
      echo "[ERROR] Python3 install not supported on this distro: $DISTRO_FAMILY"
      exit 1
      ;;
  esac
}