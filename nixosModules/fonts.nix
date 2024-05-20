{ pkgs, ... }:
{
  fonts.packages = with pkgs; [
    noto-fonts
    noto-fonts-cjk
    dejavu_fonts
  ];
  fonts.fontDir.enable = true;
  fonts.enableDefaultPackages = true; 
  fonts.fontconfig = {
    defaultFonts = {
      monospace = [ "JetBrains Mono Nerd Font" ];
    };
  };
}
