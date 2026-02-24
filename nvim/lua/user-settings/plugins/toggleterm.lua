return {
	"akinsho/toggleterm.nvim",
	version = "*",
	config = function()
		require("toggleterm").setup({
			size = function(term)
				if term.direction == "horizontal" then
					return 15
				elseif term.direction == "vertical" then
					return vim.o.columns * 0.4
				end
			end,
			open_mapping = [[<C-'>]],
			direction = "horizontal",
			shade_terminals = true,
			shading_factor = 2,
			start_insert = true,
			persist_size = true,
			close_on_exit = true,
			scroll_speed = 2,
		})

		local map = vim.keymap.set

		map("n", "<leader>tf", "<cmd>ToggleTerm direction=float<CR>", { desc = "Open floating terminal" })
		map("n", "<leader>th", "<cmd>ToggleTerm direction=horizontal<CR>", { desc = "Open horizontal terminal" })
		map("n", "<leader>tv", "<cmd>ToggleTerm direction=vertical<CR>", { desc = "Open vertical terminal" })

		-- Exit insert mode in terminal without closing it
		function _G.set_terminal_keymaps()
			local opts = { buffer = 0 }
			vim.keymap.set("t", "<Esc>", [[<C-\><C-n>]], opts)
			vim.keymap.set("t", "jk", [[<C-\><C-n>]], opts)
			-- Switch to normal mode when scrolling up with mouse
			vim.keymap.set("t", "<ScrollWheelUp>", [[<C-\><C-n><ScrollWheelUp>]], opts)
		end

		vim.api.nvim_create_autocmd("TermOpen", {
			pattern = "term://*toggleterm#*",
			callback = function()
				_G.set_terminal_keymaps()
			end,
		})
	end,
}
