#!/usr/bin/env bash
set -e

install_openssl() {
  case "$DISTRO_FAMILY" in
    debian)
      $SUDO $PACKAGE_MANAGER install -y openssl
      ;;
    alpine)
      $SUDO $PACKAGE_MANAGER add openssl
      ;;
    redhat)
      case "$PACKAGE_MANAGER" in
        dnf)
          $SUDO $PACKAGE_MANAGER install -y openssl
          ;;
        yum)
          $SUDO $PACKAGE_MANAGER install -y openssl
          ;;
        *)
          echo "[ERROR] OpenSSL install not supported on this distro: $DISTRO_FAMILY"
          exit 1
      esac
      ;;
    *)
      echo "[ERROR] OpenSSL install not supported on this distro: $DISTRO_FAMILY"
      exit 1
      ;;
  esac
}