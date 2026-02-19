return {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-tree/nvim-web-devicons", -- opcional, mas recomendado
        "MunifTanjim/nui.nvim",
    },
    config = function()
        require("neo-tree").setup({
            filesystem = {
                filtered_items = {
                    visible = true,
                    hide_dotfiles = false,
                    hide_gitignored = true,
                },
            },
            window = {
                position = "left",
                width = 30,
                mappings = {
                  ["<space>"] = "toggle_node",
                  ["<cr>"] = "open",
                  ["S"] = "open_split",
                  ["s"] = "open_vsplit",
                  ["C"] = "close_node",
                  ["R"] = "refresh",
                },
            },
        })
    end
}

