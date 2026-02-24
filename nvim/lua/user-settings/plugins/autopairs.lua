return {
	{
		"windwp/nvim-autopairs",
		event = "InsertEnter",
		config = function()
			local autopairs = require("nvim-autopairs")
			local cmp_autopairs = require("nvim-autopairs.completion.cmp")
			local cmp = require("cmp")

			autopairs.setup({
				check_ts = true, -- usa treesitter pra contexto mais inteligente
				ts_config = {
					lua = { "string" }, -- não fecha pares dentro de strings lua
					php = { "string" },
					javascript = { "template_string" },
				},
				disable_filetype = { "neo-tree", "TelescopePrompt" },
				fast_wrap = {
					map = "<M-e>", -- Alt+e envolve a palavra com o par
					chars = { "{", "[", "(", '"', "'" },
					pattern = [=[[%'%"%>%]%)%}%,]]=],
					end_key = "$",
					keys = "qwertyuiopzxcvbnmasdfghjkl",
					check_comma = true,
					highlight = "PmenuSel",
					highlight_grey = "LineNr",
				},
			})

			-- Integração com nvim-cmp (confirma par ao aceitar sugestão)
			cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
		end,
	},
}
