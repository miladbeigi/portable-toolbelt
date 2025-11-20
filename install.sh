#!/usr/bin/env bash

set -e

# --------- Default Config -----------
TOOLS_TO_INSTALL=()
PROFILE=""
DEFAULT_PROFILE="core"

# --------- Load Core Utilities ----------
source src/core/detect_os.sh
source src/core/set_sudo.sh

# --------- OS Detection --------------
detect_os
echo "[INFO] Detected OS Family: $DISTRO_FAMILY"

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

# --------- Display Tools to Install ----------
display_tools_to_install() {
  echo ""
  echo "================================================="
  echo "           PACKAGES TO BE INSTALLED"
  echo "================================================="
  if [[ -n "$PROFILE" ]]; then
    echo "Profile: $PROFILE"
    echo ""
  fi
  echo "The following ${#TOOLS_TO_INSTALL[@]} tool(s) will be installed:"
  echo ""
  for i in "${!TOOLS_TO_INSTALL[@]}"; do
    printf "  %2d. %s\n" $((i+1)) "${TOOLS_TO_INSTALL[$i]}"
  done
  echo ""
  echo "================================================="
  echo ""
}

# --------- Confirm Installation ----------
confirm_installation() {
  read -p "Do you want to proceed with the installation? (y/n): " -n 1 -r
  echo ""
  if [[ ! $REPLY =~ ^[Yy]$ ]]; then
    echo "[INFO] Installation cancelled by user."
    exit 0
  fi
  echo ""
}

# Show tools to be installed
if [[ ${#TOOLS_TO_INSTALL[@]} -gt 0 ]]; then
  display_tools_to_install
  confirm_installation
fi

# --------- Install Tools ----------
INSTALLED_TOOLS=()
FAILED_TOOLS=()

for tool in "${TOOLS_TO_INSTALL[@]}"; do
  TOOL_SCRIPT="src/tools/${tool}.sh"
  if [[ -f "$TOOL_SCRIPT" ]]; then
    echo "[INFO] Installing $tool..."
    if source "$TOOL_SCRIPT" && install_"$tool"; then
      echo "[INFO] $tool installed successfully."
      INSTALLED_TOOLS+=("$tool")
    else
      echo "[ERROR] Failed to install $tool."
      FAILED_TOOLS+=("$tool")
    fi
  else
    echo "[ERROR] No install script found for tool: $tool"
    FAILED_TOOLS+=("$tool")
  fi
done

# --------- Display Installation Summary ----------
display_installation_summary() {
  echo ""
  echo "================================================="
  echo "           INSTALLATION SUMMARY"
  echo "================================================="
  
  if [[ ${#INSTALLED_TOOLS[@]} -gt 0 ]]; then
    echo "✅ Successfully installed (${#INSTALLED_TOOLS[@]} tool(s)):"
    echo ""
    for i in "${!INSTALLED_TOOLS[@]}"; do
      printf "  %2d. %s\n" $((i+1)) "${INSTALLED_TOOLS[$i]}"
    done
    echo ""
  fi
  
  if [[ ${#FAILED_TOOLS[@]} -gt 0 ]]; then
    echo "❌ Failed to install (${#FAILED_TOOLS[@]} tool(s)):"
    echo ""
    for i in "${!FAILED_TOOLS[@]}"; do
      printf "  %2d. %s\n" $((i+1)) "${FAILED_TOOLS[$i]}"
    done
    echo ""
  fi
  
  echo "================================================="
  
  if [[ ${#FAILED_TOOLS[@]} -gt 0 ]]; then
    echo "[WARNING] Some tools failed to install. Check the logs above for details."
    exit 1
  else
    echo "[INFO] All requested tools processed successfully."
  fi
}

# Show installation summary
display_installation_summary
