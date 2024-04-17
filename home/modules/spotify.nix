{ pkgs, spicetify-nix, ...}:
let
spicePkgs = spicetify-nix.packages.${pkgs.system}.default;
in {
	programs.spicetify = {
		enable = true;
		spotifyPackage = pkgs.nur.repos.nltch.spotify-adblock;
		theme = spicePkgs.themes.catppuccin;
		colorScheme = "mocha";
	};
}
