# nix-darwin configuration for Work Mac
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
      autoUpdate = false;
      cleanup = "none";  # Don't uninstall packages not in this config
    };
  };

  # Add Homebrew to PATH (supports both Apple Silicon and Intel Macs)
  environment.systemPath = [ "/opt/homebrew/bin" "/usr/local/bin" ];

  # Shell aliases
  environment.shellAliases = {
    nix-reconcile = "sudo nix run nix-darwin -- switch --flake ~/git/nix#work-mac";
  };

  # Set primary user for system defaults
  system.primaryUser = "nicholas.majkic";

  # System packages
  environment.systemPackages = with pkgs; [
    vim
  ];

  # Set your username
  users.users.nicholas.majkic = {
    home = "/Users/nicholas.majkic";
    shell = "/bin/zsh";
  };

  # Used for backwards compatibility
  system.stateVersion = 5;
}
