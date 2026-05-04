return {
    "stevearc/oil.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
        require("oil").setup({
            default_file_explorer = true,
            view_options = {
                show_hidden = true,
            },
            keymaps = {
                ["-"] = false
            },
            float = {
                padding = 2
            },
        })

        -- vim.api.nvim_create_autocmd("VimEnter", {
        --     once = true,
        --     callback = function()
        --         if vim.fn.argc() == 0 then
        --             vim.defer_fn(function()
        --                 vim.cmd("edit oil://" .. vim.fn.getcwd())
        --             end, 50)
        --         end
        --     end,
        -- })
    end,
}
