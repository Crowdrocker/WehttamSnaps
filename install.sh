#!/bin/bash
# === WEHTTAMSNAPS INSTALLATION SCRIPT ===
# GitHub: https://github.com/Crowdrocker
# Professional Arch Linux Hyprland Setup Installer

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color

# WehttamSnaps branding
WS_VERSION="1.0.0"
WS_REPO="https://github.com/Crowdrocker/WehttamSnaps"

# Helper functions
print_banner() {
    clear
    echo -e "${PURPLE}"
    echo "╔══════════════════════════════════════════════════════════════╗"
    echo "║                                                              ║"
    echo "║     ██╗  ██╗ ██████╗ ██╗   ██╗███████╗████████╗               ║"
    echo "║     ██║ ██╔╝██╔═══██╗██║   ██║██╔════╝╚══██╔══╝               ║"
    echo "║     █████╔╝ ██║   ██║██║   ██║█████╗     ██║                  ║"
    echo "║     ██╔═██╗ ██║   ██║╚██╗ ██╔╝██╔══╝     ██║                  ║"
    echo "║     ██║  ██╗╚██████╔╝ ╚████╔╝ ███████╗   ██║                  ║"
    echo "║     ╚═╝  ╚═╝ ╚═════╝   ╚═══╝  ╚══════╝   ╚═╝                  ║"
    echo "║                                                              ║"
    echo "║                     WehttamSnaps                             ║"
    echo "║                Professional Arch Linux Setup                 ║"
    echo "║                                                              ║"
    echo "║     GitHub: https://github.com/Crowdrocker                  ║"
    echo "╚══════════════════════════════════════════════════════════════╝"
    echo -e "${NC}"
    echo -e "${CYAN}WehttamSnaps v${WS_VERSION} - Professional Arch Linux Hyprland Setup${NC}"
    echo -e "${CYAN}Repository: ${WS_REPO}${NC}"
    echo ""
}

print_status() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

print_success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

print_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

# Check if running as root
check_root() {
    if [[ $EUID -eq 0 ]]; then
        print_error "This script should not be run as root!"
        exit 1
    fi
}

# Check if on Arch Linux
check_arch() {
    if ! command -v pacman &> /dev/null; then
        print_error "This script is designed for Arch Linux!"
        exit 1
    fi
}

# Check internet connection
check_internet() {
    if ! ping -c 1 archlinux.org &> /dev/null; then
        print_error "No internet connection available!"
        exit 1
    fi
}

# Install yay AUR helper if not present
install_yay() {
    if ! command -v yay &> /dev/null; then
        print_status "Installing yay AUR helper..."
        git clone https://aur.archlinux.org/yay-bin.git /tmp/yay-bin
        cd /tmp/yay-bin
        makepkg -si --noconfirm
        cd -
        rm -rf /tmp/yay-bin
        print_success "yay installed successfully"
    else
        print_status "yay is already installed"
    fi
}

