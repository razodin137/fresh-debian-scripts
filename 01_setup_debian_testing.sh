#!/bin/bash
set -e

# 01_setup_debian_testing.sh
# Check for root
if [[ $EUID -ne 0 ]]; then
   echo "Error: This script must be run as root (use sudo)"
   exit 1
fi

echo "--- 1. Setting up Debian Unstable (Sid) ---"
# Backup existing sources
cp /etc/apt/sources.list /etc/apt/sources.list.bak

# Update sources to Unstable
cat <<EOF > /etc/apt/sources.list
deb http://deb.debian.org/debian/ unstable main contrib non-free non-free-firmware
deb-src http://deb.debian.org/debian/ unstable main contrib non-free non-free-firmware

# Experimental repo (useful for grabbing specific ultra-new packages)
deb http://deb.debian.org/debian/ experimental main contrib non-free non-free-firmware
EOF

export DEBIAN_FRONTEND=noninteractive
apt update
apt full-upgrade -y
