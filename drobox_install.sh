#!/bin/bash
set -e

# --- Dropbox Installation ---
# --- Dropbox Installation ---
echo "--- Installing Dropbox ---"

# Install headless daemon for current user
echo "Setting up Dropbox headless daemon for $USER in $HOME..."

# Download and extract the daemon
cd ~ && wget -O - "https://www.dropbox.com/download?plat=lnx.x86_64" | tar xzf -

# Download the Python control script
echo "Downloading Dropbox Python control script..."
sudo wget -O /usr/local/bin/dropbox-cli "https://www.dropbox.com/download?dl=packages/dropbox.py"
sudo chmod +x /usr/local/bin/dropbox-cli

echo "Dropbox headless daemon installed."
echo "To link your account, run: ~/.dropbox-dist/dropboxd"
echo "You can manage Dropbox using the 'dropbox-cli' command."

echo "--- Setup Complete ---"
