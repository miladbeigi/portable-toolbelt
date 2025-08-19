#!/usr/bin/env bash
set -e

install_pipx() {
  case "$DISTRO_NAME" in
    ubuntu|debian|pop)
      # Try to install pipx via apt first (available in newer Ubuntu versions)
      if $SUDO apt update -y && $SUDO apt install -y pipx 2>/dev/null; then
        echo "[INFO] pipx installed via apt"
      else
        echo "[INFO] pipx not available via apt, installing via pip"
        # Ensure python3-pip is available
        $SUDO apt install -y python3-pip
        python3 -m pip install --user pipx
      fi
      ;;

    alpine)
      # Alpine needs bootstrap via pip
      $SUDO apk update
      $SUDO apk add python3 py3-pip
      python3 -m pip install --user pipx
      ;;

    *)
      echo "[ERROR] pipx install not supported on distro: $DISTRO_NAME"
      exit 1
      ;;
  esac
  
  # Ensure pipx is in PATH
  export PATH="$HOME/.local/bin:$PATH"
  echo 'export PATH="$HOME/.local/bin:$PATH"' >> ~/.bashrc
}