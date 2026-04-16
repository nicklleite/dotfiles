return {
	{
		"williamboman/mason.nvim",
		config = function()
			require("mason").setup({
				ui = {
					icons = {
						package_installed = "✓",
						package_pending = "➜",
						package_uninstalled = "✗",
					},
				},
			})
		end,
	},
	{
		"williamboman/mason-lspconfig.nvim",
		dependencies = { "williamboman/mason.nvim" },
		config = function()
			require("mason-lspconfig").setup({
				ensure_installed = {
					"intelephense", -- PHP / Laravel
					"ts_ls", -- JavaScript / TypeScript
					"vue_ls", -- Vue.js
					"cssls", -- CSS
					"html", -- HTML
					"jsonls", -- JSON
					"emmet_language_server", -- Emmet
					"lua_ls", -- Lua
				},
				automatic_installation = true,
			})
		end,
	},
	{
		"neovim/nvim-lspconfig",
		dependencies = { "williamboman/mason-lspconfig.nvim" },
		config = function()
			local capabilities = require("cmp_nvim_lsp").default_capabilities()

			vim.api.nvim_create_autocmd("LspAttach", {
				callback = function(event)
					local map = vim.keymap.set
					local opts = { buffer = event.buf }

					map("n", "gd", vim.lsp.buf.definition, vim.tbl_extend("force", opts, { desc = "Go to definition" }))
					map("n", "gr", vim.lsp.buf.references, vim.tbl_extend("force", opts, { desc = "Show references" }))
					map("n", "K", vim.lsp.buf.hover, vim.tbl_extend("force", opts, { desc = "Hover documentation" }))
					map(
						"n",
						"<leader>rn",
						vim.lsp.buf.rename,
						vim.tbl_extend("force", opts, { desc = "Rename symbol" })
					)
					map(
						"n",
						"<leader>ca",
						vim.lsp.buf.code_action,
						vim.tbl_extend("force", opts, { desc = "Code actions" })
					)
					map(
						"n",
						"<leader>e",
						vim.diagnostic.open_float,
						vim.tbl_extend("force", opts, { desc = "Show diagnostic" })
					)
					map(
						"n",
						"[d",
						vim.diagnostic.goto_prev,
						vim.tbl_extend("force", opts, { desc = "Previous diagnostic" })
					)
					map(
						"n",
						"]d",
						vim.diagnostic.goto_next,
						vim.tbl_extend("force", opts, { desc = "Next diagnostic" })
					)
				end,
			})

			-- Servidores simples
			local servers = { "intelephense", "cssls", "html", "jsonls", "emmet_language_server" }
			for _, server in ipairs(servers) do
				vim.lsp.config(server, { capabilities = capabilities })
			end

			-- lua_ls com globals do Neovim e diagnósticos ajustados
			vim.lsp.config("lua_ls", {
				capabilities = capabilities,
				settings = {
					Lua = {
						diagnostics = {
							globals = { "vim", "Snacks" },
							disable = { "different-requires", "undefined-doc-name", "undefined-global" },
						},
						runtime = {
							version = "LuaJIT",
						},
						workspace = {
							checkThirdParty = false,
						},
						hint = { enable = false },
					},
				},
			})

			-- ts_ls com suporte a Vue
			vim.lsp.config("ts_ls", {
				capabilities = capabilities,
				init_options = {
					plugins = {
						{
							name = "@vue/typescript-plugin",
							location = vim.fn.stdpath("data")
								.. "/mason/packages/vue-language-server/node_modules/@vue/language-server",
							languages = { "vue" },
						},
					},
				},
				filetypes = { "typescript", "javascript", "javascriptreact", "typescriptreact", "vue" },
			})

			-- vue_ls
			vim.lsp.config("vue_ls", {
				capabilities = capabilities,
			})

			-- Codebook: spell check apenas em arquivos de texto
			vim.lsp.config("codebook", {
				capabilities = capabilities,
				filetypes = { "markdown", "text", "gitcommit" },
			})

			vim.lsp.enable({
				"intelephense",
				"cssls",
				"html",
				"jsonls",
				"ts_ls",
				"vue_ls",
				"emmet_language_server",
				"lua_ls",
				"codebook",
			})
		end,
	},
}
