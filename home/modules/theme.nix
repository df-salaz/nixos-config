{ pkgs, userSettings, lib, ... }:

let
	catppuccin = userSettings.colorScheme == "catppuccin";
in
{
	gtk.iconTheme = lib.mkIf catppuccin {
		name = "Papirus";
		package = pkgs.catppuccin-papirus-folders.override {
			flavor = userSettings.catppuccin.flavor;
			accent = userSettings.catppuccin.accent;
		};
	};
	home.file = {
		".config/BetterDiscord/data/stable/custom.css".text =
			lib.mkIf (userSettings.discord.enable && catppuccin)
				''@import url("https://catppuccin.github.io/discord/dist/catppuccin-${userSettings.catppuccin.flavor}-${userSettings.catppuccin.accent}.theme.css");'';
	};
	programs = {
		bat.catppuccin.enable = lib.mkIf catppuccin true;
		btop.catppuccin.enable = lib.mkIf catppuccin true;
		fzf.catppuccin.enable = lib.mkIf catppuccin true;
		zsh.initExtraFirst = ''source ~/.zsh/catppuccin_mocha-zsh-syntax-highlighting.zsh'';
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
	wayland.windowManager.hyprland.catppuccin.enable = lib.mkIf catppuccin true;
}
