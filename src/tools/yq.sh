#!/usr/bin/env bash
set -e

install_yq() {
  case "$DISTRO_FAMILY" in
    debian)
      $SUDO $PACKAGE_MANAGER install -y curl
      YQ_VERSION="v4.40.5"
      YQ_BINARY="yq_linux_amd64"
      echo "[INFO] Installing yq ${YQ_VERSION} from GitHub releases..."
      curl -sSL "https://github.com/mikefarah/yq/releases/download/${YQ_VERSION}/${YQ_BINARY}" -o /tmp/yq
      chmod +x /tmp/yq
      $SUDO mv /tmp/yq /usr/local/bin/yq
      ;;
    alpine)
      $SUDO $PACKAGE_MANAGER add yq
      ;;
    redhat)
      $SUDO $PACKAGE_MANAGER install -y curl
      YQ_VERSION="v4.40.5"
      YQ_BINARY="yq_linux_amd64"
      echo "[INFO] Installing yq ${YQ_VERSION} from GitHub releases..."
      curl -sSL "https://github.com/mikefarah/yq/releases/download/${YQ_VERSION}/${YQ_BINARY}" -o /tmp/yq
      chmod +x /tmp/yq
      $SUDO mv /tmp/yq /usr/local/bin/yq
      ;;
    *)
      echo "[ERROR] Yq install not supported on this distro: $DISTRO_FAMILY"
      exit 1
      ;;
  esac
}