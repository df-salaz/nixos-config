{
  description = "Nixos config flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    catppuccin.url = "github:catppuccin/nix";

    # Pinned NUR due to NL-TCH repo being broken
    nur.url =
      "github:nix-community/NUR?rev=57486a778b5614bbdfc96aad2b3585ef60f18c96";

    stylix.url = "github:danth/stylix";

    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
  { nixpkgs, home-manager, ... } @inputs:
  let
    userSettings = {
      name = "David";
      email = "df.salaz@gmail.com";
    };

    specialArgs = { inherit inputs; };
    extraSpecialArgs = { inherit inputs; inherit userSettings; };

    system = "x86_64-linux";
    pkgs = nixpkgs.legacyPackages.${system};

    overlays = { nixpkgs.overlays = [
      inputs.nur.overlay
      (final: prev: {
        # gamescope = nixpkgs-gamescope.legacyPackages.${system}.gamescope;
      })
    ];};

    system-modules = [
      ./sharedModules
      ./nixosModules
      inputs.catppuccin.nixosModules.catppuccin
      inputs.stylix.nixosModules.stylix
      overlays
    ];
    home-modules = [
      ./sharedModules
      ./homeModules
      inputs.nixvim.homeManagerModules.nixvim
      inputs.catppuccin.homeManagerModules.catppuccin
      inputs.stylix.homeManagerModules.stylix
      overlays
    ];

  in {
    nixosConfigurations = {
      desktop = nixpkgs.lib.nixosSystem {
        modules = system-modules ++ [./hosts/desktop];
        inherit system;
        inherit specialArgs;
      };

      laptop = nixpkgs.lib.nixosSystem {
        modules = system-modules ++ [./hosts/laptop];
        inherit system;
        inherit specialArgs;
      };

      lenovo = nixpkgs.lib.nixosSystem {
        modules = system-modules ++ [./hosts/lenovo];
        inherit system;
        inherit specialArgs;
      };
    };

    homeConfigurations = {
      "koye" = home-manager.lib.homeManagerConfiguration {
        modules = home-modules ++ [./homes/home.nix];
        inherit pkgs;
        inherit extraSpecialArgs;
      };

      "koye@david-windows" = home-manager.lib.homeManagerConfiguration {
        modules = home-modules ++ [./homes/home-wsl.nix];
        inherit pkgs;
        inherit extraSpecialArgs;
      };

      "koye@lenovo" = home-manager.lib.homeManagerConfiguration {
        modules = home-modules ++ [./homes/home-lenovo.nix];
        inherit pkgs;
        inherit extraSpecialArgs;
      };
    };
  };
}
