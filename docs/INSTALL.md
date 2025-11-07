# WehttamSnaps Installation Guide

## Overview

WehttamSnaps is a professional Arch Linux Hyprland configuration optimized for gaming, photography, and productivity. This guide will walk you through the complete installation process.

## Prerequisites

### System Requirements
- **Operating System**: Arch Linux (fresh install recommended)
- **CPU**: Intel i5-4430 or better
- **GPU**: AMD RX 580 / NVIDIA GTX 1650 or better
- **RAM**: 8GB minimum, 16GB recommended
- **Storage**: 50GB free space
- **Display**: 1920x1080 minimum

### Before Installation
1. Update your system:
   ```bash
   sudo pacman -Syu
   ```

2. Install Git if not present:
   ```bash
   sudo pacman -S git
   ```

3. Have sudo access configured

## Installation Methods

### Method 1: Automated Installation (Recommended)

1. **Clone the repository**:
   ```bash
   git clone https://github.com/Crowdrocker/WehttamSnaps.git
   cd WehttamSnaps
   ```

2. **Run the installer**:
   ```bash
   ./install.sh
   ```

3. **Follow the prompts**:
   - The installer will ask about optional packages
   - All configurations are set up automatically
   - Services are enabled and started

4. **Reboot your system**:
   ```bash
   reboot
   ```

### Method 2: Manual Installation

1. **Clone and enter the directory**:
   ```bash
   git clone https://github.com/Crowdrocker/WehttamSnaps.git
   cd WehttamSnaps
   ```

2. **Install yay AUR helper**:
   ```bash
   git clone https://aur.archlinux.org/yay-bin.git /tmp/yay-bin
   cd /tmp/yay-bin
   makepkg -si
   cd -
   ```

3. **Install core packages**:
   ```bash
   yay -S --needed - < packages/core.txt
   ```

4. **Install optional packages** (optional):
   ```bash
   yay -S --needed - < packages/optional.txt
   ```

5. **Set up configurations**:
   ```bash
   # Backup existing configs
   mv ~/.config/hyprland ~/.config/hyprland.bak.$(date +%Y%m%d_%H%M%S) 2>/dev/null || true
   
   # Symlink new configs
   ln -sf "$(pwd)/configs/hyprland" ~/.config/hyprland
   ln -sf "$(pwd)/configs/ghostty" ~/.config/ghostty
   ln -sf "$(pwd)/configs/noctalia" ~/.config/noctalia
   ln -sf "$(pwd)/configs/waybar" ~/.config/waybar
   ```

6. **Enable services**:
   ```bash
   # User services
   systemctl --user enable pipewire pipewire-pulse wireplumber
   
   # System services
   sudo systemctl enable sddm auto-cpufreq thermald gamemoded
   ```

7. **Set up Plymouth theme** (optional):
   ```bash
   sudo ./configs/scripts/setup-plymouth.sh
   ```

8. **Reboot**:
   ```bash
   reboot
   ```

## Post-Installation Setup

### First Boot

1. **Welcome Application**: The WehttamSnaps welcome app will appear on first login
2. **Keybinds**: Press `SUPER+H` to view all available shortcuts
3. **Default Browser**: Firefox will be set as default
4. **Audio**: PipeWire should be working with qpwgraph for routing

### Gaming Setup

1. **Steam**: Log in and let it update
2. **Proton GE**: Should be installed and configured
3. **Game Launch Scripts**: Located in `~/Games/`
4. **Gamemode**: Toggle with `SUPER+SHIFT+G`

### Audio Configuration

1. **Basic Setup**: Audio should work out of the box
2. **Advanced Routing**: Use `qpwgraph` (`SUPER+P`)
3. **Presets**: Use audio preset scripts
   ```bash
   ~/.config/wehttamsnaps/scripts/audio-presets.sh gaming
   ~/.config/wehttamsnaps/scripts/audio-presets.sh streaming
   ```

### Photography Setup

1. **Darktable**: For RAW photo editing
2. **GIMP**: For image manipulation
3. **Krita**: For digital painting
4. **File Management**: Use Thunar for photo organization

### WebApps

1. **Create WebApps**: Use the webapp creator
   ```bash
   ~/.config/wehttamsnaps/configs/webapps/create-webapp.sh "Service Name" "URL"
   ```

