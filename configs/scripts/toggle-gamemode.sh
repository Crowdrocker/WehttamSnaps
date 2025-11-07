#!/bin/bash
# === WEHTTAMSNAPS GAMEMODE TOGGLER ===
# GitHub: https://github.com/Crowdrocker

# Check if gamemode is currently active
if pgrep -f "gamemoderun" > /dev/null; then
    # Disable gamemode
    echo "Disabling GameMode..."
    
    # Kill gamemoderun processes
    pkill -f "gamemoderun"
    
    # Re-enable animations
    hyprctl keyword animations:enabled true
    
    # Re-enable blur
    hyprctl keyword decoration:blur:enabled true
    
    # Restore normal performance
    sudo systemctl stop auto-cpufreq 2>/dev/null
    
    # Restore normal CPU governor
    sudo cpupower frequency-set -g powersave 2>/dev/null
    
    # Show notification
    notify-send "GameMode Disabled" "Performance profile restored to normal" -a WehttamSnaps
    
    echo "GameMode disabled"
else
    # Enable gamemode
    echo "Enabling GameMode..."
    
    # Start gamemoded if not running
    if ! pgrep gamemoded > /dev/null; then
        gamemoded &
    fi
    
    # Disable animations for better performance
    hyprctl keyword animations:enabled false
    
    # Disable blur for better performance
    hyprctl keyword decoration:blur:enabled false
    
    # Set performance CPU governor
    sudo cpupower frequency-set -g performance 2>/dev/null
    
    # Start auto-cpufreq for better performance
    sudo systemctl start auto-cpufreq 2>/dev/null
    
    # Enable low latency mode for audio
    pw-metadata -n settings 0 clock.force-rate 48000
    
    # Show notification
    notify-send "GameMode Enabled" "Performance profile optimized for gaming" -a WehttamSnaps
    
    echo "GameMode enabled"
fi

# Apply changes
hyprctl reload

echo "GameMode toggle completed"