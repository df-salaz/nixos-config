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
    };
    plugins = {
      bufferline.enable = true;
      cmp.enable = true;
      gitsigns.enable = true;
      lsp.enable = true;
      lualine.enable = true;
      lualine.globalstatus = true;
      markdown-preview.enable = true;
      neo-tree.enable = true;
      nix.enable = true;
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
