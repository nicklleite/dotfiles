return {
    {
        "hrsh7th/nvim-cmp",
        dependencies = {
            "hrsh7th/cmp-nvim-lsp",     -- source: LSP
            "hrsh7th/cmp-buffer",        -- source: palavras do buffer atual
            "hrsh7th/cmp-path",          -- source: caminhos de arquivo
            "L3MON4D3/LuaSnip",          -- engine de snippets
            "saadparwaiz1/cmp_luasnip",  -- integra LuaSnip com cmp
            "rafamadriz/friendly-snippets", -- coleção de snippets prontos
        },
        config = function()
            local cmp = require("cmp")
            local luasnip = require("luasnip")

            -- Carrega snippets prontos (Laravel, JS, Vue, etc.)
            require("luasnip.loaders.from_vscode").lazy_load()

            cmp.setup({
                snippet = {
                    expand = function(args)
                        luasnip.lsp_expand(args.body)
                    end,
                },
                mapping = cmp.mapping.preset.insert({
                    ["<C-Space>"] = cmp.mapping.complete(),       -- forçar sugestões
                    ["<CR>"]      = cmp.mapping.confirm({ select = true }), -- confirmar
                    ["<Tab>"]     = cmp.mapping(function(fallback)  -- navegar sugestões
                        if cmp.visible() then
                            cmp.select_next_item()
                        elseif luasnip.expand_or_jumpable() then
                            luasnip.expand_or_jump()
                        else
                            fallback()
                        end
                    end, { "i", "s" }),
                    ["<S-Tab>"]   = cmp.mapping(function(fallback)
                        if cmp.visible() then
                            cmp.select_prev_item()
                        elseif luasnip.jumpable(-1) then
                            luasnip.jump(-1)
                        else
                            fallback()
                        end
                    end, { "i", "s" }),
                    ["<C-e>"]     = cmp.mapping.abort(),           -- fechar sugestões
                }),
                sources = cmp.config.sources({
                    { name = "nvim_lsp" },  -- maior prioridade: LSP
                    { name = "luasnip" },   -- snippets
                    { name = "buffer" },    -- palavras do buffer
                    { name = "path" },      -- caminhos de arquivo
                }),
            })
        end,
    }
}
