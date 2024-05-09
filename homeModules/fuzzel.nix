{ config, lib, ... }:
{
  options = {
    runners.fuzzel.enable =
      lib.mkEnableOption "Enable Fuzzel";
  };

  config = lib.mkIf config.runners.fuzzel.enable {
    programs.fuzzel = {
      enable = true;
      settings = {
        border = {
          width = 2;
          radius = 10;
        };
        colors = {
          background = "1e1e2eff";
          text = "cdd6f4ff";
          match = "f38ba8ff";
          selection = "313244ff";
          selection-match = "f38ba8ff";
          selection-text = "cdd6f4ff";
          border = "b4befeff";
        };
        main = {
          horizontal-pad = 32;
          vertical-pad = 8;
          inner-pad = 8;
          width = 48;
          lines = 16;
          line-height = 24;
          icon-theme = "Papirus";
          terminal = config.terminalEmulator.defaultTerminalEmulator + " -e";
        };
      };
    };
  };
}
