{
	description = "Nixos config flake";

	inputs = {
		nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
		catppuccin.url = "github:catppuccin/nix";
		nur.url = "github:nix-community/NUR";
		ags = {
			url = "github:Aylur/ags";
			inputs.nixpkgs.follows = "nixpkgs";
		};
		matugen = {
			url = "github:InioX/Matugen";
			inputs.nixpkgs.follows = "nixpkgs";
		};
		home-manager = {
			url = "github:nix-community/home-manager";
			inputs.nixpkgs.follows = "nixpkgs";
		};
	};

	outputs = { self, nixpkgs, catppuccin, nur, ags, home-manager, ... } 
	@inputs:
	let
		options = {
			username = "koye";
			hostname = "nixos";
		};
	in {
		nixosConfigurations.${options.hostname} = nixpkgs.lib.nixosSystem {
			system = "x86_64-linux";
			specialArgs = {inherit inputs;};
			modules = [
				{nixpkgs.overlays = [ nur.overlay ]; }
				./system/configuration.nix
				catppuccin.nixosModules.catppuccin
				home-manager.nixosModules.home-manager
				{
					home-manager.extraSpecialArgs = {inherit inputs;};
					home-manager.useGlobalPkgs = true;
					home-manager.useUserPackages = true;
					home-manager.users = {
						${options.username} = {
							imports = [
								./home/home.nix
								ags.homeManagerModules.default						
								catppuccin.homeManagerModules.catppuccin
							];
						};
					};
				}
			];
		};

	};
}
