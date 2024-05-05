{ pkgs, lib, config, ... }:

{
  options = {
    nh.enable =
      lib.mkEnableOption "Enables the nh helper program";
    flake = lib.mkDefault "/home/koye/.nixos";
  };

  config = lib.mkIf config.nh.enable {
    environment.systemPackages = with pkgs; [
      nh
    ];
    environment.sessionVariables = {
      FLAKE = config.nh.flake;
    };
  };
}
