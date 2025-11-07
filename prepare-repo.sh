#!/bin/bash
# === WEHTTAMSNAPS REPOSITORY PREPARATION ===
# GitHub: https://github.com/Crowdrocker
# Prepares the repository for GitHub upload

echo "Preparing WehttamSnaps repository for GitHub..."

# Create .gitignore
cat > .gitignore << 'EOF'
# WehttamSnaps .gitignore

# System files
.DS_Store
Thumbs.db

# Editor files
.vscode/
.idea/
*.swp
*.swo
*~

# Logs
*.log
logs/

# Cache and temporary files
.cache/
tmp/
temp/

# User-specific files
*.local
user-configs/
backups/

# Large binaries
*.iso
*.img
*.dmg

# Build artifacts
build/
dist/
target/

# Node modules (if any)
node_modules/

# Python cache
__pycache__/
*.pyc
*.pyo
*.pyd

# Package files
*.pkg
*.deb
*.rpm

# Backup files
*.bak
*.backup

# Personal configurations
.personal/
.private/

# Generated files
VERSION.bak

# Test files
test/
tests/
EOF

# Create LICENSE file
cat > LICENSE << 'EOF'
MIT License

Copyright (c) 2024 Crowdrocker

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
EOF

# Create CHANGELOG.md
cat > CHANGELOG.md << 'EOF'
# Changelog

All notable changes to WehttamSnaps will be documented in this file.

## [1.0.0] - 2024-01-XX

### Added
- Professional Arch Linux Hyprland configuration
- Noctalia shell integration with backup Waybar
- Ghostty terminal with Fira Code font
- Gaming optimizations for AMD RX 580 / NVIDIA GTX 1650
- Photography workflow with Darktable, GIMP, Krita
- Audio routing via PipeWire and qpwgraph
- WebApp creation system with default webapps
- Plymouth theme with animated WehttamSnaps logo
- Comprehensive installation scripts
- Professional documentation and guides

### Features
- Modular Hyprland configuration (conf.d structure)
- Custom keybinds with help system
- GameMode toggle and performance optimizations
- Division 2 and Cyberpunk 2077 crash fixes
- Steam integration with Proton GE
- Custom welcome application
- Professional theming throughout
- Automated setup and maintenance scripts

### Optimized Packages
- Core: 80 essential packages (from 400+ original)
- Optional: 50 additional packages for enhanced functionality
- Gaming: Steam, Lutris, Gamescope, Proton GE
- Photography: Darktable, GIMP, Krita, RawTherapee
- Development: VS Code, Git, Node.js, Python

### Keybinds
- SUPER+H: Show keybinds help
- SUPER+D: App launcher (rofi)
- SUPER+SPACE: Noctalia launcher
- SUPER+ENTER: Ghostty terminal
- SUPER+SHIFT+G: Toggle GameMode
- SUPER+P: Audio routing (qpwgraph)
- SUPER+W: Wallpaper selector

### Documentation
- Comprehensive README.md
- Detailed installation guide
- Quick start guide
- Inline code documentation
- Troubleshooting section

### Security
- No hardcoded passwords
- Secure default configurations
- Proper file permissions
- Minimal attack surface

### Performance
- Optimized for 1920x1080 @ 60Hz
- Low resource usage
- Fast startup times
- Responsive animations

### Compatibility
- Arch Linux (rolling)
- Wayland compositors
- AMD and NVIDIA GPUs
- Modern hardware support

### Repository Structure
- Modular configuration files
- Separated themes and assets
- Automated installation
- Professional documentation
- Version control ready

## [Unreleased]

### Planned
- Additional Plymouth themes
- More webapp templates
- Enhanced gaming profiles
- Automated backup system
- Performance monitoring
- Custom cursors and icons
</EOF

# Create CONTRIBUTING.md
cat > CONTRIBUTING.md << 'EOF'
# Contributing to WehttamSnaps

Thank you for your interest in contributing to WehttamSnaps! This document provides guidelines and information for contributors.

## 🤝 How to Contribute

### Reporting Issues

1. **Check existing issues** first to avoid duplicates
2. **Use the issue templates** when creating new issues
3. **Provide detailed information**:
   - System information (OS, hardware, etc.)
   - Steps to reproduce
   - Expected vs actual behavior
   - Screenshots if applicable
   - Relevant logs

### Feature Requests

1. **Check existing issues** for similar requests
2. **Provide clear description** of the feature
3. **Explain the use case** and why it's valuable
4. **Consider implementation** if you have ideas

### Pull Requests

1. **Fork the repository**
2. **Create a feature branch**: `git checkout -b feature/amazing-feature`
3. **Make your changes** following the guidelines below
4. **Test thoroughly** on your system
5. **Commit with clear messages**
6. **Push to your fork**: `git push origin feature/amazing-feature`
7. **Create a pull request**

## 📝 Development Guidelines

### Code Style

