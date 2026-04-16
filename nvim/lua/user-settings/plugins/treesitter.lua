-- lua/user-settings/plugins/treesitter.lua

return {
	{
		"nvim-treesitter/nvim-treesitter",
		lazy = false,
		build = ":TSUpdate",
		config = function()
			require("nvim-treesitter").install({
				"php",
				"javascript",
				"typescript",
				"vue",
				"html",
				"css",
				"scss",
				"json",
				"lua",
				"bash",
				"markdown",
			})

			vim.api.nvim_create_autocmd("FileType", {
				pattern = "*",
				callback = function()
					pcall(vim.treesitter.start)
				end,
			})
		end,
	},
}
