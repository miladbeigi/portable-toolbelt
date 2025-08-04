#!/usr/bin/env bash

set -e

# --------- Load Core Utilities ----------
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/src/core/detect_os.sh"

# --------- OS Detection --------------
detect_os
echo "[INFO] Detected OS: $DISTRO_NAME"