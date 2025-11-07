#!/bin/bash
# === WEHTTAMSNAPS WEBAPP CREATOR ===
# GitHub: https://github.com/Crowdrocker
# Creates webapp desktop entries for WehttamSnaps

show_help() {
    echo "WehttamSnaps WebApp Creator"
    echo "Usage: $0 &quot;App Name&quot; &quot;URL&quot; [icon_name]"
    echo ""
    echo "Examples:"
    echo "  $0 &quot;YouTube&quot; &quot;https://youtube.com&quot; &quot;youtube&quot;"
    echo "  $0 &quot;Twitch&quot; &quot;https://twitch.tv&quot; &quot;twitch&quot;"
    echo "  $0 &quot;GitHub&quot; &quot;https://github.com&quot; &quot;github&quot;"
    echo ""
    echo "Icons available: youtube, twitch, discord, github, spotify, twitter"
}

if [[ $# -lt 2 ]]; then
    show_help
    exit 1
fi

APP_NAME="$1"
URL="$2"
ICON_NAME="${3:-applications-internet}"
SAFE_NAME=$(echo "$APP_NAME" | tr ' ' '-' | tr '[:upper:]' '[:lower:]')

# Create desktop entry
DESKTOP_FILE="$HOME/.local/share/applications/wehttamsnaps-$SAFE_NAME.desktop"

cat > "$DESKTOP_FILE" << EOF
[Desktop Entry]
Version=1.0
Type=Application
Name=$APP_NAME
Comment=$APP_NAME WebApp
Exec=firefox --new-window --class=wehttamsnaps-$SAFE_NAME "$URL"
Icon=$ICON_NAME
Terminal=false
Categories=Network;WebBrowser;
StartupNotify=true
StartupWMClass=wehttamsnaps-$SAFE_NAME
Keywords=web;internet;browser;
EOF

# Make executable
chmod +x "$DESKTOP_FILE"

# Add Hyprland window rule
RULE="windowrulev2 = workspace 2, class:^(wehttamsnaps-$SAFE_NAME)$"
RULE_FILE="$HOME/.config/wehttamsnaps/webapp-rules.conf"

if ! grep -q "$RULE" "$RULE_FILE" 2>/dev/null; then
    echo "$RULE" >> "$RULE_FILE"
fi

# Add keybinding
KEYBINDING="bind = \$mod CTRL, $(echo "$APP_NAME" | head -c 1 | tr '[:lower:]' '[:upper:]'), exec, firefox --new-window &quot;$URL&quot;"
BINDING_FILE="$HOME/.config/wehttamsnaps/webapp-keybinds.conf"

if ! grep -q "$KEYBINDING" "$BINDING_FILE" 2>/dev/null; then
    echo "$KEYBINDING" >> "$BINDING_FILE"
fi

echo "WebApp '$APP_NAME' created successfully!"
echo "Desktop entry: $DESKTOP_FILE"
echo "Keybinding: SUPER+CTRL+$(echo "$APP_NAME" | head -c 1 | tr '[:lower:]' '[:upper:]')"
echo ""
echo "To apply Hyprland rules, add this to your ~/.config/hypr/conf.d/05-rules.conf:"
echo "$RULE"
echo ""
echo "To apply keybinding, add this to your ~/.config/hypr/conf.d/06-bindings.conf:"
echo "$KEYBINDING"

# Show notification
notify-send "WehttamSnaps WebApp" "$APP_NAME created successfully" -a WehttamSnaps