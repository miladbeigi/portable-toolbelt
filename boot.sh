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
      $SUDO apt-get update
      ;;
    alpine)
      PACKAGE_MANAGER="apk"
      echo "[INFO] Detected APK package manager"
      $SUDO apk update
      ;;
    centos|rhel|rocky|almalinux|fedora)
      # Detect package manager (DNF preferred over YUM)
      if command -v dnf &> /dev/null; then
        PACKAGE_MANAGER="dnf"
        echo "[INFO] Detected DNF package manager"
        $SUDO dnf check-update || true  # Don't fail on available updates
      elif command -v yum &> /dev/null; then
        PACKAGE_MANAGER="yum"
        echo "[INFO] Detected YUM package manager"
        $SUDO yum check-update || true  # Don't fail on available updates
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
fi

# Check if Git is installed
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

echo -e "\n[INFO] Cloning repo..."

rm -rf ~/.local/share/portable-toolbelt
git clone https://github.com/miladbeigi/portable-toolbelt.git ~/.local/share/portable-toolbelt >/dev/null

echo -e "\n[INFO] Installation starting..."
cd ~/.local/share/portable-toolbelt/
source install.sh