{ inputs, pkgs, lib, config, ... }:
{
  options = {
    discord.enable = lib.mkEnableOption "Enables Discord";
  };

  config = lib.mkIf config.discord.enable {
    home.packages = with pkgs; [
      vesktop
    ];
    wayland.windowManager = let
      cmd = "${lib.getExe pkgs.vesktop} --start-minimized";
    in {
      sway.config.startup = [
        { command = cmd; }
      ];
      hyprland.settings.exec-once = [
        cmd
      ];
    };
  };
}
