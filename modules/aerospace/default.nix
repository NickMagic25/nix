{ config, pkgs, ... }:

{
  # Install aerospace package
  environment.systemPackages = with pkgs; [
    aerospace
  ];
}
