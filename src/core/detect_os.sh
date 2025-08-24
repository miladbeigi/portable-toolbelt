#!/usr/bin/env bash

detect_os() {
  if [[ -f /etc/os-release ]]; then
    . /etc/os-release
    OS_ID="${ID,,}"  # lowercase
    case "$OS_ID" in
      ubuntu|debian|pop)
        DISTRO_FAMILY="debian"
        PACKAGE_MANAGER="apt"
        echo "[INFO] Detected package manager: $PACKAGE_MANAGER"
        $SUDO apt-get update -y
        ;;
      alpine)
        DISTRO_FAMILY="alpine"
        PACKAGE_MANAGER="apk"
        echo "[INFO] Detected package manager: $PACKAGE_MANAGER"
        $SUDO apk update
        ;;
      centos|rhel|fedora|ol)
        DISTRO_FAMILY="redhat"
        if command -v dnf &> /dev/null; then
          PACKAGE_MANAGER="dnf"
        elif command -v yum &> /dev/null; then
          PACKAGE_MANAGER="yum"
        else
          echo "[ERROR] Neither DNF nor YUM package manager found"
          exit 1
        fi
        echo "[INFO] Detected package manager: $PACKAGE_MANAGER"
        $SUDO $PACKAGE_MANAGER update -y
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
