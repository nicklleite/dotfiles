return {
    {
        "nvim-treesitter/nvim-treesitter",
        lazy = false,
        build = ":TSUpdate",
        config = function()
            -- Instala os parsers (assíncrono, roda na inicialização)
            require("nvim-treesitter").install({
                "php",
                "javascript",
                "typescript",
                "vue",
                "html",
                "css",
                "json",
                "lua",
                "bash",
                "markdown",
            })

            -- Ativa o highlight ao abrir qualquer arquivo
            vim.api.nvim_create_autocmd("FileType", {
                pattern = "*",
                callback = function()
                    pcall(vim.treesitter.start)
                end,
            })
        end,
    }
}
