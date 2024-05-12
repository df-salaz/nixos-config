{ lib, config, pkgs, userSettings, ... }:
{
  options.hyprland = {
    enable =
      lib.mkEnableOption "Enable Hyprland";
  };

  config = lib.mkIf config.hyprland.enable {
    home.packages = with pkgs; [
      pavucontrol
      brightnessctl
      hyprpicker
      cinnamon.nemo
    ];
    services = {
      cliphist.enable = true;
      udiskie.enable = true;
      udiskie.tray = "never";
    };
    wayland.windowManager.hyprland = {
      enable = true;
      settings = {
        monitor = [
          "eDP-1, 1920x1080@60, 0x0, 1"
          "HDMI-A-1, 1440x900@74.98, 0x0, 1"
        ];
        "$terminal" = let
          terminal-emulator = config.terminalEmulator.defaultTerminalEmulator;
        in "${lib.getExe pkgs.${terminal-emulator}}";
        "$lock" = "${lib.getExe pkgs.swaylock-effects}";
        "$mainMod" = "SUPER";
        "$calculator" = "${pkgs.gnome.gnome-calculator}/bin/gnome-calculator";
        "$power" = toString ./config/powermenu-sway.sh;
        "$emoji" = "${pkgs.rofimoji}/bin/rofimoji --selector fuzzel";
        "$clipboard" = "${pkgs.wtype}/bin/wtype -- $(${pkgs.cliphist}/bin/cliphist list | ${pkgs.wofi}/bin/wofi -S dmenu -P Paste | ${pkgs.cliphist}/bin/cliphist decode)";
        "$runner" = "${pkgs.wofi}/bin/wofi -b -i -S run | xargs hyprctl dispatch exec --";
        "$menu" = "${lib.getExe pkgs.fuzzel}";
        "$screenshots" = "/home/koye/Pictures/Screenshots";
        "$ss-save" = "$screenshots/Screenshot-$(date '+%a-%b-%d-%T-%Z-%Y').png";
        "$ss" = "${pkgs.wl-clipboard}/bin/wl-copy < $(${pkgs.sway-contrib.grimshot}/bin/grimshot --notify save area $ss-save)";
        "$ss-wait" = "${pkgs.wl-clipboard}/bin/wl-copy < $(${pkgs.sway-contrib.grimshot}/bin/grimshot --notify --wait 5 save area $ss-save)";
        "$ss-screen" = "${pkgs.wl-clipboard}/bin/wl-copy < $(${pkgs.sway-contrib.grimshot}/bin/grimshot --notify save screen $ss-save)";
        exec-once = [
          "${pkgs.wl-clipboard}/bin/wl-paste --watch cliphist store"
          "${pkgs.waybar}/bin/waybar"
          "${pkgs.wbg}/bin/wbg ${userSettings.wallpaper}"
        ];
        input = {
          kb_layout = "us";
          numlock_by_default = true;
          follow_mouse = 1;
          float_switch_override_focus = 0;
          sensitivity = 0;
          accel_profile = "flat";
          touchpad = {
            natural_scroll = true;
            disable_while_typing = true;
          };
        };
        general = {
          border_size = 2;
          layout = "dwindle";
          resize_on_border = true;
          gaps_in = 4;
          gaps_out = 8;
          allow_tearing = true;
        };
        animations = {
          first_launch_animation = true;
          bezier = "myBezier, 0.16, 1, 0.3, 1";
          animation = [
            "windows, 1, 3, myBezier"
            "windowsOut, 1, 7, myBezier, popin 80%"
            "border, 1, 2, default"
            "borderangle, 1, 8, default"
            "fade, 1, 3, myBezier"
            "workspaces, 1, 2, myBezier"
          ];
        };
        dwindle = {
          no_gaps_when_only = true;
        };
        decoration = {
          drop_shadow = false;
          rounding = 12;
        };
        gestures = {
          workspace_swipe = true;
          workspace_swipe_min_speed_to_force = 5;
          workspace_swipe_direction_lock = false;
          workspace_swipe_forever = true;
        };
        misc = {
          disable_hyprland_logo = true;
          force_default_wallpaper = 0;
          vfr = true;
          disable_autoreload = true;
          focus_on_activate = true;
          disable_splash_rendering = true;
          enable_swallow = true;
        };
        binds = {
          scroll_event_delay = 0;
        };
        debug = {
          overlay = false;
        };
        windowrule = [
          "noblur,^(?!(Alacritty|swayimg))"
          "windowdance,title:^(Rhythm Doctor)$"
          "forceinput,title:^(Rhythm Doctor)$"
        ];
        windowrulev2 = [
          "float,class:^(org.gnome.Calculator)$"
          "suppressevent maximize, class:.*"
          "immediate, class:.*"
        ];
        env = [
          "WLR_DRM_NO_ATOMIC,1"
        ];
        bind = [
          "$mainMod, return, exec, $terminal"
          "$mainMod, C, killactive,"
          "$mainMod, Q, exec, $calculator"
          "$mainMod, P, pin,"
          "$mainMod, F, fullscreen,"
          "$mainMod, G, fakefullscreen,"
          "$mainMod, M, exec, $lock"
          "$mainMod, E, exec, $power"
          "$mainMod, V, togglefloating, "
          "$mainMod, R, exec, $menu"
          "$mainMod, F2, exec, $runner"
          "$mainMod, comma, exec, $emoji"
          "$mainMod SHIFT, C, exec, hyprctl reload"
          "$mainMod SHIFT, S, exec, $ss"
          "$mainMod SHIFT, D, exec, $ss-wait"
          ",XF86MonBrightnessDown, exec, ${pkgs.brightnessctl}/bin/brightnessctl set 5%- -n 1920"
          ",XF86MonBrightnessUp, exec, ${pkgs.brightnessctl}/bin/brightnessctl set +5%"
          ",XF86AudioMute, exec, ${pkgs.pulseaudio}/bin/pactl set-sink-mute @DEFAULT_SINK@ toggle"
          ",XF86AudioLowerVolume, exec, ${pkgs.pulseaudio}/bin/pactl set-sink-volume @DEFAULT_SINK@ -5%"
          ",XF86AudioRaiseVolume, exec, ${pkgs.pulseaudio}/bin/pactl set-sink-volume @DEFAULT_SINK@ +5%"
          ",XF86AudioPrev, exec, ${pkgs.playerctl}/bin/playerctl previous"
          ",XF86AudioPlay, exec, ${pkgs.playerctl}/bin/playerctl play-pause"
          ",XF86AudioNext, exec, ${pkgs.playerctl}/bin/playerctl next"
          "$mainMod, H, movefocus, l"
          "$mainMod, L, movefocus, r"
          "$mainMod, K, movefocus, u"
          "$mainMod, J, movefocus, d"
          "$mainMod, minus, togglespecialworkspace, scratchpad"
          "$mainMod SHIFT, minus, movetoworkspace, special:scratchpad"
          "$mainMod, mouse_up, workspace, e+1"
          "$mainMod, mouse_down, workspace, e-1"
          "$mainMod, right, workspace, e+1"
          "$mainMod, left, workspace, e-1"
        ] ++ (
          builtins.concatLists (builtins.genList (
            x: let
              ws = let
                c = (x + 1) / 10;
              in
              builtins.toString (x + 1 - (c * 10));
            in [
              "$mainMod, ${ws}, workspace, ${toString (x + 1)}"
              "$mainMod SHIFT, ${ws}, movetoworkspace, ${toString (x + 1)}"
            ]
          )10)
        );
        bindm = [
          "$mainMod, mouse:272, movewindow"
          "$mainMod, mouse:273, resizewindow"
        ];
        workspace = "special:scratchpad, on-created-empty:[float] $terminal";
      };
    };

    swayidle.enable = true;
  };
}
