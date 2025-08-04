#!/usr/bin/env bash

set -e

# --------- Default Config -----------
TOOLS_TO_INSTALL=()

# --------- Load Core Utilities ----------
source src/core/detect_os.sh

# --------- OS Detection --------------
detect_os
echo "[INFO] Detected OS: $DISTRO_NAME"

# --------- Parse Arguments -----------
for arg in "$@"; do
  case $arg in
    --tools=*)
      IFS=',' read -ra TOOLS_TO_INSTALL <<< "${arg#*=}"
      ;;
    *)
      echo "[INFO] Unknown option: $arg"
      ;;
  esac
done


# --------- Install Tools ----------
for tool in "${TOOLS_TO_INSTALL[@]}"; do
  TOOL_SCRIPT="src/tools/${tool}.sh"
  if [[ -f "$TOOL_SCRIPT" ]]; then
    echo "[INFO] Installing $tool..."
    source "$TOOL_SCRIPT"
    install_"$tool"
    echo "[INFO] $tool installed successfully."
  else
    echo "[ERROR] No install script found for tool: $tool"
  fi
done

echo "[INFO] All requested tools processed."
