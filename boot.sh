#!/usr/bin/env bash

set -e

display_ascii_art() {
  ascii_art=$(cat << "EOF"
⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⠀⠀⠀⢠⣶⣶⣶⣦⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⢀⣴⣾⣿⣷⣄⢀⣸⣿⣿⣿⣿⣄⠀⣴⣿⣿⣶⣄⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠇⠀⠀⠀⠀⠀
⠀⠀⢀⣴⣦⣤⣠⣾⣿⣿⣿⠟⢿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣦⣀⣤⣤⡄⠀
⠀⠀⣾⣿⣿⣿⣿⣿⣿⠟⠁⠀⠀⢙⣿⣿⣿⣿⣿⡿⠋⢹⣿⣿⣿⣿⣿⣿⣿⡆
⠀⠀⠉⠻⣿⣿⣿⡿⠁⠀⠀⠀⣴⣿⣿⣿⣿⣿⣿⠃⠀⠻⠿⠃⣿⣿⣿⣿⠋⠀
⣡⣀⣀⣼⣿⣿⣿⡇⠀⠀⣠⡟⠉⠙⢿⣿⣿⡿⠉⠀⢀⣨⣤⣴⣿⣿⣿⣿⣀⣀
⢸⣿⣿⣿⣿⣿⣿⣷⣠⣾⣿⣿⣦⡄⣠⡿⠃⠀⣠⣾⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿
⠼⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠿⠁⠀⣠⡾⠿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿
⠀⠀⠀⢙⣿⣿⣿⣿⣿⠿⠿⠟⠁⠀⣠⣾⣧⡀⠀⠈⠻⣿⣿⣿⣿⣿⣿⡏⠀⠀
⠀⠀⣵⣿⣿⣿⣿⣿⠁⣾⡀⠀⢠⣾⣿⣿⣿⣿⣦⡀⠀⠈⢻⣿⣿⣿⣿⣿⣶⡀
⠀⠀⢻⣿⣿⣿⣿⣿⣼⣿⡟⠀⣼⣿⣿⣿⣿⣿⣿⣿⣦⣤⣾⣿⣿⣿⣿⣿⣿⠃
⠀⠀⠀⠙⠉⠁⠈⣻⣿⣿⣶⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠋⠀⠉⠙⠁⠀
⠀⠀⠀⠀⠀⠀⢠⣿⣿⣿⣿⡿⢿⣿⣿⣿⣿⣿⣿⠿⣿⣿⣿⣿⣧⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠙⠻⢿⠏⠀⠀⢸⣿⣿⣿⣿⠀⠀⠘⠿⠿⠛⠁⠀⠀⠀⠀⠀
EOF
)
  echo -e "$ascii_art"
}

check_sudo() {
  if [[ $EUID -eq 0 ]]; then
    SUDO=""
    echo -e "\n[INFO] User is root, sudo is not needed"
  else
    SUDO="sudo"
    echo -e "\n[INFO] User is not root, sudo is needed"
  fi
}

detect_os_and_package_manager() {
  echo -e "\n[INFO] Detecting the package manager..."
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

install_git_if_needed() {
  if ! command -v git &> /dev/null; then
    echo -e "\n[INFO] Git is not installed. Installing..."
    if [[ $PACKAGE_MANAGER == "apt" ]]; then
      $SUDO apt-get install -y git
    elif [[ $PACKAGE_MANAGER == "apk" ]]; then
      $SUDO apk add git
    elif [[ $PACKAGE_MANAGER == "dnf" ]]; then
      $SUDO dnf install -y git
    elif [[ $PACKAGE_MANAGER == "yum" ]]; then
      $SUDO yum install -y git
    else
      echo "[ERROR] Unsupported package manager: $PACKAGE_MANAGER"
      exit 1
    fi
  fi
}

clone_repo() {
  echo -e "\n[INFO] Cloning repo..."
  rm -rf ~/.local/share/portable-toolbelt
  git clone https://github.com/miladbeigi/portable-toolbelt.git ~/.local/share/portable-toolbelt >/dev/null
}

start_installation() {
  echo -e "\n[INFO] Installation starting..."
  cd ~/.local/share/portable-toolbelt/
  source install.sh
}

display_ascii_art
check_sudo
detect_os_and_package_manager
install_git_if_needed
clone_repo
start_installation