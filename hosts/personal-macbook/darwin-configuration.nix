# nix-darwin configuration for Personal MacBook Pro
{ config, pkgs, ... }:

{
  imports = [
    ../../modules/aerospace
    ../../modules/ghostty
    ../../modules/darwin/system-defaults.nix
    ../../modules/darwin/homebrew.nix
  ];

  # Disable nix-darwin's Nix management (using Determinate Systems Nix installer)
  nix.enable = false;

  # Enable and configure homebrew
  homebrew = {
    enable = true;
    onActivation.cleanup = "uninstall";

    # Homebrew formulae (CLI tools)
    brews = [
      "age"
      "bfg"
      "flux"
      "gemini-cli"
      "gh"
      "gnupg"
      "go"
      "node"
      "npq"
      "openjdk"
      "ripgrep"
      "sops"
      "talosctl"
      "flux-operator-mcp"
      "capacitor"
      "act"
    ];

    # Homebrew casks (GUI applications)
    casks = [
      "codex"
      "git-credential-manager"
    ];

    # Additional taps
    taps = [
      "derailed/k9s"
      "fluxcd/tap"
    ];
  };

  # Add Homebrew to PATH
  environment.systemPath = [ "/opt/homebrew/bin" ];

  # Shell aliases
  environment.shellAliases = {
    nix-reconcile = "sudo nix run nix-darwin -- switch --flake ~/git/nix#personal-macbook";
  };

  # Set primary user for system defaults
  system.primaryUser = "nmajkic";

  # Set your username
  users.users.nmajkic = {
    home = "/Users/nmajkic";
    shell = "/bin/zsh";
  };

  # Used for backwards compatibility
  system.stateVersion = 5;
}
