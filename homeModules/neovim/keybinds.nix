{
  programs.nixvim = {
    globals.mapleader = " ";
    plugins = {
      cmp.settings.mapping = {
        "<Tab>" = "cmp.mapping.confirm({select = true})";
        "<S-Tab>" = "cmp.mapping.close()";
        "<down>" = "cmp.mapping(cmp.mapping.select_next_item(), {'i', 's'})";
        "<up>" = "cmp.mapping(cmp.mapping.select_prev_item(), {'i', 's'})";
      };
      lsp.keymaps = {
        lspBuf = {
          K = "hover";
          gD = "references";
          gd = "definition";
          gi = "implementation";
          gt = "type_definition";
        };
        extra = [
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
      };
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
  };
}

