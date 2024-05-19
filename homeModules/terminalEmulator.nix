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
        enable = true;
        server.enable = false;
        settings = {
          main = {
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
          mouse.hide_when_typing = true;
        };
      };
      kitty = {
        enable = true;
        shellIntegration.enableZshIntegration = true;
        settings = {
          repaint_delay = 4;
          input_delay = 3;
          sync_to_monitor = "no";
          enable_audio_bell = "no";
          window_alert_on_bell = "yes";
          placement_strategy = "top-left";
        };
      };
    };
  };
}
