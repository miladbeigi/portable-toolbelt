#!/usr/bin/env bash

set -e

install_iperf3() {
  case "$DISTRO_FAMILY" in
    debian)
      $SUDO $PACKAGE_MANAGER install -y iperf3
      ;;
    alpine)
      $SUDO $PACKAGE_MANAGER add iperf3
      ;;
    redhat)
      case "$PACKAGE_MANAGER" in
        dnf)
          $SUDO $PACKAGE_MANAGER install -y iperf3
          ;;
        yum)
          $SUDO $PACKAGE_MANAGER install -y iperf3
          ;;
        *)
          echo "[ERROR] Iperf3 install not supported on this distro: $DISTRO_FAMILY"
          exit 1
      esac
      ;;
    *)
      echo "[ERROR] Iperf3 install not supported on this distro: $DISTRO_FAMILY"
      exit 1
      ;;
  esac
}
