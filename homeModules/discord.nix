{ inputs, pkgs, lib, userSettings, config, ... }:
{
  options = {
    enable = lib.mkEnableOption "Enables Discord";
  };

  config = lib.mkIf config.discord.enable {
    home.packages = with pkgs; lib.optionals (userSettings.discord.enable) [
      betterdiscordctl
      vesktop
    ];
    wayland.windowManager.hyprland.settings.exec-once = [
      "${pkgs.vesktop}/bin/vesktop --start-minimized"
    ];
  };
}
