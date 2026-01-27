# Nix Configuration Files

This repository contains Nix configuration files for managing macOS system configuration, dotfiles, and configurations across different machines using nix-darwin and Home Manager.

## Structure

```
nix/
├── flake.nix                       # Main Nix flake configuration
├── install.sh                      # Installation script
├── hosts/
│   └── personal-macbook/           # Personal MacBook Pro configuration
│       ├── darwin-configuration.nix # macOS system configuration
│       └── home.nix                 # Home Manager user configuration
├── shared/                         # Shared configs across all machines
│   └── aerospace/
│       └── aerospace.toml          # AeroSpace window manager config
└── README.md
```

## Installation

### First Time Setup

1. Clone this repo (if you haven't already):
   ```bash
   cd ~/git
   git clone <your-repo-url> nix
   cd nix
   ```

2. Run the installation script:
   ```bash
   ./install.sh
   ```

   This will:
   - Install Nix (using the Determinate Systems installer with flakes enabled)
   - Install and activate nix-darwin
   - Set up Home Manager integration
   - Apply your system configuration

3. Restart your terminal after the first run

### After Installation

Once installed, apply configuration changes with:

```bash
darwin-rebuild switch --flake ~/git/nix#personal-macbook
```

## Usage

### Making Configuration Changes

1. Edit your configuration files:
   - System settings: `hosts/personal-macbook/darwin-configuration.nix`
   - User dotfiles: `hosts/personal-macbook/home.nix`
   - Shared configs: `shared/`

2. Commit your changes to git:
   ```bash
   git add .
   git commit -m "Update configuration"
   git push
   ```

3. Apply the changes:
   ```bash
   darwin-rebuild switch --flake ~/git/nix#personal-macbook
   ```

### Auto-Reconcile with Git Repo

To automatically pull and apply updates from your git repo:

```bash
cd ~/git/nix && git pull && darwin-rebuild switch --flake .#personal-macbook
```

You can create an alias in your shell config:
```bash
alias nixup='cd ~/git/nix && git pull && darwin-rebuild switch --flake .#personal-macbook'
```

### Useful Commands

- `darwin-rebuild switch --flake ~/git/nix#personal-macbook` - Apply configuration changes
- `darwin-rebuild build --flake ~/git/nix#personal-macbook` - Build without activating
- `nix flake update ~/git/nix` - Update all dependencies (nixpkgs, nix-darwin, home-manager)
- `nix flake show ~/git/nix` - Show available configurations

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