2. **Default WebApps**: Run the default webapp installer
   ```bash
   ~/.config/wehttamsnaps/configs/webapps/create-default-webapps.sh
   ```

## Customization

### Hyprland Configuration

1. **Main Config**: `~/.config/hyprland/hypr.conf`
2. **Modular Configs**: `~/.config/hyprland/conf.d/`
3. **Personal Overrides**: `~/.config/hyprland/conf.d/99-overrides.conf`

### Noctalia Shell

1. **Configuration**: `~/.config/noctalia/`
2. **Themes**: `~/.config/noctalia/themes/`
3. **Widgets**: `~/.config/noctalia/widgets/`

### Ghostty Terminal

1. **Config File**: `~/.config/ghostty/config`
2. **Font**: Fira Code (configurable)
3. **Theme**: System-integrated

### Wallpapers

1. **Location**: `~/Pictures/Wallpapers/`
2. **Default**: `~/.config/wehttamsnaps/wallpapers/`
3. **Switch**: `SUPER+W`

## Troubleshooting

### Common Issues

#### Display Issues
```bash
# Check Hyprland config
hyprctl config reload

# Check Wayland status
echo $XDG_SESSION_TYPE

# Restart display manager
sudo systemctl restart sddm
```

#### Audio Issues
```bash
# Restart PipeWire
systemctl --user restart pipewire pipewire-pulse

# Check audio devices
pactl list sinks
pactl list sources

# Test audio
speaker-test -c 2 -t wav
```

#### Gaming Issues
```bash
# Check GPU drivers
lspci -k | grep -A 2 -i vga

# Check Vulkan
vulkaninfo

# Test Steam
steam --no-cef-sandbox
```

#### Performance Issues
```bash
# Check gamemode
gamemoded -s

# Check CPU governor
cpupower frequency-info

# Check system load
btop
```

### Performance Optimization

1. **Enable ZRAM**:
   ```bash
   sudo systemctl enable zram-generator
   ```

2. **Optimize Storage**:
   ```bash
   # Enable fstrim timer
   sudo systemctl enable fstrim.timer
   ```

3. **Gaming Performance**:
   ```bash
   # Toggle gamemode
   ~/.config/wehttamsnaps/scripts/toggle-gamemode.sh
   ```

### Getting Help

1. **Check Logs**:
   - Hyprland: `~/.local/share/hyprland/hyprland.log`
   - PipeWire: `journalctl --user -u pipewire`
   - Xorg: `journalctl -b | grep -i xorg`

2. **Community Support**:
   - GitHub Issues: [Create an issue](https://github.com/Crowdrocker/WehttamSnaps/issues)
   - Discord: Join the community server

3. **Documentation**:
   - [Main README](../README.md)
   - [Hyprland Wiki](https://wiki.hyprland.org/)
   - [Noctalia Documentation](https://github.com/noctalia-dev/noctalia-shell)

## Upgrading

### Update WehttamSnaps

1. **Pull latest changes**:
   ```bash
   cd ~/WehttamSnaps
   git pull
   ```

2. **Run upgrade script** (if available):
   ```bash
   ./upgrade.sh
   ```

3. **Reboot**:
   ```bash
   reboot
   ```

### Update Packages

1. **Update system**:
   ```bash
   yay -Syu
   ```

2. **Check for AUR updates**:
   ```bash
   yay -Y --gendb
   yay -Syu --devel
   ```

## Uninstallation

If you need to remove WehttamSnaps:

1. **Remove configs**:
   ```bash
   rm -rf ~/.config/hyprland
   rm -rf ~/.config/ghostty
   rm -rf ~/.config/noctalia
   rm -rf ~/.config/wehttamsnaps
   ```

2. **Remove packages** (careful - may remove other needed packages):
   ```bash
   yay -Rns $(cat packages/core.txt)
   ```

3. **Restore previous configs** (if backed up):
   ```bash
   mv ~/.config/hyprland.bak.* ~/.config/hyprland 2>/dev/null || true
   ```

## Contributing

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Test thoroughly
5. Submit a pull request

## License

This project is licensed under the MIT License - see the [LICENSE](../LICENSE) file for details.

---

**Happy customizing! 🎮🖥️📸**

Made with ❤️ by [Crowdrocker](https://github.com/Crowdrocker)