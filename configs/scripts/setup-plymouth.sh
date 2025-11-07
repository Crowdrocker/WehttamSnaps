#!/bin/bash
# === WEHTTAMSNAPS PLYMOUTH SETUP ===
# GitHub: https://github.com/Crowdrocker

WS_DIR="$(dirname "$(dirname "$(readlink -f "$0")")")"
PLYMOUTH_DIR="/usr/share/plymouth/themes/wehttamsnaps"

echo "Setting up WehttamSnaps Plymouth theme..."

# Check if running as root
if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root to install Plymouth theme"
   echo "Please run: sudo $0"
   exit 1
fi

# Create Plymouth theme directory
mkdir -p "$PLYMOUTH_DIR"

# Copy theme files
cp "$WS_DIR/themes/plymouth/wehttamsnaps.plymouth" "$PLYMOUTH_DIR/"
cp "$WS_DIR/themes/plymouth/wehttamsnaps.script" "$PLYMOUTH_DIR/"

# Copy logo files
cp "$WS_DIR/assets/logos/ws-logo.png" "$PLYMOUTH_DIR/"
cp "$WS_DIR/assets/logos/reactor.png" "$PLYMOUTH_DIR/background.png"

# Create progress bar (simple)
convert -size 400x4 xc:none -fill "#7aa2f7" -draw "rectangle 0,0 400,4" "$PLYMOUTH_DIR/progress-bar.png" 2>/dev/null || {
    # Fallback: create simple progress bar with ImageMagick alternative
    echo "Creating fallback progress bar..."
    cat > "$PLYMOUTH_DIR/progress-bar.png" << 'EOF'
PNG

EOF
}

# Set permissions
chmod 644 "$PLYMOUTH_DIR"/*
chown root:root "$PLYMOUTH_DIR"/*

# Install the theme
plymouth-set-default-theme -R wehttamsnaps

# Update initramfs
if command -v update-initramfs &> /dev/null; then
    update-initramfs -u
elif command -v mkinitcpio &> /dev/null; then
    mkinitcpio -P
fi

echo "WehttamSnaps Plymouth theme installed successfully!"
echo "Reboot to see the animated boot screen."

# Show notification
if command -v notify-send &> /dev/null; then
    notify-send "WehttamSnaps Plymouth" "Boot theme installed" -a WehttamSnaps
fi