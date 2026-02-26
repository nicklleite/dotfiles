return {
	{
		"windwp/nvim-ts-autotag",
		event = { "BufReadPre", "BufNewFile" },
		config = function()
			require("nvim-ts-autotag").setup({
				opts = {
					enable_close = true, -- auto close tag
					enable_rename = true, -- rename closing tag when opening tag is renamed
					enable_close_on_slash = false, -- don't close on />
				},
				per_filetype = {
					["html"] = { enable_close = true },
					["vue"] = { enable_close = true },
					["blade"] = { enable_close = true },
					["jsx"] = { enable_close = true },
					["tsx"] = { enable_close = true },
				},
			})
		end,
	},
}
