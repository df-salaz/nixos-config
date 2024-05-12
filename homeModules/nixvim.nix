{ lib, config, pkgs, ... }:

{
  options.nixvim = {
    enable = lib.mkEnableOption "Enable NixVim";
  };

  config = lib.mkIf config.nixvim.enable {
    home.packages = with pkgs; [
      texliveFull
    ];
    programs.nixvim = {
      enable = true;
      defaultEditor = true;
      clipboard = {
        providers.wl-copy.enable = true;
        register = "unnamedplus";
      };
      colorschemes.catppuccin.enable = true;
      globals = {
        mapleader = " ";
        neovide_hide_mouse_when_typing = true;
        neovide_cursor_animation_length = 0.04;
        neovide_cursor_unfocused_outline_width = 0.08;
        neovide_floating_shadow = true;
        neovide_scroll_animation_length = 0.2;
      };
      keymaps = [
        {
          key = "<leader>ff";
          action = "<cmd>Telescope fd<CR>";
          mode = "n";
          options.silent = true;
        }{
          key = "<leader>k";
          action = "<cmd>Neotree toggle<CR>";
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
          action = "<cmd>m +1<CR>";
          mode = "n";
          options.silent = true;
        }{
          key = "<A-k>";
          action = "<cmd>m -2<CR>";
          mode = "n";
          options.silent = true;
        }{
          key = "<leader>e";
          action = "<cmd>bd<CR>";
          mode = "n";
        }{
          key = "<leader>E";
          action = "<cmd>bd!<CR>";
          mode = "n";
        }{
          key = "<C-/>";
          action = "<cmd>normal gcc<CR>";
          mode = ["n" "i"];
          options.silent = true;
        }{
          key = "<C-/>";
          action = "gb";
          mode = "v";
          options.silent = true;
          options.remap = true;
        }{
          key = "<leader>z";
          action = "<cmd>ZenMode<CR>";
        }
      ];
      opts = {
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
        textwidth = 79;
        fillchars.eob = " ";
        wrap = false;
        guifont = "JetBrainsMono Nerd Font:h12";
      };
      plugins = {
        bufferline = {
          enable = true;
          middleMouseCommand = "bdelete! %d";
          separatorStyle = "slant";
          showBufferCloseIcons = false;
        };
        cmp = {
          enable = true;
          settings = {
            expirimental = {ghost_text = true;};
            mapping = {
              "<Tab>" = "cmp.mapping.confirm({select = true})";
              "<S-Tab>" = "cmp.mapping.close()";
              "<down>" = "cmp.mapping(cmp.mapping.select_next_item(), {'i', 's'})";
              "<up>" = "cmp.mapping(cmp.mapping.select_prev_item(), {'i', 's'})";
            };
            snippet.expand = "luasnip";
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
        comment.enable = true;
        friendly-snippets.enable = true;
        fugitive.enable = true;
        gitsigns.enable = true;
        indent-blankline.enable = true;
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
            nil_ls.enable = true;
            html.enable = true;
            rust-analyzer = {
              enable = true;
              installCargo = true;
              installRustc = true;
            };
            texlab.enable = true;
            tsserver.enable = true;
          };
        };
        lspkind = {
          enable = true;
          mode = "symbol";
        };
        lualine = {
          enable = true;
          globalstatus = true;
        };
        luasnip = {
          enable = true;
          fromLua = [{}];
          fromVscode = [{}];
        };
        markdown-preview.enable = true;
        neo-tree.enable = true;
        nix.enable = true;
        nvim-autopairs.enable = true;
        nvim-colorizer.enable = true;
        nvim-jdtls = {
          enable = true;
          cmd = [(lib.getExe pkgs.jdt-language-server)];
          rootDir.__raw = "vim.fs.dirname(vim.fs.find({ 'gradlew', '.git', 'mvnw', 'pom.xml' }, { upward = true })[1])";
        };
        statuscol.enable = true;
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
        ts-context-commentstring.enable = true;
        twilight.enable = true;
        vim-matchup.enable = true;
        vimtex = {
          enable = true;
          texlivePackage = pkgs.texliveFull;
        };
        zen-mode.enable = true;
      };
      viAlias = true;
      vimAlias = true;
    };
  };
}
