{ config, lib, pkgs, ... }:
{
  options.ags = {
    enable =
      lib.mkEnableOption "Enable AGS";
  };

  config = lib.mkIf config.ags.enable {
    programs.ags = {
      enable = true;
      configDir = ./config/ags;
      extraPackages = with pkgs; [
      ];
    };
  };
}
