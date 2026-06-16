{ config, pkgs, lib, ... }:

{
  services.aerospace = {
    enable = true;
    settings = {
      after-login-command = [];
      after-startup-command = [];
      enable-normalization-flatten-containers = true;
      enable-normalization-opposite-orientation-for-nested-containers = true;
      accordion-padding = 30;
      default-root-container-layout = "tiles";
      default-root-container-orientation = "auto";
      key-mapping.preset = "qwerty";
      on-focused-monitor-changed = ["move-mouse monitor-lazy-center"];
      workspace-to-monitor-force-assignment = {
        q = "dell";
        w = "dell";
        e = "dell";
        r = "dell";
        a = "built-in";
        s = "built-in";
        d = "built-in";
        f = "built-in";
      };

      gaps = {
        inner.horizontal = 0;
        inner.vertical = 0;
        outer.left = 0;
        outer.bottom = 0;
        outer.top = 0;
        outer.right = 0;
      };

      mode.main.binding = {
        alt-enter = "exec-and-forget open -n /Applications/Ghostty.app";
        alt-shift-c = ''exec-and-forget open -na "Google Chrome"'';
        alt-shift-backspace = ''exec-and-forget open -na "Codex"'';
        alt-slash = "layout tiles horizontal vertical";
        alt-comma = "layout accordion horizontal vertical";
        alt-j = "focus left";
        alt-k = "focus down";
        alt-i = "focus up";
        alt-l = "focus right";
        alt-shift-j = "move left";
        alt-shift-k = "move down";
        alt-shift-i = "move up";
        alt-shift-l = "move right";
        alt-shift-minus = "resize smart -50";
        alt-shift-equal = "resize smart +50";
        alt-1 = "workspace 1";
        alt-2 = "workspace 2";
        alt-3 = "workspace 3";
        alt-4 = "workspace 4";
        alt-5 = "workspace 5";
        alt-6 = "workspace 6";
        alt-7 = "workspace 7";
        alt-8 = "workspace 8";
        alt-9 = "workspace 9";
        alt-0 = "workspace 10";
        alt-q = "workspace q";
        alt-w = "workspace w";
        alt-e = "workspace e";
        alt-r = "workspace r";
        alt-a = "workspace a";
        alt-s = "workspace s";
        alt-d = "workspace d";
        alt-f = "workspace f";
        alt-shift-1 = "move-node-to-workspace 1";
        alt-shift-2 = "move-node-to-workspace 2";
        alt-shift-3 = "move-node-to-workspace 3";
        alt-shift-4 = "move-node-to-workspace 4";
        alt-shift-5 = "move-node-to-workspace 5";
        alt-shift-6 = "move-node-to-workspace 6";
        alt-shift-7 = "move-node-to-workspace 7";
        alt-shift-8 = "move-node-to-workspace 8";
        alt-shift-9 = "move-node-to-workspace 9";
        alt-shift-0 = "move-node-to-workspace 10";
        alt-shift-q = "move-node-to-workspace q";
        alt-shift-w = "move-node-to-workspace w";
        alt-shift-e = "move-node-to-workspace e";
        alt-shift-r = "move-node-to-workspace r";
        alt-shift-a = "move-node-to-workspace a";
        alt-shift-s = "move-node-to-workspace s";
        alt-shift-d = "move-node-to-workspace d";
        alt-shift-f = "move-node-to-workspace f";
        alt-backtick = "workspace --wrap-around next";
        alt-shift-backtick = "workspace --wrap-around prev";
        alt-tab = "workspace-back-and-forth";
        alt-shift-tab = "move-workspace-to-monitor --wrap-around next";
        alt-shift-n = ["move-node-to-monitor --wrap-around next" "focus-monitor --wrap-around next"];
        alt-shift-p = ["move-node-to-monitor --wrap-around prev" "focus-monitor --wrap-around prev"];
        alt-shift-semicolon = "mode service";
        ctrl-esc = ["close-all-windows-but-current" "close"];
      };

      mode.service.binding = {
        esc = ["reload-config" "mode main"];
        r = ["flatten-workspace-tree" "mode main"];
        f = ["layout floating tiling" "mode main"];
        backspace = ["close-all-windows-but-current" "mode main"];
        alt-shift-j = ["join-with left" "mode main"];
        alt-shift-k = ["join-with down" "mode main"];
        alt-shift-i = ["join-with up" "mode main"];
        alt-shift-l = ["join-with right" "mode main"];
      };

      on-window-detected = [
        { "if".app-id = "com.apple.finder"; run = "layout floating"; }
        { "if".app-id = "com.apple.iCal"; run = "layout floating"; }
        { "if".app-id = "com.apple.MobileSMS"; run = "layout floating"; }
        { "if".app-id = "com.apple.Home"; run = "layout floating"; }
        { "if".app-id = "com.apple.Photos"; run = "layout floating"; }
        { "if".app-id = "com.apple.reminders"; run = "layout floating"; }
        { "if".app-id = "com.apple.FaceTime"; run = "layout floating"; }
        { "if".app-id = "com.apple.findmy"; run = "layout floating"; }
        { "if".app-id = "com.moonlight-stream.Moonlight"; run = "layout floating"; }
        { "if".app-id = "com.apple.weather"; run = "layout floating"; }
      ];
    };
  };
}
