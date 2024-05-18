{ lib, config, pkgs, ... }:

{
  options.nixvim.tex = {
    enable = lib.mkEnableOption "Enable TeX Live and VimTeX";
  };

  config = lib.mkIf config.nixvim.tex.enable {
    home.packages = with pkgs; [
      texliveFull
    ];
    programs.nixvim = {
      plugins = {
        lsp = {
          servers = {
            texlab.enable = true;
          };
        };
        treesitter = {
          disabledLanguages = [
            "latex"
          ];
        };
        vimtex = {
          enable = true;
          texlivePackage = pkgs.texliveFull;
        };
      };
    };
  };
}
