#!/usr/bin/env bash

set -e

install_vim() {
  case "$DISTRO_NAME" in
    ubuntu|debian|pop)
      $SUDO apt update -y
      $SUDO apt install -y vim
      ;;
    alpine)
      $SUDO apk update
      $SUDO apk add vim
      ;;
    *)
      echo "[ERROR] Vim install not supported on this distro: $DISTRO_NAME"
      exit 1
      ;;
  esac
}
