{ config, pkgs, userSettings, lib, ... }:
{
  options.theme = {
    catppuccin = {
      enable = lib.mkEnableOption "Enable the Catppuccin theme";
      flavor = lib.mkOption {
        default = "mocha";
      };
      accent = lib.mkOption {
        default = "mocha";
      };
    };
  };

  config = lib.mkIf config.theme.catppuccin.enable {
    catppuccin.flavour = config.theme.catppuccin.flavor;
    catppuccin.accent = config.theme.catppuccin.accent;
    gtk = {
      catppuccin.enable = true;
      iconTheme = {
        name = "Papirus";
        package = pkgs.catppuccin-papirus-folders.override {
          flavor = config.catppuccin.flavor;
          accent = config.catppuccin.accent;
        };
      };
      gtk3.extraConfig.Settings = true;
      gtk4.extraConfig.Settings = true;
    };
    home.file = {
      ".config/vesktop/settings/quickCss.css".text =
        lib.mkIf (config.discord.enable)
        ''@import url("https://catppuccin.github.io/discord/dist/catppuccin-${userSettings.catppuccin.flavor}-${userSettings.catppuccin.accent}.theme.css");'';
    };
    programs = {
      alacritty = {
        catppuccin.enable = true;
        settings = {
          colors.cursor.cursor = lib.mkForce "#cdd6f4";
        };
      };
      bat.catppuccin.enable = true;
      btop.catppuccin.enable = true;
      fzf.catppuccin.enable = true;
      zathura.catppuccin.enable = true;
      cava.catppuccin.enable = true;
    };
    wayland.windowManager = {
      hyprland = {
        catppuccin.enable = true;
        settings = {
          general = {
            "col.inactive_border" = "$base";
            "col.active_border" = "\$${userSettings.catppuccin.accent}";
            border_size = 2;
          };
          decoration.rounding = 5;
        };
      };
      sway = {
        catppuccin.enable = true;
        config.colors = let
          accent = "\$${userSettings.catppuccin.accent}";
          background = "$crust";
          unfocused = {
            inherit background;
            border = "$crust";
            childBorder = "$crust";
            indicator = "$crust";
            text = "$text";
          };
        in {
          focused = {
            inherit background;
            border = accent;
            childBorder = accent;
            indicator = accent;
            text = "$text";
          };
          urgent ={
            inherit background;
            border = "$red";
            childBorder = "$red";
            indicator = "$red";
            text = "$text";
          };
          placeholder = unfocused;
          focusedInactive = unfocused;
          inherit unfocused;
          inherit background;
        };
      };
    };
    services = {
      dunst.settings = {
        global = {
          background = "#1e1e2e";
          foreground = "#cdd6f4";
          separator_color = "frame";
        };
        urgency_low = {
          frame_color = "#a6e3a1";
        };
        urgency_normal = {
          frame_color = "#89b4fa";
        };
        urgency_critical = {
          frame_color = "#f38ba8";
        };
      };
    };
  };
}
