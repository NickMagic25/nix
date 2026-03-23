{ config, pkgs, ... }:

{
  homebrew = {
    enable = true;

    onActivation.autoUpdate = true;

    brews = [
      "btop"
      "fastfetch"
      "helm"
      "helmfile"
      "k3d"
      "k9s"
    ];

    casks = [
      "linearmouse"
    ];
  };

}
