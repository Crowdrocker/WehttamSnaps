#!/bin/bash
# ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
# WehttamSnaps Audio Routing Setup
# Creates virtual sinks for streaming and content creation
# Similar to Voicemeeter but using PipeWire
# ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

CONFIG_DIR="$HOME/.config/wehttamsnaps/audio"
PIPEWIRE_CONFIG="$HOME/.config/pipewire/pipewire.conf.d"

# Colors
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
NC='\033[0m'

echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo -e "${BLUE}WehttamSnaps Audio Routing Setup${NC}"
echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo ""

# ┌─────────────────────────────────────────────────────────────────────────┐
# │ CHECK PREREQUISITES                                                      │
# └─────────────────────────────────────────────────────────────────────────┘

if ! command -v pw-cli &> /dev/null; then
    echo -e "${YELLOW}Error: PipeWire not found. Please install pipewire.${NC}"
    exit 1
fi

if ! command -v wpctl &> /dev/null; then
    echo -e "${YELLOW}Error: wireplumber not found. Please install wireplumber.${NC}"
    exit 1
fi

# ┌─────────────────────────────────────────────────────────────────────────┐
# │ CREATE CONFIGURATION DIRECTORIES                                         │
# └─────────────────────────────────────────────────────────────────────────┘

mkdir -p "$CONFIG_DIR"
mkdir -p "$PIPEWIRE_CONFIG"
mkdir -p "$HOME/.config/qpwgraph/layouts"

# ┌─────────────────────────────────────────────────────────────────────────┐
# │ CREATE VIRTUAL SINKS                                                     │
# └─────────────────────────────────────────────────────────────────────────┘

echo -e "${GREEN}Creating virtual audio sinks...${NC}"

# Create PipeWire virtual devices config
cat > "$PIPEWIRE_CONFIG/virtual-devices.conf" << 'EOF'
# WehttamSnaps Virtual Audio Devices
# Created by setup-audio.sh

context.modules = [
    # Game Audio Sink
    {
        name = libpipewire-module-loopback
        args = {
            node.description = "Game Audio"
            capture.props = {
                node.name = "game_audio_sink"
                media.class = "Audio/Sink"
                audio.position = [ FL FR ]
            }
            playback.props = {
                node.name = "game_audio_output"
                media.class = "Audio/Source"
                audio.position = [ FL FR ]
            }
        }
    }
    
    # Discord/Chat Sink
    {
        name = libpipewire-module-loopback
        args = {
            node.description = "Discord/Chat"
            capture.props = {
                node.name = "chat_audio_sink"
                media.class = "Audio/Sink"
                audio.position = [ FL FR ]
            }
            playback.props = {
                node.name = "chat_audio_output"
                media.class = "Audio/Source"
                audio.position = [ FL FR ]
            }
        }
    }
    
    # Music/Browser Sink
    {
        name = libpipewire-module-loopback
        args = {
            node.description = "Music/Browser"
            capture.props = {
                node.name = "music_audio_sink"
                media.class = "Audio/Sink"
                audio.position = [ FL FR ]
            }
            playback.props = {
                node.name = "music_audio_output"
                media.class = "Audio/Source"
                audio.position = [ FL FR ]
            }
        }
    }
    
    # Desktop Audio (Everything Else)
    {
        name = libpipewire-module-loopback
        args = {
            node.description = "Desktop Audio"
            capture.props = {
                node.name = "desktop_audio_sink"
                media.class = "Audio/Sink"
                audio.position = [ FL FR ]
            }
            playback.props = {
                node.name = "desktop_audio_output"
                media.class = "Audio/Source"
                audio.position = [ FL FR ]
            }
        }
    }
]
EOF

echo -e "${GREEN}✓ Virtual sinks configuration created${NC}"

# ┌─────────────────────────────────────────────────────────────────────────┐
# │ CREATE QPWGRAPH LAYOUT PRESETS                                           │
# └─────────────────────────────────────────────────────────────────────────┘

echo -e "${GREEN}Creating qpwgraph layout presets...${NC}"

# Streaming Layout
cat > "$HOME/.config/qpwgraph/layouts/streaming.qpwgraph" << 'EOF'
<!DOCTYPE qpwgraph>
<qpwgraph version="0.5.0">
 <nodes>
  <!-- Virtual Sinks -->
  <node type="1" name="game_audio_sink"/>
  <node type="1" name="chat_audio_sink"/>
  <node type="1" name="music_audio_sink"/>
  <node type="1" name="desktop_audio_sink"/>
 </nodes>
 <connections>
  <!-- Route all sinks to main output -->
  <connect output="game_audio_output:output_FL" input="alsa_output.pci-0000_00_1f.3.analog-stereo:playback_FL"/>
  <connect output="game_audio_output:output_FR" input="alsa_output.pci-0000_00_1f.3.analog-stereo:playback_FR"/>
  <connect output="chat_audio_output:output_FL" input="alsa_output.pci-0000_00_1f.3.analog-stereo:playback_FL"/>
  <connect output="chat_audio_output:output_FR" input="alsa_output.pci-0000_00_1f.3.analog-stereo:playback_FR"/>
  <connect output="music_audio_output:output_FL" input="alsa_output.pci-0000_00_1f.3.analog-stereo:playback_FL"/>
  <connect output="music_audio_output:output_FR" input="alsa_output.pci-0000_00_1f.3.analog-stereo:playback_FR"/>
 </connections>
