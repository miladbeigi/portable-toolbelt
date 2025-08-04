#!/usr/bin/env bash
set -e

install_nmap() {
  case "$DISTRO_NAME" in
    ubuntu|debian|pop)
      $SUDO apt update -y
      $SUDO apt install -y nmap
      ;;

    alpine)
      $SUDO apk update
      $SUDO apk add nmap
      ;;

    *)
      echo "[ERROR] nmap install not supported on distro: $DISTRO_NAME"
      exit 1
      ;;
  esac
}