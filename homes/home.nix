{config, lib, inputs, options, userSettings, pkgs, ... }:

{
  home.username = "koye";
  home.homeDirectory = "/home/koye";

  ## Custom modules

  # Visual Flare
  cava.enable = true;
  hyfetch.enable = true;
  theme = {
    enable = true;
    catppuccin = {
      enable = true;
      flavor = "mocha";
      accent = "blue";
    };
  };

  # Entertainment
  spotify.enable = true;
  discord.enable = true;
  games.enable = true;

  # Development
  shell.enable = true;
  git.enable = true;
  rojo.enable = false;
  helix.enable = true;
  zellij.enable = true;
  nixvim = {
    enable = true;
    luau.enable = false;
    tex.enable = true;
  };

  # GUI
  hyprland.enable = true;
  sway.enable = true;
  sway.swayfx.enable = true;
  guiToolkits.enable = true;
  runners = {
    wofi.enable = false;
    fuzzel.enable = true;
  };
  terminalEmulator = {
    enable = true;
    defaultTerminalEmulator = "alacritty";
  };

  ## End custom modules

  xdg.enable = true;

  nixpkgs.config.allowUnfree = true;
  home.packages = with pkgs; [
    gh
    vlc
    dolphin-emu
    obsidian
    krita
    blender
    prismlauncher
    zoom-us
    firefox
    chromium
    libsForQt5.kdenlive
    godot_4
    neo
  ];
  home.sessionPath = [
    "$HOME/.local/bin"
  ];

  programs = {
    ripgrep.enable = true;
    obs-studio.enable = true;
    zathura.enable = true;
  };

  services = {
    easyeffects.enable = true;
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
