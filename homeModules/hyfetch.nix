{ lib, pkgs, config, ... }:
{
  options.hyfetch = {
    enable =
      lib.mkEnableOption "Enable Hyfetch";
  };

  config = lib.mkIf config.hyfetch.enable {
    home.packages = with pkgs; [
      fastfetch
    ];
    programs.hyfetch = {
      enable = true;
      settings = {
        preset = "pansexual";
        mode = "rgb";
        light_dark = "dark";
        lightness = 0.75;
        color_align.mode = "horizontal";
        backend = "fastfetch";
      };
    };
  };
}
