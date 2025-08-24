#!/usr/bin/env bash

set -e

install_speedtest-cli() {
  case "$DISTRO_FAMILY" in
    debian)
      $SUDO $PACKAGE_MANAGER install -y speedtest-cli
      ;;
    alpine)
      $SUDO $PACKAGE_MANAGER add speedtest-cli
      ;;
    redhat)
      case "$PACKAGE_MANAGER" in
        dnf)
          $SUDO $PACKAGE_MANAGER install -y python3-speedtest-cli
          ;;
        yum)
          $SUDO $PACKAGE_MANAGER install -y python3-speedtest-cli
          ;;
        *)
          echo "[ERROR] Speedtest-cli install not supported on this distro: $DISTRO_FAMILY"
          exit 1
      esac
      ;;
    *)
      echo "[ERROR] Speedtest-cli install not supported on this distro: $DISTRO_FAMILY"
      exit 1
      ;;
  esac
}