</qpwgraph>
EOF

echo -e "${GREEN}✓ qpwgraph layouts created${NC}"

# ┌─────────────────────────────────────────────────────────────────────────┐
# │ CREATE HELPER SCRIPTS                                                    │
# └─────────────────────────────────────────────────────────────────────────┘

# Script to route applications to specific sinks
cat > "$CONFIG_DIR/route-app.sh" << 'EOF'
#!/bin/bash
# Route an application to a specific virtual sink

APP_NAME="$1"
SINK_NAME="$2"

if [ -z "$APP_NAME" ] || [ -z "$SINK_NAME" ]; then
    echo "Usage: route-app.sh <app_name> <sink_name>"
    echo ""
    echo "Available sinks:"
    echo "  game_audio_sink"
    echo "  chat_audio_sink"
    echo "  music_audio_sink"
    echo "  desktop_audio_sink"
    exit 1
fi

# Find the application's sink input
SINK_INPUT=$(pactl list sink-inputs | grep -B 20 "$APP_NAME" | grep "Sink Input" | head -1 | awk '{print $3}' | tr -d '#')

if [ -z "$SINK_INPUT" ]; then
    echo "Error: Could not find application '$APP_NAME'"
    exit 1
fi

# Move the sink input to the specified sink
pactl move-sink-input "$SINK_INPUT" "$SINK_NAME"
echo "Moved $APP_NAME to $SINK_NAME"
EOF

chmod +x "$CONFIG_DIR/route-app.sh"

# Script to quickly setup OBS sources
cat > "$CONFIG_DIR/setup-obs-sources.sh" << 'EOF'
#!/bin/bash
# Quick guide for setting up OBS audio sources

echo "═══════════════════════════════════════════════════════════════"
echo "OBS Audio Source Setup Guide"
echo "═══════════════════════════════════════════════════════════════"
echo ""
echo "1. Open OBS Studio"
echo ""
echo "2. Add Audio Sources:"
echo "   Settings → Audio → Add the following Desktop Audio Devices:"
echo ""
echo "   • Game Audio     → game_audio_output"
echo "   • Discord/Chat   → chat_audio_output"
echo "   • Music/Browser  → music_audio_output"
echo "   • Microphone     → (your physical mic)"
echo ""
echo "3. Route Applications:"
echo "   Use pavucontrol (SUPER+SHIFT+M) to route apps to sinks:"
echo ""
echo "   • Game (Steam/Lutris) → Game Audio"
echo "   • Discord             → Discord/Chat"
echo "   • Spotify/Firefox     → Music/Browser"
echo ""
echo "4. Control Individual Volumes:"
echo "   Each source has its own volume slider in OBS"
echo ""
echo "5. Mute/Unmute:"
echo "   Click speaker icon next to each source"
echo ""
echo "═══════════════════════════════════════════════════════════════"
EOF

chmod +x "$CONFIG_DIR/setup-obs-sources.sh"

# ┌─────────────────────────────────────────────────────────────────────────┐
# │ RESTART PIPEWIRE                                                         │
# └─────────────────────────────────────────────────────────────────────────┘

echo ""
echo -e "${YELLOW}Restarting PipeWire to apply changes...${NC}"
systemctl --user restart pipewire pipewire-pulse wireplumber

sleep 2

# ┌─────────────────────────────────────────────────────────────────────────┐
# │ VERIFY SETUP                                                             │
# └─────────────────────────────────────────────────────────────────────────┘

echo ""
echo -e "${GREEN}Verifying virtual sinks...${NC}"

if pw-cli ls Node | grep -q "game_audio_sink"; then
    echo -e "${GREEN}✓ Game Audio sink created${NC}"
else
    echo -e "${YELLOW}⚠ Game Audio sink not found${NC}"
fi

if pw-cli ls Node | grep -q "chat_audio_sink"; then
    echo -e "${GREEN}✓ Chat Audio sink created${NC}"
else
    echo -e "${YELLOW}⚠ Chat Audio sink not found${NC}"
fi

if pw-cli ls Node | grep -q "music_audio_sink"; then
    echo -e "${GREEN}✓ Music Audio sink created${NC}"
else
    echo -e "${YELLOW}⚠ Music Audio sink not found${NC}"
fi

# ┌─────────────────────────────────────────────────────────────────────────┐
# │ COMPLETION MESSAGE                                                       │
# └─────────────────────────────────────────────────────────────────────────┘

echo ""
echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo -e "${GREEN}✓ Audio routing setup complete!${NC}"
echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo ""
echo "Next steps:"
echo ""
echo "1. Open pavucontrol (SUPER+SHIFT+M) to route applications"
echo "2. Open qpwgraph (SUPER+CTRL+M) to visualize connections"
echo "3. Run setup-obs-sources.sh for OBS configuration"
echo ""
echo "Quick commands:"
echo "  • Route app:     $CONFIG_DIR/route-app.sh <app> <sink>"
echo "  • OBS guide:     $CONFIG_DIR/setup-obs-sources.sh"
echo "  • Volume mixer:  pavucontrol"
echo "  • Graph view:    qpwgraph"
echo ""
echo "Virtual sinks available:"
echo "  • game_audio_sink    (for games)"
echo "  • chat_audio_sink    (for Discord/chat apps)"
echo "  • music_audio_sink   (for music/browser)"
echo "  • desktop_audio_sink (everything else)"
echo ""
