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
      "terragrunt"
      "tree"
      "trivy"
      "mise"
      "opentofu"
      "cosign"
      "crane"
      "sops"
    ];

    casks = [
      "linearmouse"
    ];

    taps = [
      "derailed/k9s"
    ];
  };

}
