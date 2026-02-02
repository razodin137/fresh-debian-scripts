#!/bin/bash
set -e

# 02_setup_repos.sh
# 02_setup_repos.sh

echo "--- 2. Setting up Repositories ---"
sudo apt install -y curl git gpg ca-certificates wget

# --- Antigravity Repo ---
sudo mkdir -p /etc/apt/keyrings &&
curl -fsSL https://us-central1-apt.pkg.dev/doc/repo-signing-key.gpg | \
 sudo gpg --dearmor --yes -o /etc/apt/keyrings/antigravity-repo-key.gpg  &&
echo "deb [signed-by=/etc/apt/keyrings/antigravity-repo-key.gpg] https://us-central1-apt.pkg.dev/projects/antigravity-auto-updater-dev/ antigravity-debian main" | \
 sudo tee /etc/apt/sources.list.d/antigravity.list > /dev/null &&

# update apt to pull in new repos
sudo apt update

echo "Repositories have been set up successfully. Run sudo apt install antigravity when you're ready."
