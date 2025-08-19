#!/usr/bin/env bash
set -e

install_python3() {
  case "$DISTRO_NAME" in
    ubuntu|debian|pop)
      $SUDO apt update -y
      $SUDO apt install -y python3 python3-venv python3-pip
      ;;

    alpine)
      $SUDO apk update
      $SUDO apk add python3 py3-pip
      ;;

    *)
      echo "[ERROR] python3 install not supported on distro: $DISTRO_NAME"
      exit 1
      ;;
  esac
}