{ inputs, pkgs, config, ... }:
{
	home.packages = with pkgs; [
		pkgs.betterdiscordctl
		discord
	];
}
