#!/usr/bin/env bash
set -e

install_gpg() {
  case "$DISTRO_NAME" in
    ubuntu|debian|pop)
      $SUDO apt update -y
      $SUDO apt install -y gnupg
      ;;

    alpine)
      $SUDO apk update
      $SUDO apk add gnupg
      ;;

    *)
      echo "[ERROR] gpg install not supported on distro: $DISTRO_NAME"
      exit 1
      ;;
  esac
}