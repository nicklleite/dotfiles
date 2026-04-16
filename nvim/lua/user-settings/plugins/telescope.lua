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
					file_ignore_patterns = {
						"node_modules/",
						"%.git/",
						"vendor/",
						"storage/logs/",
						"tmux/plugins/",
						"go/",
					},
					layout_strategy = "horizontal",
					sorting_strategy = "ascending",
					layout_config = {
						prompt_position = "bottom",
					},
					preview = {
						treesitter = false,
					},
				},
				extensions = {
					file_browser = {
						hijack_netrw = true,
						hidden = true,
						grouped = true,
						respect_gitignore = true,
					},
				},
			})

			telescope.load_extension("fzf")

			local function project_root()
				local root = vim.fn.systemlist("git -C " .. vim.fn.getcwd() .. " rev-parse --show-toplevel")[1]
				if vim.v.shell_error ~= 0 then
					return vim.fn.getcwd()
				end
				return root
			end

			local map = vim.keymap.set

			map("n", "<C-p>", function()
				builtin.find_files({
					cwd = project_root(),
					hidden = true,
					find_command = { "fd", "--type", "f", "--hidden", "--exclude", ".git" },
				})
			end, { desc = "Find files in project" })

			map("n", "<leader>fg", function()
				builtin.live_grep({
					cwd = project_root(),
					additional_args = { "--hidden" },
				})
			end, { desc = "Search content in project" })

			map("n", "<leader>fb", builtin.buffers, { desc = "List open buffers" })

			-- File browser na raiz do projeto
			map("n", "<leader>fe", function()
				telescope.extensions.file_browser.file_browser({ cwd = project_root() })
			end, { desc = "File browser" })
		end,
	},
}
