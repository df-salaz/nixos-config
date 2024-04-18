{ config, inputs, lib, pkgs, ... }:

{
	home.pointerCursor = {
		gtk.enable = true;
		package = lib.mkDefault pkgs.gnome.adwaita-icon-theme;
		name = lib.mkDefault "Adwaita";
		size = lib.mkDefault 16;
	};

	gtk = {
		enable = true;
		iconTheme = lib.mkDefault {
			name = "Papirus";
			package = pkgs.papirus-icon-theme;
		};
	};

	qt = {
		enable = true;
		platformTheme = "gtk3";
	};
}
