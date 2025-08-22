#!/usr/bin/env bash
set -e

install_wget() {
  case "$DISTRO_NAME" in
    ubuntu|debian|pop)
      $SUDO apt update -y
      $SUDO apt install -y wget
      ;;

    alpine)
      $SUDO apk update
      $SUDO apk add wget
      ;;

    fedora)
      $SUDO ${PACKAGE_MANAGER:-dnf} install -y wget
      ;;

    *)
      echo "[ERROR] wget install not supported on distro: $DISTRO_NAME"
      exit 1
      ;;
  esac
}
