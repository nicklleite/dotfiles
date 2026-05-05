return {
	{
		"nvim-telescope/telescope.nvim",
		tag = "0.1.8",
		dependencies = {
			"nvim-lua/plenary.nvim",
			{
				"nvim-telescope/telescope-fzf-native.nvim",
				build = "make",
			},
		},
		config = function()
			local telescope = require("telescope")
			local builtin = require("telescope.builtin")

			telescope.setup({
				defaults = {
					initial_mode = "normal",
					layout_strategy = "horizontal",
					sorting_strategy = "ascending",
					layout_config = {
						prompt_position = "bottom",
					},
					preview = {
						treesitter = false,
					},
				},
			})

			telescope.load_extension("fzf")

			local default_excludes = {
				".git",
				"node_modules",
				"vendor",
				"storage/logs",
				".cache",
				".local",
				"firefox",
				"spotify",
				"tmux/plugins",
				"go/pkg",
				"pulse",
				"pulsewire",
				"wireplumber",
				"composer",
				"gtk-3.0",
				"ibus",
				"dconf",
			}

			local default_exclude_globs = {
				"*lock*",
				"*.lock",
				"*-lock.*",
			}

			local function fd_exclude_args()
				local args = { "fd", "--type", "f", "--hidden" }
				for _, dir in ipairs(default_excludes) do
					table.insert(args, "--exclude")
					table.insert(args, dir)
				end
				for _, glob in ipairs(default_exclude_globs) do
					table.insert(args, "--exclude")
					table.insert(args, glob)
				end
				return args
			end

			local function rg_exclude_args()
				local args = { "--hidden" }
				for _, dir in ipairs(default_excludes) do
					table.insert(args, "--glob")
					table.insert(args, "!" .. dir)
				end
				for _, glob in ipairs(default_exclude_globs) do
					table.insert(args, "--glob")
					table.insert(args, "!" .. glob)
				end
				return args
			end

			local map = vim.keymap.set

			map("n", "<C-p>", function()
				builtin.find_files({
					cwd = vim.g.root_dir,
					hidden = true,
					find_command = fd_exclude_args(),
				})
			end, { desc = "Find files in project" })

			map("n", "<leader>fg", function()
				builtin.live_grep({
					cwd = vim.g.root_dir,
					additional_args = rg_exclude_args(),
				})
			end, { desc = "Search content in project" })

			map("n", "<leader>fb", builtin.buffers, { desc = "List open buffers" })
		end,
	},
}
