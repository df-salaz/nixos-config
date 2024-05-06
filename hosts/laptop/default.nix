{ inputs, ... }:
{
  imports = [ ./hardware-configuration.nix ];

  home-manager.users = {
    "koye" = {
      imports = [
        ./home.nix
        ../../homeModules
        inputs.catppuccin.homeManagerModules.catppuccin
        inputs.nixvim.homeManagerModules.nixvim
      ];
    };
  };

  networking.hostName = "laptop";
  nh.enable = true;
  theme.catppuccin = {
    enable = true;
    flavor = "mocha";
  };
}
