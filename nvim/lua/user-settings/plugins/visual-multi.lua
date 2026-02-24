return {
	{
		"mg979/vim-visual-multi",
		branch = "master",
		init = function()
			vim.g.VM_maps = {
				["Find Under"] = "<C-d>", -- select next occurrence (like Ctrl+D in VS Code)
				["Find Subword Under"] = "<C-d>",
				["Select All"] = "<leader>A", -- select all occurrences
				["Skip Region"] = "<C-x>", -- skip current occurrence (like VS Code)
			}
		end,
	},
}
