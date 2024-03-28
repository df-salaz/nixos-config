return {
	"akinsho/toggleterm.nvim",
	config = function ()
		require("toggleterm").setup{
			shade_terminals = true
		}
		vim.keymap.set("n","<C-t>", vim.cmd.ToggleTerm, {noremap = true, silent = true})

		vim.api.nvim_create_autocmd({"BufEnter", "BufWinEnter"}, {
			pattern = {"*toggleterm*"},
			command = "setlocal nospell",
		})
	end
}
