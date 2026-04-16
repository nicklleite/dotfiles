return {
	{
		"folke/tokyonight.nvim",
		priority = 1000,
		config = function()
			require("tokyonight").setup({
				style = "night",
				transparent = false,
				terminal_colors = true,
				styles = {
					comments = { italic = true },
					keywords = { italic = true },
					functions = {},
					variables = {},
				},
				integrations = {
					treesitter = true,
					telescope = true,
					neotree = true,
					cmp = true,
					native_lsp = {
						enabled = true,
					},
				},
			})

			vim.cmd.colorscheme("tokyonight-night")
		end,
	},
}
