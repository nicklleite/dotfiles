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
					-- Layout
					layout_strategy = "horizontal",
					layout_config = {
						horizontal = {
							preview_width = 0.6,
						},
					},

					-- Ignorar apenas o necessário
					file_ignore_patterns = {
						"^.git/",
						"node_modules/",
						"%.jpg",
						"%.jpeg",
						"%.png",
						"%.svg",
						"%.otf",
						"%.ttf",
					},

					-- Preview
					preview = {
						treesitter = false,
					},
				},

				pickers = {
					find_files = {
						hidden = true,
						find_command = {
							"rg",
							"--files",
							"--hidden",
							"--glob",
							"!**/.git/*",
						},
						-- Prompt customizado
						prompt_prefix = "> ",
						selection_caret = "➜ ",
					},

					live_grep = {
						additional_args = function()
							return { "--hidden" }
						end,
					},
				},
			})
			telescope.load_extension("fzf")

			-- Retorna a raiz do projeto Git, ou cwd como fallback
			local function project_root()
				local root = vim.fn.systemlist("git -C " .. vim.fn.expand("%:p:h") .. " rev-parse --show-toplevel")[1]
				if vim.v.shell_error ~= 0 then
					return vim.fn.getcwd()
				end
				return root
			end

			local map = vim.keymap.set

			-- Ctrl+P para abrir arquivos (igual VS Code)
			map("n", "<C-p>", function()
				builtin.find_files({ cwd = project_root() })
			end, { desc = "Buscar arquivos no projeto" })

			-- <leader>fg para buscar conteúdo dentro dos arquivos
			map("n", "<leader>fg", function()
				builtin.live_grep({ cwd = project_root() })
			end, { desc = "Buscar conteúdo no projeto" })

			-- <leader>fb para listar buffers abertos
			map("n", "<leader>fb", builtin.buffers, { desc = "Listar buffers" })

			-- <leader>fh para buscar na ajuda do nvim
			map("n", "<leader>fh", builtin.help_tags, { desc = "Buscar na ajuda" })
		end,
	},
}
