local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	local lazyrepo = "https://github.com/folke/lazy.nvim.git"
	local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
	if vim.v.shell_error ~= 0 then
		vim.api.nvim_echo({
			{ "Failed to clone lazy.nvim:\n", "ErrorMsg" },
			{ out, "WarningMsg" },
			{ "\nPress any key to exit..." },
		}, true, {})
		vim.fn.getchar()
		os.exit(1)
	end
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
	require("user-settings.plugins.colorscheme"), -- primeiro sempre
	require("user-settings.plugins.treesitter"), -- antes do LSP e comment
	require("user-settings.plugins.lsp"), -- antes do cmp
	require("user-settings.plugins.cmp"), -- depois do lsp
    require("user-settings.plugins.oil"),
	require("user-settings.plugins.conform"),
	require("user-settings.plugins.comment"),
	require("user-settings.plugins.telescope"),
	require("user-settings.plugins.lualine"),
	require("user-settings.plugins.visual-multi"),
	require("user-settings.plugins.indent-blankline"),
	require("user-settings.plugins.autopairs"),
	require("user-settings.plugins.snacks"),
	require("user-settings.plugins.gitsigns"),
})
