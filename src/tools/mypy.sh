#!/usr/bin/env bash
set -e

install_mypy() {
  # Ensure pipx is available and in PATH
  export PATH="$HOME/.local/bin:$PATH"
  
  # Check if pipx is available
  if ! command -v pipx &> /dev/null; then
    echo "[ERROR] pipx is required to install mypy. Please install pipx first."
    exit 1
  fi
  
  # Install mypy via pipx
  pipx install mypy
}