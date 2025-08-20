#!/usr/bin/env bash
set -e

install_black() {
  case "$DISTRO_NAME" in
    ubuntu|debian|pop)
      # Use apt package for system install
      $SUDO apt update -y
      $SUDO apt install -y black
      ;;

    alpine)
      # Use native Alpine package
      $SUDO apk update
      $SUDO apk add py3-black
      ;;

    *)
      echo "[ERROR] black install not supported on distro: $DISTRO_NAME"
      exit 1
      ;;
  esac
}