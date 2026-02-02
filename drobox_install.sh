#!/bin/bash
set -e

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
