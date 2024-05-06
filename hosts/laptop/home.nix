{config, lib, inputs, options, userSettings, pkgs, ... }:

{
  ## Custom modules

  cava.enable = true;
  spotify.enable = true;

  discord.enable = true;
  games.enable = true;

  git.enable = true;
  nixvim.enable = true;

  hyprland.enable = false;
  sway.enable = true;
  guiToolkits.enable = true;

  shell.enable = true;
  terminalEmulator = {
    enable = true;
    defaultTerminalEmulator = "alacritty";
  };

  theme = {
    enable = true;
    catppuccin = {
      enable = true;
      flavor = "mocha";
      accent = "blue";
    };
  };

  ## End custom modules

  xdg.enable = true;

  nixpkgs.config.allowUnfree = true;
  home.packages = with pkgs; [
    vlc
    dolphin-emu
    obsidian
#    mathematica
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
  home.sessionPath = [
    "$HOME/.emacs.d/bin"
    "$HOME/.local/bin"
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
