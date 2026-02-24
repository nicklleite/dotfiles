return {
	{
		"numToStr/Comment.nvim",
		event = { "BufReadPre", "BufNewFile" },
		config = function()
			require("Comment").setup({
				-- Adiciona espaço entre o delimitador e o texto
				padding = true,
				-- Mantém o cursor na posição ao comentar
				sticky = true,
				toggler = {
					line = "gcc", -- toggle linha inteira
					block = "gbc", -- toggle bloco
				},
				opleader = {
					line = "gc", -- comentar seleção (visual mode)
					block = "gb", -- comentar bloco (visual mode)
				},
			})
		end,
	},
}
