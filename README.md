# Nix Configuration Files

This repository contains Nix configuration files for managing system dotfiles and configurations across different machines.

## Structure

```
nix/
├── hosts/
│   └── personal-macbook/      # Personal MacBook Pro configuration
│       └── home.nix           # Home Manager module
├── shared/                    # Shared configs across all machines
│   └── aerospace/
│       └── aerospace.toml     # AeroSpace window manager config
└── README.md
```

## Usage

### With Home Manager

Import the `home.nix` module for your specific machine in your Home Manager configuration:

```nix
imports = [
  /Users/nmajkic/git/nix/hosts/personal-macbook/home.nix
];
```

Then run:
```bash
home-manager switch
```

### Manual Sync

To manually sync the aerospace configuration:

```bash
cp shared/aerospace/aerospace.toml ~/.config/aerospace/aerospace.toml
```

## Adding New Machines

To add a new machine configuration:

1. Create a new directory under `hosts/`:
   ```bash
   mkdir -p hosts/<machine-name>
   ```

2. Copy or create a `home.nix` file for that machine:
   ```bash
   cp hosts/personal-macbook/home.nix hosts/<machine-name>/home.nix
   ```

3. Edit the new `home.nix` to customize machine-specific settings
   - Shared configs (like aerospace.toml) will automatically be available
   - Add any machine-specific configurations as needed

## Managed Files

### Shared Across All Machines
- `~/.config/aerospace/aerospace.toml` - AeroSpace window manager configuration

### Personal MacBook Pro
- Currently uses all shared configurations
