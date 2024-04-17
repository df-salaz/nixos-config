{ pkgs, ...}:
{
	nixpkgs.config.packageOverrides = pkgs: {
		nur = import (builtins.fetchTarball "https://github.com/nix-community/NUR/archive/master.tar.gz") {
			inherit pkgs;
		};
	};
	home.packages = with pkgs; [
		nur.repos.nltch.spotify-adblock
	];
}
