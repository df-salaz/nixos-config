return {
	"windwp/nvim-autopairs",
	event = "InsertEnter",
	config = function ()
		require("nvim-autopairs").setup{}

		local npairs = require'nvim-autopairs'
		local Rule = require'nvim-autopairs.rule'
		local cond = require 'nvim-autopairs.conds'
		npairs.add_rules({
			Rule("$", "$",{"tex", "latex"})
				:with_pair(cond.not_after_regex("%%"))
				:with_move(),
			Rule("then", "end", "lua")
				:with_move(),
		})
	end
}
