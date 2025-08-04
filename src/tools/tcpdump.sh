#!/usr/bin/env bash
set -e

install_tcpdump() {
  case "$DISTRO_NAME" in
    ubuntu|debian|pop)
      $SUDO apt update -y
      $SUDO apt install -y tcpdump
      ;;

    alpine)
      $SUDO apk update
      $SUDO apk add tcpdump
      ;;

    *)
      echo "[ERROR] tcpdump install not supported on distro: $DISTRO_NAME"
      exit 1
      ;;
  esac
}