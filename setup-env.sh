#!/usr/bin/env bash

set -euo pipefail



# --- Config (you can change the base directory name if your lab wants another) ---

BASE_DIR="$HOME/nginx-lab"

DIRS=(

  "$BASE_DIR"

  "$BASE_DIR/www"

  "$BASE_DIR/logs"

  "$BASE_DIR/conf"

  "$BASE_DIR/scripts"

)



echo "==> Creating directory structure under: $BASE_DIR"

for d in "${DIRS[@]}"; do

  mkdir -p "$d"

done



echo "==> Directory structure created:"

ls -la "$BASE_DIR"



# --- Install nginx depending on OS ---

echo "==> Installing Nginx (if not installed)..."



if command -v apt >/dev/null 2>&1; then

  # Ubuntu/Debian

  sudo apt update

  sudo apt install -y nginx

elif command -v dnf >/dev/null 2>&1; then

  # Fedora/RHEL (new)

  sudo dnf install -y nginx

elif command -v yum >/dev/null 2>&1; then

  # RHEL/CentOS (older)

  sudo yum install -y nginx

elif command -v pacman >/dev/null 2>&1; then

  # Arch

  sudo pacman -Sy --noconfirm nginx

else

  echo "ERROR: Unsupported package manager. Install nginx manually."

  exit 1

fi



# --- Enable and start nginx ---

echo "==> Enabling & starting Nginx service..."

sudo systemctl enable nginx

sudo systemctl restart nginx



echo "==> Checking nginx status..."

sudo systemctl --no-pager --full status nginx | head -n 15



echo "==> Done!"

echo "Try: curl -I http://localhost"
