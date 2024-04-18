{ config, inputs, lib, pkgs, ... }:

{
	home.pointerCursor = {
		gtk.enable = true;
		package = pkgs.gnome.adwaita-icon-theme;
		name = "Adwaita";
		size = 16;
	};

	gtk = {
		enable = true;
		catppuccin.enable = true;
		catppuccin.accent = "mauve";
		iconTheme = lib.mkDefault {
			name = "Papirus";
			package = pkgs.papirus-icon-theme;
		};
		gtk3.extraConfig.Settings = ''gtk-application-prefer-dark-theme = 1;'';
		gtk4.extraConfig.Settings = ''gtk-application-prefer-dark-theme = 1;'';
	};

	qt = {
		enable = true;
		platformTheme = "gtk3";
	};
}
