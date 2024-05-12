{ lib, config, pkgs, userSettings, ... }:
{
  options.i3 = {
    enable =
      lib.mkEnableOption "Enable i3 window manager";
  };

  config = lib.mkIf config.i3.enable {
    xsession.windowManager.i3 = {
      enable = true;
      config = let
        modifier = "Mod4";
        terminal-pkg-name = config.terminalEmulator.defaultTerminalEmulator;
        terminal = "${lib.getExe pkgs.${terminal-pkg-name}}";
        menu = "${lib.getExe pkgs.rofi}";
        rofimoji = "${lib.getExe pkgs.rofimoji}";
      in {
        inherit modifier;
        inherit menu;
        inherit terminal;
        keybindings = let
          cfg = config.xsession.windowManager.i3;
          calculator =
            lib.getExe' pkgs.gnome.gnome-calculator "gnome-calculator";
          brightnessctl = lib.getExe pkgs.brightnessctl;
          pactl = "${pkgs.pulseaudio}/bin/pactl";
          playerctl = "${pkgs.playerctl}/bin/playerctl";
        in {
          "${modifier}+return" = "exec ${terminal}";
          "${modifier}+e" = "exec ${toString ./config/powermenu-sway.sh}";
          "${modifier}+f" = "fullscreen";
          "${modifier}+v" = "floating toggle";
          "${modifier}+c" = "kill";
          "${modifier}+q" = "exec ${calculator}";
          "${modifier}+r" = "exec ${menu}";
          "${modifier}+p" = "sticky toggle";

          "${modifier}+period" = "exec ${rofimoji}";

          "${modifier}+shift+c" = "reload";

          "${modifier}+1" = "workspace number 1";
          "${modifier}+2" = "workspace number 2";
          "${modifier}+3" = "workspace number 3";
          "${modifier}+4" = "workspace number 4";
          "${modifier}+5" = "workspace number 5";
          "${modifier}+6" = "workspace number 6";
          "${modifier}+7" = "workspace number 7";
          "${modifier}+8" = "workspace number 8";
          "${modifier}+9" = "workspace number 9";
          "${modifier}+0" = "workspace number 10";

          "--whole-window ${modifier}+button4" = "workspace prev";
          "--whole-window ${modifier}+button5" = "workspace next";

          "${modifier}+Shift+1" = "move container to workspace number 1";
          "${modifier}+Shift+2" = "move container to workspace number 2";
          "${modifier}+Shift+3" = "move container to workspace number 3";
          "${modifier}+Shift+4" = "move container to workspace number 4";
          "${modifier}+Shift+5" = "move container to workspace number 5";
          "${modifier}+Shift+6" = "move container to workspace number 6";
          "${modifier}+Shift+7" = "move container to workspace number 7";
          "${modifier}+Shift+8" = "move container to workspace number 8";
          "${modifier}+Shift+9" = "move container to workspace number 9";
          "${modifier}+Shift+0" = "move container to workspace number 10";

          "${modifier}+Shift+minus" = "move scratchpad";
          "${modifier}+minus" = "scratchpad show";

          "${modifier}+h" = "focus left";
          "${modifier}+j" = "focus down";
          "${modifier}+k" = "focus up";
          "${modifier}+l" = "focus right";

          "${modifier}+Left" = "focus left";
          "${modifier}+Down" = "focus down";
          "${modifier}+Up" = "focus up";
          "${modifier}+Right" = "focus right";

          "${modifier}+Shift+h" = "move left";
          "${modifier}+Shift+j" = "move down";
          "${modifier}+Shift+k" = "move up";
          "${modifier}+Shift+l" = "move right";

          "${modifier}+Shift+Left" = "move left";
          "${modifier}+Shift+Down" = "move down";
          "${modifier}+Shift+Up" = "move up";
          "${modifier}+Shift+Right" = "move right";

          "XF86MonBrightnessDown" = "exec ${brightnessctl} set 5%- -n 1920";
          "XF86MonBrightnessUp" = "exec ${brightnessctl} set +5%";
          "XF86AudioMute" = "exec ${pactl} set-sink-mute @DEFAULT_SINK@ toggle";
          "XF86AudioLowerVolume" = "exec ${pactl} set-sink-volume @DEFAULT_SINK@ -2%";
          "XF86AudioRaiseVolume" = "exec ${pactl} set-sink-volume @DEFAULT_SINK@ +2%";
          "XF86AudioPrev" = "exec ${playerctl} previous";
          "XF86AudioPlay" = "exec ${playerctl} play-pause";
          "XF86AudioNext" = "exec ${playerctl} next";
        };
        startup = [
          { command = "${lib.getExe pkgs.autotiling-rs}"; }
          { command = "${lib.getExe pkgs.feh} --bg-scale ${userSettings.wallpaper}"; }
        ];
        bars = [{
        }];
        floating = {
          border = 2;
          titlebar = false;
          criteria = [
            { instance="^.*Minecraft.*$"; }
          ];
        };
        window = {
          border = 2;
          titlebar = false;
        };
        focus = {
          newWindow = "focus";
          mouseWarping = true;
        };
        gaps = {
          inner = 4;
          outer = 0;
          smartBorders = "on";
          smartGaps = true;
        };
        defaultWorkspace = "workspace number 1";
        colors = let
          accent = "\$${config.catppuccin.accent}";
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
  };
}
