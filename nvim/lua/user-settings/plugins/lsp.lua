return {
    -- Gerenciador de servidores LSP
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

    -- Ponte entre Mason e lspconfig
    {
        "williamboman/mason-lspconfig.nvim",
        dependencies = { "williamboman/mason.nvim" },
        config = function()
            require("mason-lspconfig").setup({
                ensure_installed = {
                    "intelephense",
                    "ts_ls",
                    "vue_ls",
                    "cssls",
                    "html",
                    "jsonls",
                },
                automatic_installation = true,
            })
        end,
    },

    -- Configuração dos servidores LSP
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
                    map("n", "[d", vim.diagnostic.goto_prev, vim.tbl_extend("force", opts, { desc = "Diagnóstico anterior" }))
                    map("n", "]d", vim.diagnostic.goto_next, vim.tbl_extend("force", opts, { desc = "Próximo diagnóstico" }))
                end,
            })

            -- Servidores simples
            local servers = { "intelephense", "cssls", "html", "jsonls" }
            for _, server in ipairs(servers) do
                vim.lsp.config(server, { capabilities = capabilities })
            end

            -- ts_ls com suporte a Vue
            vim.lsp.config("ts_ls", {
                capabilities = capabilities,
                init_options = {
                    plugins = {
                        {
                            name = "@vue/typescript-plugin",
                            location = vim.fn.stdpath("data") .. "/mason/packages/vue-language-server/node_modules/@vue/language-server",
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

            vim.lsp.enable({ "intelephense", "cssls", "html", "jsonls", "ts_ls", "vue_ls" })
        end,
    },
}
