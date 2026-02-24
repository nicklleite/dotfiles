local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	local lazyrepo = "https://github.com/folke/lazy.nvim.git"
	local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
	if vim.v.shell_error ~= 0 then
		error("Error cloning lazy.nvim:\n" .. out)
	end
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
	require("user-settings.plugins.colorscheme"),
	require("user-settings.plugins.neotree"),
	require("user-settings.plugins.toggleterm"),
	require("user-settings.plugins.telescope"),
	require("user-settings.plugins.lsp"),
	require("user-settings.plugins.cmp"),
	require("user-settings.plugins.treesitter"),
	require("user-settings.plugins.conform"),
	require("user-settings.plugins.gitsigns"),
	require("user-settings.plugins.lualine"),
	require("user-settings.plugins.visual-multi"),
	require("user-settings.plugins.indent-blankline"),
	require("user-settings.plugins.autopairs"),
})
