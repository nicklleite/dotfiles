-- telescope.lua
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
                    layout_strategy = "horizontal",
                    sorting_strategy = "ascending",
                    layout_config = {
                        prompt_position = "bottom",
                    },
                    preview = {
                        treesitter = false,
                    },
                },
            })

            telescope.load_extension("fzf")

            local map = vim.keymap.set

            map("n", "<C-p>", function()
                builtin.find_files({
                    cwd = vim.fn.getcwd(),
                    hidden = true,
                    find_command = {
                        "fd", "--type", "f", "--hidden",
                        "--exclude", ".git",
                        "--exclude", "node_modules",
                        "--exclude", "vendor",
                        "--exclude", "storage/logs",
                    },
                })
            end, { desc = "Find files in project" })

            map("n", "<leader>fg", function()
                builtin.live_grep({
                    cwd = vim.fn.getcwd(),
                    additional_args = {
                        "--hidden",
                        "--glob", "!.git",
                        "--glob", "!node_modules",
                        "--glob", "!vendor",
                        "--glob", "!storage/logs",
                    },
                })
            end, { desc = "Search content in project" })

            map("n", "<leader>fb", builtin.buffers, { desc = "List open buffers" })
        end,
    },
}
