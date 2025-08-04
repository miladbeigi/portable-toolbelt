#!/usr/bin/env bash
set -e

install_openssl() {
  case "$DISTRO_NAME" in
    ubuntu|debian|pop)
      $SUDO apt update -y
      $SUDO apt install -y openssl
      ;;

    alpine)
      $SUDO apk update
      $SUDO apk add openssl
      ;;

    *)
      echo "[ERROR] openssl install not supported on distro: $DISTRO_NAME"
      exit 1
      ;;
  esac
}