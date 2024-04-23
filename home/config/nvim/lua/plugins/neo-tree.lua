return {
	"nvim-neo-tree/neo-tree.nvim",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
		"MunifTanjim/nui.nvim",
	},
	config = function ()
		vim.keymap.set("n", "<leader>i", "<cmd>Neotree show filesystem reveal left<CR>",
		{ desc = "Toggle Outline" })
	end
}
