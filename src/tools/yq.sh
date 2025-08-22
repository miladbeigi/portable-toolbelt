#!/usr/bin/env bash
set -e

install_yq() {
  case "$DISTRO_NAME" in
    ubuntu|debian|pop)
      # yq is not available in default Ubuntu repos, install from GitHub releases
      YQ_VERSION="v4.40.5"
      YQ_BINARY="yq_linux_amd64"
      
      echo "[INFO] Installing yq ${YQ_VERSION} from GitHub releases..."
      curl -sSL "https://github.com/mikefarah/yq/releases/download/${YQ_VERSION}/${YQ_BINARY}" -o /tmp/yq
      chmod +x /tmp/yq
      $SUDO mv /tmp/yq /usr/local/bin/yq
      ;;

    alpine)
      $SUDO apk update
      $SUDO apk add yq
      ;;

    fedora)
      # RHEL/Fedora also doesn't have yq in default repos, use GitHub releases
      YQ_VERSION="v4.40.5"
      YQ_BINARY="yq_linux_amd64"
      
      echo "[INFO] Installing yq ${YQ_VERSION} from GitHub releases..."
      curl -sSL "https://github.com/mikefarah/yq/releases/download/${YQ_VERSION}/${YQ_BINARY}" -o /tmp/yq
      chmod +x /tmp/yq
      $SUDO mv /tmp/yq /usr/local/bin/yq
      ;;

    *)
      echo "[ERROR] yq install not supported on distro: $DISTRO_NAME"
      exit 1
      ;;
  esac
}