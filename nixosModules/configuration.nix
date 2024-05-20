{ pkgs, lib, ... }:
{
  nixpkgs.config.allowUnfree = true;
  environment.defaultPackages = [];
  environment.systemPackages = with pkgs; [
    gcc
    ntfs3g
    killall
  ];
  programs = {
    steam = {
      enable = true;
      gamescopeSession.enable = lib.mkDefault true;
    };
  };

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  system.stateVersion = "23.11";
}
