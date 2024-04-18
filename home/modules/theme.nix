{ pkgs, userSettings, lib, ... }:

let
	catppuccin = userSettings.colorScheme == "catppuccin";
in
{
	gtk.iconTheme = lib.mkIf catppuccin {
		name = "Papirus";
		package = pkgs.catppuccin-papirus-folders.override {
			flavor = "mocha";
			accent = "mauve";
		};
	};
	home.file = lib.mkIf (userSettings.discord.enable && catppuccin) {
		".config/BetterDiscord/data/stable/custom.css".text =
			''@import url("https://catppuccin.github.io/discord/dist/catppuccin-mocha-mauve.theme.css");'';
	};
	programs = {
		cava.settings.color = lib.mkIf catppuccin {
			gradient = 1;
			gradient_count = 8;
			gradient_color_1 = "'#94e2d5'";
			gradient_color_2 = "'#89dceb'";
			gradient_color_3 = "'#74c7ec'";
			gradient_color_4 = "'#89b4fa'";
			gradient_color_5 = "'#cba6f7'";
			gradient_color_6 = "'#f5c2e7'";
			gradient_color_7 = "'#eba0ac'";
			gradient_color_8 = "'#f38ba8'";
		};
	};
}
