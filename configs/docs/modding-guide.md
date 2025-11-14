# 🎮 WehttamSnaps Modding Guide

> **Professional modding workflow for Steam games on Arch Linux**

## 🎯 Overview

WehttamSnaps includes comprehensive modding support with optimized window rules, keybinds, and workflows for SteamTinkerLaunch, Vortex, Mod Organizer 2, and Wabbajack.

## 🛠️ Supported Modding Tools

### SteamTinkerLaunch (STL)
- **Purpose**: Advanced Steam game management
- **Keybind**: `Super + Shift + T`
- **Features**: Console access, Proton management, game optimization
- **Best for**: Linux-native game tweaking

### Vortex Mod Manager
- **Purpose**: User-friendly mod management
- **Keybind**: `Super + Shift + V`
- **Features**: Automatic deployment, conflict resolution
- **Best for**: Beginners and visual workflow users

### Mod Organizer 2 (MO2)
- **Purpose**: Advanced mod management
- **Keybind**: `Super + Shift + M`
- **Features**: Profile management, virtual file system
- **Best for**: Power users and complex mod setups

### Wabbajack
- **Purpose**: Automated modlist installation
- **Keybind**: `Super + Shift + W`
- **Features**: One-click modlist installation
- **Best for**: Complete mod overhaul setups

## 🗂️ Workspace Organization

### Workspace 3: Modding Tools
- **Purpose**: Primary modding applications
- **Contents**: STL, Vortex, MO2, Wabbajack
- **Layout**: Floating windows for easy multitasking
- **Access**: `Super + Ctrl + 3`

### Workspace 4: File Management
- **Purpose**: Mod downloads and organization
- **Contents**: File managers, archive tools
- **Layout**: Multiple file managers side-by-side
- **Access**: `Super + Ctrl + 4`

### Workspace 5: Web Tools
- **Purpose**: Modding websites and documentation
- **Contents**: Nexus Mods, Discord, wikis
- **Layout**: Dedicated webapp windows
- **Access**: `Super + Ctrl + 5`

## ⌨️ Comprehensive Keybinds

### Modding Tool Launchers
| Keybind | Tool | Description |
|---------|------|-------------|
| `Super + Shift + T` | SteamTinkerLaunch | Advanced Steam management |
| `Super + Shift + V` | Vortex | User-friendly mod manager |
| `Super + Shift + M` | Mod Organizer 2 | Advanced mod management |
| `Super + Shift + W` | Wabbajack | Modlist installer |
| `Super + Shift + L` | LOOT | Load order optimization |
| `Super + Shift + X` | xEdit | Plugin editing tools |
| `Super + Shift + C` | Creation Kit | Game editor |
| `Super + Shift + F` | FNIS/Nemesis | Animation tools |

### Workspace Management
| Keybind | Action | Description |
|---------|--------|-------------|
| `Super + Ctrl + 3` | Focus WS3 | Modding tools workspace |
| `Super + Ctrl + 4` | Focus WS4 | File management workspace |
| `Super + Ctrl + 5` | Focus WS5 | Web tools workspace |
| `Super + Alt + M` | Setup Workspaces | Organize modding environment |

### File Management
| Keybind | Action | Description |
|---------|--------|-------------|
| `Super + Ctrl + D` | Modding Directory | Main modding folder |
| `Super + Ctrl + S` | Downloads Folder | Mod downloads |
| `Super + Ctrl + R` | Tools Folder | CLI utilities |
| `Super + Ctrl + G` | Game Directories | Game mod folders |

### Web Tools
| Keybind | Action | Description |
|---------|--------|-------------|
| `Super + Alt + N` | Nexus Mods | Mod browsing webapp |
| `Super + Alt + L` | LOOT Web | Load order tool |
| `Super + Alt + D` | Modding Discord | Community chat |
| `Super + Alt + W` | Modding Wiki | Documentation |

