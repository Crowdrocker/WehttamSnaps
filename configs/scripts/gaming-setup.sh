#!/bin/bash
# === WEHTTAMSNAPS GAMING SETUP SCRIPT ===
# GitHub: https://github.com/Crowdrocker
# Optimizes system for gaming

echo "Setting up WehttamSnaps gaming environment..."

# Set gaming environment variables
export GAMING_DRI_PRIME=1
export DXVK_HUD=fps,frametimes,version,devinfo,gpuload
export DXVK_STATE_CACHE_PATH=/tmp/dxvk_cache
export MANGOHUD=1
export MANGOHUD_CONFIG=fps,frametime,cpu_temp,gpu_temp,cpu_mhz,gpu_mhz,ram,vram,position=top-left,background_alpha=0.4
export RADV_PERFTEST=aco

# AMD GPU optimizations
if lspci | grep -i "AMD.*Radeon" > /dev/null; then
    echo "AMD GPU detected - applying optimizations..."
    export VK_ICD_FILENAMES=/usr/share/vulkan/icd.d/radeon_icd.x86_64.json:/usr/share/vulkan/icd.d/radeon_icd.i686.json
    
    # Set AMD performance mode
    echo 'high' | sudo tee /sys/class/drm/card0/device/power_dpm_state 2>/dev/null
    
    # Enable AMD overclocking if available
    echo 'auto' | sudo tee /sys/class/drm/card0/device/power_dpm_force_performance_level 2>/dev/null
fi

# NVIDIA GPU optimizations
if lspci | grep -i "NVIDIA" > /dev/null; then
    echo "NVIDIA GPU detected - applying optimizations..."
    export __GLX_VENDOR_LIBRARY_NAME=nvidia
    export __GL_THREADED_OPTIMIZATIONS=1
    export __NV_PRIME_RENDER_OFFLOAD=1
    export __VK_LAYER_NV_optimus=NVIDIA_only
fi

# Set up PipeWire audio for gaming
pw-metadata -n settings 0 clock.force-rate 48000 2>/dev/null
pw-metadata -n settings 0 log.level 0 2>/dev/null

# Create gaming directories
mkdir -p ~/Games/Steam
mkdir -p ~/Games/Lutris
mkdir -p ~/Games/Gamescope

# Fix Division 2 crashes
if [ -d "$HOME/.local/share/Steam/steamapps/common/The Division 2" ]; then
    echo "The Division 2 detected - applying fixes..."
    # Create Division 2 launch script
    cat > ~/Games/Division2-Launch.sh << 'EOF'
#!/bin/bash
export DXVK_HUD=1
export PROTON_USE_WINED3D=1
export WINEPREFIX="$HOME/.local/share/Steam/steamapps/compatdata/617290"
gamemoderun steam -applaunch 617290
EOF
    chmod +x ~/Games/Division2-Launch.sh
fi

# Fix Cyberpunk 2077 issues
if [ -d "$HOME/.local/share/Steam/steamapps/common/Cyberpunk 2077" ]; then
    echo "Cyberpunk 2077 detected - applying fixes..."
    # Create Cyberpunk 2077 launch script
    cat > ~/Games/Cyberpunk2077-Launch.sh << 'EOF'
#!/bin/bash
export DXVK_HUD=1
export PROTON_USE_WINED3D=0
export WINEPREFIX="$HOME/.local/share/Steam/steamapps/compatdata/1091500"
export gamemoderun=1
gamemoderun steam -applaunch 1091500
EOF
    chmod +x ~/Games/Cyberpunk2077-Launch.sh
fi

# Create Gamescope launch script
cat > ~/Games/Gamescope-Launch.sh << 'EOF'
#!/bin/bash
# Gamescope launcher for WehttamSnaps
# Usage: ./Gamescope-Launch.sh [game_command]

GAME_CMD=${1:-"steam"}
GAMESCOPE_ARGS="--adaptive-sync --fade-duration 0 --expose-wayland"

# Detect resolution (default to 1920x1080)
RES_X=${GAMESCOPE_RES_X:-1920}
RES_Y=${GAMESCOPE_RES_Y:-1080}

# Run gamescope with the game
gamescope \
    -W "$RES_X" -H "$RES_Y" \
    -w "$RES_X" -h "$RES_Y" \
    -f -b \
    $GAMESCOPE_ARGS \
    -- $GAME_CMD
EOF
chmod +x ~/Games/Gamescope-Launch.sh

# Set up Steam gaming optimizations
mkdir -p ~/.steam/steam/config
cat > ~/.steam/steam/config/steamapps.json << 'EOF'
{
  "compatibilitytools": {
    "proton_ge_custom": {
      "name": "Proton-GE",
      "from_oslist": "windows"
    }
  }
}
EOF

# Optimize system for gaming
# Set swappiness for better performance
echo 10 | sudo tee /proc/sys/vm/swappiness 2>/dev/null

# Set CPU governor to performance if available
if command -v cpupower > /dev/null; then
    sudo cpupower frequency-set -g performance 2>/dev/null
fi

# Start necessary services
systemctl --user enable pipewire pipewire-pulse 2>/dev/null
systemctl --user start pipewire pipewire-pulse 2>/dev/null

echo "Gaming setup completed successfully!"
echo "Use SUPER+SHIFT+G to toggle gamemode"
echo "Use SUPER+ALT+G to launch gamescope"
echo "Game launch scripts created in ~/Games/"

# Show notification
notify-send "WehttamSnaps Gaming Setup" "Gaming environment optimized" -a WehttamSnaps