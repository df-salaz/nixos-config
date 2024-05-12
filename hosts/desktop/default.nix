{ pkgs, inputs, lib, ... }:
{
  imports = [ ./hardware-configuration.nix ];

  networking.hostName = "desktop";
  nh.enable = true;
  theme.catppuccin = {
    enable = true;
    flavor = "mocha";
  };

  # Broken on this hardware
  programs.steam.gamescopeSession.enable = false;
}
