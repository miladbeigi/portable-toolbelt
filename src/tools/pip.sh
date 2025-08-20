#!/usr/bin/env bash
set -e

install_pip() {
  case "$DISTRO_NAME" in
    ubuntu|debian|pop)
      $SUDO apt update -y
      $SUDO apt install -y python3-pip
      ;;

    alpine)
      $SUDO apk update
      $SUDO apk add py3-pip
      ;;

    *)
      echo "[ERROR] pip install not supported on distro: $DISTRO_NAME"
      exit 1
      ;;
  esac
}