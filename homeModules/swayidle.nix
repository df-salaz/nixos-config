{ config, lib, pkgs, ... }:
{
  options.swayidle = {
    enable = lib.mkEnableOption "Enable Swayidle";
  };

  config = lib.mkIf config.swayidle.enable {
    services.swayidle = {
      enable = true;
      events = [{
        event = "before-sleep";
        command = "${pkgs.swaylock-effects}/bin/swaylock";
      }{
        event = "lock";
        command = "${pkgs.swaylock-effects}/bin/swaylock";
      }];
    };
  };
}