# Install core packages
install_core_packages() {
    print_status "Installing core packages..."
    
    # Update package database
    sudo pacman -Syu --noconfirm
    
    # Install packages from core.txt
    if [[ -f "packages/core.txt" ]]; then
        while IFS= read -r package; do
            # Skip comments and empty lines
            [[ $package =~ ^#.*$ ]] && continue
            [[ -z "$package" ]] && continue
            
            print_status "Installing $package..."
            
            # Try with pacman first, then yay for AUR packages
            if sudo pacman -S --needed --noconfirm "$package" 2>/dev/null; then
                print_success "$package installed"
            elif yay -S --needed --noconfirm "$package" 2>/dev/null; then
                print_success "$package installed from AUR"
            else
                print_warning "$package could not be installed"
            fi
        done < "packages/core.txt"
    fi
}

# Install optional packages
install_optional_packages() {
    print_warning "Optional packages installation (may take a while)..."
    read -p "Do you want to install optional packages? (y/N): " -n 1 -r
    echo
    
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        if [[ -f "packages/optional.txt" ]]; then
            while IFS= read -r package; do
                # Skip comments and empty lines
                [[ $package =~ ^#.*$ ]] && continue
                [[ -z "$package" ]] && continue
                
                print_status "Installing optional $package..."
                
                if yay -S --needed --noconfirm "$package" 2>/dev/null; then
                    print_success "$package installed"
                else
                    print_warning "$package could not be installed"
                fi
            done < "packages/optional.txt"
        fi
    fi
}

# Setup configuration files
setup_configs() {
    print_status "Setting up configuration files..."
    
    # Create necessary directories
    mkdir -p ~/.config/wehttamsnaps/{logs,backups}
    mkdir -p ~/.config/{hyprland,ghostty,noctalia,waybar}
    mkdir -p ~/Pictures/{Screenshots,Wallpapers}
    mkdir -p ~/Games
    
    # Backup existing configs
    if [[ -d ~/.config/hyprland ]]; then
        mv ~/.config/hyprland ~/.config/wehttamsnaps/backups/hyprland.bak.$(date +%Y%m%d_%H%M%S)
    fi
    
    # Symlink configuration files
    ln -sf "$(pwd)/configs/hyprland" ~/.config/hyprland
    ln -sf "$(pwd)/configs/ghostty" ~/.config/ghostty
    ln -sf "$(pwd)/configs/noctalia" ~/.config/noctalia
    ln -sf "$(pwd)/configs/waybar" ~/.config/waybar
    ln -sf "$(pwd)/configs/scripts" ~/.config/wehttamsnaps/scripts
    
    # Copy logos and assets
    mkdir -p ~/.config/wehttamsnaps/assets/{logos,sounds,fonts}
    cp -r assets/* ~/.config/wehttamsnaps/assets/ 2>/dev/null || true
    
    # Create VERSION file
    echo "$WS_VERSION" > ~/.config/wehttamsnaps/VERSION
    
    print_success "Configuration files set up"
}

# Setup SDDM theme
setup_sddm() {
    print_status "Setting up SDDM theme..."
    
    sudo systemctl enable sddm
    sudo sddm-example-config --install
    
    # Set SDDM theme if available
    if pacman -Qi sddm-sugar-candy-git &> /dev/null; then
        sudo mkdir -p /etc/sddm.conf.d
        echo "[Theme]" | sudo tee /etc/sddm.conf.d/theme.conf > /dev/null
        echo "Current=sugar-candy" | sudo tee -a /etc/sddm.conf.d/theme.conf > /dev/null
        print_success "SDDM theme set to sugar-candy"
    fi
}

# Setup Plymouth theme
setup_plymouth() {
    print_status "Setting up Plymouth theme..."
    
    if command -v plymouth &> /dev/null; then
        sudo systemctl enable plymouth-quit-wait.service
        
        # Create WehttamSnaps Plymouth theme directory
        sudo mkdir -p /usr/share/plymouth/themes/wehttamsnaps
        
        # Copy theme files if available
        if [[ -d "themes/plymouth" ]]; then
            sudo cp -r themes/plymouth/* /usr/share/plymouth/themes/wehttamsnaps/
            
            # Set Plymouth theme
            sudo plymouth-set-default-theme -R wehttamsnaps
            print_success "Plymouth theme set to WehttamSnaps"
        fi
    else
        print_warning "Plymouth not installed, skipping theme setup"
    fi
}

# Setup user services
setup_services() {
    print_status "Setting up user services..."
    
    # Enable user services
    systemctl --user enable pipewire pipewire-pulse 2>/dev/null || true
    systemctl --user enable wireplumber 2>/dev/null || true
    
    # Enable system services
    sudo systemctl enable auto-cpufreq 2>/dev/null || true
    sudo systemctl enable thermald 2>/dev/null || true
    sudo systemctl enable gamemoded 2>/dev/null || true
    
    print_success "Services configured"
}

# Setup gaming optimizations
setup_gaming() {
    print_status "Setting up gaming optimizations..."
    
    # Create directories for games
    mkdir -p ~/Games/{Steam,Lutris,Gamescope}
    
    # Copy gaming scripts
    cp configs/scripts/gaming-setup.sh ~/.config/wehttamsnaps/scripts/
    cp configs/scripts/toggle-gamemode.sh ~/.config/wehttamsnaps/scripts/
    
    # Make scripts executable
    chmod +x ~/.config/wehttamsnaps/scripts/gaming-*.sh
    chmod +x ~/.config/wehttamsnaps/scripts/toggle-*.sh
    
    # Run gaming setup
    ~/.config/wehttamsnaps/scripts/gaming-setup.sh
    
    print_success "Gaming optimizations configured"
}

# Create desktop entries
create_desktop_entries() {
    print_status "Creating desktop entries..."
    
    # Create WehttamSnaps welcome desktop entry
    cat > ~/.local/share/applications/wehttamsnaps-welcome.desktop << EOF
[Desktop Entry]
Version=1.0
Type=Application
Name=WehttamSnaps Welcome
Comment=WehttamSnaps Setup and Information
Exec=python3 ~/.config/wehttamsnaps/scripts/welcome.py
Icon=preferences-desktop-theme-global
Terminal=false
Categories=System;Settings;
StartupNotify=false
EOF

    # Create WehttamSnaps keyhints desktop entry
    cat > ~/.local/share/applications/wehttamsnaps-keyhints.desktop << EOF
[Desktop Entry]
Version=1.0
Type=Application
Name=WehttamSnaps Keybinds
Comment=Show WehttamSnaps keyboard shortcuts
Exec=~/.config/wehttamsnaps/scripts/keyhints.sh
Icon=preferences-desktop-keyboard
Terminal=false
Categories=System;Documentation;
StartupNotify=false
EOF

    print_success "Desktop entries created"
}

# Final setup
finalize_setup() {
    print_status "Finalizing setup..."
    
    # Update shell configuration
    if ! grep -q "WehttamSnaps" ~/.zshrc 2>/dev/null; then
        echo "# WehttamSnaps Configuration" >> ~/.zshrc
        echo "export WS_CONFIG_DIR=\$HOME/.config/wehttamsnaps" >> ~/.zshrc
        echo "export PATH=\$PATH:\$WS_CONFIG_DIR/scripts" >> ~/.zshrc
    fi
    
    # Set default browser
    xdg-settings set default-web-browser firefox.desktop
    
    # Create desktop shortcuts
    mkdir -p ~/Desktop
    ln -sf ~/.local/share/applications/wehttamsnaps-welcome.desktop ~/Desktop/ 2>/dev/null || true
    
    # Set permissions
    chmod +x ~/.config/wehttamsnaps/scripts/*.sh
    chmod +x ~/.config/wehttamsnaps/scripts/*.py
    
    print_success "Setup finalized"
}

# Show completion message
show_completion() {
    print_success "WehttamSnaps installation completed successfully!"
    echo ""
    echo -e "${CYAN}=== WEHTTAMSNAPS SETUP COMPLETE ===${NC}"
    echo ""
    echo -e "${GREEN}🚀 What's next:${NC}"
    echo "1. Reboot your system to load all configurations"
    echo "2. The welcome app will appear on first login"
    echo "3. Press SUPER+H to view all keybinds"
    echo "4. Use SUPER+SHIFT+G to toggle gamemode"
    echo ""
    echo -e "${GREEN}📚 Documentation:${NC}"
    echo "• README.md for full documentation"
    echo "• configs/hyprland/conf.d/ for configuration"
    echo "• ~/.config/wehttamsnaps/scripts/ for utilities"
    echo ""
    echo -e "${GREEN}🎮 Gaming:${NC}"
    echo "• Steam is configured with optimizations"
    echo "• Game launch scripts are in ~/Games/"
    echo "• Division 2 and Cyberpunk 2077 fixes applied"
    echo ""
    echo -e "${GREEN}🎨 Customization:${NC}"
    echo "• Edit configs/hyprland/conf.d/99-overrides.conf for personal tweaks"
    echo "• Wallpapers go in ~/Pictures/Wallpapers/"
    echo "• Custom scripts go in ~/.config/wehttamsnaps/scripts/"
    echo ""
    echo -e "${PURPLE}Thank you for using WehttamSnaps!${NC}"
    echo -e "${PURPLE}GitHub: https://github.com/Crowdrocker${NC}"
    echo ""
    
    read -p "Press Enter to continue or Ctrl+C to exit..."
}

# Main installation function
main() {
    print_banner
    
    print_status "Starting WehttamSnaps installation..."
    
    # Check prerequisites
    check_root
    check_arch
    check_internet
    
    # Installation steps
    install_yay
    install_core_packages
    install_optional_packages
    setup_configs
    setup_sddm
    setup_plymouth
    setup_services
    setup_gaming
    create_desktop_entries
    finalize_setup
    
    show_completion
}

# Run installation
main "$@"