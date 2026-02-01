#!/bin/bash
# Script to disable middle mouse click behaviors on the trackpad/mouse
# Targeted at GNOME on Wayland systems, including Virtual Machines (VMware/QEMU)

echo "--- Advanced Disable Middle Click ---"

# 1. Disable Global GTK Primary Selection Paste (The most common reason middle click is annoying)
echo "Disabling global middle-click paste (primary selection)..."
gsettings set org.gnome.desktop.interface gtk-enable-primary-paste false

# 2. Disable Middle Click Emulation for both Touchpad and Mouse
# This prevents clicking L+R together from acting as a middle click.
echo "Disabling middle-click emulation..."
gsettings set org.gnome.desktop.peripherals.touchpad middle-click-emulation false
gsettings set org.gnome.desktop.peripherals.mouse middle-click-emulation false

# 3. Touchpad specific: Change Click Method
# If it's a real touchpad, 'areas' prevents the 3-finger middle click.
echo "Setting touchpad click method to 'areas'..."
gsettings set org.gnome.desktop.peripherals.touchpad click-method 'areas'

# 4. Firefox Fix (Primary Selection is hardcoded in Firefox config)
if [ -d "$HOME/.mozilla/firefox" ]; then
    echo "Attempting to disable middle-click paste in Firefox profiles..."
    find "$HOME/.mozilla/firefox" -name "prefs.js" -exec sh -c 'grep -q "middlemouse.paste" "$1" || echo "user_pref(\"middlemouse.paste\", false);" >> "$1"' _ {} \;
    find "$HOME/.mozilla/firefox" -name "prefs.js" -exec sh -c 'grep -q "middlemouse.contentLoadURL" "$1" || echo "user_pref(\"middlemouse.contentLoadURL\", false);" >> "$1"' _ {} \;
fi

echo "-------------------------------------------------------"
echo "Middle click behaviors have been restricted."
echo "- GTK Primary Paste: DISABLED"
echo "- Middle-click emulation: DISABLED (Touchpad & Mouse)"
echo "- Firefox middle-click paste: DISABLED (applied to profiles)"
echo "-------------------------------------------------------"

# Check if we are in a VM (VMware/QEMU mice often ignore GNOME touchpad settings)
if grep -iqE "vmware|qemu" /proc/bus/input/devices; then
    echo "⚠️  DETECTED VIRTUAL MACHINE:"
    echo "VMware/QEMU mice often act as simple mice, not touchpads."
    echo "If middle-click paste is STILL happening in some apps,"
    echo "you may need to disable the button at the hardware level."
    echo ""
    echo "THE NUCLEAR OPTION (requires sudo):"
    echo "Create a libinput quirk to ignore the middle button entirely:"
    echo "sudo mkdir -p /etc/libinput"
    echo "echo '[Disable Middle Click]' | sudo tee /etc/libinput/local-overrides.quirks"
    echo "echo 'MatchName=VirtualPS/2 VMware VMMouse' | sudo tee -a /etc/libinput/local-overrides.quirks"
    echo "echo 'AttrEventCode=-BTN_MIDDLE' | sudo tee -a /etc/libinput/local-overrides.quirks"
    echo "Then REBOOT or restart your session."
fi


















































































































