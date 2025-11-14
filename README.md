# 🖥️ WehttamSnaps - Professional Arch Linux Niri Setup

![WehttamSnaps Logo](assets/ws-logo.png)

> **WehttamSnaps** - A professional Arch Linux Niri configuration optimized for photography, gaming, and content creation on AMD hardware.

## 🎯 Overview

WehttamSnaps combines the best elements from popular dotfiles while adding unique optimizations for creative professionals and gamers. Built on Niri (Wayland compositor) with Noctalia (Quickshell-based) for a modern, efficient workflow.

### 🌟 Key Features

- **🎮 Gaming Optimized**: RX 580 / AMD GPU tuned for maximum performance
- **🛠️ Professional Modding**: SteamTinkerLaunch, Vortex, MO2, Wabbajack integration
- **📸 Photography Workflow**: Darktable, RawTherapee, GIMP, Inkscape integration
- **🎬 Content Creation**: OBS Studio, audio routing, streaming ready
- **🚀 Modern Shell**: Noctalia (Quickshell) with custom widgets
- **⚡ Performance**: Game mode, CPU governor controls, RAM optimization
- **🎨 Professional Theme**: Consistent WehttamSnaps branding throughout
- **🌐 WebApps**: Dedicated webapp launchers for distraction-free usage

## 📋 System Requirements

### ✅ Minimum Requirements
- **OS**: Arch Linux (fresh install recommended)
- **CPU**: Intel i5-4430 or equivalent
- **GPU**: AMD RX 580 (primary) / NVIDIA GTX 1650 (secondary)
- **RAM**: 16GB DDR3
- **Storage**: 1TB SSD + 2x 120GB SSDs

### 🔧 Recommended Hardware
- **Display**: 1920x1080 @ 60Hz (single monitor setup)
- **Audio**: USB/3.5mm headset with microphone
- **Input**: Gaming mouse + mechanical keyboard

## 🚀 Quick Start

### 1. Install WehttamSnaps

```bash
# Clone the repository
git clone https://github.com/Crowdrocker/wehttamsnaps.git
cd wehttamsnaps

# Make installer executable
chmod +x install.sh

# Run the installer
./install.sh
```

### 2. Reboot and Select Niri

After installation:
1. Reboot your system
2. Select **Niri** from your display manager (SDDM)
3. Wait for the WehttamSnaps welcome app to start

### 3. First-Time Configuration

The welcome app will guide you through:
- Theme selection
- Audio setup
- Gaming configuration
- Photography workflow setup

## 🎮 Gaming Configuration

### RX 580 Optimizations

```bash
# Enable gaming mode
Super + Shift + G

# GPU control panel
Super + Ctrl + G

# Start Steam
Super + Shift + S

# Launch with Gamescope
Super + Alt + G
```

### Game Launch Options

**Cyberpunk 2077:**
```
gamemoderun %command% -vulkan -fullscreen
```

**The Division 2:**
```
gamemoderun %command% -force-vulkan
```

### Performance Tips

1. **Enable Game Mode** - Disables animations, sets CPU to performance
2. **Use Gamescope** - Better performance and compatibility
3. **Close background apps** - Free up RAM and GPU resources
4. **Update drivers** - Keep Mesa and AMDGPU packages current

## 📸 Photography Workflow

### Keybinds for Photography

| Function | Keybind | Application |
|----------|---------|-------------|
| Darktable | `Super + Shift + D` | Photo editing |
| RawTherapee | `Super + Shift + R` | RAW processing |
| GIMP | `Super + Shift + G` | Image editing |
| Inkscape | `Super + Shift + I` | Vector graphics |
| File Manager | `Super + F` | Thunar |
| Color Picker | `Super + C` | Hyprpicker |

### Color Management

- **Display Calibration**: Use `dispwin` with custom ICC profiles
- **Print Preparation**: GIMP with soft proofing enabled
- **RAW Processing**: RawTherapee for batch processing
- **Final Editing**: Darktable for non-destructive workflow

## 🛠️ Professional Modding Integration

WehttamSnaps includes comprehensive modding support for Steam games with optimized workflows:

### Supported Modding Tools

- **SteamTinkerLaunch** - `Super + Shift + T` (Advanced Steam management)
- **Vortex** - `Super + Shift + V` (User-friendly mod manager)
- **Mod Organizer 2** - `Super + Shift + M` (Advanced mod management)
- **Wabbajack** - `Super + Shift + W` (Automated modlist installer)
- **LOOT** - `Super + Shift + L` (Load order optimization)

### Modding Workspace Organization

- **Workspace 3**: Modding Tools - `Super + Ctrl + 3`
- **Workspace 4**: File Management - `Super + Ctrl + 4`
- **Workspace 5**: Web Tools - `Super + Ctrl + 5`

### Modding WebApps

- **Nexus Mods** - `Super + Alt + N` (Mod browsing)
- **Modding Discord** - `Super + Alt + D` (Community support)
- **LOOT Web** - `Super + Alt + L` (Load order tool)
- **Modding Wiki** - `Super + Alt + W` (Documentation)

### Advanced Features

- **Smart Game Launcher**: `Super + Ctrl + Shift + G`
- **Mod Profile Switching**: `Super + Ctrl + Shift + S`
- **Backup/Restore**: `Super + Ctrl + Shift + B/R`
- **Modding Keybinds Help**: `Super + Shift + Alt + H`