### Tool-Specific Controls
| Tool | Keybind | Action |
|------|---------|--------|
| **STL** | `Super + Alt + T` | Quick actions |
| **STL** | `Super + Alt + Shift + T` | Configuration |
| **MO2** | `Super + Alt + O` | Quick launch |
| **MO2** | `Super + Alt + Shift + O` | Mod installer |
| **Vortex** | `Super + Alt + V` | Quick actions |
| **Vortex** | `Super + Alt + Shift + V` | Deploy mods |
| **Wabbajack** | `Super + Alt + W` | Quick launch |
| **Wabbajack** | `Super + Alt + Shift + W` | Download lists |

### Game Launch
| Keybind | Action | Description |
|---------|--------|-------------|
| `Super + Ctrl + Shift + G` | Launch with Mods | Smart game launcher |
| `Super + Alt + Shift + G` | Launch Vanilla | Game without mods |
| `Super + Ctrl + Shift + S` | Switch Profiles | Change mod profiles |

### Utilities
| Keybind | Action | Description |
|---------|--------|-------------|
| `Super + Ctrl + Shift + B` | Backup Setup | Backup configurations |
| `Super + Ctrl + Shift + C` | Clean Cache | Clear temporary files |
| `Super + Ctrl + Shift + U` | Update Tools | Update utilities |
| `Super + Ctrl + Shift + P` | Process Monitor | Monitor modding tools |
| `Super + Shift + Alt + H` | Modding Help | Show this guide |

## 📁 Directory Structure

```
~/.local/share/modding/
├── downloads/          # Mod downloads and archives
├── tools/              # CLI utilities and scripts
├── backups/            # Configuration backups
├── cache/              # Temporary files
├── profiles/           # Mod profiles
├── logs/               # Tool logs
├── docs/               # Documentation
└── scripts/            # Custom scripts

~/.config/steamtinkerlaunch/
├── config/             # STL configurations
├── logs/               # STL logs
└── custom/             # Custom scripts

~/.config/vortex/
├── games/              # Game instances
├── downloads/          # Mod downloads
└── settings/           # Vortex settings

~/.config/modorganizer2/
├── profiles/           # MO2 profiles
├── mods/               # Mod list
└── downloads/          # Downloaded mods
```

## 🎮 Game-Specific Setup

### Skyrim Special Edition
1. **Install**: Through Steam
2. **SKSE**: Install Script Extender
3. **Mod Manager**: Choose Vortex or MO2
4. **Common Mods**: SkyUI, Unofficial Patches
5. **Keybinds**: Use Skyrim mod keybinds

### Fallout 4
1. **Install**: Through Steam
2. **F4SE**: Install Script Extender
3. **Mod Manager**: Vortex recommended
4. **Common Mods**: Unofficial Patch, CBBE
5. **Keybinds**: Use Fallout 4 mod keybinds

### General Setup
1. **Create profiles**: Separate profiles for different mod setups
2. **Backup vanilla**: Keep clean game backup
3. **Test incrementally**: Add mods gradually
4. **Use LOOT**: Optimize load order automatically

## 🌐 WebApp Integration

### Nexus Mods WebApp
- **Purpose**: Browse and download mods
- **Keybind**: `Super + Alt + N`
- **Features**: Distraction-free browsing, download management
- **Location**: `~/.config/wehttamsnaps/webapps/nexusmods/`

### Modding Discord
- **Purpose**: Community support and chat
- **Keybind**: `Super + Alt + D`
- **Features**: Persistent login, community channels
- **Location**: `~/.config/wehttamsnaps/webapps/modding-discord/`

### LOOT WebApp
- **Purpose**: Load order optimization
- **Keybind**: `Super + Alt + L`
- **Features**: Online LOOT interface
- **Location**: `~/.config/wehttamsnaps/webapps/loot/`

### Modding Wiki
- **Purpose**: Documentation and guides
- **Keybind**: `Super + Alt + W`
- **Features**: Creation Kit wiki, modding guides
- **Location**: `~/.config/wehttamsnaps/webapps/modding-wiki/`

