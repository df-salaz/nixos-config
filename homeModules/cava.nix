{ config, lib, inputs, pkgs, ... }:

{
  options.cava = {
    enable = lib.mkEnableOption "Enables cava";
  };

  config = lib.mkIf config.cava.enable {
    programs.cava = {
      enable = true;
      settings = {
        input.method = "pipewire";
        smoothing.noise_reduction = 15;
      };
    };
  };
}

