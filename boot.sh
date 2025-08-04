#!/usr/bin/env bash

set -e

# PORTABLE TOOLBELT
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

echo "Cloning repo..."
rm -rf ~/.local/share/portable-toolbelt
git clone https://github.com/miladbeigi/portable-toolbelt.git ~/.local/share/portable-toolbelt >/dev/null

echo "Installation starting..."
source ~/.local/share/portable-toolbelt/install.sh