## 🔧 Advanced Configuration

### Custom Window Rules
Add custom rules to `~/.config/niri/conf.d/35-modding.kdl`:

```kdl
window-rule {
    match app-id="your-mod-tool"
    open-floating true
    geometry-corner-radius 12
    default-width { fixed 1400 }
    default-height { fixed 900 }
}
```

### Custom Keybinds
Add to `~/.config/niri/conf.d/51-modding-keybinds.kdl`:

```kdl
bind-key {
    Super + Shift + Custom {
        spawn "your-custom-command"
    }
}
```

### Environment Variables
Set in `~/.config/wehttamsnaps/modding-env`:

```bash
export CUSTOM_MOD_DIR="$HOME/.local/share/modding/custom"
export GAME_NAME="Your Game"
```

## 🚀 Performance Optimization

### GameMode Integration
- Automatic GameMode activation for modded games
- CPU governor optimization
- RAM management improvements

### Storage Optimization
- ZRAM for mod cache compression
- SSD optimization for fast loading
- Automatic cleanup of unused files

### Network Optimization
- Parallel mod downloads
- Download resume support
- Cache for frequently accessed mods

## 🔍 Troubleshooting

### Common Issues

**Mods not loading:**
1. Check load order with LOOT
2. Verify dependencies are installed
3. Check for conflicts in mod manager
4. Ensure game version compatibility

**Performance issues:**
1. Enable GameMode: `Super + Shift + G`
2. Check GPU usage: `nvtop`
3. Monitor RAM: `htop`
4. Clean cache: `Super + Ctrl + Shift + C`

**Tool crashes:**
1. Check logs in `~/.local/share/modding/logs/`
2. Update tool versions
3. Verify Proton compatibility
4. Check disk space

### Debug Commands
```bash
# Check modding processes
Super + Ctrl + Shift + P

# Monitor disk usage
Super + Ctrl + Shift + D

# View modding logs
ls -la ~/.local/share/modding/logs/

# Test tool functionality
steamtinkerlaunch test
vortex --debug
modorganizer2 --log
```

## 📚 Learning Resources

### Documentation
- [SteamTinkerLaunch Wiki](https://github.com/sonic2kk/steamtinkerlaunch/wiki)
- [Vortex Documentation](https://wiki.nexusmods.com/index.php/Category:Vortex_Mod_Manager)
- [Mod Organizer 2 Wiki](https://github.com/ModOrganizer2/modorganizer/wiki)
- [Wabbajack Guide](https://www.wabbajack.org/)

### Community
- WehttamSnaps Discord
- Nexus Mods forums
- r/linux_gaming
- r/modorganizer

### Video Tutorials
- WehttamSnaps YouTube channel
- Gopher's Modding Tutorials
- GamerPoets Mod Guides

## 🎯 Best Practices

### Workflow Tips
1. **Start simple**: Begin with essential mods
2. **Test often**: Launch game after each major addition
3. **Backup regularly**: Use `Super + Ctrl + Shift + B`
4. **Document changes**: Keep notes on mod configurations
5. **Use profiles**: Separate setups for different playstyles

### Security Considerations
1. **Download from trusted sources**: Nexus Mods primarily
2. **Scan archives**: Check for malware
3. **Backup before changes**: Always have restore points
4. **Keep original files**: Don't overwrite game files

### Performance Tips
1. **Use SSD storage**: Faster loading times
2. **Optimize textures**: Compress large texture packs
3. **Monitor VRAM**: Don't exceed GPU memory
4. **Use GameMode**: Automatic performance optimization

---

**🎮 Enhanced Modding Experience with WehttamSnaps**

This comprehensive modding setup provides everything you need for professional game modding on Arch Linux. The integrated workflow, optimized keybinds, and specialized tools make modding accessible and efficient.

For support and updates, visit: https://github.com/Crowdrocker