#!/bin/bash
set -e

# 02_setup_repos.sh
# 02_setup_repos.sh

echo "--- 2. Setting up Repositories ---"
sudo apt install -y curl git gpg ca-certificates wget


# --- GitHub CLI Official Repo ---
echo "Adding GitHub CLI Repository..."
curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg | \
  sudo gpg --dearmor --yes -o /etc/apt/keyrings/githubcli-archive-keyring.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | \
  sudo tee /etc/apt/sources.list.d/github-cli.list > /dev/null

# update apt to pull in new repos
sudo apt update

sudo apt install gh

