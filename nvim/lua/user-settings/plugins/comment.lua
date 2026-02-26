return {
	{
		"numToStr/Comment.nvim",
		event = { "BufReadPre", "BufNewFile" },
		dependencies = {
			"JoosepAlviste/nvim-ts-context-commentstring",
		},
		config = function()
			local comment = require("Comment")
			local ts_context = require("ts_context_commentstring.integrations.comment_nvim")

			comment.setup({
				padding = true,
				sticky = true,
				toggler = {
					line = "gcc", -- toggle entire line
					block = "gbc", -- toggle block
				},
				opleader = {
					line = "gc", -- comment selection (visual mode)
					block = "gb", -- comment block (visual mode)
				},
				-- Detects the correct comment type based on cursor position (essential for .vue files)
				pre_hook = ts_context.create_pre_hook(),
			})

			require("ts_context_commentstring").setup({
				enable_autocmd = false,
			})
		end,
	},
}
