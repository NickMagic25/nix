{ config, pkgs, lib, ... }:

{
  options.aerospace.extension = lib.mkOption {
    type = lib.types.enum [ "home" "work" "none" ];
    default = "none";
    description = "Which AeroSpace extension to use (home, work, or none)";
  };

  config = {
    # AeroSpace configuration
    # Config is composed of base aerospace.toml + optional extension
    home.file.".aerospace.toml".text =
      builtins.readFile ./aerospace.toml +
      (if config.aerospace.extension != "none" then
        "\n\n# Extension: ${config.aerospace.extension}\n" +
        builtins.readFile (./extensions + "/${config.aerospace.extension}.toml")
      else "");
  };
}
