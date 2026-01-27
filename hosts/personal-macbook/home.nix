# Home Manager configuration for Personal MacBook Pro
# To use this, import it in your main home-manager configuration
{ config, pkgs, ... }:

{
  # AeroSpace window manager configuration (shared across machines)
  xdg.configFile."aerospace/aerospace.toml".source = ../../shared/aerospace/aerospace.toml;
}
