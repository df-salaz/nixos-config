{ config, lib, pkgs, userSettings, ... }:

{
  options.sway = {
    enable =
      lib.mkEnableOption "Enable Sway configuration";
    swayfx.enable =
      lib.mkEnableOption "Enable SwayFX";
  };

  config = {
    home.packages = with pkgs; [
      pavucontrol
      cinnamon.nemo
    ];
    services = {
      cliphist.enable = true;
      udiskie.enable = true;
      udiskie.tray = "never";
    };
    wayland.windowManager.sway = {
      enable = true;
      package = lib.mkIf (config.sway.swayfx.enable) pkgs.swayfx;
      config = let
        modifier = "Mod4";
        terminal-pkg-name = config.terminalEmulator.defaultTerminalEmulator;
        terminal = "${lib.getExe pkgs.${terminal-pkg-name}}";
        menu = "${lib.getExe pkgs.wofi} -b -i -S drun | xargs swaymsg exec --";
        rofimoji = "${lib.getExe pkgs.rofimoji}";
      in {
        inherit modifier;
        inherit menu;
        inherit terminal;
        keybindings = let
          wl-copy = "${pkgs.wl-clipboard}/bin/wl-copy";
          ss-save = ''~/Pictures/Screenshots/Screenshot-$(date "+%a-%b-%d-%T-%Z-%Y").png'';
          grimshot = lib.getExe pkgs.sway-contrib.grimshot;
          wtype = lib.getExe pkgs.wtype;
          cliphist = lib.getExe pkgs.cliphist;
          wofi = lib.getExe pkgs.wofi;
          lock = lib.getExe pkgs.swaylock-effects;
          calculator =
            lib.getExe' pkgs.gnome.gnome-calculator "gnome-calculator";
          cfg = config.wayland.windowManager.sway;
          brightnessctl = lib.getExe pkgs.brightnessctl;
          pactl = "${pkgs.pulseaudio}/bin/pactl";
          playerctl = "${pkgs.playerctl}/bin/playerctl";
        in {
          "${modifier}+return" = "exec ${terminal}";
          "${modifier}+e" = "exec ${toString ./config/powermenu-sway.sh}";
          "${modifier}+f" =  "fullscreen";
          "${modifier}+v" = "floating toggle";
          "${modifier}+c" = "kill";
          "${modifier}+q" = "exec ${calculator}";
          "${modifier}+r" = "exec ${menu}";
          "${modifier}+m" = "exec ${lock}";
          "${modifier}+p" = "sticky toggle";

          "${modifier}+period" = "exec ${rofimoji} --selector wofi";
          "${modifier}+comma" = "exec ${wtype} -- $(${cliphist} list | ${wofi} -S dmenu -P Paste | ${cliphist} decode)";

          "${modifier}+Shift+s" = "exec ${wl-copy} < $(${grimshot} --notify save area ${ss-save})";
          "${modifier}+Shift+d" = "exec ${wl-copy} < $(${grimshot} --notify --wait 5 save area ${ss-save})";

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

          "${modifier}+${cfg.config.left}" = "focus left";
          "${modifier}+${cfg.config.down}" = "focus down";
          "${modifier}+${cfg.config.up}" = "focus up";
          "${modifier}+${cfg.config.right}" = "focus right";

          "${modifier}+Left" = "focus left";
          "${modifier}+Down" = "focus down";
          "${modifier}+Up" = "focus up";
          "${modifier}+Right" = "focus right";

          "${modifier}+Shift+${cfg.config.left}" = "move left";
          "${modifier}+Shift+${cfg.config.down}" = "move down";
          "${modifier}+Shift+${cfg.config.up}" = "move up";
          "${modifier}+Shift+${cfg.config.right}" = "move right";

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
        output."eDP-1" = {
          mode = "1920x1080@60Hz";
          scale = "1";
          max_render_time = "7";
        };
        output."HDMI-A-1" = {
          mode = "1440x900@74.984Hz";
          scale = "1";
          max_render_time = "2";
        };
        startup = [
          { command = "${lib.getExe pkgs.autotiling}"; }
          { command = "${pkgs.wl-clipboard}/bin/wl-paste --watch cliphist store"; }
          { command = "${lib.getExe pkgs.xorg.xrandr} --output WAYLAND0 --primary"; always = true; }
          { command = "${pkgs.wbg}/bin/wbg ${userSettings.wallpaper}"; }
        ];
        bars = [{
          command = "${lib.getExe pkgs.waybar}";
        }];
        floating = {
          border = 2;
          titlebar = false;
          criteria = [
            { app_id = "org.prismlauncher.PrismLauncher"; title = "^.*—.*$"; }
            { instance="^.*Minecraft.*$"; }
            { app_id="firefox"; title="^Picture-in-Picture$"; }
            { app_id = "nemo"; }
            { app_id = "pavucontrol"; }
            { app_id = "org.gnome.Calculator"; }
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
        input."type:touchpad" = {
          dwt = "enabled";
          tap = "enabled";
          natural_scroll = "enabled";
          middle_emulation = "enabled";
        };
        input."type:keyboard" = {
          xkb_numlock = "enabled";
        };
        input."type:pointer" = {
          accel_profile = "flat";
        };
        defaultWorkspace = "workspace number 1";
      };
      checkConfig = false;
      extraConfig = let
        swipe-gestures = ''
          bindgesture swipe:right workspace prev
          bindgesture swipe:left workspace next
        '';
      in if config.sway.swayfx.enable then
        swipe-gestures + ''
          corner_radius 10
        ''
        else
        swipe-gestures;
    };
    swayidle.enable = true;
  };
}
