#!/bin/bash
# Nuclear Option: Disable Middle Mouse Click via Libinput Quirks
# specific for VMware/QEMU environment

if [ "$EUID" -ne 0 ]; then
  echo "This script requires root privileges. Elevating..."
  exec sudo "$0" "$@"
fi

QUIRKS_FILE="/etc/libinput/local-overrides.quirks"

echo "Writing libinput quirks to $QUIRKS_FILE..."

# Ensure directory exists
mkdir -p /etc/libinput

cat > "$QUIRKS_FILE" <<EOF
[Disable Middle Click VMMouse]
MatchName=VirtualPS/2 VMware VMMouse
AttrEventCode=-BTN_MIDDLE

[Disable Middle Click QEMU Tablet]
MatchName=QEMU QEMU USB Tablet
AttrEventCode=-BTN_MIDDLE
EOF

echo "Done. File content:"
cat "$QUIRKS_FILE"

echo ""
echo "IMPORTANT: You must REBOOT for these changes to take effect."
