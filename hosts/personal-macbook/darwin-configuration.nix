# nix-darwin configuration for Personal MacBook Pro
{ config, pkgs, ... }:

{
  imports = [
    ../../modules/aerospace
    ../../modules/ghostty
    ../../modules/darwin/system-defaults.nix
    ../../modules/darwin/homebrew.nix
  ];

  # Disable nix-darwin's Nix management (using Determinate Systems Nix installer)
  nix.enable = false;

  # Enable and configure homebrew
  homebrew = {
    enable = true;
    onActivation.cleanup = "uninstall";

    # Homebrew formulae (CLI tools)
    brews = [
      "age"
      "bfg"
      "flux"
      "gh"
      "gnupg"
      "go"
      "node"
      "npq"
      "openjdk"
      "ripgrep"
      "sops"
      "talosctl"
      "flux-operator-mcp"
      "capacitor"
      "act"
      "ansible"
    ];

    # Homebrew casks (GUI applications)
    casks = [
      "codex"
      "git-credential-manager"
    ];

    # Additional taps
    taps = [
      "derailed/k9s"
      "fluxcd/tap"
    ];
  };

  # Add Homebrew to PATH
  environment.systemPath = [ "/opt/homebrew/bin" ];

  # Shell aliases
  environment.shellAliases = {
    nix-reconcile = "sudo nix run nix-darwin -- switch --flake github:NickMagic25/nix#personal-macbook";
  };

  # Set primary user for system defaults
  system.primaryUser = "nmajkic";

  # Set your username
  users.users.nmajkic = {
    home = "/Users/nmajkic";
    shell = "/bin/zsh";
  };

  # Auto-rebuild nix-darwin on boot and every other day at 3am.
  # Runs as root (no sudo needed). Boot triggers always rebuild; scheduled
  # triggers skip if last rebuild was < 48 hours ago.
  launchd.daemons.nix-darwin-rebuild = {
    serviceConfig = {
      Label = "com.nmajkic.nix-darwin-rebuild";
      ProgramArguments = [
        "/bin/bash"
        "-c"
        ''
          STAMP=/var/lib/nix-darwin-rebuild-last-run
          LOG=/var/log/nix-darwin-rebuild.log
          NOW=$(date +%s)
          BOOT_EPOCH=$(sysctl -n kern.boottime | sed 's/.*sec = \([0-9]*\).*/\1/')
          UPTIME=$((NOW - BOOT_EPOCH))

          run_rebuild() {
            echo "[$(date)] Starting nix-darwin rebuild" >> "$LOG"
            echo "$NOW" > "$STAMP"
            PATH=/nix/var/nix/profiles/default/bin:/opt/homebrew/bin:/usr/bin:/bin \
              nix run nix-darwin -- switch --flake github:NickMagic25/nix#personal-macbook >> "$LOG" 2>&1
            echo "[$(date)] Rebuild finished (exit $?)" >> "$LOG"
          }

          # On fresh boot (within 5 minutes), always rebuild
          if [ "$UPTIME" -lt 300 ]; then
            run_rebuild
            exit 0
          fi

          # On scheduled runs, skip if rebuilt within the last 48 hours
          if [ -f "$STAMP" ]; then
            LAST=$(cat "$STAMP")
            ELAPSED=$((NOW - LAST))
            if [ "$ELAPSED" -lt 172800 ]; then
              echo "[$(date)] Skipping — last rebuild was $((ELAPSED / 3600))h ago" >> "$LOG"
              exit 0
            fi
          fi

          run_rebuild
        ''
      ];
      RunAtLoad = true;
      StartCalendarInterval = [{ Hour = 3; Minute = 0; }];
    };
  };

  # Used for backwards compatibility
  system.stateVersion = 5;
}
