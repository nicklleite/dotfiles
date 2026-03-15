return {
	"yetone/avante.nvim",
	event = "VeryLazy",
	lazy = false,
	version = false, -- nunca use "*" aqui
	build = "make",

	keys = {
		{ "<leader>aa", "<cmd>AvanteAsk<cr>", desc = "Avante Ask", mode = "n" },
		{ "<leader>ae", "<cmd>AvanteEdit<cr>", desc = "Avante Edit", mode = "v" },
		{ "<leader>at", "<cmd>AvanteToggle<cr>", desc = "Avante Toggle", mode = "n" },
		{ "<leader>ar", "<cmd>AvanteRefresh<cr>", desc = "Avante Refresh", mode = "n" },
		{ "<leader>af", "<cmd>AvanteFocus<cr>", desc = "Avante Focus", mode = "n" },
	},

	opts = {
		-- Provider padrão: Ollama local
		provider = "ollama",

		providers = {
			ollama = {
				-- IMPORTANTE: sem /v1 no final (mudança recente da API)
				endpoint = "http://127.0.0.1:11434",
				model = "qwen2.5-coder:14b",
				extra_request_body = {
					options = {
						num_ctx = 8192,
						temperature = 0.1,
					},
				},
				timeout = 60000, -- 60s para modelos maiores
			},

			-- Provider cloud como fallback (opcional)
			-- Alterne com :AvanteProvider claude
			claude = {
				endpoint = "https://api.anthropic.com",
				model = "claude-sonnet-4-20250514",
				api_key_name = "ANTHROPIC_API_KEY",
				timeout = 30000,
			},
		},

		behaviour = {
			auto_suggestions = false,
			auto_set_keymaps = false,
			auto_apply_diff_after_generation = false,
		},

		-- Integração com Telescope
		file_selector = {
			provider = "telescope",
		},
	},

	dependencies = {
		"nvim-lua/plenary.nvim",
		"MunifTanjim/nui.nvim",
		"nvim-tree/nvim-web-devicons",

		-- Telescope para seleção de arquivos de contexto
		"nvim-telescope/telescope.nvim",

		-- Renderização de markdown no painel do avante
		{
			"MeanderingProgrammer/render-markdown.nvim",
			opts = {
				file_types = { "markdown", "Avante" },
			},
			ft = { "markdown", "Avante" },
		},

		-- Suporte a colar imagens (útil para compartilhar erros)
		{
			"HakonHarnes/img-clip.nvim",
			event = "VeryLazy",
			opts = {
				default = {
					embed_image_as_base64 = false,
					prompt_for_file_name = false,
					drag_and_drop = { insert_mode = true },
				},
			},
		},
	},
}