## 🌐 Web Applications

WehttamSnaps includes optimized webapp launchers for distraction-free usage:

### Available WebApps

- **YouTube** - `Super + Shift + Y`
- **Twitch** - `Super + Shift + T`
- **Music** (YouTube Music) - `Super + Shift + M`
- **Discord** - `Super + Shift + D`
- **Notion** - `Super + Shift + N`

### WebApp Benefits

- **Isolated profiles** - No interference with main browser
- **Optimized settings** - Hardware acceleration enabled
- **Clean interface** - No browser chrome or distractions
- **Independent windows** - Can be managed separately

## 🎵 Audio & Streaming Setup

### PipeWire Configuration

```bash
# Audio control center
EasyEffects

# Patchbay for routing
Qpwgraph

# Virtual sinks for streaming
~/.config/wehttamsnaps/scripts/audio-setup.sh
```

### Streaming Audio Routing

1. **Game Audio** → Virtual sink "Game"
2. **Microphone** → Virtual sink "Mic"
3. **Music/Browser** → Virtual sink "Media"
4. **Discord** → Virtual sink "Chat"

Use Qpwgraph to connect these to your recording/monitoring setup.

## ⚙️ Configuration Files

### Directory Structure

```
~/.config/wehttamsnaps/
├── scripts/          # Utility scripts
├── webapps/          # Webapp launchers
├── assets/          # Logos and themes
├── themes/          # Custom themes
└── wallpapers/      # Wallpaper collection

~/.config/niri/
├── config.kdl       # Main configuration
└── conf.d/          # Modular configs
    ├── 00-base.kdl
    ├── 10-input.kdl
    ├── 20-layout.kdl
    ├── 30-rules.kdl
    ├── 40-gaming.kdl
    ├── 50-keybinds.kdl
    └── 60-autostart.kdl

~/.config/ghostty/
└── config          # Terminal configuration
```

### Customizing Your Setup

1. **Edit keybinds**: `~/.config/niri/conf.d/50-keybinds.kdl`
2. **Add window rules**: `~/.config/niri/conf.d/30-rules.kdl`
3. **Modify autostart**: `~/.config/niri/conf.d/60-autostart.kdl`
4. **Change theme**: Use Noctalia settings panel

## 🛠️ Troubleshooting

### Common Issues

**Games won't launch:**
```bash
# Check GameMode status
gamemoded -s

# Verify Vulkan support
vulkaninfo

# Update ProtonGE
protonup-qt
```

**Audio not working:**
```bash
# Restart PipeWire
systemctl --user restart pipewire pipewire-pulse

# Check devices
pactl list sinks
pactl list sources
```

**Display issues:**
```bash
# Check Niri config
niri --verify-config

# Restart compositor
niri-msg action quit
```

### Performance Optimization

**Enable ZRAM:**
```bash
sudo systemctl enable zram-generator
sudo reboot
```

**CPU governor:**
```bash
# Performance mode
sudo cpupower frequency-set -g performance

# Ondemand mode
sudo cpupower frequency-set -g ondemand
```

**GPU tuning:**
```bash
# CoreCtrl for AMD GPUs
corectrl

# Monitor GPU usage
nvtop
```

## 📚 Learning Resources

### Documentation

- [Niri Wiki](https://github.com/YaLTeR/niri/wiki)
- [Noctalia Shell](https://github.com/noctalia-dev/noctalia-shell)
- [Ghostty Terminal](https://github.com/mitchellh/ghostty)

### Video Tutorials

- [WehttamSnaps Setup Guide](https://youtube.com/@WehttamSnaps)
- [Niri Configuration](https://youtube.com/@WehttamSnaps)
- [Gaming on Linux](https://youtube.com/@WehttamSnaps)

### Community

- [GitHub Issues](https://github.com/Crowdrocker/wehttamsnaps/issues)
- [Discord Server](https://discord.gg/wehttamsnaps)
- [Reddit r/archlinux](https://reddit.com/r/archlinux)

## 🤝 Contributing

We welcome contributions! Here's how you can help:

### Reporting Issues

1. Check existing issues first
2. Include system information
3. Provide steps to reproduce
4. Add relevant logs

### Submitting Changes

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Test thoroughly
5. Submit a pull request

### Areas for Contribution

- **New webapp launchers**
- **Additional window rules**
- **Performance optimizations**
- **Documentation improvements**
- **Theme variations**

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 🙏 Acknowledgments

- **JaKooLit** - Inspiration for theming structure
- **Omarchy** - Workflow optimization ideas
- **Noctalia Team** - Amazing Quickshell-based shell
- **Niri Developer** - Excellent Wayland compositor
- **Arch Linux Community** - Continuous support and innovation

## 📞 Support

- **GitHub**: [@Crowdrocker](https://github.com/Crowdrocker)
- **YouTube**: [@WehttamSnaps](https://youtube.com/@WehttamSnaps)
- **Email**: wehttamsnaps@example.com

---

**Made with ❤️ for the Linux community**

*If you find WehttamSnaps useful, please give it a ⭐ on GitHub and consider subscribing to my YouTube channel!*