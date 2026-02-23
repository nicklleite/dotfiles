return {
    {
        "catppuccin/nvim",
        name = "catppuccin",
        priority = 1000,    -- carrega antes de qualquer outro plugin
        config = function()
            require("catppuccin").setup({
                flavour = "mocha",  -- latte, frappe, macchiato, mocha
                integrations = {
                    treesitter = true,
                    native_lsp = {
                        enabled = true,
                    },
                    telescope = { enabled = true },
                    neotree = true,
                    cmp = true,
                },
            })

            vim.cmd.colorscheme("catppuccin")
        end,
    }
}
