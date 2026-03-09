return {
	{
		"folke/which-key.nvim",
		event = "VeryLazy",
		config = function()
			local wk = require("which-key")

			wk.setup({
				delay = 500, -- tempo em ms para o popup aparecer
				preset = "modern", -- visual moderno
				icons = {
					rules = false, -- não usa ícones por regra, mantém simples
				},
			})

			-- Documenta os grupos de atalhos do leader
			wk.add({
				{ "<leader>f", group = "Find (Telescope)" },
				{ "<leader>h", group = "Git (Gitsigns)" },
				{ "<leader>r", group = "Refactor / Replace" },
				{ "<leader>x", group = "Emmet" },
				{ "<leader>s", group = "Misc" },
				{ "g", group = "Go to / LSP" },
				{ "[", group = "Previous" },
				{ "]", group = "Next" },
			})
		end,
	},
}
