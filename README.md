# Artemis

A modern NixOS configuration with Hyprland, featuring development tools and a cohesive Catppuccin Mocha theme.

## Overview

This repository contains the complete system configuration for Artemis, a NixOS system optimized for development work. The setup includes a Wayland-based desktop environment with Hyprland, comprehensive development tools, and a consistent dark theme across all applications.

## System Configuration

### Core Components

- **OS**: NixOS with Flakes
- **Window Manager**: Hyprland (Wayland)
- **Display Manager**: SDDM
- **Shell**: Fish with enhanced productivity features
- **Terminal**: Kitty with transparency and blur effects
- **Editor**: Neovim with LSP support
- **Theme**: Catppuccin Mocha throughout

### Hardware Support

- AMD GPU with AMDGPU drivers
- Bluetooth with auto-power on
- Audio via PipeWire with JACK and PulseAudio compatibility
- Network management through NetworkManager

## Development Environment

### Programming Languages

The configuration includes LSP support and tooling for:

- C/C++
- Java
- TypeScript/JavaScript
- HTML/CSS
- SQL
- Bash
- Nix
- Tailwind CSS

### Development Tools

- Git with sensible defaults
- Starship prompt with language indicators
- Zoxide for smart directory navigation
- Eza for enhanced file listings
- Comprehensive Fish shell aliases and functions

### Applications

- Firefox browser
- Steam with GameScope and GameMode
- Prism Launcher for Minecraft
- Rofi application launcher
- File manager (Nautilus)
- Audio control (PavuControl)
- Bluetooth management (Blueberry)

## File Structure

```
├── nixos/               # NixOS system configuration
│   ├── flake.nix       # Flake definition with inputs
│   ├── hosts/          # Host-specific configurations
│   └── modules/        # Modular configuration components
├── fish/               # Fish shell configuration
├── kitty/              # Terminal emulator settings
├── hypr/               # Hyprland window manager config
├── waybar/             # Status bar configuration
├── rofi/               # Application launcher theming
└── starship/           # Shell prompt configuration
```

## Installation

### Prerequisites

- NixOS system with Flakes enabled
- Git installed

### Setup

1. Clone this repository:
   ```bash
   git clone <repository-url>
   cd artemis
   ```

2. Build and switch to the configuration:
   ```bash
   sudo nixos-rebuild switch --flake ./nixos#Artemis
   ```

3. Install dotfiles using GNU Stow:
   ```bash
   stow fish kitty hypr waybar rofi starship
   ```

## Key Features

### Fish Shell Enhancements

- Comprehensive Git aliases and abbreviations
- Enhanced navigation with zoxide integration
- Productivity aliases for common tasks
- Custom functions for development workflows
- Syntax highlighting with green valid commands

### Hyprland Configuration

- Optimized for development workflows
- Consistent window management
- Integrated with Waybar status bar
- Support for multiple workspaces

### Theme Consistency

- Catppuccin Mocha theme across all applications
- Transparent terminal with blur effects
- Coordinated color scheme for better visual coherence
- Custom SDDM login theme

### Development Workflow

- Neovim with LSP, autocomplete, and file tree
- Git integration with helpful aliases
- Terminal-based workflow optimization
- Language-specific tooling and formatting

## Customization

The configuration is modular and can be easily customized:

- **Languages**: Add new language support in `nvf-configuration.nix`
- **Applications**: Modify package lists in `configuration.nix`
- **Themes**: Adjust colors in respective application configs
- **Keybindings**: Update Hyprland and application-specific bindings

For questions or modifications, refer to the individual configuration files in each application directory.
