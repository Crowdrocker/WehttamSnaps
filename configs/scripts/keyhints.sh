#!/bin/bash
# === WEHTTAMSNAPS KEYBINDINGS HELP ===
# GitHub: https://github.com/Crowdrocker

# GDK BACKEND. Change to either wayland or x11 if having issues
BACKEND=wayland

# Check if rofi or yad is running and kill them if they are
if pidof rofi > /dev/null; then
  pkill rofi
fi

if pidof yad > /dev/null; then
  pkill yad
fi

# Launch yad with calculated width and height
GDK_BACKEND=$BACKEND yad \
    --center \
    --title="WehttamSnaps Quick Cheat Sheet" \
    --no-buttons \
    --list \
    --column=Key: \
    --column=Description: \
    --column=Command: \
    --timeout-indicator=bottom \
"ESC" "close this app" "" \
" SPACE" "Application Launcher" "(Noctalia Shell)" \
" D" "App Launcher" "(rofi-wayland)" \
" S" "Control Center" "(Noctalia Shell)" \
" ," "Settings" "(Noctalia Shell)" \
"" "" "" \
" ENTER" "Terminal" "(Ghostty)" \
" SHIFT ENTER" "New Tab" "(Ghostty)" \
" B" "Web Browser" "(Firefox)" \
" C" "Code Editor" "(VS Code)" \
" E" "File Manager" "(Thunar)" \
" Q" "Close Window" "(active)" \
" SHIFT Q" "Kill Window" "(force)" \
" F" "Fullscreen" "(toggle)" \
" SHIFT F" "Fake Fullscreen" "(toggle)" \
" T" "Float Window" "(toggle)" \
" SHIFT T" "Float All Windows" "(toggle)" \
"" "" "" \
" V" "Clipboard Manager" "(Noctalia)" \
" H" "Show This Help" "(Keybinds)" \
" W" "Wallpaper Menu" "(Swww)" \
" SHIFT W" "Random Wallpaper" "(Swww)" \
" M" "Theme Switcher" "(WehttamSnaps)" \
" SHIFT M" "Theme Effects" "(Swww)" \
"" "" "" \
"PRINT" "Screenshot" "(Fullscreen)" \
" PRINT" "Screenshot Region" "(Grimblast)" \
" SHIFT PRINT" "Screenshot Active" "(Window)" \
"" "" "" \
" SHIFT G" "Toggle Gamemode" "(Performance)" \
" ALT G" "Gamescope Launcher" "(Gaming)" \
" CTRL G" "Launch Steam" "(Gaming)" \
" CTRL SHIFT G" "Launch Lutris" "(Gaming)" \
"" "" "" \
" 1-0" "Switch Workspace" "(1-10)" \
" SHIFT 1-0" "Move Window to Workspace" "(1-10)" \
" ALT TAB" "Switch Windows" "(Alt+Tab)" \
"  TAB" "Cycle Groups" "(Window Groups)" \
"" "" "" \
" ARROWS" "Move Focus" "(Directional)" \
" SHIFT ARROWS" "Move Window" "(Directional)" \
" ALT ARROWS" "Resize Window" "(Directional)" \
"" "" "" \
" CTRL B" "Toggle Waybar" "(Backup Shell)" \
" CTRL L" "Lock Screen" "(Noctalia)" \
" CTRL R" "Reboot System" "(Systemd)" \
" CTRL DELETE" "Power Off" "(Systemd)" \
"" "" "" \
"Audio Controls:" "" "" \
"XF86AudioRaiseVolume" "Volume Up" "(Pamixer)" \
"XF86AudioLowerVolume" "Volume Down" "(Pamixer)" \
"XF86AudioMute" "Mute Output" "(Pamixer)" \
"XF86AudioMicMute" "Mute Input" "(Pamixer)" \
"XF86AudioPlay" "Play/Pause" "(Playerctl)" \
"XF86AudioNext" "Next Track" "(Playerctl)" \
"XF86AudioPrev" "Previous Track" "(Playerctl)" \
"" "" "" \
"Display Controls:" "" "" \
"XF86MonBrightnessUp" "Brightness Up" "(Brightnessctl)" \
"XF86MonBrightnessDown" "Brightness Down" "(Brightnessctl)" \
"" "" "" \
"WehttamSnaps Webapps:" "" "" \
" CTRL Y" "YouTube" "(Firefox)" \
" CTRL T" "Twitch" "(Firefox)" \
" CTRL D" "Discord" "(Firefox)" \
" CTRL G" "GitHub" "(Firefox)" \
"" "" "" \
"More info:" "https://github.com/Crowdrocker" "WehttamSnaps" \
"" "" "" \
"WehttamSnaps v1.0.0" "Professional Arch Linux Setup" "Hyprland + Noctalia"