return {
    "akinsho/toggleterm.nvim",
    version = "*",
    config = function()
        require("toggleterm").setup({
            size = function(term)
                if term.direction == "horizontal" then
                    return 15
                elseif term.direction == "vertical" then
                    return vim.o.columns * 0.4
                end
            end,
            open_mapping = [[<C-'>]],   -- Ctrl+` igual ao VS Code
            direction = "horizontal",   -- abre embaixo por padrão
            shade_terminals = true,
            shading_factor = 2,
            start_insert = true,        -- já entra em insert mode no terminal
            persist_size = true,
            close_on_exit = true,
        })

        -- Atalhos extras
        local map = vim.keymap.set

        -- Ctrl+` para toggle (já definido acima via open_mapping)
        -- Terminal flutuante com <leader>tf
        map("n", "<leader>tf", "<cmd>ToggleTerm direction=float<CR>", { desc = "Terminal flutuante" })
        -- Terminal horizontal com <leader>th
        map("n", "<leader>th", "<cmd>ToggleTerm direction=horizontal<CR>", { desc = "Terminal horizontal" })
        -- Terminal vertical com <leader>tv
        map("n", "<leader>tv", "<cmd>ToggleTerm direction=vertical<CR>", { desc = "Terminal vertical" })

        -- Escapar do modo insert no terminal com Esc ou jk (sem fechar)
        function _G.set_terminal_keymaps()
            local opts = { buffer = 0 }
            vim.keymap.set("t", "<Esc>", [[<C-\><C-n>]], opts)
            vim.keymap.set("t", "jk", [[<C-\><C-n>]], opts)
        end

        vim.cmd("autocmd! TermOpen term://* lua set_terminal_keymaps()")
    end,
}
