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
