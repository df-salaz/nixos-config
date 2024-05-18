{config, lib, inputs, options, userSettings, pkgs, ... }:

{
  home.username = "koye";
  home.homeDirectory = "/home/koye";

  ## Custom modules

  # Visual Flare
  cava.enable = false;
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
  spotify.enable = false;
  discord.enable = false;
  games.enable = false;

  # Development
  shell.enable = true;
  git.enable = true;
  rojo.enable = true;
  nixvim = {
    enable = true;
    luau.enable = true;
    tex.enable = false;
  };

  # GUI
  hyprland.enable = false;
  sway.enable = false;
  sway.swayfx.enable = false;
  guiToolkits.enable = false;
  runners = {
    wofi.enable = false;
    fuzzel.enable = false;
  };
  terminalEmulator = {
    enable = false;
    defaultTerminalEmulator = "alacritty";
  };

  ## End custom modules

  xdg.enable = true;

  nixpkgs.config.allowUnfree = true;
  home.packages = with pkgs; [
    gh
    nh
  ];
  home.sessionPath = [
    "$HOME/.local/bin"
  ];

  programs = {
    ripgrep.enable = true;
  };

  services = {
    easyeffects.enable = false;
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
