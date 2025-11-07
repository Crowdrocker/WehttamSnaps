#!/bin/bash
# === WEHTTAMSNAPS AUDIO ROUTING SETUP ===
# GitHub: https://github.com/Crowdrocker
# Configures PipeWire audio routing for streaming and gaming

echo "Setting up WehttamSnaps audio routing..."

# Create virtual sinks for different applications
echo "Creating virtual audio sinks..."

# Game audio sink
pactl load-module module-null-sink sink_name=GameAudio sink_properties=device.description="GameAudio" rate=48000

# Voice chat sink
pactl load-module module-null-sink sink_name=VoiceChat sink_properties=device.description="VoiceChat" rate=48000

# System audio sink
pactl load-module module-null-sink sink_name=SystemAudio sink_properties=device.description="SystemAudio" rate=48000

# Stream output sink (combines all audio)
pactl load-module module-null-sink sink_name=StreamOutput sink_properties=device.description="StreamOutput" rate=48000

# Create loopbacks to route audio
echo "Setting up audio routing loops..."

# Route game audio to both speakers and stream output
pactl load-module module-loopback source=GameAudio.monitor sink=auto_null
pactl load-module module-loopback source=GameAudio.monitor sink=StreamOutput

# Route voice chat to both headset and stream output
pactl load-module module-loopback source=VoiceChat.monitor sink=auto_null
pactl load-module module-loopback source=VoiceChat.monitor sink=StreamOutput

# Route system audio to both speakers and stream output
pactl load-module module-loopback source=SystemAudio.monitor sink=auto_null
pactl load-module module-loopback source=SystemAudio.monitor sink=StreamOutput

# Create qpwgraph layout file
mkdir -p ~/.config/qpwgraph

cat > ~/.config/qpwgraph/wehttamsnaps.xml << 'EOF'
<?xml version="1.0" encoding="UTF-8"?>
<graph>
  <group mode="1" name="GameAudio" x="100" y="100"/>
  <group mode="1" name="VoiceChat" x="300" y="100"/>
  <group mode="1" name="SystemAudio" x="500" y="100"/>
  <group mode="1" name="StreamOutput" x="300" y="300"/>
  <group mode="0" name="Microphone" x="100" y="400"/>
  <group mode="0" name="Speakers" x="500" y="400"/>
</graph>
EOF

# Set up low latency configuration
echo "Configuring low latency audio..."

# Set PipeWire buffer size for low latency
pw-metadata -n settings 0 clock.force-rate 48000
pw-metadata -n settings 0 clock.quantum-limit 8192
pw-metadata -n settings 0 default.clock.rate 48000
pw-metadata -n settings 0 default.clock.quantum 256
pw-metadata -n settings 0 default.clock.min-quantum 32
pw-metadata -n settings 0 default.clock.max-quantum 8192

# Create application routing script
cat > ~/.config/wehttamsnaps/scripts/route-app-audio.sh << 'EOF'
#!/bin/bash
# Route application audio to specific sink

if [[ $# -lt 2 ]]; then
    echo "Usage: $0 &quot;app_name&quot; &quot;sink_name&quot;"
    echo "Available sinks: GameAudio, VoiceChat, SystemAudio, StreamOutput"
    exit 1
fi

APP_NAME="$1"
SINK_NAME="$2"

# Find application's sink input
SINK_INPUT=$(pactl list sink-inputs short | grep "$APP_NAME" | awk '{print $1}')

if [[ -n "$SINK_INPUT" ]]; then
    pactl move-sink-input "$SINK_INPUT" "$SINK_NAME"
    echo "Routed $APP_NAME to $SINK_NAME"
else
    echo "Could not find $APP_NAME sink input"
    echo "Try starting the application first"
fi
EOF

chmod +x ~/.config/wehttamsnaps/scripts/route-app-audio.sh

# Create quick routing presets
cat > ~/.config/wehttamsnaps/scripts/audio-presets.sh << 'EOF'
#!/bin/bash
# Quick audio routing presets

case "$1" in
    "gaming")
        echo "Setting up gaming audio preset..."
        ~/.config/wehttamsnaps/scripts/route-app-audio.sh "Steam" "GameAudio"
        ~/.config/wehttamsnaps/scripts/route-app-audio.sh "Lutris" "GameAudio"
        echo "Gaming preset activated"
        ;;
    "streaming")
        echo "Setting up streaming audio preset..."
        # All audio should already be routed to StreamOutput
        echo "Streaming preset activated - all audio routed to StreamOutput"
        ;;
    "voicechat")
        echo "Setting up voice chat preset..."
        ~/.config/wehttamsnaps/scripts/route-app-audio.sh "Discord" "VoiceChat"
        ~/.config/wehttamsnaps/scripts/route-app-audio.sh "TelegramDesktop" "VoiceChat"
        echo "Voice chat preset activated"
        ;;
    "reset")
        echo "Resetting audio routing..."
        pactl unload-module module-loopback
        pactl unload-module module-null-sink
        echo "Audio routing reset"
        ;;
    *)
        echo "Usage: $0 {gaming|streaming|voicechat|reset}"
        echo "Available presets:"
        echo "  gaming     - Route games to GameAudio sink"
        echo "  streaming  - All audio routed to StreamOutput sink"
        echo "  voicechat  - Route chat apps to VoiceChat sink"
        echo "  reset      - Reset all routing"
        ;;
esac
EOF

chmod +x ~/.config/wehttamsnaps/scripts/audio-presets.sh

# Set default sink to auto_null (virtual)
pactl set-default-sink auto_null

echo "WehttamSnaps audio routing setup completed!"
echo ""
echo "Available commands:"
echo "• ~/.config/wehttamsnaps/scripts/audio-presets.sh gaming"
echo "• ~/.config/wehttamsnaps/scripts/audio-presets.sh streaming"
echo "• ~/.config/wehttamsnaps/scripts/audio-presets.sh voicechat"
echo "• ~/.config/wehttamsnaps/scripts/audio-presets.sh reset"
echo "• qpwgraph (to manually adjust routing)"
echo ""
echo "Keybinds added:"
echo "• SUPER+P → qpwgraph (audio routing GUI)"

# Add keybinding to Hyprland config
if ! grep -q "qpwgraph" ~/.config/hyprland/conf.d/06-bindings.conf; then
    echo "bind = \$mod, P, exec, qpwgraph" >> ~/.config/hyprland/conf.d/06-bindings.conf
    echo "Added qpwgraph keybinding to Hyprland config"
fi

# Show notification
notify-send "WehttamSnaps Audio" "Audio routing configured" -a WehttamSnaps