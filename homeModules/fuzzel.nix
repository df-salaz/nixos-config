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
        main = {
          terminal = config.terminalEmulator.defaultTerminalEmulator;
        };
        colors = {
          background = "1e1e2edd";
          text = "cdd6f4ff";
          match = "f38ba8ff";
          selection = "585b70ff";
          selection-match = "f38ba8ff";
          selection-text = "cdd6f4ff";
          border = "b4befeff";
        };
      };
    };
  };
}
