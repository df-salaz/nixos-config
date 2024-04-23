{ lib, userSettings, pkgs, ... }:

{
  programs.nixvim = {
    enable = true;
    defaultEditor = true;
    clipboard.register = "unnamedplus";
    colorschemes.catppuccin.enable = true;
    globals.mapleader = " ";
    keymaps = [
      {
        key = "<leader>ff";
        action = "<cmd>Telescope fd<CR>";
        mode = "n";
        options.silent = true;
      }{
        key = "<C-t>";
        action = "<cmd>ToggleTerm<CR>";
        mode = "n";
        options.silent = true;
      }{
        key = "H";
        action = "vim.cmd.bprevious";
        lua = true;
        options.silent = true;
      }{
        key = "L";
        action = "vim.cmd.bnext";
        lua = true;
        options.silent = true;
      }{
        key = "<";
        action = "<gv";
        mode = "v";
        options.silent = true;
      }{
        key = ">";
        action = ">gv";
        mode = "v";
        options.silent = true;
      }{
        # Copy entire file
        key = "<C-S-y>";
        action = "gg0yG<C-o>";
        mode = "n";
        options.silent = true;
      }{
        # Backspace whole words in insert mode
        key = "<C-BS>";
        action = "<C-w>";
        mode = "i";
      }
    ];
    options = {
      updatetime = 100;
      nu = true;
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
