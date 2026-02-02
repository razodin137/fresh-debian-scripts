#!/bin/bash
set -e

# 01_setup_debian_testing.sh
# 01_setup_debian_testing.sh
# 1. Backup existing sources
sudo cp /etc/apt/sources.list /etc/apt/sources.list.bak

# 2. Update sources to point to 'testing' keyword
# This replaces whatever version name (trixie, stable, etc.) with 'testing'
sudo sed -i 's/trixie/testing/g' /etc/apt/sources.list
sudo sed -i 's/stable/testing/g' /etc/apt/sources.list

# 3. Update package index
sudo apt update
