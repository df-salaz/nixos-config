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
      kitty = {
        enable = true;
        font = {
          name = "JetBrainsMono Nerd Font";
          package = (pkgs.nerdfonts.override { fonts = [ "JetBrainsMono" ]; });
          size = 12;
        };
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
