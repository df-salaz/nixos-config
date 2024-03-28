return {
	'akinsho/bufferline.nvim',
	version = "*",
	dependencies = 'nvim-tree/nvim-web-devicons',
	config = function ()
		vim.opt.termguicolors = true
		require("bufferline").setup{
			options = {
				diagnostics = "nvim_lsp",
				-- separator_style = "slope",
				middle_mouse_command = "bdelete! %d",
				show_buffer_close_icons = false
			}
		}
	end
}
