#!/bin/bash
set -e

# 02_setup_repos.sh
if [[ $EUID -ne 0 ]]; then
   echo "Error: This script must be run as root (use sudo)"
   exit 1
fi

echo "--- 2. Setting up Repositories ---"
apt install -y curl git gpg ca-certificates wget

# --- Google Antigravity Repo ---
echo "Adding Google Antigravity Repository..."
mkdir -p /etc/apt/keyrings
curl -fsSL https://us-central1-apt.pkg.dev/doc/repo-signing-key.gpg | \
  gpg --dearmor --yes -o /etc/apt/keyrings/antigravity-repo-key.gpg
echo "deb [signed-by=/etc/apt/keyrings/antigravity-repo-key.gpg] https://us-central1-apt.pkg.dev/projects/antigravity-auto-updater-dev/ antigravity-debian main" | \
  tee /etc/apt/sources.list.d/antigravity.list > /dev/null

# --- GitHub CLI Official Repo ---
echo "Adding GitHub CLI Repository..."
curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg | \
  gpg --dearmor --yes -o /etc/apt/keyrings/githubcli-archive-keyring.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | \
  tee /etc/apt/sources.list.d/github-cli.list > /dev/null

# update apt to pull in new repos
apt update

# --- Dropbox Installation ---
echo "--- Installing Dropbox ---"

if [ -n "$SUDO_USER" ]; then
    USER_HOME=$(getent passwd "$SUDO_USER" | cut -d: -f6)
    echo "Setting up Dropbox headless daemon for $SUDO_USER in $USER_HOME..."
    
    # Download and extract the daemon as the user
    sudo -u "$SUDO_USER" bash -c "cd $USER_HOME && wget -O - \"https://www.dropbox.com/download?plat=lnx.x86_64\" | tar xzf -"
    
    # Download the Python control script
    echo "Downloading Dropbox Python control script..."
    wget -O /usr/local/bin/dropbox-cli "https://www.dropbox.com/download?dl=packages/dropbox.py"
    chmod +x /usr/local/bin/dropbox-cli
    
    echo "Dropbox headless daemon installed."
    echo "To link your account, the user '$SUDO_USER' should run: ~/.dropbox-dist/dropboxd"
    echo "You can manage Dropbox using the 'dropbox-cli' command."
else
    echo "SUDO_USER not detected. Skipping headless setup."
fi

echo "--- Setup Complete ---"