{ config, pkgs, lib, userSettings, ... }:
{
  options.theme = {
    enable = lib.mkEnableOption "Enable theming";
    catppuccin = {
      enable = lib.mkEnableOption "Enable the Catppuccin theme";
      flavor = lib.mkOption {
        default = "mocha";
      };
      accent = lib.mkOption {
        default = "blue";
      };
    };
  };

  config = let
    cat = config.theme.catppuccin.enable;
  in
    lib.mkIf config.theme.enable {
    catppuccin.flavour =  config.theme.catppuccin.flavor;
    catppuccin.accent = config.theme.catppuccin.accent;
    gtk = {
      enable = true;
      catppuccin = lib.mkIf cat {
        enable = true;
      };
      iconTheme = lib.mkIf cat {
        name = "Papirus";
        package = pkgs.catppuccin-papirus-folders.override {
          flavor = config.catppuccin.flavour;
          accent = config.catppuccin.accent;
        };
      };
      gtk3.extraConfig.Settings = "gtk-application-prefer-dark-theme = 1";
      gtk4.extraConfig.Settings = "gtk-application-prefer-dark-theme = 1";
    };
    home.file = lib.mkIf (cat && config.discord.enable) {
      ".config/vesktop/settings/quickCss.css".text =
        ''@import url("https://catppuccin.github.io/discord/dist/catppuccin-${config.catppuccin.flavour}-${config.catppuccin.accent}.theme.css");'';
    };
    programs = {
      /* alacritty = {
        catppuccin.enable = cat;
        settings = {
          colors.cursor.cursor = lib.mkForce "#cdd6f4";
        };
      }; */
      /* kitty = {
        catppuccin.enable = cat;
      }; */
      foot.settings = {
        cursor = {
          color = "111111 cccccc";
        };
        colors = {
          foreground = "cdd6f4";
          background = "1e1e2e";
          regular0 = "45475a";
          regular1 = "f38ba8";
          regular2 = "a6e3a1";
          regular3 = "f9e2af";
          regular4 = "89b4fa";
          regular5 = "C4A0EE";
          regular6 = "94e2d5";
          regular7 = "bac2de";
          bright0 = "585b70";
          bright1 = "f38ba8";
          bright2 = "a6e3a1";
          bright3 = "f9e2af";
          bright4 = "89b4fa";
          bright5 = "C4A0EE";
          bright6 = "94e2d5";
          bright7 = "a6adc8";
          scrollback-indicator = "000000 98c379";
        };
      };
      swaylock = {
        enable = true;
        package = pkgs.swaylock-effects;
        settings = {
          indicator-idle-visible = true;
          clock = true;
          hide-keyboard-layout = true;
          disable-caps-lock-text = true;
          font = "JetBrainsMonoNerdFontMono";
          timestr = "%I:%M %p";
          effect-blur = "14x5";
          effect-vignette = "0.7:0";
          indicator-radius = "400";
          indicator-thickness = "20";
          key-hl-color = "cdd6f4";
          separator-color = "00000000";
          ring-color = "89b4fa";
          ring-ver-color = "a6e3a1";
          ring-wrong-color = "f38ba8";
          ring-clear-color = "f9e2af";
          line-color = "00000000";
          line-wrong-color = "00000000";
          line-ver-color = "00000000";
          line-clear-color = "00000000";
          inside-color = "181825aa";
          inside-wrong-color = "181825aa";
          inside-ver-color = "181825aa";
          inside-clear-color = "181825aa";
          text-wrong = "Incorrect";
          text-ver = "";
          text-color = "cdd6f4";
          text-wrong-color = "cdd6f4";
          text-clear-color = "cdd6f4";
          bs-hl-color = "f38ba8";
          image = toString ../wallpaper.png;
        };
      };
      bat.catppuccin.enable = cat;
      btop.catppuccin.enable = cat;
      fzf.catppuccin.enable = cat;
      zathura.catppuccin.enable = cat;
      cava.catppuccin.enable = cat;
      zellij.catppuccin.enable = cat;
    };
    wayland.windowManager = {
      hyprland = {
        catppuccin.enable = cat;
        settings = {
          general = lib.mkIf cat (lib.mkForce {
            "col.inactive_border" = "$base";
            "col.active_border" = "\$${config.catppuccin.accent}";
          });
        };
      };
      sway = lib.mkIf cat {
        catppuccin.enable = true;
        config.colors = let
          accent = "\$${config.catppuccin.accent}";
          background = "$crust";
          unfocused = {
            inherit background;
            border = "$base";
            childBorder = "$base";
            indicator = "$base";
            text = "$text";
          };
        in lib.mkForce {
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
  };
}
