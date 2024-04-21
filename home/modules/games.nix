{ userSettings, pkgs, lib, ... }:

{
	home.packages = with pkgs; lib.optionals (userSettings.games.extra) [
		openrct2
		superTuxKart
		mindustry-wayland
	];
}
