# mise (rtx) - Home Manager configuration
{ config, lib, pkgs, ... }:

{
  options.mise.extraTasks = lib.mkOption {
    type = lib.types.lines;
    default = "";
    description = "Extra TOML task definitions appended to the mise config (host-specific tasks).";
  };

  config = {
    home.file.".config/mise/config.toml".text = ''
      # mise configuration
      # See: https://mise.jdx.dev/configuration.html

      [settings]
      experimental = false
      verbose = false

      # Auto-activate mise when entering directories with .mise.toml
      activate_aggressive = true

      # Global tasks
      [tasks.trivy-scan]
      description = "Scan container image for vulnerabilities using Trivy"
      run = "trivy image --vuln-severity-source nvd,auto $@"

    '' + config.mise.extraTasks;
  };
}
