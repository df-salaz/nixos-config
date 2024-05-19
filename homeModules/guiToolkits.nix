{ config, inputs, lib, pkgs, ... }:

{
  options.guiToolkits = {
    enable =
      lib.mkEnableOption "Enable GUI toolkit management";
  };

  config = lib.mkIf config.guiToolkits.enable {
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
      platformTheme.name = "gtk3";
    };
  };
}
