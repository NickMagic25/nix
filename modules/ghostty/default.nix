# Ghostty terminal emulator - Darwin system configuration
{ config, pkgs, ... }:

{
  # Install Ghostty via Homebrew for proper macOS integration
  homebrew.casks = [ "ghostty" ];
}
