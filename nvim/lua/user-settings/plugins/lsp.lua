return {
    {
        "williamboman/mason.nvim",
        config = function()
            require("mason").setup({
                ui = {
                    icons = {
                        package_installed = "✓",
                        package_pending = "➜",
                        package_uninstalled = "✗"
                    }
                }
            })
        end,
    },

    {
        "williamboman/mason-lspconfig.nvim",
        dependencies = { "williamboman/mason.nvim" },
        config = function()
            require("mason-lspconfig").setup({
                ensure_installed = {
                    "intelephense",
                    "ts_ls",
                    "volar",
                    "cssls",
                    "html",
                    "jsonls",
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

            -- Atalhos ativados quando LSP conecta em um buffer
            vim.api.nvim_create_autocmd("LspAttach", {
                callback = function(event)
                    local map = vim.keymap.set
                    local opts = { buffer = event.buf }

                    map("n", "gd", vim.lsp.buf.definition, vim.tbl_extend("force", opts, { desc = "Ir para definição" }))
                    map("n", "gr", vim.lsp.buf.references, vim.tbl_extend("force", opts, { desc = "Ver referências" }))
                    map("n", "K", vim.lsp.buf.hover, vim.tbl_extend("force", opts, { desc = "Documentação hover" }))
                    map("n", "<leader>rn", vim.lsp.buf.rename, vim.tbl_extend("force", opts, { desc = "Renomear símbolo" }))
                    map("n", "<leader>ca", vim.lsp.buf.code_action, vim.tbl_extend("force", opts, { desc = "Code actions" }))
                    map("n", "<leader>e", vim.diagnostic.open_float, vim.tbl_extend("force", opts, { desc = "Ver diagnóstico" }))
                end,
            })

            -- Configuração dos servidores via nova API
            local servers = { "intelephense", "ts_ls", "volar", "cssls", "html", "jsonls" }
            for _, server in ipairs(servers) do
                vim.lsp.config(server, { capabilities = capabilities })
            end

            vim.lsp.enable(servers)
        end,
    },
}
