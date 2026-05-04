vim.g.root_dir = vim.fn.getcwd()

require("user-settings.options")
require("user-settings.keymaps")
require("user-settings.plugins") -- this one is always last!!

vim.g.loaded_node_provider = 0
vim.g.loaded_perl_provider = 0
vim.g.loaded_ruby_provider = 0
