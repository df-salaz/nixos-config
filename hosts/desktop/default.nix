{ pkgs, inputs, lib, ... }:
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
      wayland.windowManager.sway.startup = [{
        command = "${lib.getExe pkgs.steam} -silent";
      }];
    };
  };

  networking.hostName = "desktop";
  nh.enable = true;
  theme.catppuccin = {
    enable = true;
    flavor = "mocha";
  };
}
