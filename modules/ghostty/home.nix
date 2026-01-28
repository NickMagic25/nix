# Ghostty terminal emulator - Home Manager configuration
{ config, pkgs, ... }:

{
  # Ghostty configuration file
  home.file.".config/ghostty/config".text = ''
    # Theme - using a built-in theme
    # Common options: tokyonight, catppuccin-mocha, nord, dracula, gruvbox-dark
    # Or leave commented out to use default
    # theme = tokyonight

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
