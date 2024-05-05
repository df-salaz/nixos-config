return {
	"preservim/vim-markdown",
	config = function ()
		vim.g.tex_conceal = ""
		vim.g.vim_markdown_math = 1
		vim.g.vim_markdown_strikethrough = 1
		vim.g.vim_markdown_conceal_code_blocks = 0
		vim.g.vim_markdown_edit_url_in = 'tab'
	end
}
