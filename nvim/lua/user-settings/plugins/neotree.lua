return {
	"nvim-neo-tree/neo-tree.nvim",
	branch = "v3.x",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-tree/nvim-web-devicons",
		"MunifTanjim/nui.nvim",
	},
	config = function()
		require("neo-tree").setup({
			close_if_last_window = false, -- não fecha o nvim se o neotree for o último split
			popup_border_style = "rounded",
			enable_git_status = true,
			enable_diagnostics = true, -- mostra erros do LSP na árvore

			filesystem = {
				filtered_items = {
					visible = true,
					hide_dotfiles = false,
					hide_gitignored = true,
				},
				follow_current_file = {
					enabled = true, -- destaca o arquivo aberto na árvore
				},
				use_libuv_file_watcher = true, -- atualiza a árvore automaticamente
			},

			window = {
				position = "left",
				width = 30,
				mappings = {
					["<space>"] = "toggle_node",
					["<cr>"] = "open",
					["S"] = "open_split",
					["s"] = "open_vsplit",
					["C"] = "close_node",
					["R"] = "refresh",
					["a"] = "add", -- criar arquivo (pasta com / no final)
					["d"] = "delete", -- deletar arquivo/pasta
					["r"] = "rename", -- renomear
					["y"] = "copy_to_clipboard",
					["x"] = "cut_to_clipboard",
					["p"] = "paste_from_clipboard",
					["?"] = "show_help",
				},
			},

			event_handlers = {
				-- Fecha o Neotree ao abrir um arquivo
				{
					event = "file_opened",
					handler = function()
						require("neo-tree.command").execute({ action = "close" })
					end,
				},
			},
		})

		-- Reabre o Neotree quando o último buffer de arquivo é fechado
		vim.api.nvim_create_autocmd("BufDelete", {
			callback = function()
				vim.schedule(function()
					local buffers = vim.tbl_filter(function(buf)
						return vim.bo[buf].buflisted
							and vim.bo[buf].buftype == ""
							and vim.api.nvim_buf_get_name(buf) ~= ""
							and buf ~= vim.api.nvim_get_current_buf()
					end, vim.api.nvim_list_bufs())

					if #buffers == 0 then
						vim.cmd("Neotree show")
					end
				end)
			end,
		})
	end,
}
