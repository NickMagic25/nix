# Nix Configuration

macOS system configuration managed with nix-darwin and Home Manager, covering two machines.

| Host | Config |
|------|--------|
| `personal-macbook` | `hosts/personal-macbook/` |
| `work-mac` | `hosts/work-mac/` |

## Prerequisites

On a fresh machine, run `prereqs.sh` first. It installs Homebrew and Nix (via Determinate Systems) if either is missing.

```bash
./prereqs.sh
```

## Applying Configuration

```bash
# Personal MacBook
darwin-rebuild switch --flake ~/git/nix#personal-macbook

# Work Mac
darwin-rebuild switch --flake ~/git/nix#work-mac
```

The `nix-reconcile` shell alias (defined per host) does the same thing.

Personal MacBook also has a launchd daemon that auto-rebuilds on boot and every 48 hours.

## Making Changes

1. Edit the relevant files (see structure below)
2. Commit and push
3. Run `nix-reconcile` (or the full `darwin-rebuild switch` command above)

## Structure

```
hosts/
  personal-macbook/
    darwin-configuration.nix   # system config, homebrew packages, launchd daemon
    home.nix                   # user dotfiles via Home Manager
  work-mac/
    darwin-configuration.nix   # system config, homebrew packages
    home.nix                   # user dotfiles via Home Manager

modules/
  aerospace/       # AeroSpace window manager (nix-darwin services.aerospace)
  darwin/
    homebrew.nix   # shared Homebrew taps/casks
    system-defaults.nix  # macOS system defaults
  ghostty/         # Ghostty terminal (installed via Homebrew cask)
  linearmouse/     # LinearMouse config
  mise/            # mise version manager
  vscode/          # VS Code settings and extensions (personal only)
  zshrc/           # zsh config (personal only)
```

## Useful Commands

```bash
# Apply configuration
darwin-rebuild switch --flake ~/git/nix#personal-macbook

# Build without activating (dry run)
darwin-rebuild build --flake ~/git/nix#personal-macbook

# Update all flake inputs (nixpkgs, nix-darwin, home-manager)
nix flake update ~/git/nix

# Show available configurations
nix flake show ~/git/nix
```

## Adding a New Machine

1. Create a host directory:
   ```bash
   mkdir -p hosts/<machine-name>
   ```
2. Add `darwin-configuration.nix` and `home.nix`, using an existing host as a template.
3. Register the host in `flake.nix` under `darwinConfigurations`.
