{ pkgs, userSettings, lib, ... }:

let
  catppuccin = userSettings.colorScheme == "catppuccin";
in
  {
    catppuccin.flavour = userSettings.catppuccin.flavor;
    catppuccin.accent = userSettings.catppuccin.accent;
    gtk = {
      catppuccin.enable = lib.mkIf catppuccin true;
      iconTheme = lib.mkIf catppuccin {
        name = "Papirus";
        package = pkgs.catppuccin-papirus-folders.override {
          flavor = userSettings.catppuccin.flavor;
          accent = userSettings.catppuccin.accent;
        };
      };
      gtk3.extraConfig.Settings = lib.mkIf userSettings.darkTheme ''gtk-application-prefer-dark-theme = 1;'';
      gtk4.extraConfig.Settings = lib.mkIf userSettings.darkTheme ''gtk-application-prefer-dark-theme = 1;'';
    };
    home.file = {
      ".config/vesktop/settings/quickCss.css".text =
        lib.mkIf (userSettings.discord.enable && catppuccin)
        ''@import url("https://catppuccin.github.io/discord/dist/catppuccin-${userSettings.catppuccin.flavor}-${userSettings.catppuccin.accent}.theme.css");'';
      };
      programs = {
        alacritty = lib.mkIf catppuccin {
          catppuccin.enable = true;
          settings = {
            colors.cursor.cursor = lib.mkForce "#cdd6f4";
          };
        };
        bat.catppuccin.enable = lib.mkIf catppuccin true;
        btop.catppuccin.enable = lib.mkIf catppuccin true;
        fzf.catppuccin.enable = lib.mkIf catppuccin true;
        zathura.catppuccin.enable = lib.mkIf catppuccin true;
        cava.catppuccin.enable = lib.mkIf catppuccin true;
      };
      wayland.windowManager = lib.mkIf catppuccin {
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
        sway = lib.mkIf catppuccin {
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
    }