#!/usr/bin/env bash

set -e

# --------- Load Core Utilities ----------
cd ~/.local/share/portable-toolbelt/
source src/core/detect_os.sh

# --------- OS Detection --------------
detect_os
echo "[INFO] Detected OS: $DISTRO_NAME"