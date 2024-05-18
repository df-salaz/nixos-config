{ lib, config, pkgs, ... }:

{
  options.nixvim.luau = {
    enable = lib.mkEnableOption "Enable luau";
  };

  config = lib.mkIf config.nixvim.luau.enable {
    programs.nixvim = {
      extraPlugins = with pkgs; [
        vimPlugins.plenary-nvim
        (pkgs.vimUtils.buildVimPlugin {
          name = "luau-lsp.nvim";
          src = pkgs.fetchFromGitHub {
            owner = "lopi-py";
            repo = "luau-lsp.nvim";
            rev = "516929172874a6d240ae9100bb85d69cf50c11e7";
            hash = "sha256-ssvuwWT6DD6XkGzTl6MdNhUi2kRn3g6e5jZ+VqCgjKc=";
          };
        })
      ];
      extraConfigLua = ''
        require("luau-lsp").setup {
          plugin = {
            enabled = true,
            port = 3667,
          },
          server = {
            settings = {
              ["luau-lsp"] = {
                completion = {
                  imports = {
                    enabled = true,
                  },
                },
              },
            },
          },
        }
      '';
    };
  };
}
