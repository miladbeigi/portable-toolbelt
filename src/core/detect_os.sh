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
      centos|rhel|rocky|almalinux|fedora)
        DISTRO_NAME="fedora"
        # Detect package manager (DNF preferred over YUM)
        if command -v dnf &> /dev/null; then
          PACKAGE_MANAGER="dnf"
        elif command -v yum &> /dev/null; then
          PACKAGE_MANAGER="yum"
        else
          echo "[ERROR] Neither DNF nor YUM package manager found"
          exit 1
        fi
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
