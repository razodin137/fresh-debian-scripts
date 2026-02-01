#!/bin/bash

# Script to disable middle mouse click behaviors on the trackpad
# Targeted at GNOME on Wayland systems

echo "Configuring trackpad settings..."

# 1. Disable Middle Click Emulation (clicking left and right buttons simultaneously)
gsettings set org.gnome.desktop.peripherals.touchpad middle-click-emulation false

# 2. Change Click Method
# 'fingers' (default) uses 1-finger for left, 2-finger for right, 3-finger for middle click.
# 'areas' uses the bottom right of the pad for right click and the rest for left click.
# 'none' disables software-emulated right/middle clicks entirely.
# We'll set it to 'areas' as it's often more controlled, or 'fingers' if you prefer.
# However, to ELIMINATE middle click, 'none' or disabling the paste action is best.
gsettings set org.gnome.desktop.peripherals.touchpad click-method 'areas'

# 3. Disable Primary Selection Paste (The most common reason middle click is annoying)
# This prevents the middle click from pasting highlighted text.
echo "Disabling middle-click paste (primary selection)..."
gsettings set org.gnome.desktop.interface gtk-enable-primary-paste false

# 4. (Optional) Disable tap-to-click if accidental taps are the issue
# gsettings set org.gnome.desktop.peripherals.touchpad tap-to-click false

echo "-------------------------------------------------------"
echo "Middle click behaviors have been disabled/restricted."
echo "- Middle-click emulation: Disabled"
echo "- Click method: Set to 'areas' (Bottom right for right-click)"
echo "- Global middle-click paste: Disabled"
echo "-------------------------------------------------------"
echo "To revert these changes, you can run:"
echo "  gsettings set org.gnome.desktop.peripherals.touchpad middle-click-emulation true"
echo "  gsettings set org.gnome.desktop.peripherals.touchpad click-method 'fingers'"
echo "  gsettings set org.gnome.desktop.interface gtk-enable-primary-paste true"
