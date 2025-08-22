#!/usr/bin/env bash
set -e

install_jq() {
  case "$DISTRO_NAME" in
    ubuntu|debian|pop)
      $SUDO apt update -y
      $SUDO apt install -y jq
      ;;

    alpine)
      $SUDO apk update
      $SUDO apk add jq
      ;;

    fedora)
      $SUDO ${PACKAGE_MANAGER:-dnf} install -y jq
      ;;

    *)
      echo "[ERROR] jq install not supported on distro: $DISTRO_NAME"
      exit 1
      ;;
  esac
}