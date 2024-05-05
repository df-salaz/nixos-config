{ config, inputs, lib, pkgs, ... }:

{
  options.guiToolkits = {
    enable =
      lib.mkEnableOption "Enable GUI toolkit management";
  };

  config = lib.mkIf config.guiToolkits.enable {
    home.pointerCursor = {
      gtk.enable = true;
      package = lib.mkDefault pkgs.gnome.adwaita-icon-theme;
      name = lib.mkDefault "Adwaita";
      size = lib.mkDefault 16;
    };

    dconf.settings = {
      "org/gnome/desktop/wm/preferences" = {
        button-layout = ""; # No titlebar buttons
      };
    };

    gtk = {
      enable = true;
      iconTheme = lib.mkDefault {
        name = "Papirus";
        package = pkgs.papirus-icon-theme;
      };
    };

    qt = {
      enable = true;
      platformTheme = "gtk3";
    };
  };
}
