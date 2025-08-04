#!/usr/bin/env bash
set -e

install_htop() {
  case "$DISTRO_NAME" in
    ubuntu|debian|pop)
      $SUDO apt update -y
      $SUDO apt install -y htop
      ;;

    alpine)
      $SUDO apk update
      $SUDO apk add htop
      ;;

    *)
      echo "[ERROR] htop install not supported on distro: $DISTRO_NAME"
      exit 1
      ;;
  esac
}
