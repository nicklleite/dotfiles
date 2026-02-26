-- ╔══════════════════════════════════════════════════════╗
-- ║           snacks.nvim - Catppuccin Mocha             ║
-- ╚══════════════════════════════════════════════════════╝

return {
	"folke/snacks.nvim",
	priority = 1000,
	lazy = false,

	---@type snacks.Config
	opts = {

		-- ── Dashboard ────────────────────────────────────────────────────────
		dashboard = {
			enabled = true,
			width = 60,
			row = nil,
			col = nil,
			pane_gap = 4,
			autokeys = "1234567890abcdefghijklmnopqrstuvwxyz",

			preset = {
				keys = {
					{ icon = " ", key = "n", desc = "Novo arquivo", action = ":ene | startinsert" },
					{ icon = " ", key = "f", desc = "Buscar arquivo", action = ":Telescope find_files" },
					{ icon = "󰊄 ", key = "g", desc = "Live Grep", action = ":Telescope live_grep" },
					{ icon = " ", key = "r", desc = "Recentes", action = ":Telescope oldfiles" },
					{
						icon = " ",
						key = "s",
						desc = "Restaurar sessão",
						action = ":lua require('persistence').load()",
						enabled = pcall(require, "persistence"),
					},
					{
						icon = "󰒲 ",
						key = "l",
						desc = "Lazy",
						action = ":Lazy",
						enabled = package.loaded.lazy ~= nil,
					},
					{ icon = " ", key = "m", desc = "Mason", action = ":Mason" },
					{ icon = " ", key = "q", desc = "Sair", action = ":qa" },
				},

				header = [[
███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗
████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║
██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║
██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║
██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║
╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝]],
			},

			sections = {
				{ section = "header" },
				{
					padding = 1,
					section = "keys",
					gap = 1,
					indent = 2,
				},
				{
					section = "recent_files",
					title = "  Recentes",
					indent = 2,
					padding = 1,
					limit = 8,
				},
				{
					section = "projects",
					title = "  Projetos",
					indent = 2,
					padding = 1,
					limit = 5,
				},
				{ section = "startup" },
			},
		},

		-- ── Notifier ─────────────────────────────────────────────────────────
		notifier = {
			enabled = true,
			timeout = 3000,
			style = "fancy", -- "compact" | "fancy" | "minimal"
			top_down = true,
		},

		-- ── Scroll suave ──────────────────────────────────────────────────────
		scroll = {
			enabled = true,
			animate = {
				duration = { step = 15, total = 250 },
				easing = "linear",
			},
		},

		-- ── Word highlights ───────────────────────────────────────────────────
		words = { enabled = true },

		-- ── Status column ─────────────────────────────────────────────────────
		statuscolumn = {
			enabled = true,
			left = { "mark", "sign" },
			right = { "fold", "git" },
			folds = { open = false, git_hl = true },
			git = { patterns = { "GitSign" } },
		},

		-- ── Input flutuante ───────────────────────────────────────────────────
		input = { enabled = true },

		-- ── BigFile ───────────────────────────────────────────────────────────
		bigfile = { enabled = true },

		-- ── Quickfile ─────────────────────────────────────────────────────────
		quickfile = { enabled = true },

		-- ── Lazygit flutuante ─────────────────────────────────────────────────
		lazygit = {
			enabled = true,
			configure = true,
		},

		-- ── Terminal flutuante ────────────────────────────────────────────────
		terminal = {
			enabled = true,
			win = {
				style = "terminal",
				position = "float",
				border = "rounded",
				width = 0.8,
				height = 0.8,
			},
		},

		-- ── Estilos globais (Catppuccin Mocha) ────────────────────────────────
		styles = {
			float = {
				border = "rounded",
				backdrop = 60,
				wo = { winblend = 5 },
			},
			notification = {
				border = "rounded",
				wo = { winblend = 5 },
			},
		},
	},

	-- ── Keymaps ───────────────────────────────────────────────────────────────
	keys = {
		-- Dashboard
		{
			"<leader>.",
			function()
				Snacks.dashboard()
			end,
			desc = "Dashboard",
		},

		-- Git com Lazygit
		{
			"<leader>gg",
			function()
				Snacks.lazygit()
			end,
			desc = "Lazygit",
		},
		{
			"<leader>gf",
			function()
				Snacks.lazygit.log_file()
			end,
			desc = "Log do Arquivo (Git)",
		},
		{
			"<leader>gl",
			function()
				Snacks.lazygit.log()
			end,
			desc = "Log Git",
		},

		-- Terminal
		{
			"<leader>tt",
			function()
				Snacks.terminal()
			end,
			desc = "Terminal Flutuante",
		},
		{
			"<C-\\>",
			function()
				Snacks.terminal()
			end,
			desc = "Terminal Flutuante",
			mode = { "n", "t" },
		},

		-- Notificações
		{
			"<leader>nd",
			function()
				Snacks.notifier.hide()
			end,
			desc = "Fechar Notificações",
		},
		{
			"<leader>nh",
			function()
				Snacks.notifier.show_history()
			end,
			desc = "Histórico de Notificações",
		},

		-- Utilitários
		{
			"<leader>bd",
			function()
				Snacks.bufdelete()
			end,
			desc = "Deletar Buffer",
		},
		{
			"<leader>cR",
			function()
				Snacks.rename.rename_file()
			end,
			desc = "Renomear Arquivo",
		},
		{
			"]]",
			function()
				Snacks.words.jump(vim.v.count1)
			end,
			desc = "Próxima Referência",
			mode = { "n", "t" },
		},
		{
			"[[",
			function()
				Snacks.words.jump(-vim.v.count1)
			end,
			desc = "Referência Anterior",
			mode = { "n", "t" },
		},
	},

	-- ── Autocmds ──────────────────────────────────────────────────────────────
	init = function()
		vim.api.nvim_create_autocmd("User", {
			pattern = "VeryLazy",
			callback = function()
				Snacks.toggle.diagnostics():map("<leader>ud")
				Snacks.toggle.line_number():map("<leader>ul")
				Snacks.toggle.treesitter():map("<leader>uT")
				Snacks.toggle.inlay_hints():map("<leader>uh")
				Snacks.toggle.dim():map("<leader>uD")
				Snacks.toggle.scroll():map("<leader>uS")
				Snacks.toggle.words():map("<leader>uW")
			end,
		})
	end,
}
