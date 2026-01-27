#!/bin/bash
set -e

echo "Installing Nix and nix-darwin..."
echo ""

# Check if Nix is already installed
if command -v nix &> /dev/null; then
    echo "✓ Nix is already installed"
else
    echo "Installing Nix..."
    curl --proto '=https' --tlsv1.2 -sSf -L https://install.determinate.systems/nix | sh -s -- install

    echo ""
    echo "Nix installed! Please restart your terminal and run this script again."
    exit 0
fi

# Check if nix-darwin is already installed
if [ -f "/etc/nix/nix.conf" ] && grep -q "nix-darwin" /etc/nix/nix.conf 2>/dev/null; then
    echo "✓ nix-darwin appears to be installed"
    echo ""
    echo "To rebuild your system configuration, run:"
    echo "  darwin-rebuild switch --flake ~/git/nix#personal-macbook"
else
    echo "Installing nix-darwin..."
    echo ""

    # Determine architecture
    ARCH=$(uname -m)
    if [ "$ARCH" = "arm64" ]; then
        SYSTEM="aarch64-darwin"
    else
        SYSTEM="x86_64-darwin"
    fi

    echo "Detected system: $SYSTEM"

    # Build and activate nix-darwin
    nix run nix-darwin -- switch --flake ~/git/nix#personal-macbook

    echo ""
    echo "✓ nix-darwin installed successfully!"
fi

echo ""
echo "Setup complete! Your system is now managed by nix-darwin."
echo ""
echo "Useful commands:"
echo "  darwin-rebuild switch --flake ~/git/nix#personal-macbook  # Apply configuration changes"
echo "  darwin-rebuild build --flake ~/git/nix#personal-macbook   # Build without activating"
echo "  nix flake update ~/git/nix                                # Update dependencies"
echo ""
echo "Configuration files:"
echo "  ~/git/nix/flake.nix                                       # Main flake configuration"
echo "  ~/git/nix/hosts/personal-macbook/darwin-configuration.nix # System configuration"
echo "  ~/git/nix/hosts/personal-macbook/home.nix                 # Home Manager configuration"
