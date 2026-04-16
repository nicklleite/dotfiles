return {
	{
		"stevearc/oil.nvim",
		dependencies = {
			"nvim-tree/nvim-web-devicons",
			"refractalize/oil-git-status.nvim",
		},
		config = function()
			require("oil").setup({
				columns = { "icon", "git_status" },
				keymaps = {
					["<C-h>"] = false,
					["<M-h>"] = "actions.select_split",
				},
				view_options = {
					show_hidden = true,
				},
				git = {
					enabled = true,
					timeout = 500,
				},
				win_options = {
					signcolumn = "yes:2",
				},
			})

			require("oil-git-status").setup()

			-- Open parent directory in current window
			vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })

			-- Open parent directory in floating window
			vim.keymap.set("n", "<space>-", require("oil").toggle_float)
		end,
	},
}
