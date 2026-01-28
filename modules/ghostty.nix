# Ghostty terminal emulator
{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    ghostty
  ];

  # Ghostty configuration file
  home.file.".config/ghostty/config".text = ''
    # Theme
    theme = dark

    # Font settings
    font-family = "JetBrains Mono"
    font-size = 13

    # Window settings
    window-padding-x = 10
    window-padding-y = 10

    # macOS specific settings
    macos-titlebar-style = tabs
    macos-option-as-alt = true
  '';
}
