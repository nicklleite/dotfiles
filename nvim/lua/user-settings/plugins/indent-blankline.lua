return {
	{
		"lukas-reineke/indent-blankline.nvim",
		main = "ibl",
		event = { "BufReadPre", "BufNewFile" },
		config = function()
			require("ibl").setup({
				indent = {
					char = "│", -- caractere da linha guia
				},
				scope = {
					enabled = true, -- destaca o bloco atual
					show_start = false, -- não mostra marcador no início do bloco
					show_end = false, -- não mostra marcador no fim do bloco
				},
				exclude = {
					filetypes = {
						"help",
						"neo-tree",
						"Trouble",
						"lazy",
						"mason",
						"toggleterm",
					},
				},
			})
		end,
	},
}
