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

  outputs = { self, nixpkgs, catppuccin, nur, nixvim, home-manager, ... } 
  @inputs:
  let
    #  Switches and Settings  #
    # --- System Settings --- #
    # ----------------------- #
    systemSettings = {
      # Hardware #
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

      # Programs #
      terminal = "alacritty";
      discord.enable = true;
      games.extra = true;

      # Theming #
      # Options:
      # - catppuccin
      colorScheme = "catppuccin";
      catppuccin.flavor = "mocha";
      catppuccin.accent = "blue";

      darkTheme = true;
      wallpaper = "~/Pictures/nix.png";
      font = "JetBrainsMono Nerd Font";
    };
  in {
    nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
      specialArgs = {
        inherit inputs;
        inherit systemSettings;
      };
      modules = [
        {nixpkgs.overlays = [ nur.overlay ]; }
        ./desktop/configuration.nix
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
            ${userSettings.username} = {
              imports = [
                ./home/home.nix
                catppuccin.homeManagerModules.catppuccin
                nixvim.homeManagerModules.nixvim
              ];
            };
          };
        }
      ];
    };
  };
}
