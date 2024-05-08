{ inputs, pkgs, ... }:
{
  imports = [ ./hardware-configuration.nix ];

  home-manager.users = let
    username = "koye";
  in  {
    ${username} = {
      imports = [
        ./home.nix
        ../../homeModules
        inputs.catppuccin.homeManagerModules.catppuccin
        inputs.nixvim.homeManagerModules.nixvim
      ];
      home.username = username;
      home.homeDirectory = "/home/"+username;
    };
  };

  environment.systemPackages = with pkgs; [
    mathematica
  ];

  networking.hostName = "laptop";
  nh.enable = true;
  theme.catppuccin = {
    enable = true;
    flavor = "mocha";
  };
}