#### Shell Scripts
- Use 4 spaces for indentation
- Use `#!/bin/bash` shebang
- Add comments for complex logic
- Use meaningful variable names
- Handle errors appropriately

#### Configuration Files
- Keep consistent formatting
- Add comments for complex sections
- Use logical grouping
- Maintain backwards compatibility when possible

#### Documentation
- Use clear, concise language
- Include examples
- Update documentation with code changes
- Use proper markdown formatting

### Testing

- Test on fresh Arch Linux installation
- Verify all scripts work correctly
- Check for syntax errors
- Test keybinds and functionality
- Ensure no broken references

### File Structure

Follow the existing structure:
```
WehttamSnaps/
├── configs/          # Configuration files
├── packages/         # Package lists
├── themes/           # Theme files
├── docs/             # Documentation
├── assets/           # Media assets
└── scripts/          # Utility scripts
```

## 🐛 Bug Reports

When reporting bugs, please include:

### System Information
```bash
# System info
neofetch

# Package versions
pacman -Qi hyprland
pacman -Qi noctalia-shell

# Hardware info
lspci -k | grep -A 2 -i vga
```

### Logs
```bash
# Hyprland logs
cat ~/.local/share/hyprland/hyprland.log

# PipeWire logs
journalctl --user -u pipewire

# Application logs
journalctl -xe
```

### Steps to Reproduce
1. Clear, numbered steps
2. Expected behavior
3. Actual behavior
4. Screenshots if relevant

## 💡 Feature Ideas

We welcome feature suggestions, especially for:

- **Performance optimizations**
- **New webapp templates**
- **Additional themes**
- **Better documentation**
- **Quality of life improvements**
- **Hardware compatibility**
- **Gaming enhancements**

## 📋 Pull Request Process

### Before Submitting

1. **Read this document** carefully
2. **Check existing issues** and PRs
3. **Test your changes** thoroughly
4. **Update documentation** if needed
5. **Follow code style** guidelines

### PR Template

Use this structure for your PR:

```markdown
## Description
Brief description of changes

## Type of Change
- [ ] Bug fix
- [ ] New feature
- [ ] Breaking change
- [ ] Documentation update

## Testing
How I tested my changes

## Screenshots
If applicable, add screenshots

## Additional Notes
Any additional information
```

### Review Process

1. **Automated checks** pass
2. **Code review** by maintainers
3. **Testing** on maintainer systems
4. **Documentation** review
5. **Approval** and merge

## 🏆 Recognition

Contributors are recognized in:
- README.md contributors section
- CHANGELOG.md for significant changes
- Special mention in releases
- Invitation to contributor Discord

## 📞 Getting Help

If you need help contributing:

1. **Check existing issues** for similar problems
2. **Ask questions** in existing relevant issues
3. **Join our Discord** for real-time help
4. **Email us** at crowdrocker@proton.me

## 🔒 Security

If you discover security vulnerabilities:

1. **Do NOT open public issues**
2. **Email us privately** at crowdrocker@proton.me
3. **Provide detailed information** about the vulnerability
4. **Wait for our response** before disclosing

## 📄 License

By contributing, you agree that your contributions will be licensed under the MIT License, same as the project.

## 🙏 Thank You

Thank you for contributing to WehttamSnaps! Every contribution helps make this project better for everyone.

---

**Happy coding! 🚀**

Made with ❤️ by the WehttamSnaps team
EOF

# Make all scripts executable
find . -name "*.sh" -exec chmod +x {} \;

# Create GitHub releases folder structure
mkdir -p releases

# Create release info
cat > releases/README.md << 'EOF'
# WehttamSnaps Releases

This directory contains release information and assets for WehttamSnaps.

## Latest Release

### Version 1.0.0
- **Date**: 2024-01-XX
- **Status**: Stable
- **Installation**: `./install.sh`

## Release Notes

See [CHANGELOG.md](../CHANGELOG.md) for detailed release notes.

## Installation

For each release, the installation process is the same:

1. Download the release
2. Extract the archive
3. Run `./install.sh`
4. Reboot and enjoy!

## Upgrade Instructions

To upgrade from a previous version:

1. Backup your custom configurations
2. Download the new release
3. Run `./install.sh`
4. Restore custom configurations
5. Reboot

## Archive

Older releases are archived here for reference.
EOF

echo "Repository preparation completed!"
echo ""
echo "Files created/updated:"
echo "- .gitignore"
echo "- LICENSE"
echo "- CHANGELOG.md"
echo "- CONTRIBUTING.md"
echo "- releases/README.md"
echo "- Made scripts executable"
echo ""
echo "Repository is ready for GitHub!"
echo ""
echo "Next steps:"
echo "1. Initialize git repository: git init"
echo "2. Add all files: git add ."
echo "3. Commit: git commit -m 'Initial WehttamSnaps release'"
echo "4. Add remote: git remote add origin https://github.com/Crowdrocker/WehttamSnaps.git"
echo "5. Push: git push -u origin main"
echo ""
echo "🚀 WehttamSnaps is ready for the world!"