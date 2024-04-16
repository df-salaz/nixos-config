{
	description = "Nixos config flake";

	inputs = {
		nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
		ags.url = "github:Aylur/ags";
		matugen.url = "github:InioX/Matugen";
		catppuccin.url = "github:catppuccin/nix";
		home-manager = {
			url = "github:nix-community/home-manager";
			inputs.nixpkgs.follows = "nixpkgs";
		};
	};

	outputs = { self, nixpkgs, catppuccin, ags, home-manager, ... }@inputs:
	let
		system = "x86_64-linux";
		pkgs = import nixpkgs {inherit system;};
	in {
		nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
			inherit system;
			specialArgs = {inherit inputs;};
			modules = [
				./system/system.nix
				catppuccin.nixosModules.catppuccin
				home-manager.nixosModules.home-manager
				{
					home-manager.useGlobalPkgs = true;
					home-manager.useUserPackages = true;
					home-manager.users.koye = {
						imports = [
							./home/home.nix
							ags.homeManagerModules.default						
							catppuccin.homeManagerModules.catppuccin
						];
					};
				}
			];
		};
	};
}
