#!/usr/bin/env bash

set -e

# --------- Default Config -----------
TOOLS_TO_INSTALL=()
PROFILE=""
DEFAULT_PROFILE="core"

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
    --profile=*)
      PROFILE="${arg#*=}"
      ;;
    *)
      echo "[INFO] Unknown option: $arg"
      ;;
  esac
done

# --------- Use Default Profile If Nothing Is Specified ----------
if [[ ${#TOOLS_TO_INSTALL[@]} -eq 0 && -z "$PROFILE" ]]; then
  PROFILE="$DEFAULT_PROFILE"
  echo "[INFO] No tools or profile specified. Defaulting to profile: $PROFILE"
fi

# --------- Load Profile ----------
if [[ -n "$PROFILE" ]]; then
  PROFILE_FILE="profiles/${PROFILE}.txt"
  if [[ -f "$PROFILE_FILE" ]]; then
    echo "[INFO] Loading tools from profile: $PROFILE"
    while IFS= read -r line || [[ -n "$line" ]]; do
      [[ -n "$line" && ! "$line" =~ ^# ]] && TOOLS_TO_INSTALL+=("$line")
    done < "$PROFILE_FILE"
  else
    echo "[ERROR] Profile not found: $PROFILE_FILE"
    exit 1
  fi
fi

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
