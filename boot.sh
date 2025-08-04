#!/usr/bin/env bash

set -e

# ASCII ART
ascii_art=$(cat << "EOF"
__________              __        ___.   .__    ___________           .__ ___.          .__   __   
\______   \____________/  |______ \_ |__ |  |   \__    ___/___   ____ |  |\_ |__   ____ |  |_/  |_ 
 |     ___/  _ \_  __ \   __\__  \ | __ \|  |     |    | /  _ \ /  _ \|  | | __ \_/ __ \|  |\   __\
 |    |  (  <_> )  | \/|  |  / __ \| \_\ \  |__   |    |(  <_> |  <_> )  |_| \_\ \  ___/|  |_|  |  
 |____|   \____/|__|   |__| (____  /___  /____/   |____| \____/ \____/|____/___  /\___  >____/__|  
                                 \/    \/                                      \/     \/           
EOF
)

echo -e "$ascii_art"

# Detect OS
if [[ -f /etc/os-release ]]; then
  . /etc/os-release
  OS_ID="${ID,,}"  # lowercase
  case "$OS_ID" in
    ubuntu|debian)
      DISTRO_NAME="ubuntu"
      PACKAGE_MANAGER="apt"
      ;;
    alpine)
      DISTRO_NAME="alpine"
      PACKAGE_MANAGER="apk"
      ;;
    *)
      echo "[ERROR] Unsupported or unrecognized distro: $OS_ID"
      exit 1
      ;;
  esac
fi

# Install Git
if [[ $PACKAGE_MANAGER == "apt" ]]; then
  sudo apt-get update && sudo apt-get install -y git
elif [[ $PACKAGE_MANAGER == "apk" ]]; then
  sudo apk add git
else
  echo "[ERROR] Unsupported package manager: $PACKAGE_MANAGER"
  exit 1
fi

echo "Cloning repo..."
rm -rf ~/.local/share/portable-toolbelt
git clone https://github.com/miladbeigi/portable-toolbelt.git ~/.local/share/portable-toolbelt >/dev/null

echo "Installation starting..."
source ~/.local/share/portable-toolbelt/install.sh