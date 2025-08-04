#!/usr/bin/env bash

set -e

# ASCII ART
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

# If user is root, sudo is not needed
if [[ $EUID -eq 0 ]]; then
  SUDO=""
  echo -e "\n[INFO] User is root, sudo is not needed"
else
  SUDO="sudo"
  echo -e "\n[INFO] User is not root, sudo is needed"
fi

# Detect Package Manager
echo -e "\n[INFO] Detecting the package manager..."
if [[ -f /etc/os-release ]]; then
  . /etc/os-release
  OS_ID="${ID,,}"  # lowercase
  case "$OS_ID" in
    ubuntu|debian|pop)
      PACKAGE_MANAGER="apt"
      echo "[INFO] Detected APT package manager"
      ;;
    alpine)
      PACKAGE_MANAGER="apk"
      echo "[INFO] Detected APK package manager"
      ;;
    *)
      echo "[ERROR] Unsupported or unrecognized distro: $OS_ID"
      exit 1
      ;;
  esac
fi

# Install Git
echo -e "\n[INFO] Installing Git..."

if [[ $PACKAGE_MANAGER == "apt" ]]; then
  $SUDO apt-get update && $SUDO apt-get install -y git
elif [[ $PACKAGE_MANAGER == "apk" ]]; then
  $SUDO apk add git
else
  echo "[ERROR] Unsupported package manager: $PACKAGE_MANAGER"
  exit 1
fi

echo -e "\n[INFO] Cloning repo..."

rm -rf ~/.local/share/portable-toolbelt
git clone https://github.com/miladbeigi/portable-toolbelt.git ~/.local/share/portable-toolbelt >/dev/null

echo -e "\n[INFO] Installation starting..."
cd ~/.local/share/portable-toolbelt/
source install.sh