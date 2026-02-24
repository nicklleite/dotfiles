return {
	{
		"lewis6991/gitsigns.nvim",
		config = function()
			require("gitsigns").setup({
				signs = {
					add = { text = "▎" },
					change = { text = "▎" },
					delete = { text = "▁" },
					topdelete = { text = "▔" },
					changedelete = { text = "▎" },
					untracked = { text = "▎" },
				},

				-- Inline blame at the end of the line (like GitLens in VS Code)
				current_line_blame = true,
				current_line_blame_opts = {
					delay = 500,
				},

				on_attach = function(bufnr)
					local gs = require("gitsigns")
					local map = vim.keymap.set
					local opts = { buffer = bufnr }

					-- Navigate between hunks
					map("n", "]h", gs.next_hunk, vim.tbl_extend("force", opts, { desc = "Next hunk" }))
					map("n", "[h", gs.prev_hunk, vim.tbl_extend("force", opts, { desc = "Previous hunk" }))

					-- Stage / unstage
					map("n", "<leader>hs", gs.stage_hunk, vim.tbl_extend("force", opts, { desc = "Stage hunk" }))
					map("n", "<leader>hu", gs.undo_stage_hunk, vim.tbl_extend("force", opts, { desc = "Unstage hunk" }))
					map(
						"n",
						"<leader>hS",
						gs.stage_buffer,
						vim.tbl_extend("force", opts, { desc = "Stage entire buffer" })
					)

					-- Reset
					map("n", "<leader>hr", gs.reset_hunk, vim.tbl_extend("force", opts, { desc = "Reset hunk" }))
					map(
						"n",
						"<leader>hR",
						gs.reset_buffer,
						vim.tbl_extend("force", opts, { desc = "Reset entire buffer" })
					)

					-- Preview hunk
					map("n", "<leader>hp", gs.preview_hunk, vim.tbl_extend("force", opts, { desc = "Preview hunk" }))

					-- Blame
					map(
						"n",
						"<leader>hb",
						gs.blame_line,
						vim.tbl_extend("force", opts, { desc = "Blame current line" })
					)
					map(
						"n",
						"<leader>hB",
						gs.toggle_current_line_blame,
						vim.tbl_extend("force", opts, { desc = "Toggle inline blame" })
					)

					-- Diff
					map("n", "<leader>hd", gs.diffthis, vim.tbl_extend("force", opts, { desc = "Diff current file" }))
				end,
			})
		end,
	},
}
