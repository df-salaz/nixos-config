{ lib, pkgs, config, ... }:
{
  options.terminalEmulator = {
    enable =
      lib.mkEnableOption "Configure a terminal emulator";
    defaultTerminalEmulator = lib.mkOption {
      default = "alacritty";
      type = lib.types.string;
    };
  };

  config = lib.mkIf config.terminalEmulator.enable {
    programs = {
      foot = {
        enable = true;
        server.enable = false;
        settings = {
          main = {
            font = "JetBrainsMono Nerd Font:size=12";
            initial-window-size-chars = "90x24";
          };
          mouse = {
            hide-when-typing = "yes";
          };
        };
      };
      alacritty = {
        enable = true;
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
