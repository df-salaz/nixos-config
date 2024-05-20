{ pkgs, ... }:
{
  programs = {
    hyprland.enable = true;
    sway = {
      enable = true;
      package = pkgs.swayfx;
    };
  };

  services.displayManager.sddm = {
    enable = true;
    wayland.enable = true;
    autoNumlock = true;
  };

  xdg.portal = {
    enable = true;
    extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
  };
}
