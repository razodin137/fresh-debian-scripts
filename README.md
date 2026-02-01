# Fresh Debian Scripts

Setup scripts for a fresh Debian Testing (Unstable/Sid) environment.

## Repository
[fresh-debian-scripts-local-development](https://github.com/razodin137/fresh-debian-scripts-local-development)

## Scripts

### 1. [01_setup_debian_testing.sh](./01_setup_debian_testing.sh)
- Configuration for Debian Unstable/Testing.
- Updates `sources.list`.

### 2. [02_setup_repos.sh](./02_setup_repos.sh)
- Installs prerequisites (`curl`, `git`, `gpg`).
- Adds **Antigravity** and **GitHub CLI** repositories.
- Skips Docker as requested.

### 3. [03_install_packages.sh](./03_install_packages.sh)
- Installs all packages in categorized lists for better readability.
- Includes `gh`, `antigravity`, `zsh`, `tmux`, etc.

## How to use
```bash
git clone https://github.com/razodin137/fresh-debian-scripts-local-development.git
cd fresh-debian-scripts-local-development
sudo ./01_setup_debian_testing.sh
sudo ./02_git_plus_antigrav.sh
```
