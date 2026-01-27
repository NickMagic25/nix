{ config, pkgs, ... }:

{
  # AeroSpace configuration
  # Config must be placed at ~/.aerospace.toml
  home.file.".aerospace.toml" = {
    source = ./aerospace.toml;
  };
}
