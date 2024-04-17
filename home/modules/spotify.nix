{ pkgs, spicetify-nix, ...}:
{
	home.packages = with pkgs; [
		nur.repos.nltch.spotify-adblock
	];
	programs.spicetify =
	let
		spicePkgs = spicetify-nix.packages.${pkgs.system}.default;
	in {
		spotifyPackage = pkgs.nur.repos.nltch.spotify-adblock;
		theme = spicePkgs.themes.catppuccin;
		colorScheme = "mocha";
	};
}
