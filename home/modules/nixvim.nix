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
      cmp = {
        enable = true;
        settings = {
          expirimental = {ghost_text = true;};
          mapping = {
            "<Tab>" = "cmp.mapping.confirm({select = true})";
            "<S-Tab>" = "cmp.mapping.close()";
          };
        };
      };
      cmp-buffer.enable = true;
      cmp-nvim-lsp.enable = true;
      fugitive.enable = true;
      gitsigns.enable = true;
      lsp = {
        enable = true;
        keymaps.lspBuf = {
          K = "hover";
          gD = "references";
          gd = "definition";
          gi = "implementation";
          gt = "type_definition";
        };
        keymaps.extra = [
          {
            key = "<leader>rn";
            action = "vim.lsp.buf.rename";
            mode = "n";
            lua = true;
          }{
            key = "<A-CR>";
            action = "vim.lsp.buf.code_action";
            lua = true;
          }
        ];
        servers = {
          lua-ls.enable = true;
          nixd.enable = true;
          texlab.enable = true;
        };
      };
      lualine = {
        enable = true;
        globalstatus = true;
      };
      markdown-preview.enable = true;
      neo-tree.enable = true;
      nix.enable = true;
      nvim-jdtls = {
        enable = true;
        cmd = [(lib.getExe pkgs.jdt-language-server)];
      };
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
