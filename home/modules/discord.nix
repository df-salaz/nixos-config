{ inputs, pkgs, config, ... }:
{
	home.packages = with pkgs; [
		pkgs.betterdiscordctl
		discord
	];
	home.file = {
		".config/BetterDiscord/data/stable/custom.css".text =
			''@import url("https://catppuccin.github.io/discord/dist/catppuccin-mocha-mauve.theme.css");'';
	};
}
