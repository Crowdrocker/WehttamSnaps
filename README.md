# WehttamSnaps - Professional Arch Linux Hyprland Setup

<div align="center">

![WehttamSnaps Logo](assets/logos/ws-logo.png)

**A professional, modular Arch Linux Hyprland configuration optimized for photography, gaming, and productivity**

[![GitHub](https://img.shields.io/badge/GitHub-Crowdrocker-blue?style=for-the-badge&logo=github)](https://github.com/Crowdrocker)
[![Arch Linux](https://img.shields.io/badge/Arch_Linux-1793D1?style=for-the-badge&logo=arch-linux)](https://archlinux.org/)
[![Hyprland](https://img.shields.io/badge/Hyprland-00AAFF?style=for-the-badge&logo=hyprland)](https://hyprland.org/)
[![License](https://img.shields.io/badge/License-MIT-green?style=for-the-badge)](LICENSE)

</div>

## ✨ Features

### 🎮 Gaming Optimized
- **Steam integration** with optimized launch options
- **Gamescope support** for improved performance
- **AMD GPU optimization** (RX 580 friendly)
- **Gamemode** integration for performance boosts
- Fixes for common gaming crashes (Division 2, Cyberpunk)

### 🖥️ Desktop Environment
- **Hyprland** - Dynamic tiling Wayland compositor
- **Noctalia Shell** - Modern Quickshell-based UI (primary)
- **Waybar** - Backup status bar (optional)
- **Ghostty** - Modern terminal with Fira Code font
- **Modular configuration** with clean separation

### 📸 Photography & Productivity
- **Darktable** integration for photo editing
- **GIMP** with optimized settings
- **Custom webapps** for quick access to services
- **Audio routing** via PipeWire + qpwgraph
- **Professional theming** throughout

### 🎨 Theming & Branding
- **WehttamSnaps branding** throughout all configs
- **Material Design 3** color schemes
- **Plymouth theme** with animated logo
- **Consistent GTK/Qt theming**
- **Custom welcome application**

## 🚀 Quick Start

### Prerequisites
- Arch Linux (fresh install recommended)
- AMD GPU (RX 580) or NVIDIA (GTX 1650+)
- Basic command line knowledge

### Installation

```bash
# Clone the repository
git clone https://github.com/Crowdrocker/WehttamSnaps.git
cd WehttamSnaps

# Run the installer
./install.sh

# Reboot and enjoy!
reboot
```

### What Gets Installed

#### Core System
- `hyprland` - Wayland compositor
- `noctalia-shell` - Modern shell
- `ghostty` - Terminal emulator
- `pipewire` - Audio system
- `gamemode` - Gaming optimization

#### Desktop Applications
- `ghostty` - Terminal (replaces kitty/thunar)
- `rofi` - Application launcher
- `firefox` - Web browser
- `thunar` - File manager
- `obs-studio` - Streaming/recording

#### Gaming
- `steam` - Gaming platform
- `gamescope` - Performance enhancer
- `lutris` - Game launcher
- `proton-ge-custom` - Steam compatibility

#### Photography
- `darktable` - Photo editing
- `gimp` - Image manipulation
- `rawtherapee` - RAW processing

## 📁 Configuration Structure

```
WehttamSnaps/
├── configs/
│   ├── hyprland/           # Hyprland configuration
│   │   ├── hypr.conf        # Main config file
│   │   └── conf.d/          # Modular configs
│   ├── ghostty/             # Ghostty terminal config
│   ├── noctalia/            # Noctalia shell configs
│   ├── waybar/              # Waybar backup bar
│   ├── webapps/             # Web application configs
│   └── scripts/             # Utility scripts
├── themes/                  # Theme files
│   ├── gtk/                 # GTK themes
│   ├── qt/                  # Qt themes
│   └── plymouth/            # Boot theme
├── packages/                # Package lists
├── wallpapers/              # Wallpaper collection
├── assets/                  # Assets and media
│   ├── logos/               # Brand assets
│   ├── sounds/              # Audio files
│   └── fonts/               # Font files
└── docs/                    # Documentation
```

## 🎮 Gaming Setup

### Steam Optimization
```bash
# Steam launch options for better performance
RADV_PERFTEST=aco %command%
```

### Gamescope Integration
```bash
# Launch games with Gamescope for better performance
gamescope -w 1920 -h 1080 -f -- steam
```

### Known Issues Fixed
- **Division 2 crashes**: Vulkan driver fixes
- **Cyberpunk issues**: Memory optimization
- **AMD GPU**: Proper RADV configuration

## ⌨️ Keybindings

### Essential Shortcuts
| Keybind | Action |
|---------|--------|
| `SUPER + ENTER` | Open Ghostty terminal |
| `SUPER + D` | Application launcher (rofi) |
| `SUPER + B` | Web browser |
| `SUPER + Q` | Close active window |
| `SUPER + H` | Show keybindings help |
| `SUPER + SHIFT + G` | Toggle gamemode |
| `SUPER + W` | Wallpaper selector |
| `PRINT` | Screenshot |
| `CTRL + ALT + L` | Lock screen |

### Noctalia Shell Controls
| Keybind | Action |
|---------|--------|
| `SUPER + SPACE` | Application launcher |
| `SUPER + S` | Control center |
| `SUPER + ,` | Settings |
| `SUPER + V` | Clipboard history |
| `SUPER + L` | Lock screen |

## 🔧 Customization

### Adding WebApps
```bash
# Create a new webapp
./configs/scripts/create-webapp.sh "YouTube" "https://youtube.com"
```

### Custom Themes
- Edit `configs/noctalia/themes/` for Noctalia themes
- Modify `configs/hyprland/conf.d/20-theme.conf` for Hyprland theming
- Use `configs/scripts/change-theme.sh` to switch themes

### Audio Routing
Use `qpwgraph` to set up audio routing for streaming:
```bash
# Launch audio routing GUI
qpwgraph
```

## 📊 Performance

### System Requirements
- **CPU**: Intel i5-4430 or better
- **GPU**: AMD RX 580 / NVIDIA GTX 1650 or better
- **RAM**: 8GB minimum, 16GB recommended
- **Storage**: 50GB free space

### Optimizations
- ZRAM for swap compression
- Auto-cpufreq for CPU scaling
- Gamemode for gaming performance
- PipeWire for low-latency audio

## 🐛 Troubleshooting

### Common Issues

#### Audio Issues
```bash
# Restart PipeWire
systemctl --user restart pipewire pipewire-pulse
```

#### Display Issues
```bash
# Check Hyprland config
hyprctl config reload
```

#### Gaming Issues
```bash
# Update GPU drivers
sudo pacman -Syu amd-ucode mesa lib32-mesa
```

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Test thoroughly
5. Submit a pull request

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 🙏 Acknowledgments

- **JaKooLit** - Inspiration for theming approach
- **Omarchy** - Workflow and structure ideas
- **Noctalia** - Modern shell framework
- **Hyprland** - Amazing Wayland compositor
- **Arch Linux** - Best Linux distribution

## 📞 Support

- **GitHub Issues**: [Create an issue](https://github.com/Crowdrocker/WehttamSnaps/issues)
- **Discord**: Join the community server
- **Email**: crowdrocker@proton.me

---

<div align="center">

**Made with ❤️ by [Crowdrocker](https://github.com/Crowdrocker)**

*"WehttamSnaps - Because your desktop should work for you, not against you"*

</div>