#!/usr/bin/env bash
set -e

install_screen() {
  case "$DISTRO_NAME" in
    ubuntu|debian|pop)
      $SUDO apt update -y
      $SUDO apt install -y screen
      ;;

    alpine)
      $SUDO apk update
      $SUDO apk add screen
      ;;

    *)
      echo "[ERROR] screen install not supported on distro: $DISTRO_NAME"
      exit 1
      ;;
  esac
}