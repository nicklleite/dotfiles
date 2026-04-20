return {
	"stevearc/oil.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	config = function()
		require("oil").setup({
			default_file_explorer = true,
			-- demais opções que você já tiver...
		})
	end,
	init = function()
		-- Abre o oil ao iniciar o neovim sem argumentos
		vim.api.nvim_create_autocmd("VimEnter", {
			callback = function()
				if vim.fn.argc() == 0 then
					require("oil").open()
				end
			end,
		})

		-- Abre o oil ao fechar o último buffer
		vim.api.nvim_create_autocmd("BufDelete", {
			callback = function(event)
				local buffers = vim.tbl_filter(function(b)
					return vim.bo[b].buflisted and b ~= event.buf
				end, vim.api.nvim_list_bufs())

				if #buffers == 0 then
					require("oil").open()
				end
			end,
		})
	end,
}
