{ pkgs, ...}:
{
	home.file = {
		".config/spicetify/Themes/catppuccin".source = 
			../config/spicetify/Themes/catppuccin;
	};
	# imperative instructions:
	# `spicetify config current_theme catppuccin`
	# `spicetify config color_scheme mocha`
	# `spicetify config inject_css 1 inject_theme_js 1 replace_colors 1 overwrite assets_1`
	# `spicetify apply`
	home.packages = with pkgs; [
		nur.repos.nltch.spotify-adblock
		spicetify-cli
	];
}
