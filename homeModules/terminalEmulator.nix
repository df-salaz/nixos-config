{ lib, pkgs, config, ... }:
{
  options.terminalEmulator = {
    enable =
      lib.mkEnableOption "Configure a terminal emulator";
    defaultTerminalEmulator = lib.mkOption {
      default = "alacritty";
    };
  };

  config = lib.mkIf config.terminalEmulator.enable {
    programs = {
      foot = {
        enable = config.terminalEmulator.defaultTerminalEmulator == "foot";
        server.enable = false;
        settings = {
          main = {
            font = "JetBrainsMono Nerd Font:size=12";
            initial-window-size-chars = "90x24";
          };
          mouse = {
            hide-when-typing = "yes";
          };
          cursor = {
            color = "111111 cccccc";
          };
          colors = {
            foreground = "cdd6f4";
            background = "1e1e2e";
            regular0 = "45475a";
            regular1 = "f38ba8";
            regular2 = "a6e3a1";
            regular3 = "f9e2af";
            regular4 = "89b4fa";
            regular5 = "C4A0EE";
            regular6 = "94e2d5";
            regular7 = "bac2de";
            bright0 = "585b70";
            bright1 = "f38ba8";
            bright2 = "a6e3a1";
            bright3 = "f9e2af";
            bright4 = "89b4fa";
            bright5 = "C4A0EE";
            bright6 = "94e2d5";
            bright7 = "a6adc8";
            scrollback-indicator = "000000 98c379";
          };
        };
      };
      alacritty = {
        enable =
          config.terminalEmulator.defaultTerminalEmulator == "alacritty";
        settings = {
          window = {
            dimensions = {
              columns = 90;
              lines = 24;
            };
            decorations = "None";
          };
          font.size = 12;
          mouse.hide_when_typing = true;
        };
      };
    };
  };
}
