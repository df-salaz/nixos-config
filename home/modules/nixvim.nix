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
      }{
        # Use alt + j/k to move lines of text
        key = "<A-j>";
        action = ":m +1<CR>";
        mode = "n";
      }{
        key = "<A-k>";
        action = ":m -2<CR>";
        mode = "n";
      }
    ];
    options = {
      updatetime = 100;
      nu = true;
      relativenumber = true;
      cursorline = true;
      cursorlineopt = "number";
      tabstop = 4;
      shiftwidth = 4;
      smartindent = true;
      formatoptions = "tcro/qwa2nlj";
      conceallevel = 2;
      scrolloff = 8;
      incsearch = true;
      ignorecase = true;
    };
    plugins = {
      bufferline = {
        enable = true;
        middleMouseCommand = "bdelete! %d";
        separatorStyle = "slope";
        showBufferCloseIcons = false;
      };
      cmp = {
        enable = true;
        settings = {
          expirimental = {ghost_text = true;};
          mapping = {
            "<Tab>" = "cmp.mapping.confirm({select = true})";
            "<S-Tab>" = "cmp.mapping.close()";
          };
          snippet.expand = "function(args) require('luasnip').lsp_expand(args.body) end";
          sources = [
            { name = "nvim_lsp"; }
            { name = "luasnip"; }
            { name = "path"; }
            { name = "buffer"; }
          ];
        };
      };
      cmp_luasnip.enable = true;
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
      lspkind.enable = true;
      lualine = {
        enable = true;
        globalstatus = true;
      };
      luasnip.enable = true;
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
      treesitter = {
        enable = true;
        disabledLanguages = [
          "latex"
          "markdown"
        ];
      };
      ts-autotag.enable = true;
      vim-css-color.enable = true;
      vim-matchup.enable = true;
      vimtex.enable = true;
    };
    viAlias = true;
    vimAlias = true;
  };
}
