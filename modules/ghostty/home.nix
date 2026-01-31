# Ghostty terminal emulator - Home Manager configuration
{ config, pkgs, ... }:

{
  # Ghostty configuration file
  home.file.".config/ghostty/config".text = ''
    # Theme
    theme = "tokyonight night"

    # Font settings
    font-family = "JetBrains Mono"
    font-size = 13

    # Window settings
    window-padding-x = 10
    window-padding-y = 10
    background-opacity=0.95

    # macOS specific settings
    macos-titlebar-style = tabs
    macos-option-as-alt = true
    macos-dock-drop-behavior = window

    # Shell integration
    shell-integration = zsh

    quit-after-last-window-closed = true
    window-colorspace = display-p3
  '';
}
