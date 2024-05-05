{
  description = "Nixos config flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    catppuccin.url = "github:catppuccin/nix";
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
      username = "koye";
      name = "David";
      email = "df.salaz@gmail.com";
      colorScheme = "catppuccin";
      catppuccin = {
        flavor = "mocha";
        accent = "blue";
      };
      wallpaper = "~/Pictures/nix.png";
    };
    specialArgs = {
      inherit inputs;
    };
    system-modules = [
      ./nixosModules
      {nixpkgs.overlays = [ nur.overlay ]; }
      catppuccin.nixosModules.catppuccin
      home-manager.nixosModules.home-manager
      {
        home-manager.extraSpecialArgs = {
          inherit inputs;
          inherit userSettings;
        };
        home-manager.backupFileExtension = "old";
        home-manager.useGlobalPkgs = true;
        home-manager.useUserPackages = true;
        home-manager.users = {
          "koye" = {
            imports = [
              ./home/home.nix
              ./homeModules
              catppuccin.homeManagerModules.catppuccin
              nixvim.homeManagerModules.nixvim
            ];
          };
        };
      }
    ];
  in {
    nixosConfigurations.desktop = nixpkgs.lib.nixosSystem {
      inherit specialArgs;
      modules = system-modules ++ [./desktop];
    };
    nixosConfigurations.laptop = nixpkgs.lib.nixosSystem {
      inherit specialArgs;
      modules = system-modules ++ [./laptop];
    };
  };
}
