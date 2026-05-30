# Home Manager configuration for Work Mac
# To use this, import it in your main home-manager configuration
{ config, pkgs, ... }:

{
  imports = [
    ../../modules/ghostty/home.nix
    ../../modules/mise/home.nix
    ../../modules/linearmouse/home.nix
  ];

  # Home Manager needs a bit of information about you and the paths it should manage
  home.username = "nicholas.majkic";
  home.homeDirectory = "/Users/nicholas.majkic";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "24.05"; # Please read the comment before changing.

  mise.extraTasks = ''

    [tasks.docker-build]
    description = "Build a Dockerfile for current platform"
    run = "docker buildx build --no-cache $@"

    [tasks.docker-buildx86]
    description = "Build a Dockerfile for linux/amd64"
    run = "docker buildx build --platform linux/amd64 --no-cache $@"
  '';

}
