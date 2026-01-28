# Home Manager configuration for Personal MacBook Pro
# To use this, import it in your main home-manager configuration
{ config, pkgs, ... }:

{
  imports = [
    ../../modules/aerospace/home.nix
    ../../modules/neovim/home.nix
    ../../modules/ghostty/home.nix
  ];

  # AeroSpace configuration - use home extension
  aerospace.extension = "home";

  # Home Manager needs a bit of information about you and the paths it should manage
  home.username = "nmajkic";
  home.homeDirectory = "/Users/nmajkic";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "24.05"; # Please read the comment before changing.

  # Zsh configuration (shared across machines)
  home.file.".zshrc" = {
    source = ../../modules/zshrc/.zshrc;
    force = true;  # Replace existing file
  };
}
