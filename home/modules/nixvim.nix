{ userSettings, pkgs, ... }:

{
	programs.nixvim = {
		clipboard.register = "unnamedplus";
		colorschemes.catppuccin.enable = true;
		plugins = {
			bufferline.enable = true;
			cmp.enable = true;
			gitsigns.enable = true;
			lsp.enable = true;
			lualine.enable = true;
			lualine.globalstatus = true;
			markdown-preview.enable = true;
			neo-tree.enable = true;
			neocord.enable = true; # This is so funny
			nix.enable = true;
			obsidian.enable = true;
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
