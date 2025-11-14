#!/bin/bash
# === WEHTTAMSNAPS INSTALLATION VERIFICATION ===
# Check if all components are properly installed

set -euo pipefail

# Colors
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
RED='\033[0;31m'
NC='\033[0m'

# Counter for results
PASSED=0
FAILED=0
TOTAL=0

echo -e "${BLUE}🔍 WehttamSnaps Installation Verification${NC}"
echo -e "${BLUE}Checking all components...${NC}"
echo ""

# Function to run a test
run_test() {
    local test_name="$1"
    local test_command="$2"
    
    TOTAL=$((TOTAL + 1))
    
    echo -e "${YELLOW}[TEST] $test_name${NC}"
    
    if eval "$test_command" &>/dev/null; then
        echo -e "   ${GREEN}✅ PASS${NC}"
        PASSED=$((PASSED + 1))
    else
        echo -e "   ${RED}❌ FAIL${NC}"
        FAILED=$((FAILED + 1))
    fi
    echo ""
}

# Check required packages
run_test "Niri installed" "command -v niri"
run_test "Noctalia installed" "command -v qs"
run_test "Ghostty installed" "command -v ghostty"
run_test "Steam installed" "command -v steam"
run_test "GameMode installed" "command -v gamemoded"
run_test "EasyEffects installed" "command -v easyeffects"
run_test "Qpwgraph installed" "command -v qpwgraph"
run_test "Darktable installed" "command -v darktable"
run_test "GIMP installed" "command -v gimp"
run_test "OBS Studio installed" "command -v obs"

# Check configuration files
run_test "Niri config exists" "test -f ~/.config/niri/config.kdl"
run_test "Ghostty config exists" "test -f ~/.config/ghostty/config"
run_test "WehttamSnaps directory exists" "test -d ~/.config/wehttamsnaps"
run_test "Scripts directory exists" "test -d ~/.config/wehttamsnaps/scripts"
run_test "WebApps directory exists" "test -d ~/.config/wehttamsnaps/webapps"

# Check script functionality
run_test "Welcome script executable" "test -x ~/.config/wehttamsnaps/scripts/welcome.py"
run_test "Keyhints script executable" "test -x ~/.config/wehttamsnaps/scripts/keyhints.sh"
run_test "Gaming toggle script executable" "test -x ~/.config/wehttamsnaps/scripts/toggle-gamemode.sh"
run_test "Audio setup script executable" "test -x ~/.config/wehttamsnaps/scripts/audio-setup.sh"

# Check webapp scripts
run_test "YouTube webapp script exists" "test -f ~/.config/wehttamsnaps/webapps/youtube.sh"
run_test "Twitch webapp script exists" "test -f ~/.config/wehttamsnaps/webapps/twitch.sh"
run_test "Music webapp script exists" "test -f ~/.config/wehttamsnaps/webapps/music.sh"
run_test "Discord webapp script exists" "test -f ~/.config/wehttamsnaps/webapps/discord.sh"

# Check services
run_test "PipeWire running" "pgrep -x pipewire"
run_test "WirePlumber running" "pgrep -x wireplumber"
run_test "GameMode service enabled" "systemctl is-enabled gamemoded"

# Check gaming components
run_test "Vulkan support available" "vulkaninfo --summary | grep -q 'GPU'"
run_test "DXVK installed" "ls /usr/share/vulkan/implicit_layer.d/ | grep -q dxvk"

# Check audio components
run_test "Audio devices available" "pactl list sinks | grep -q 'Sink'"
run_test "Microphone devices available" "pactl list sources | grep -q 'Source'"

# Check display configuration
run_test "Xwayland available" "command -v Xwayland"
run_test "GTK themes installed" "ls /usr/share/themes/ | grep -q 'Tokyonight'"

# Check hardware optimization
run_test "CPU frequency control available" "command -v cpupower"
run_test "GPU monitoring tool available" "command -v nvtop"

# Print results
echo -e "${BLUE}📊 VERIFICATION RESULTS${NC}"
echo -e "${GREEN}✅ Passed: $PASSED${NC}"
echo -e "${RED}❌ Failed: $FAILED${NC}"
echo -e "${YELLOW}📋 Total: $TOTAL${NC}"
echo ""

# Calculate percentage
PERCENT=$((PASSED * 100 / TOTAL))
echo -e "${BLUE}📈 Success Rate: $PERCENT%${NC}"
echo ""

if [ $FAILED -eq 0 ]; then
    echo -e "${GREEN}🎉 PERFECT INSTALLATION!${NC}"
    echo -e "${GREEN}All WehttamSnaps components are properly installed.${NC}"
    echo ""
    echo -e "${YELLOW}🚀 Next steps:${NC}"
    echo -e "   1. Reboot your system"
    echo -e "   2. Select Niri from your display manager"
    echo -e "   3. Enjoy your WehttamSnaps setup!"
else
    echo -e "${YELLOW}⚠️  INSTALLATION ISSUES DETECTED${NC}"
    echo -e "${YELLOW}Some components may need manual attention.${NC}"
    echo ""
    echo -e "${YELLOW}🛠️  Troubleshooting steps:${NC}"
    echo -e "   1. Check failed components above"
    echo -e "   2. Install missing packages manually"
    echo -e "   3. Verify configuration file locations"
    echo -e "   4. Restart relevant services"
    echo ""
    echo -e "${BLUE}📖 For help, see:${NC}"
    echo -e "   • README.md for documentation"
    echo -e "   • PROJECT_SUMMARY.md for overview"
    echo -e "   • GitHub issues for support"
fi

echo ""
echo -e "${PURPLE}🔗 WehttamSnaps Links:${NC}"
echo -e "   • GitHub: https://github.com/Crowdrocker"
echo -e "   • YouTube: https://youtube.com/@WehttamSnaps"
echo ""