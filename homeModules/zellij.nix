{ pkgs, config, lib, ... }:
{
  options.zellij = {
    enable = lib.mkEnableOption "Enable Zellij";
  };

  config = lib.mkIf config.zellij.enable {
    programs.zellij = {
      enable = true;
      enableZshIntegration = true;
      settings = {
        on_force_close = "detach";
        simplified_ui = false;
        pane_frames = true;
        # default_layout = "compact";
        copy_command = "${pkgs.wl-clipboard}/bin/wl-copy";
        ui.pane_frames.rounded_corners = true;
        keybinds = {
        };
      };
    };
  };
}
