{ lib, pkgs, ... }:

{
  wayland.windowManager.sway = {
    enable = true;
    config = let
      modifier = "Mod4";
      menu = let
        wofi = pkgs.getExe pkgs.wofi;
      in "${wofi} -b -i -S drun | xargs swaymsg exec --";
    in {
      inherit modifier;
      inherit menu;
      terminal = "${lib.getExe pkgs.alacritty}";
      keybindings = let
        wl-copy = "${pkgs.wl-clipboard}/bin/wl-copy";
        ss-save = ''~/Pictures/Screenshots/Screenshot-$(date "+%a-%b-%d-%T-%Z-%Y").png)'';
        grimshot = lib.getExe pkgs.grimshot;
        wtype = lib.getExe pkgs.wtype;
        cliphist = lib.getExe pkgs.cliphist;
        wofi = lib.getExe pkgs.wofi;
        lock = lib.getExe pkgs.swaylock-effects;
        calculator = lib.getExe pkgs.gnome.gnome-calculator;
      in {
        "${modifier}+e" = "exec ${toString ../config/powermenu-sway.sh}";
        "${modifier}+v" = "floating toggle";
        "${modifier}+c" = "kill";
        "${modifier}+q" = "exec ${calculator}";
        "${modifier}+r" = menu;
        "${modifier}+m" = "exec ${lock}";
        "${modifier}+p" = "sticky toggle";

        "${modifier}+period" = "exec rofimoji --selector wofi";
        "${modifier}+comma" = "exec ${wtype} -- $(${cliphist} list | ${wofi} -S dmenu -P Paste | ${cliphist} decode)";

        "${modifier}+shift+s" = "${wl-copy} < $(${grimshot} --notify save area ${ss-save})";
        "${modifier}+shift+d" = "${wl-copy} < $(${grimshot} --notify --wait 5 save area ${ss-save})";
      };
      output."eDP-1" = {
        mode = "1920x1080@60Hz";
        scale = 1;
        max_render_time = 7;
      };
      startup = [
        { command = "${pkgs.wl-clipboard}/bin/wl-paste --watch cliphist store"; }
        { command = ""; }
      ];
      seat."*" = {
        hide_cursor = "when-typing enable";
      };
    };
    extraConfig = ''
      bindgesture swipe:right workspace prev
      bindgesture swipe:left workspace next
    '';
  };
}
