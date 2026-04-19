return {
    'nvim-treesitter/nvim-treesitter',
    branch = 'main',
    build = ':TSUpdate',
    init = function()
        local ensure_installed = { 'lua', 'php', 'javascript', 'typescript', 'html', 'css', 'vue' }
        local already_installed = require('nvim-treesitter.config').get_installed()
        local to_install = vim.iter(ensure_installed)
            :filter(function(p) return not vim.tbl_contains(already_installed, p) end)
            :totable()
        require('nvim-treesitter').install(to_install)
    end,
    opts = {
        highlight = { enable = true },
        indent    = { enable = true },
    },
}
