{ lib, config, pkgs, ... }:

{
  options.nixvim = {
    enable = lib.mkEnableOption "Enable NixVim";
  };

  config = lib.mkIf config.nixvim.enable {
    programs.nixvim = {
      enable = true;
      defaultEditor = true;
      clipboard = {
        providers.wl-copy.enable = true;
        register = "unnamedplus";
      };
      colorschemes.catppuccin.enable = true;
      globals = {
        neovide_hide_mouse_when_typing = true;
        neovide_cursor_animation_length = 0.04;
        neovide_cursor_unfocused_outline_width = 0.08;
        neovide_floating_shadow = true;
        neovide_scroll_animation_length = 0.2;
      };
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
            snippet.expand = ''function(args) 
              require('luasnip').lsp_expand(args.body)
            end'';
            sources = [
              { name = "nvim_lsp"; }
              { name = "luasnip"; }
              { name = "path"; }
            ];
          };
        };
        cmp_luasnip.enable = true;
        cmp-nvim-lsp.enable = true;
        comment.enable = true;
        friendly-snippets.enable = true;
        fugitive.enable = true;
        gitsigns.enable = true;
        indent-blankline.enable = true;
        lsp = {
          enable = true;
          servers = {
            lua-ls = {
              enable = true;
              filetypes = [
                "lua"
                "luau"
              ];
            };
            nil_ls.enable = true;
            html.enable = true;
            rust-analyzer = {
              enable = true;
              installCargo = true;
              installRustc = true;
            };
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
          ensureInstalled = [
            "lua"
            "luau"
            "css"
          ];
          disabledLanguages = [
            "markdown"
          ];
        };
        ts-autotag.enable = true;
        ts-context-commentstring.enable = true;
        twilight.enable = true;
        vim-matchup.enable = true;
        zen-mode.enable = true;
      };
      viAlias = true;
      vimAlias = true;
    };
  };
}
