#!/usr/bin/env bash
set -euo pipefail

# Install Homebrew if not present
if ! command -v brew &>/dev/null; then
  echo "Installing Homebrew..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

  # Add Homebrew to PATH for the rest of this script
  if [[ -f /opt/homebrew/bin/brew ]]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
  else
    eval "$(/usr/local/bin/brew shellenv)"
  fi
else
  echo "Homebrew already installed, skipping."
fi

# Install Nix (Determinate Systems) if not present
if ! command -v nix &>/dev/null; then
  echo "Installing Nix (Determinate Systems)..."
  curl --proto '=https' --tlsv1.2 -sSf -L https://install.determinate.systems/nix | sh -s -- install
  # Source nix into current shell
  . /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh
else
  echo "Nix already installed, skipping."
fi

echo ""
echo "Prerequisites installed. To apply your configuration, run one of:"
echo ""
echo "  darwin-rebuild switch --flake ~/git/nix#personal-macbook"
echo "  darwin-rebuild switch --flake ~/git/nix#work-mac"
