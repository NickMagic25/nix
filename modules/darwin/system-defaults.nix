{ config, pkgs, ... }:

{
  # macOS system defaults
  system.defaults = {
    dock = {
      autohide = true;
      orientation = "bottom";
      show-recents = false;
    };

    finder = {
      AppleShowAllExtensions = false;
      FXEnableExtensionChangeWarning = false;
    };

    NSGlobalDomain = {
      AppleShowAllExtensions = true;
      InitialKeyRepeat = 15;
      KeyRepeat = 2;
      "com.apple.keyboard.fnState" = true;
    };
  };

  # Keyboard and trackpad
  system.keyboard = {
    enableKeyMapping = true;
    remapCapsLockToControl = true;
  };
}
