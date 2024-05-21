{ config, lib, ... }:
{
  options.zellij = {
    enable = lib.mkEnableOption "Enable Zellij";
  };

  config = lib.mkIf config.zellij.enable {
    programs.zellij = {
      enable = true;
      enableZshIntegration = true;
      settings = {
      };
    };
  };
}
