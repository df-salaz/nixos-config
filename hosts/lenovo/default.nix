{ pkgs, inputs, lib, ... }:
{
  imports = [ ./hardware-configuration.nix ];

  networking.hostName = "lenovo";
  nh.enable = true;
  theme.catppuccin = {
    enable = true;
    flavor = "mocha";
  };

  programs.steam.gamescopeSession.enable = true;
}
