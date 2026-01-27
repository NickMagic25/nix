# nix-darwin configuration for Personal MacBook Pro
{ config, pkgs, ... }:

{
  imports = [
    ../../modules/aerospace
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
    ];

    # Homebrew casks (GUI applications)
    casks = [
      "codex"
      "git-credential-manager"
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

  # macOS system defaults
  system.defaults = {
    dock = {
      autohide = false;
      orientation = "bottom";
      show-recents = false;
    };

    finder = {
      AppleShowAllExtensions = true;
      FXEnableExtensionChangeWarning = false;
    };

    NSGlobalDomain = {
      AppleShowAllExtensions = true;
      InitialKeyRepeat = 15;
      KeyRepeat = 2;
    };
  };

  # Keyboard and trackpad
  system.keyboard = {
    enableKeyMapping = true;
    remapCapsLockToControl = true;
  };

  # Set your username
  users.users.nmajkic = {
    home = "/Users/nmajkic";
    shell = pkgs.zsh;
  };

  # Used for backwards compatibility
  system.stateVersion = 5;
}
