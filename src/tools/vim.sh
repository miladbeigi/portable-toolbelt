#!/usr/bin/env bash

set -e

install_vim() {
  case "$DISTRO_FAMILY" in
    debian)
      $SUDO $PACKAGE_MANAGER install -y vim
      ;;
    alpine)
      $SUDO $PACKAGE_MANAGER add vim
      ;;
    redhat)
      case "$PACKAGE_MANAGER" in
        dnf)
          $SUDO $PACKAGE_MANAGER install -y vim-enhanced
          ;;
        yum)
          $SUDO $PACKAGE_MANAGER install -y vim-enhanced
          ;;
        *)
          echo "[ERROR] Vim install not supported on this distro: $DISTRO_FAMILY"
          exit 1
      esac
      ;;
    *)
      echo "[ERROR] Vim install not supported on this distro: $DISTRO_FAMILY"
      exit 1
      ;;
  esac
}
