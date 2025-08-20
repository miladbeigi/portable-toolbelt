# --------- Set SUDO Variable ----------
if [[ $EUID -eq 0 ]]; then
  SUDO=""
  echo "[INFO] User is root, sudo is not needed"
else
  SUDO="sudo"
  echo "[INFO] User is not root, sudo is needed"
fi
