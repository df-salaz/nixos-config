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

	outputs = { self, nixpkgs, catppuccin, nur, ags, home-manager, ... } @inputs:
	let
		#  Switches and Settings  #
		# --- System Settings --- #
		# ----------------------- #
		systemSettings = {
			# Hardware #
			hostname = "nixos";
			system = "x86_64-linux";

			# Theming #
			# Options:
			# - catppuccin
			colorScheme = "catppuccin";
			catppuccin.flavor = "mocha";

			# Keep this repository in this folder
			flake = "/home/${userSettings.username}/.nixos";
		};

		# --- User Settings --- #
		# --------------------- #
		userSettings = {
			# Personal #
			username = "koye";
			name = "David";
			email = "df.salaz@gmail.com";

			# Theming #
			# Options:
			# - catppuccin
			colorScheme = "catppuccin";
			catppuccin.flavor = "mocha";
			catppuccin.accent = "mauve";

			darkTheme = true;
			wallpaper = "~/Pictures/nix.png";
			font = "JetBrainsMono Nerd Font";

			# Programs #
			discord.enable = true;
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
								catppuccin.homeManagerModules.catppuccin
							];
						};
					};
				}
			];
		};
	};
}
