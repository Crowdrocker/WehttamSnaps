#!/bin/bash
# === WEHTTAMSNAPS DEFAULT WEBAPPS ===
# GitHub: https://github.com/Crowdrocker
# Creates default webapps for WehttamSnaps

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
CREATE_SCRIPT="$SCRIPT_DIR/create-webapp.sh"

echo "Creating WehttamSnaps default webapps..."

# YouTube
$CREATE_SCRIPT "YouTube" "https://youtube.com" "youtube"

# Twitch
$CREATE_SCRIPT "Twitch" "https://twitch.tv" "twitch"

# Discord
$CREATE_SCRIPT "Discord" "https://discord.com/app" "discord"

# GitHub
$CREATE_SCRIPT "GitHub" "https://github.com/Crowdrocker" "github"

# Spotify Web
$CREATE_SCRIPT "Spotify" "https://open.spotify.com" "spotify"

# Twitter/X
$CREATE_SCRIPT "X" "https://x.com" "twitter"

# Reddit
$CREATE_SCRIPT "Reddit" "https://reddit.com" "reddit"

# Proton Mail
$CREATE_SCRIPT "Proton Mail" "https://mail.proton.me" "email"

echo "Default webapps created successfully!"
echo "Use SUPER+CTRL+[first_letter] to launch webapps"
echo ""
echo "Available keybindings:"
echo "• SUPER+CTRL+Y → YouTube"
echo "• SUPER+CTRL+T → Twitch"
echo "• SUPER+CTRL+D → Discord"
echo "• SUPER+CTRL+G → GitHub"
echo "• SUPER+CTRL+S → Spotify"
echo "• SUPER+CTRL+X → X (Twitter)"
echo "• SUPER+CTRL+R → Reddit"
echo "• SUPER+CTRL+P → Proton Mail"