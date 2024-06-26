{ lib, config, ... }:
{
  options = {
    runners.wofi.enable =
      lib.mkEnableOption "Enable Wofi";
  };

  config = lib.mkIf config.runners.wofi.enable {
    programs.wofi = {
      enable = true;
      settings = {
        gtk_dark = true;
        key_expand = "Tab";
        hide_scroll = true;
        width = 800;
        height = 800;
      };
    };
    home.file = {
      ".config/wofi/style.css".source = ./config/wofi.css;
    };
  };
}
