{ config, pkgs, lib, ...}:
{
  options.theme = {
    catppuccin = {
      enable = lib.mkEnableOption "Enable the Catppuccin theme";
      flavor = lib.mkOption {
        default = "mocha";
      };
    };
  };

  config =
  let
    catppuccin = config.theme.catppuccin.enable;
  in {
    catppuccin.flavour = lib.mkIf (catppuccin)
      config.theme.catppuccin.flavor;
    console.catppuccin.enable = lib.mkIf catppuccin true;
    boot.loader.grub.catppuccin.enable = lib.mkIf catppuccin true;
    services.displayManager.sddm.theme = lib.mkIf catppuccin 
    "catppuccin-sddm-corners";

    environment.systemPackages = with pkgs; lib.optionals (catppuccin) [
      catppuccin-sddm-corners
      libsForQt5.qt5.qtgraphicaleffects
      libsForQt5.qt5.qtquickcontrols2
    ];
  };
}
