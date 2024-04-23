{ userSettings, pkgs, ... }:

{
  programs.nixvim = {
    enable = true;
    defaultEditor = true;
    clipboard.register = "unnamedplus";
    colorschemes.catppuccin.enable = true;
    options = {
      updatetime = 100;
      relativenumber = true;
      cursorline = true;
      cursorlineopt = "number";
      tabstop = 4;
      smartindent = true;
      formatoptions = "tcro/qwa2nlj";
      conceallevel = 2;
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
          texlab.enable = true;
        };
      };
      lualine.enable = true;
      lualine.globalstatus = true;
      markdown-preview.enable = true;
      neo-tree.enable = true;
      nix.enable = true;
      nvim-jdtls.enable = true;
      statuscol.enable = true;
      surround.enable = true;
      telescope = {
        enable = true;
        "<leader>ff" = "find_files";
      };
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
