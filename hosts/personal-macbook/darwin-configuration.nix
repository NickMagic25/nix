# nix-darwin configuration for Personal MacBook Pro
{ config, pkgs, ... }:

{
  imports = [
    ../../modules/aerospace
    ../../modules/darwin/system-defaults.nix
  ];

  # Disable nix-darwin's Nix management (using Determinate Systems Nix installer)
  nix.enable = false;

  # Enable and configure homebrew
  homebrew = {
    enable = true;
    onActivation = {
      autoUpdate = true;
      cleanup = "uninstall";  # Remove packages not in this config
    };

    # Homebrew formulae (CLI tools)
    brews = [
      "age"
      "bfg"
      "flux"
      "gemini-cli"
      "gh"
      "gnupg"
      "go"
      "helm"
      "helmfile"
      "k3d"
      "k9s"
      "kustomize"
      "node"
      "npq"
      "openjdk"
      "ripgrep"
      "sops"
      "talosctl"
      "terraform"
      "terragrunt"
      "tree"
      "trivy"
      "flux-operator-mcp"
      "capacitor"
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

  # System packages
  environment.systemPackages = with pkgs; [
    vim
  ];

  # Set your username
  users.users.nicholas.majkic= {
    home = "/Users/nicholas.majkic";
    shell = "/bin/zsh";
  };

  # Used for backwards compatibility
  system.stateVersion = 5;
}
