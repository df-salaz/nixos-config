{ pkgs, ... }:
{
  stylix = {
    targets = {
      bat.enable = false;
      btop.enable = false;
      fuzzel.enable = false;
      gtk.enable = false;
      swaylock.enable = false;
      vim.enable = false;
      waybar.enable = false;
      zathura.enable = false;
    };

    cursor = {
      package = pkgs.gnome.adwaita-icon-theme;
      name = "Adwaita";
      size = 16;
    };
  };
}
