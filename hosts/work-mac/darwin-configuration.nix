# nix-darwin configuration for Work Mac
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
      autoUpdate = false;
      cleanup = "none";  # Don't uninstall packages not in this config
    };
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
