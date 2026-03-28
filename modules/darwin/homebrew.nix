{ config, pkgs, ... }:

{
  homebrew = {
    enable = true;

    onActivation.autoUpdate = true;
    onActivation.upgrade = true;

    brews = [
      "btop"
      "fastfetch"
      "helm"
      "helmfile"
      "k3d"
      "k9s"
      "kustomize"
      "uv"
      "apko"
      "melange"
      "terraform"
      "terragrunt"
      "tree"
      "trivy"
      "mise"
      "opentofu"
      "cosign"
      "crane"
    ];

    casks = [
      "linearmouse"
    ];
  };

}
