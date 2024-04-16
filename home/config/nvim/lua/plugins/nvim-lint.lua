return {
	"mfussenegger/nvim-lint",
	config = function ()
		require('lint').linters_by_ft = {
			zsh = {"zsh"},
			sh = {"zsh"},
			-- text = {"languagetool","typos"},
			-- tex = {"typos", "languagetool"},
			-- markdown = {"typos"}
		}
		vim.api.nvim_create_autocmd({ "InsertLeave", "BufWritePost" }, {
			callback = function()
				local lint_status, lint = pcall(require, "lint")
				if lint_status then
					lint.try_lint()
				end
			end,
		})
	end
}
