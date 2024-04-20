{ inputs, pkgs, lib, userSettings, config, ... }:
{
	home.packages = with pkgs; lib.optionals (userSettings.discord.enable) [
		betterdiscordctl
		vesktop
	];
	wayland.windowManager.hyprland.settings.exec-once = [
		"${pkgs.vesktop}/bin/vesktop --start-minimized"
	];
}
