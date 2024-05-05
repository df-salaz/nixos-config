{ config, pkgs, lib, ... }:

{
  options.games = {
    enable =
      lib.mkEnableOption "Enable extra games";
  };

  config = lib.mkIf config.games.enable {
    home.packages = with pkgs; [
      openrct2
      superTuxKart
      mindustry-wayland
    ];
  };
}
