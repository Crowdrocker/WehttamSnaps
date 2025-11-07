# WehttamSnaps Quick Start Guide

## 🚀 First Steps

After installation and reboot, here's how to get started with WehttamSnaps:

### Essential Keybinds

| Keybind | Action | Description |
|---------|--------|-------------|
| `SUPER + H` | Help | Show all keybinds |
| `SUPER + D` | Launcher | Open app launcher (rofi) |
| `SUPER + SPACE` | Noctalia | Open Noctalia launcher |
| `SUPER + ENTER` | Terminal | Open Ghostty terminal |
| `SUPER + B` | Browser | Open Firefox |
| `SUPER + E` | Files | Open Thunar file manager |
| `SUPER + Q` | Close | Close active window |
| `SUPER + C` | Code | Open VS Code |

### Workspace Management

| Keybind | Action |
|---------|--------|
| `SUPER + 1-0` | Switch to workspace 1-10 |
| `SUPER + SHIFT + 1-0` | Move window to workspace 1-10 |
| `SUPER + ARROWS` | Move focus between windows |
| `SUPER + SHIFT + ARROWS` | Move windows |

### Gaming & Performance

| Keybind | Action |
|---------|--------|
| `SUPER + SHIFT + G` | Toggle GameMode |
| `SUPER + ALT + G` | Launch Gamescope |
| `SUPER + CTRL + G` | Launch Steam |
| `PRINT` | Screenshot |
| `SUPER + PRINT` | Region screenshot |

### Audio & Media

| Keybind | Action |
|---------|--------|
| `SUPER + P` | Audio routing (qpwgraph) |
| `SUPER + V` | Clipboard history |
| `XF86AudioPlay/Pause` | Media control |
| `XF86AudioRaise/Lower` | Volume control |

## 🎮 Gaming Setup

### Steam Configuration
1. **Launch**: `SUPER + CTRL + G`
2. **Enable Proton GE**: Settings → Steam Play → Enable Steam Play for all titles
3. **Launch Options**: Add `RADV_PERFTEST=aco %command%` for AMD GPUs

### Game Launch Scripts
All game launch scripts are in `~/Games/`:
- `./Division2-Launch.sh` - Fixed Division 2 crashes
- `./Cyberpunk2077-Launch.sh` - Optimized Cyberpunk 2077
- `./Gamescope-Launch.sh` - Gamescope wrapper

### Performance Optimization
- Toggle GameMode: `SUPER + SHIFT + G`
- Monitor performance: `btop`
- Check GPU stats: `nvtop` or `radeontop`

## 📸 Photography Workflow

### Applications
- **Darktable**: `SUPER + D` (set to workspace 4)
- **GIMP**: Available in app launcher
- **Krita**: Digital painting
- **RawTherapee**: Advanced RAW processing

### File Organization
- **Photos**: `~/Pictures/`
- **RAW files**: Organize by date in `~/Pictures/RAW/`
- **Edited**: `~/Pictures/Edited/`
- **Thunar**: `SUPER + E` for file management

## 🎵 Audio Setup

### Basic Audio
Audio should work immediately with PipeWire. Use:
- `pavucontrol` for volume control
- `qpwgraph` for routing (`SUPER + P`)

### Streaming Setup
Use audio presets for streaming:
```bash
~/.config/wehttamsnaps/scripts/audio-presets.sh streaming
```

### Voice Chat
```bash
~/.config/wehttamsnaps/scripts/audio-presets.sh voicechat
```

## 🌐 WebApps

### Default WebApps
Run the installer to get default webapps:
```bash
~/.config/wehttamsnaps/configs/webapps/create-default-webapps.sh
```

### Access WebApps
- `SUPER + CTRL + Y` → YouTube
- `SUPER + CTRL + T` → Twitch  
- `SUPER + CTRL + D` → Discord
- `SUPER + CTRL + G` → GitHub

### Create Custom WebApps
```bash
~/.config/wehttamsnaps/configs/webapps/create-webapp.sh "Name" "URL"
```

## 🎨 Customization

### Change Theme
1. **Wallpaper**: `SUPER + W`
2. **Color Scheme**: Use Noctalia settings (`SUPER + ,`)
3. **GTK Theme**: `nwg-look` in app launcher

### Modify Configuration
1. **Hyprland**: `~/.config/hyprland/conf.d/99-overrides.conf`
2. **Ghostty**: `~/.config/ghostty/config`
3. **Noctalia**: `~/.config/noctalia/`

### Add Wallpapers
1. Place images in `~/Pictures/Wallpapers/`
2. Use `SUPER + W` to select
3. Or use `SUPER + SHIFT + W` for random

## 🔧 Troubleshooting

### Common Fixes

#### Display Issues
```bash
hyprctl reload
```

#### Audio Issues
```bash
systemctl --user restart pipewire pipewire-pulse
```

#### Performance Issues
```bash
~/.config/wehttamsnaps/scripts/toggle-gamemode.sh
```

#### App Won't Launch
- Check if installed: `which appname`
- Check logs: `journalctl -xe`
- Try launching from terminal

### Get Help
1. **Keybinds**: `SUPER + H`
2. **Logs**: `~/.local/share/hyprland/hyprland.log`
3. **Config**: Check syntax with `hyprctl config errors`

## 📋 Daily Workflow

### Morning Startup
1. Launch terminal: `SUPER + ENTER`
2. Check updates: `yay`
3. Start work apps: `SUPER + C` (VS Code)

### Work Session
1. Workspace 1: Terminal
2. Workspace 2: Browser
3. Workspace 3: Code editor
4. Workspace 4: Photo editing

### Gaming Session
1. Toggle GameMode: `SUPER + SHIFT + G`
2. Launch Steam: `SUPER + CTRL + G`
3. Use gaming workspace: `SUPER + 8`

### Ending Session
1. Close apps: `SUPER + Q` or save work
2. Logout: `SUPER + ALT + Delete`

## 🆘 Emergency Commands

### System Recovery
```bash
# Reboot
sudo systemctl reboot

# Power off
sudo systemctl poweroff

# Emergency exit Hyprland
super + shift + escape
```

### Reset Configurations
```bash
# Reset Hyprland
cp ~/.config/hyprland/conf.d/99-overrides.conf.bak ~/.config/hyprland/conf.d/99-overrides.conf

# Reset to defaults
rm ~/.config/hyprland/conf.d/99-overrides.conf
hyprctl reload
```

---

## 🎉 You're Ready!

You now have everything you need to be productive with WehttamSnaps. Remember:

- **Help is always available**: `SUPER + H`
- **Customize everything**: Edit configs in `~/.config/wehttamsnaps/`
- **Join the community**: GitHub issues for support

**Enjoy your professional Arch Linux setup! 🚀**

Made with ❤️ by [Crowdrocker](https://github.com/Crowdrocker)