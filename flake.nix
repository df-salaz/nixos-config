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
		# --- System Settings --- #
		systemSettings = {
			hostname = "nixos";
			system = "x86_64-linux";
		};

		# --- User Settings --- #
		userSettings = {
			username = "koye";
			colorScheme = "catppuccin";
		};
	in {
		nixosConfigurations.${systemSettings.hostname} = 
			nixpkgs.lib.nixosSystem {
			system = systemSettings.system;
			specialArgs = {
				inherit inputs;
				inherit systemSettings;
			};
			modules = [
				{nixpkgs.overlays = [ nur.overlay ]; }
				./system/configuration.nix
				catppuccin.nixosModules.catppuccin
				home-manager.nixosModules.home-manager
				{
					home-manager.extraSpecialArgs = {
						inherit inputs;
						inherit userSettings;
					};
					home-manager.useGlobalPkgs = true;
					home-manager.useUserPackages = true;
					home-manager.users = {
						${userSettings.username} = {
							imports = [
								./home/home.nix
								ags.homeManagerModules.default						
							];
						};
					};
				}
			];
		};

	};
}
