{ inputs, pkgs, lib, userSettings, config, ... }:
{
	home.packages = with pkgs; lib.optionals (userSettings.discord.enable) [
		betterdiscordctl
		discord-screenaudio
	];
}
