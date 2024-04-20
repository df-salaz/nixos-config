return {
	"tpope/vim-commentary",
	config = function ()
		vim.keymap.set('n', '<C-/>', '<Plug>CommentaryLine', {})
		vim.keymap.set('i', '<C-/>', '<C-[><Plug>CommentaryLine', {})
		vim.keymap.set('v', '<C-/>', '<Plug>Commentary', {})
	end
}

