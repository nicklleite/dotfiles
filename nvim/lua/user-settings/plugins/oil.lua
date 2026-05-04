function _G.get_oil_winbar()
    local bufnr = vim.api.nvim_win_get_buf(vim.g.statusline_winid)
    local dir = require("oil").get_current_dir(bufnr)
    if dir then
        return vim.fn.fnamemodify(dir, ":~")
    else
        return vim.api.nvim_buf_get_name(0)
    end
end

local default_ignores = {
    "%.git$",
    "node_modules",
    "vendor",
    "storage/logs",
    "%.cache",
    "%.local",
    "firefox",
    "spotify",
    "tmux/plugins",
    "go/pkg",
    "pulse",
    "pulsewire",
    "wireplumber",
    "composer",
    "gtk%-3%.0",
    "ibus",
    "dconf",
    ".*lock.*",
    ".*%.lock$",
    ".*%-lock%..*",
}

local function get_gitignore_patterns()
    local gitignore = vim.g.root_dir .. "/.gitignore"
    local patterns = {}
    local f = io.open(gitignore, "r")
    if not f then return patterns end
    for line in f:lines() do
        if line ~= "" and not line:match("^#") then
            local pattern = line:gsub("/$", ""):gsub("%.", "%%."):gsub("%*", ".*")
            table.insert(patterns, pattern)
        end
    end
    f:close()
    return patterns
end

local function build_ignore_patterns()
    local patterns = {}
    for _, p in ipairs(default_ignores) do
        table.insert(patterns, p)
    end
    for _, p in ipairs(get_gitignore_patterns()) do
        table.insert(patterns, p)
    end
    return patterns
end

return {
    "stevearc/oil.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
        local ignore_patterns = build_ignore_patterns()

        require("oil").setup({
            win_options = {
                winbar = "%!v:lua.get_oil_winbar()",
            },
            default_file_explorer = true,
            view_options = {
                show_hidden = true,
                is_always_hidden = function(name, _)
                    for _, pattern in ipairs(ignore_patterns) do
                        if name:match(pattern) then
                            return true
                        end
                    end
                    return false
                end,
            },
            keymaps = {
                ["-"] = false,
                ["<BS>"] = {
                    callback = function()
                        local current = require("oil").get_current_dir()
                        if not current then return end
                        local root = vim.g.root_dir .. "/"
                        if current == root or current == vim.g.root_dir then
                            return
                        end
                        require("oil").open(vim.fn.fnamemodify(current:gsub("/$", ""), ":h"))
                    end,
                    desc = "Go to parent (limited to root)",
                },
            },
            float = {
                padding = 2,
            },
        })
    end,
}
