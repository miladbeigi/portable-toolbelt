#!/usr/bin/env bash

detect_os() {
  if [[ -f /etc/os-release ]]; then
    . /etc/os-release
    OS_ID="${ID,,}"  # lowercase
    case "$OS_ID" in
      ubuntu|debian|pop)
        DISTRO_NAME="ubuntu"
        ;;
      alpine)
        DISTRO_NAME="alpine"
        ;;
      *)
        echo "[ERROR] Unsupported or unrecognized distro: $OS_ID"
        exit 1
        ;;
    esac
  else
    echo "[ERROR] Cannot detect OS: /etc/os-release not found"
    exit 1
  fi
}
