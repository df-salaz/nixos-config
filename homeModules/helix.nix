{ config, lib, ... }:
{
  options.helix = {
    enable = lib.mkEnableOption "Enable Helix";
  };

  config = lib.mkIf (config.helix.enable) {
    programs.helix = {
      enable = true;
      settings = {
        editor = {
          scrolloff = 8;
          line-number = "relative";
          cursorline = true;
          bufferline = "multiple";
          cursor-shape = {
            normal = "block";
            insert = "bar";
            select = "underline";
          };
          gutters = {
            layout = [
              "line-numbers"
              "spacer"
              "diagnostics"
              "diff"
            ];
            line-numbers = {
              min-width = 3;
            };
          };
          soft-wrap = {
            enable = true;
            max-wrap = 20;
            max-indent-retain = 40;
            wrap-at-text-width = true;
          };
          true-color = true;
        };
      };
    };
  };
}
