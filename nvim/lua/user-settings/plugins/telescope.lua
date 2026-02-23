return {
    {
        "nvim-telescope/telescope.nvim",
        tag = "0.1.8",
        dependencies = {
            "nvim-lua/plenary.nvim",
            {
                "nvim-telescope/telescope-fzf-native.nvim",
                build = "make",
            },
        },
        config = function()
            local telescope = require("telescope")
            local builtin = require("telescope.builtin")

            telescope.setup({
                defaults = {
                    file_ignore_patterns = {
                        "node_modules", ".git", "vendor", "storage/logs"
                    },
                    layout_strategy = "horizontal",
                    sorting_strategy = "ascending",
                    layout_config = {
                        prompt_position = "top",
                    },
                    preview = {
                        treesitter = false
                    },
                },
            })

            telescope.load_extension("fzf")

            -- Retorna a raiz do projeto Git, ou cwd como fallback
            local function project_root()
                local root = vim.fn.systemlist("git -C " .. vim.fn.expand("%:p:h") .. " rev-parse --show-toplevel")[1]
                if vim.v.shell_error ~= 0 then
                    return vim.fn.getcwd()
                end
                return root
            end

            local map = vim.keymap.set

            -- Ctrl+P para abrir arquivos (igual VS Code)
            map("n", "<C-p>", function()
                builtin.find_files({ cwd = project_root() })
            end, { desc = "Buscar arquivos no projeto" })

            -- <leader>fg para buscar conteúdo dentro dos arquivos
            map("n", "<leader>fg", function()
                builtin.live_grep({ cwd = project_root() })
            end, { desc = "Buscar conteúdo no projeto" })

            -- <leader>fb para listar buffers abertos
            map("n", "<leader>fb", builtin.buffers, { desc = "Listar buffers" })

            -- <leader>fh para buscar na ajuda do nvim
            map("n", "<leader>fh", builtin.help_tags, { desc = "Buscar na ajuda" })
        end,
    }
}
