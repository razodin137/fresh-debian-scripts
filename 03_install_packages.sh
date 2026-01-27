#!/bin/bash
set -e

# 03_install_packages.sh
if [[ $EUID -ne 0 ]]; then
   echo "Error: This script must be run as root (use sudo)"
   exit 1
fi

echo "--- 3. Installing Packages ---"

PACKAGES=(
    # --- Core Utilities ---
    curl
    git
    wget
    unzip
    build-essential
    gpg
    
    # --- Development Tools ---
    gh
    antigravity
    python3-pip
    python3-venv
    jq
    ripgrep
    fd-find
    
    # --- Shell & Terminal ---
    zsh
    tmux
    bat
    fzf
    btop
    
    # --- Languages ---
    php-cli
    ruby-full
    
    # --- Editors ---
    nano
    
    # --- Browsers ---
    chromium
)

# Install defined packages
apt install -y "${PACKAGES[@]}"

# Fix Debian naming for bat and fd (optional but recommended)
ln -sf /usr/bin/batcat /usr/local/bin/bat || true
ln -sf /usr/bin/fdfind /usr/local/bin/fd || true

echo "All packages installed successfully!"
