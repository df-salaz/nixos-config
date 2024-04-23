{ lib, userSettings, pkgs, ... }:

{
  programs.nixvim = {
    enable = true;
    defaultEditor = true;
    clipboard.register = "unnamedplus";
    colorschemes.catppuccin.enable = true;
    keymaps = [
      {
        action = "<cmd>Telescope fd<CR>";
        key = "<leader>ff";
      }
    ];
    options = {
      updatetime = 100;
      relativenumber = true;
      cursorline = true;
      cursorlineopt = "number";
      tabstop = 4;
      smartindent = true;
      formatoptions = "tcro/qwa2nlj";
      conceallevel = 2;
      scrolloff = 8;
      incsearch = true;
      ignorecase = true;
    };
    plugins = {
      bufferline.enable = true;
      cmp.enable = true;
      cmp-nvim-lsp.enable = true;
      fugitive.enable = true;
      gitsigns.enable = true;
      lsp = {
        enable = true;
        servers = {
          lua-ls.enable = true;
          nixd.enable = true;
          texlab.enable = true;
        };
      };
      lualine.enable = true;
      lualine.globalstatus = true;
      markdown-preview.enable = true;
      neo-tree.enable = true;
      nix.enable = true;
      nvim-jdtls = {
        enable = true;
        cmd = [
          (lib.getExe pkgs.jdt-language-server)
        ];
      };
      statuscol.enable = true;
      surround.enable = true;
      telescope.enable = true;
      todo-comments.enable = true;
      toggleterm.enable = true;
      treesitter.enable = true;
      ts-autotag.enable = true;
      vim-css-color.enable = true;
      vim-matchup.enable = true;
      vimtex.enable = true;
    };
    viAlias = true;
    vimAlias = true;
  };
}
