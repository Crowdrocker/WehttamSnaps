# WehttamSnaps — Arch Linux Niri Setup (Professional Plan)

Author: Matthew (GitHub: [Crowdrocker](https://github.com/Crowdrocker))  
Brand: WehttamSnaps — "WehttamSnaps" = "WehttamSnaps" (your handle spelled backwards)  
Twitch / YouTube: WehttamSnaps

Status: Draft / Roadmap / Install blueprint  
Target platform: Arch Linux (desktop), Niri (Wayland compositor)  
Shell: Noctalia (Quickshell-based) — primary UI (replace Waybar)

Summary
-------
This repository / plan contains a modular, brandable Niri configuration optimized for photography, content creation, streaming, and gaming on a budget build (i5-4430 + RX 580 / GTX 1650). The aim is a hybrid of Omarchy (workflow) + JaKooLit (themeing) with Noctalia (Quickshell) as the shell.

High-level goals
- A consistent WehttamSnaps brand (logo.txt present in configs, GitHub link).
- Minimal, fast, and modular Niri config (split into files).
- Quickshell widgets for Work and Gaming (easy-to-add widget template).
- J.A.R.V.I.S. integration (sound pack + triggered audio events).
- Modular repo structure: wallpapers, themes, webapps, sounds, widgets, scripts.
- New-user friendly: clear README, install scripts, branch structure.
- Streaming-friendly audio routing using PipeWire + qpwgraph + virtual sinks.
- Gamemode + performance toggles (gamescope, gamemode, zram, etc.)

Hardware consideration: Which GPU?
1) Which GPU is better for you?
- RX 580 (AMD)
  - Pros: Generally superior for Linux gaming due to open-source Mesa/AMDGPU support, Vulkan performance, better Linux drivers, and freesync support. Good for 1080p gaming.
  - Cons: Slightly older; 4/8 GB variants.
- GTX 1650 (NVIDIA)
  - Pros: Works well in many games; proprietary drivers may provide better vendor-backed performance in some titles.
  - Cons: NVIDIA Wayland support is improving but more fragile than AMD for open-source stacks. Proprietary drivers complicate Wayland/Niri (XWayland/GBM issues).
Recommendation: Prefer RX 580 for a Wayland-first Niri + PipeWire + Gamescope stack. If specific Windows-only games or better proprietary driver performance is required, consider the 1650, but for Linux Niri RX 580 is the better fit.

Decide: Fork vs Start from scratch?
- Fork a curated preconfig (JaKooLit / Omarchy) and then:
  - Pros: Faster start, proven configs, compatible modules.
  - Cons: Extra cleanup to remove Waybar / unnecessary packages.
- Start from scratch:
  - Pros: Full control and minimal cruft.
  - Cons: More time to get parity with the features you like.

Recommendation: Fork a clean, actively maintained preconfig (e.g., Omarchy or JaKooLit) as the base branch, then create a "wehttamsnaps" branch that:
- Replaces waybar with Noctalia (Quickshell).
- Adds themeing (JaKooLit) and workflows (Omarchy) features selectively.
This gives speed + control.

Mix and match safely
- Extract only the config modules you want (fonts, rofi themes, hypr rules, keybinds). Keep Niri config modular and document sections with tags and headers (e.g., # MPV media player window rules).
- Replace Waybar modules with compatible Quickshell widgets.
- Test incremental changes on a separate branch; use a VM or another user account when possible.

Component Integration Strategy
- Component | Best Template | Modifications Needed | Base
  - Niri | Omarchy hypr conf (modular) | Split into conf.d files, add tags, remove Waybar sections | Omarchy (base)
  - Noctalia (Quickshell) | Noctalia base | Add custom widgets, top/bottom bar options, integrate theme | Noctalia repo
  - Quickshell widgets | JaKooLit-inspired widget visuals | Create widget template generator (create_widget.sh) | Noctalia / Quickshell
  - Theming (GTK/kvantum) | JaKooLit themes (Tokyonight / Sweet-Ambar) | Adjust color vars to WehttamSnaps gradient | JaKooLit theme repo
  - Audio routing | PipeWire + qpwgraph | Provide J.A.R.V.I.S. sound manager + virtual sinks | PipeWire default
  - Steam/Gaming | Gamemode + Gamescope | Toggle animations, swap to performance profile, start gamescope on launch | Gamemode / Gamescope
  - Autostart scripts | Modular systemd user services + hypr exec-once | Add jarvis startup/shutdown hooks | Minimal systemd user services
  - Welcome app | GTK welcome (modified) | Brand, link to GitHub, show quick tips | Custom Python GTK app
  - Key hints | JaKooLit keyhint script | Update keybinds to Quickshell, Ghostty terminal, Webapps | JaKooLit template

Quickshell / Noctalia strategy
- Use Noctalia as the primary bar (top or bottom) — user preference: top or bottom only.
- Provide a widgets/ directory with clear templates.
- Add README widgets: add-widget.sh (interactive), widget-manifest.json, example CSS and a usage guide.
- Webapps: create small webapp launcher entries (scripts that start webapp wrappers using gtk-webkit or webapp containers).

Modular repo structure (recommended)
- / (repo root)
  - README.md
  - install.sh (top-level installer / scaffolding script)
  - logo.txt (ASCII art + GitHub link)
  - docs/
    - INSTALL.md (detailed step-by-step)
    - QUICKSTART.md (first boot)
  - configs/
    - Niri/
      - hypr.conf (main loader)
      - conf.d/
        - 00-base.conf
        - 10-rules.conf
        - 20-work.conf
        - 30-gaming.conf
        - 99-overrides.conf
    - noctalia/ (Quickshell configs & widgets)
      - widgets/
        - README.md
        - widget-template/
          - manifest.json
          - widget.sh
          - style.css
        - work/
        - gaming/
    - quickshell-apps/
      - welcome.py
      - settings.sh
    - sounds/
      - jarvis-startup.mp3
      - jarvis-shutdown.mp3
      - jarvis-notification.mp3
    - webapps/
      - youtube.webapp
      - twitch.webapp
    - scripts/
      - create_widget.sh
      - toggle-gamemode.sh
      - audio-setup.sh
      - save-configs.sh
  - packages/
    - package.list.txt (curated; trimmed)
  - wallpapers/
  - themes/
  - branches/ (instructions, not actual branches)
    - branch-structure.md

Branching model suggestion
- main (stable / release)
- develop (integration)
- wehttamsnaps-theme (themeing experiments)
- wehttamsnaps-widgets (widget dev)
- wallpapers
- jarvis-sounds
- docs

Repository tips
- Use GitHub Desktop if you prefer a GUI — totally fine. You can still run install.sh locally to bootstrap.
- Use descriptive commits and keep a CHANGELOG.md.

Saving and versioning progress
- Keep config files in the repo and symlink into ~/.config with a small script (save-configs.sh and install script).
- Use git branches for experiments (widgets, themes, sounds).
- Keep a "dotfiles-style" deployment flow: install.sh creates symlinks from repo to ~/.config/wehttamsnaps/...
- Consider adding automatic backups (git push to fork) and snapshots.

Quickshell Widget Template maker
- Provide create_widget.sh that scaffolds a widget folder with manifest.json, widget.sh, style.css and README. Widgets should be loaded by Noctalia from configs/noctalia/widgets/.
- Each widget manifest should include metadata, keybindings suggestions, and how to toggle.

Keybinding cheat sheet auto-update
- Strategy:
  - Keep a canonical keybinds.json in repo.
  - Provide a small script (generate_cheatsheet.sh) that converts keybinds.json into a printable cheatsheet (yad/rofi/text).
  - When a developer adds a new key in the JSON, call generate_cheatsheet to append; the script can also create a rofi searchable file.

Niri config separation
- Break up hypr.conf into conf.d/*.conf and have a small loader file that sources them in order.
- Prefix files with numbers for ordering and include comments with tags (e.g., # MPV media player window rules).

Audio routing (Voicemeeter-like)
- Use PipeWire + qpwgraph + wireplumber.
- Create virtual sinks for each source (game, browser, chat) and route each app to a sink using pavucontrol or set-default-sink per-app.
- Provide an audio-setup.sh that creates pipes and a small qpwgraph layout file for common streaming scenes.

J.A.R.V.I.S. integration
- Place sound files in configs/sounds/.
- welcome.py will optionally play jarvis-startup.mp3 on first-run or per-boot.
- Provide helper scripts for "gaming mode" (play jarvis-gaming.mp3, disable animations, switch performance profile).

Minimal curated package list (trimmed)
Note: your package list is long and includes many optional packages. Keep core essentials and add extras when needed.
Core packages to start:
- Niri, hyprpaper, hyprshot, hyprpicker, hyprlock, hyprpolkitagent
- noctalia-shell, quickshell
- pipewire, wireplumber, pavucontrol, qpwgraph
- gamemode, gamescope, lutris, steam
- python (for scripts), python-gi (for GTK welcome)
- neovim, git, git-lfs (if needed)
- obs-studio, obs-vaapi
- zsh, starship, fastfetch
- mpv, mpv-mpris
- fuzzel, rofi, wf-recorder, grim, slurp
- sddm (or your preferred display manager) + sddm-sugar-candy (theming)
- colord/gtk themes you like, kvantum
- balena-etcher, reflector, mkinitcpio, zram-generator
(Keep the full list in packages/package.list.txt but split into core vs optional.)

Streaming / Scenes
- Template OBS scenes in obs-cli snippets and folder configs.
- Provide scripts to route audio sinks before starting streaming.

File tagging & comments
- Use a header tag in each config file:
  - # === WEHTTAMSNAPS CONFIG ===
  - # logo: ../logo.txt (link)
  - # repo: https://github.com/Crowdrocker/Hypr-Snaps.git

What I'll provide in this deliverable
1) Cleaned-up professional Markdown "My-Niri-Setup-Idea.md" (this file).  
2) An install / repo structure and branch model (below).  
3) Modified welcome app (GTK Python) branded to WehttamSnaps and optionally plays J.A.R.V.I.S. startup sound.  
4) Updated KeyHints script tuned for Noctalia / Quickshell / Ghostty / Webapps.  
5) create_widget.sh scaffold script to create Quickshell widgets.
6) install.sh skeleton that creates branches and scaffolds repository layout (safe, non-destructive, interactive).

Next steps (suggested)
- Pick a base preconfig to fork (Omarchy recommended).
- Decide layout for Quickshell bar (top or bottom).
- Provide a small test branch with a single integrated feature (e.g., Niri + Noctalia + welcome app + one widget).
- I will provide code files (welcome.py, KeyHints.sh, create_widget.sh, install.sh, logo.txt) and the recommended repo layout in the next message so you can drop them into your repo.
