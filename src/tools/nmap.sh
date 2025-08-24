#!/usr/bin/env bash
set -e

install_nmap() {
  case "$DISTRO_FAMILY" in
    debian)
      $SUDO $PACKAGE_MANAGER install -y nmap
      ;;
    alpine)
      $SUDO $PACKAGE_MANAGER add nmap
      ;;
    redhat)
      case "$PACKAGE_MANAGER" in
        dnf)
          $SUDO $PACKAGE_MANAGER install -y nmap
          ;;
        yum)
          $SUDO $PACKAGE_MANAGER install -y nmap
          ;;
        *)
          echo "[ERROR] Nmap install not supported on this distro: $DISTRO_FAMILY"
          exit 1
      esac
      ;;
    *)
      echo "[ERROR] Nmap install not supported on this distro: $DISTRO_FAMILY"
      exit 1
      ;;
  esac
}