{ pkgs, userSettings, lib, ... }:

let
	catppuccin = userSettings.colorScheme == "catppuccin";
in
{
	catppuccin.flavour = userSettings.catppuccin.flavor;
	catppuccin.accent = userSettings.catppuccin.accent;
	gtk = {
		catppuccin.enable = lib.mkIf catppuccin true;
		iconTheme = lib.mkIf catppuccin {
			name = "Papirus";
			package = pkgs.catppuccin-papirus-folders.override {
				flavor = userSettings.catppuccin.flavor;
				accent = userSettings.catppuccin.accent;
			};
		};
		gtk3.extraConfig.Settings = lib.mkIf userSettings.darkTheme ''gtk-application-prefer-dark-theme = 1;'';
		gtk4.extraConfig.Settings = lib.mkIf userSettings.darkTheme ''gtk-application-prefer-dark-theme = 1;'';
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
		zathura.catppuccin.enable = true;
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
	wayland.windowManager.hyprland = {
		catppuccin.enable = lib.mkIf catppuccin true;
		settings = {
			general = {
				"col.inactive_border" = "$base";
				"col.active_border" = "\$${userSettings.catppuccin.accent}";
				border_size = 2;
			};
			decoration.rounding = 5;
		};
	};
	services = {
		dunst.settings = {
			global = {
				background = "#1e1e2e";
				foreground = "#cdd6f4";
				separator_color = "frame";
			};
			urgency_low = {
				frame_color = "#a6e3a1";
			};
			urgency_normal = {
				frame_color = "#cba6f7";
			};
			urgency_critical = {
				frame_color = "#f38ba8";
			};
		};
	};
}
