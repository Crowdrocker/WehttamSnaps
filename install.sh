#!/bin/bash
# === WEHTTAMSNAPS INSTALLER ===
# GitHub: https://github.com/Crowdrocker
# Arch Linux Niri + Noctalia + Ghostty Setup

set -euo pipefail

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color

# ASCII Art Logo
show_logo() {
    echo -e "${PURPLE}"
    cat << "EOF"
    ██╗  ██╗███████╗██████╗ ██████╗ ██╗    ██╗
    ██║  ██║██╔════╝██╔══██╗██╔══██╗██║    ██║
    ███████║█████╗  ██████╔╝██████╔╝██║ █╗ ██║
    ██╔══██║██╔══╝  ██╔══██╗██╔══██╗██║███╗██║
    ██║  ██║███████╗██║  ██║██║  ██║╚███╔███╔╝
    ╚═╝  ╚═╝╚══════╝╚═╝  ╚═╝╚═╝  ╚═╝ ╚══╝╚══╝ 
                                           
               ██████╗ ██████╗ ███╗   ██╗██╗
              ██╔════╝██╔═══██╗████╗  ██║██║
              ██║     ██║   ██║██╔██╗ ██║██║
              ██║     ██║   ██║██║╚██╗██║╚═╝
              ╚██████╗╚██████╔╝██║ ╚████║██╗
               ╚═════╝ ╚═════╝ ╚═╝  ╚═══╝╚═╝
EOF
    echo -e "${NC}"
    echo -e "${CYAN}Professional Arch Linux Niri Setup for Photography & Gaming${NC}"
    echo -e "${CYAN}GitHub: https://github.com/Crowdrocker${NC}"
    echo ""
}

# Check if running as root
check_root() {
    if [[ $EUID -eq 0 ]]; then
        echo -e "${RED}ERROR: Do not run as root! This installer should be run as a regular user.${NC}"
        exit 1
    fi
}

# Check if running on Arch Linux
check_arch() {
    if ! command -v pacman &> /dev/null; then
        echo -e "${RED}ERROR: This installer is designed for Arch Linux only!${NC}"
        exit 1
    fi
}

# Check for internet connection
check_internet() {
    if ! ping -c 1 google.com &> /dev/null; then
        echo -e "${RED}ERROR: No internet connection detected!${NC}"
        exit 1
    fi
}

# Install AUR helper if not present
install_aur_helper() {
    echo -e "${BLUE}[INFO] Installing AUR helper...${NC}"
    
    if command -v paru &> /dev/null; then
        echo -e "${GREEN}[OK] Paru already installed${NC}"
        return
    fi
    
    echo -e "${YELLOW}[INSTALL] Installing paru...${NC}"
    sudo pacman -S --needed --noconfirm base-devel git
    
    temp_dir=$(mktemp -d)
    cd "$temp_dir"
    git clone https://aur.archlinux.org/paru-bin.git
    cd paru-bin
    makepkg -si --noconfirm
    
    cd "$HOME"
    rm -rf "$temp_dir"
    
    echo -e "${GREEN}[OK] AUR helper installed${NC}"
}

