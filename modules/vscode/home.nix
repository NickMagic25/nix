{ config, pkgs, ... }:

{
  programs.vscode = {
    enable = true;

    userSettings = {
      "github.copilot.enable" = { "*" = false; };
      "github.copilot.editor.enableAutoCompletions" = false;
      "github.copilot.chat.enabled" = false;
    };

    keybindings = [
      {
        key = "shift+enter";
        command = "workbench.action.terminal.sendSequence";
        args = { text = "\u001b\r"; };
        when = "terminalFocus";
      }
      {
        key = "cmd+g p";
        command = "git.pull";
      }
      {
        key = "cmd+g o";
        command = "git.push";
      }
    ];
  };
}
