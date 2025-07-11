# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Repository Overview

This is a NixOS system configuration repository using flakes and home-manager. It follows a modular architecture where system and user configurations are separated and individual features are organized as modules.

## Architecture

### Core Files
- `flake.nix`: Entry point defining inputs (nixpkgs, home-manager, NUR, nix-vscode-extensions) and the NixOS system configuration
- `configuration.nix`: System-level configuration (bootloader, networking, users, services)
- `home.nix`: User-level configuration managed by home-manager, imports user modules
- `hardware-configuration.nix`: Auto-generated hardware-specific configuration

### Module System
Modules are organized under `module/` with each feature in its own directory:
- System modules (imported in `configuration.nix`): 1password, docker
- User modules (imported in `home.nix`): git, zsh, direnv, vscodium, librewolf

Each module follows the pattern `module/<name>/default.nix`.

## Key Commands

### System Management
```bash
# Rebuild and switch to new configuration
sudo nixos-rebuild switch --flake .#nixos

# Test configuration without switching
sudo nixos-rebuild test --flake .#nixos

# Update flake inputs
nix flake update

# Show flake info
nix flake show
```

### Development
```bash
# Format Nix files
alejandra .

# Check Nix syntax
nil diagnostics <file>

# Enter development shell with flakes
nix develop
```

## Configuration Notes

- System hostname: "nixos"
- Primary user: "f15u" with zsh as default shell
- Flakes and nix-command are enabled as experimental features
- Automatic garbage collection and store optimization are configured weekly
- KDE Plasma 6 is the desktop environment
- Italian keyboard layout and timezone (Europe/Rome)