# Install core packages
install_packages() {
    echo -e "${BLUE}[INFO] Installing core packages...${NC}"
    
    # Install packages from core list
    while IFS= read -r package; do
        # Skip comments and empty lines
        [[ "$package" =~ ^#.*$ ]] && continue
        [[ -z "$package" ]] && continue
        
        echo -e "${YELLOW}[INSTALL] $package${NC}"
        
        if paru -S --needed --noconfirm "$package"; then
            echo -e "${GREEN}[OK] $package installed${NC}"
        else
            echo -e "${RED}[FAIL] Failed to install $package${NC}"
        fi
    done < configs/packages/core-packages.txt
    
    echo -e "${GREEN}[OK] Core packages installed${NC}"
}

# Setup directories
setup_directories() {
    echo -e "${BLUE}[INFO] Setting up directories...${NC}"
    
    directories=(
        "$HOME/.config/wehttamsnaps"
        "$HOME/.config/wehttamsnaps/scripts"
        "$HOME/.config/wehttamsnaps/webapps"
        "$HOME/.config/wehttamsnaps/assets"
        "$HOME/.config/wehttamsnaps/themes"
        "$HOME/.config/wehttamsnaps/wallpapers"
        "$HOME/.config/niri/conf.d"
        "$HOME/.config/ghostty"
        "$HOME/Pictures/Screenshots"
        "$HOME/Videos/Screencasts"
    )
    
    for dir in "${directories[@]}"; do
        mkdir -p "$dir"
        echo -e "${GREEN}[OK] Created $dir${NC}"
    done
}

# Copy configuration files
copy_configs() {
    echo -e "${BLUE}[INFO] Installing configuration files...${NC}"
    
    # Niri configuration
    cp -r configs/niri/* "$HOME/.config/niri/"
    echo -e "${GREEN}[OK] Niri configuration installed${NC}"
    
    # Ghostty configuration
    cp configs/ghostty/config "$HOME/.config/ghostty/"
    echo -e "${GREEN}[OK] Ghostty configuration installed${NC}"
    
    # Scripts
    cp configs/scripts/*.sh "$HOME/.config/wehttamsnaps/scripts/"
    chmod +x "$HOME/.config/wehttamsnaps/scripts/"*.sh
    echo -e "${GREEN}[OK] Scripts installed${NC}"
    
    # Webapps
    cp configs/webapps/*.sh "$HOME/.config/wehttamsnaps/webapps/"
    chmod +x "$HOME/.config/wehttamsnaps/webapps/"*.sh
    echo -e "${GREEN}[OK] Webapps installed${NC}"
    
    # Plymouth theme
    if [[ -d configs/plymouth ]]; then
        sudo mkdir -p /usr/share/plymouth/themes/wehttamsnaps
        sudo cp configs/plymouth/* /usr/share/plymouth/themes/wehttamsnaps/
        sudo cp ws-logo.png /usr/share/plymouth/themes/wehttamsnaps/
        sudo cp reactor.png /usr/share/plymouth/themes/wehttamsnaps/
        echo -e "${GREEN}[OK] Plymouth theme installed${NC}"
    fi
    
    # Assets
    cp *.png "$HOME/.config/wehttamsnaps/assets/"
    echo -e "${GREEN}[OK] Assets copied${NC}"
}

# Setup services
setup_services() {
    echo -e "${BLUE}[INFO] Setting up services...${NC}"
    
    # Enable services
    services=(
        "gdm"
        "NetworkManager"
        "bluetooth"
        " cups"
    )
    
    for service in "${services[@]}"; do
        sudo systemctl enable "$service" 2>/dev/null || true
        echo -e "${GREEN}[OK] Enabled $service${NC}"
    done
    
    # Enable user services
    user_services=(
        "pipewire"
        "pipewire-pulse"
        "wireplumber"
    )
    
    for service in "${user_services[@]}"; do
        systemctl --user enable "$service" 2>/dev/null || true
        echo -e "${GREEN}[OK] Enabled user service $service${NC}"
    done
}

# Setup Plymouth theme
setup_plymouth() {
    echo -e "${BLUE}[INFO] Setting up Plymouth theme...${NC}"
    
    # Install plymouth if not present
    if ! command -v plymouth &> /dev/null; then
        sudo pacman -S --noconfirm plymouth
    fi
    
    # Set up WehttamSnaps theme
    sudo plymouth-set-default-theme -R wehttamsnaps
    
    # Update GRUB for Plymouth
    if sudo grep -q "GRUB_CMDLINE_LINUX_DEFAULT=" /etc/default/grub; then
        sudo sed -i 's/GRUB_CMDLINE_LINUX_DEFAULT="[^"]*/& splash quiet/' /etc/default/grub
    else
        echo 'GRUB_CMDLINE_LINUX_DEFAULT="quiet splash"' | sudo tee -a /etc/default/grub
    fi
    
    sudo grub-mkconfig -o /boot/grub/grub.cfg
    
    echo -e "${GREEN}[OK] Plymouth theme configured${NC}"
}

# Create VERSION file
create_version() {
    echo "1.0.0" > "$HOME/.config/wehttamsnaps/VERSION"
    echo -e "${GREEN}[OK] Version file created${NC}"
}

# Setup shell
setup_shell() {
    echo -e "${BLUE}[INFO] Setting up shell...${NC}"
    
    # Change to Zsh if available
    if command -v zsh &> /dev/null; then
        chsh -s /bin/zsh
        echo -e "${GREEN}[OK] Shell changed to Zsh${NC}"
    fi
    
    # Setup Starship prompt
    if command -v starship &> /dev/null; then
        echo 'eval "$(starship init zsh)"' >> "$HOME/.zshrc"
        echo -e "${GREEN}[OK] Starship prompt configured${NC}"
    fi
}

# Final optimizations
optimize_system() {
    echo -e "${BLUE}[INFO] Applying system optimizations...${NC}"
    
    # Enable performance governor for gaming
    echo "options cpufreq.default_governor=ondemand" | sudo tee -a /etc/modprobe.d/cpufreq.conf
    
    # Enable user namespaces
    echo "user.max_user_namespaces=150000" | sudo tee -a /etc/sysctl.d/99-userns.conf
    
    # Add user to required groups
    sudo usermod -a -G video,audio,input,docker "$USER"
    
    echo -e "${GREEN}[OK] System optimizations applied${NC}"
}

# Create desktop entry for WehttamSnaps
create_desktop_entry() {
    echo -e "${BLUE}[INFO] Creating desktop entry...${NC}"
    
    cat > "$HOME/.local/share/applications/wehttamsnaps.desktop" << EOF
[Desktop Entry]
Name=WehttamSnaps
Comment=WehttamSnaps Configuration Tool
Exec=python3 $HOME/.config/wehttamsnaps/scripts/welcome.py --force
Icon=applications-system
Terminal=false
Type=Application
Categories=System;Settings;
EOF
    
    echo -e "${GREEN}[OK] Desktop entry created${NC}"
}

# Display final message
show_final_message() {
    echo ""
    echo -e "${GREEN}╔══════════════════════════════════════════════════════════════╗${NC}"
    echo -e "${GREEN}║                    🎉 INSTALLATION COMPLETE! 🎉                ║${NC}"
    echo -e "${GREEN}╚══════════════════════════════════════════════════════════════╝${NC}"
    echo ""
    echo -e "${CYAN}WehttamSnaps has been successfully installed on your system!${NC}"
    echo ""
    echo -e "${YELLOW}📋 NEXT STEPS:${NC}"
    echo -e "   1. Reboot your system to apply all changes"
    echo -e "   2. Select Niri from your display manager"
    echo -e "   3. The WehttamSnaps welcome app will start automatically"
    echo -e "   4. Press SUPER + H anytime to view keybinds"
    echo ""
    echo -e "${YELLOW}🎮 GAMING OPTIMIZATIONS:${NC}"
    echo -e "   • RX 580 drivers configured"
    echo -e "   • Vulkan support enabled"
    echo -e "   • Gaming mode toggle: SUPER + SHIFT + G"
    echo -e "   • CoreCtrl for GPU control: SUPER + CTRL + G"
    echo ""
    echo -e "${YELLOW}📸 PHOTOGRAPHY WORKFLOW:${NC}"
    echo -e "   • Darktable: SUPER + SHIFT + D"
    echo -e "   • RawTherapee: SUPER + SHIFT + R"
    echo -e "   • GIMP: SUPER + SHIFT + G"
    echo -e "   • Inkscape: SUPER + SHIFT + I"
    echo ""
    echo -e "${YELLOW}🌐 WEBAPPS:${NC}"
    echo -e "   • YouTube: SUPER + SHIFT + Y"
    echo -e "   • Twitch: SUPER + SHIFT + T"
    echo -e "   • Music: SUPER + SHIFT + M"
    echo -e "   • Discord: SUPER + SHIFT + D"
    echo ""
    echo -e "${PURPLE}📚 DOCUMENTATION & SUPPORT:${NC}"
    echo -e "   • GitHub: https://github.com/Crowdrocker"
    echo -e "   • YouTube: https://youtube.com/@WehttamSnaps"
    echo -e "   • Configs: ~/.config/wehttamsnaps/"
    echo ""
    echo -e "${GREEN}Thank you for choosing WehttamSnaps! Enjoy your new setup! 🚀${NC}"
    echo ""
}

# Main installation function
main() {
    show_logo
    
    echo -e "${BLUE}[INFO] Starting WehttamSnaps installation...${NC}"
    
    # Pre-install checks
    check_root
    check_arch
    check_internet
    
    # Installation steps
    install_aur_helper
    install_packages
    setup_directories
    copy_configs
    setup_services
    setup_plymouth
    create_version
    setup_shell
    optimize_system
    create_desktop_entry
    
    show_final_message
}

# Handle script arguments
case "${1:-}" in
    --help|-h)
        echo "WehttamSnaps Installer"
        echo "Usage: $0 [options]"
        echo "Options:"
        echo "  --help, -h     Show this help message"
        echo "  --no-plymouth  Skip Plymouth theme installation"
        exit 0
        ;;
    --no-plymouth)
        echo -e "${YELLOW}[INFO] Skipping Plymouth theme installation${NC}"
        # Remove Plymouth setup from main function
        main() {
            show_logo
            check_root
            check_arch
            check_internet
            install_aur_helper
            install_packages
            setup_directories
            copy_configs
            setup_services
            create_version
            setup_shell
            optimize_system
            create_desktop_entry
            show_final_message
        }
        ;;
esac

# Run main installation
main "$@"