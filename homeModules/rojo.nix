{ lib, pkgs, config, ...}:
{
  options.rojo = {
    enable = lib.mkEnableOption "Enable Rojo";
  };

  config = lib.mkIf config.rojo.enable {
    home.packages = with pkgs; [
      rojo
    ];
  };
}
