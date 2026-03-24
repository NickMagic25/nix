# mise (rtx) - Home Manager configuration
{ config, pkgs, ... }:

{
  # mise configuration file
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

    [tasks.docker-build]
    description = "Build a Dockerfile for current platform"
    run = "docker buildx build --no-cache $@"
    
    [tasks.docker-buildx86]
    description = "Build a Dockerfile for linux/amd64"
    run = "docker buildx build --platform linux/amd64 --no-cache $@"
  '';
}
