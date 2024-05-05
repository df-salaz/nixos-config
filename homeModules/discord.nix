{ inputs, pkgs, lib, config, ... }:
{
  options = {
    discord.enable = lib.mkEnableOption "Enables Discord";
  };

  config = lib.mkIf config.discord.enable {
    home.packages = with pkgs; [
      betterdiscordctl
      vesktop
    ];
    wayland.windowManager.hyprland.settings.exec-once = [
      "${pkgs.vesktop}/bin/vesktop --start-minimized"
    ];
  };
}
