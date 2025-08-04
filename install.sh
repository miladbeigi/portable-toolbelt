#!/usr/bin/env bash

set -e

# --------- Default Config -----------
REPO_URL="https://github.com/miladbeigi/portable-toolbelt"
CLONE_DIR="/tmp/portable-toolbelt"

# --------- Clone Repo ----------
if [[ ! -f "$(dirname "$0")/core/detect_os.sh" ]]; then
  echo "[INFO] Cloning full installer from $REPO_URL..."
  rm -rf "$CLONE_DIR"
  git clone --quiet "$REPO_URL.git" "$CLONE_DIR"

  echo "[INFO] Re-launching installer from cloned repo..."
  exec bash "$CLONE_DIR/install.sh" "$@"
  exit 0
fi

# --------- Load Core Utilities ----------
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/core/detect_os.sh"

# --------- OS Detection --------------
detect_os
echo "[INFO] Detected OS: $DISTRO_NAME"