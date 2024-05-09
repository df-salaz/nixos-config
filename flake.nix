{
  description = "Nixos config flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    # Pinned catppuccin revision due to GTK bug
    catppuccin.url =
      "github:catppuccin/nix?rev=2788becbb58bd2a60666fbbf2d4f6ae1721112d5";
    nur.url = "github:nix-community/NUR";
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
    { self, nixpkgs, catppuccin, nur, nixvim, home-manager, ... }
    @inputs:
  let
    userSettings = {
      name = "David";
      email = "df.salaz@gmail.com";
      wallpaper = "~/Pictures/nix.png";
    };

    specialArgs = { inherit inputs; };

    system-modules = [
      ./nixosModules
      catppuccin.nixosModules.catppuccin
      { nixpkgs.overlays = [ nur.overlay ]; }
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
        pkgs = import nixpkgs { inherit system; };

        extraSpecialArgs = {
          inherit inputs;
          inherit userSettings;
        };

        modules = [
          ./home.nix
          ./homeModules
          catppuccin.homeManagerModules.catppuccin
          nixvim.homeManagerModules.nixvim
          { nixpkgs.overlays = [ nur.overlay ]; }
        ];
      };
    };
  };
}
