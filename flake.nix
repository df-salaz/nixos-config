{
  description = "Nixos config flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    catppuccin.url = "github:catppuccin/nix";

    ags.url = "github:Aylur/ags";

    # Pinned NUR due to NL-TCH repo being broken
    nur.url =
      "github:nix-community/NUR?rev=57486a778b5614bbdfc96aad2b3585ef60f18c96";

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
    { self,
    nixpkgs,
    catppuccin,
    nur,
    nixvim,
    home-manager,
    ags,
    ... }
    @inputs:
  let
    userSettings = {
      name = "David";
      email = "df.salaz@gmail.com";
      wallpaper = "~/Pictures/nix.png";
    };

    specialArgs = { inherit inputs; };

    nur-overlay = { nixpkgs.overlays = [ nur.overlay ]; };
    system-modules = [
      ./nixosModules
      catppuccin.nixosModules.catppuccin
      nur-overlay
    ];

    system = "x86_64-linux";

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
    };

    homeConfigurations = {
      koye = home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages.${system};

        extraSpecialArgs = {
          inherit inputs;
          inherit userSettings;
        };

        modules = [
          ./home.nix
          ./homeModules
          catppuccin.homeManagerModules.catppuccin
          nixvim.homeManagerModules.nixvim
          ags.homeManagerModules.default
          nur-overlay
        ];
      };
    };
  };
}
