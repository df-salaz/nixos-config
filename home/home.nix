{config, inputs, options, userSettings, pkgs, ... }:

{
  xdg.enable = true;

  imports = [
    ./modules
  ];

  home.username = userSettings.username;
  home.homeDirectory = "/home/"+userSettings.username;

  nixpkgs.config.allowUnfree = true;
  home.packages = with pkgs; [
    vlc
    dolphin-emu
    obsidian
    mathematica
    krita
    blender
    prismlauncher
    gnome.gnome-calculator
    cinnamon.nemo
    rofimoji
    zoom-us
    neofetch
    firefox
    chromium
  ];

  programs = {
    ripgrep.enable = true;
    obs-studio.enable = true;
    zathura.enable = true;
    emacs.enable = true;
  };

  services = {
    easyeffects.enable = true;
    cliphist.enable = true;
    udiskie.enable = true;
    udiskie.tray = "never";
  };

    # Let Home Manager install and manage itself.
    programs.home-manager.enable = true;

    # This value determines the Home Manager release that your configuration is
    # compatible with. This helps avoid breakage when a new Home Manager release
    # introduces backwards incompatible changes.
    #
    # You should not change this value, even if you update Home Manager. If you do
    # want to update the value, then make sure to first check the Home Manager
    # release notes.
    home.stateVersion = "23.11"; # Please read the comment before changing.
  }
