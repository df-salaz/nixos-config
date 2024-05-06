{ lib, ... }:
{
	programs.wofi = {
		enable = true;
		settings = {
			gtk_dark = true;
			key_expand = "Tab";
			hide_scroll = true;
			width = 800;
			height = 800;
		};
	};
	home.file = {
        ".config/wofi.css".source = ./config/wofi/style.css;
	};
}
