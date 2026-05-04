local map = vim.api.nvim_set_keymap

-- Set <Space> as leader key
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Disable the spacebar key's default behavior in Normal and Visual modes
vim.keymap.set({ "n", "v" }, "<Space>", "<Nop>", { silent = true })
vim.keymap.set({ "n", "v" }, "G", "G$", { desc = "Go to end of file (last line, end of line)" })
vim.keymap.set("n", "<leader>Q", function()
    vim.cmd("silent! wa")
    vim.cmd("qa")
end, { desc = "Save and quit all!" })

vim.keymap.set("n", "-", function()
    local current = vim.api.nvim_buf_get_name(0)
    if vim.startswith(current, "oil://") then
        return
    end
    local dir = vim.fn.expand("%:p:h")
    vim.cmd("edit oil://" .. dir)
end, { desc = "Open file browser" })

-- 1) Normal mode
map("n", "<leader>w", ":w<CR>", { desc = "Save file" })

vim.keymap.set("n", "<leader>q", function()
    local current = vim.api.nvim_get_current_buf()
    local current_name = vim.api.nvim_buf_get_name(current)

    if vim.startswith(current_name, "oil://") then
        vim.cmd("bd")
        return
    end

    local remaining = vim.tbl_filter(function(b)
        local name = vim.api.nvim_buf_get_name(b)
        return vim.bo[b].buflisted
            and b ~= current
            and not vim.startswith(name, "oil://")
    end, vim.api.nvim_list_bufs())

    vim.cmd("bd")

    if #remaining == 0 then
        vim.cmd("edit oil://" .. vim.fn.getcwd())
    end
end, { desc = "Close buffer" })

map("n", "<leader>L", ":Lazy<CR>", { desc = "Opens the Lazy window" })
map("n", "<S-Tab>", "<<", { desc = "Unindent line (normal mode)" })
map("n", "<C-h>", "<C-w>h", { desc = "Focus on the left split" })
map("n", "<C-l>", "<C-w>l", { desc = "Focus on the right split" })
map("n", "<C-j>", "<C-w>j", { desc = "Focus on the bottom split" })
map("n", "<C-k>", "<C-w>k", { desc = "Focus on the top split" })
map("n", "<leader>dl", ":t.<CR>", { desc = "Duplicate current line" })
map("n", "<leader>-", "za", { desc = "Toggle folding block" })
map("n", "<leader>=", "zR", { desc = "Opens all folds" })
map("n", "<leader>0", "zM", { desc = "Closes all folds" })

-- 1.1) Regex macros
map("n", "<leader>rel", ":s/\\r//ge<CR>", { desc = "Removes any occurrence of '\r' on files" })
map("v", "<leader>rms", ":s/^\\s\\+//<CR>", { desc = "Remove indentation in selection" })
map("v", "<leader>rmc", ":s/,$//<CR>", { desc = "Remove comma at the end of each line in selection" })
vim.keymap.set("v", "<leader>sc", function()
    vim.cmd('normal! "zy')
    local text = vim.fn.getreg("z")

    local accents = {
        ["á"] = "a",
        ["à"] = "a",
        ["ã"] = "a",
        ["â"] = "a",
        ["ä"] = "a",
        ["é"] = "e",
        ["è"] = "e",
        ["ê"] = "e",
        ["ë"] = "e",
        ["í"] = "i",
        ["ì"] = "i",
        ["î"] = "i",
        ["ï"] = "i",
        ["ó"] = "o",
        ["ò"] = "o",
        ["õ"] = "o",
        ["ô"] = "o",
        ["ö"] = "o",
        ["ú"] = "u",
        ["ù"] = "u",
        ["û"] = "u",
        ["ü"] = "u",
        ["ç"] = "c",
        ["ñ"] = "n",
        ["Á"] = "a",
        ["À"] = "a",
        ["Ã"] = "a",
        ["Â"] = "a",
        ["Ä"] = "a",
        ["É"] = "e",
        ["È"] = "e",
        ["Ê"] = "e",
        ["Ë"] = "e",
        ["Í"] = "i",
        ["Ì"] = "i",
        ["Î"] = "i",
        ["Ï"] = "i",
        ["Ó"] = "o",
        ["Ò"] = "o",
        ["Õ"] = "o",
        ["Ô"] = "o",
        ["Ö"] = "o",
        ["Ú"] = "u",
        ["Ù"] = "u",
        ["Û"] = "u",
        ["Ü"] = "u",
        ["Ç"] = "c",
        ["Ñ"] = "n",
    }

    for accent, replacement in pairs(accents) do
        text = text:gsub(accent, replacement)
    end

    text = text:lower()
    text = text:gsub("[ -]", "_")

    vim.fn.setreg("z", text)
    vim.cmd('normal! gv"zp')
end, { desc = "Convert selection to snake_case" })

-- 2) Insert mode
map("i", "jk", "<Esc>", { desc = "Exit insert mode using 'jk'" })
map("i", "<C-s>", "<Esc>:w<CR>a", { desc = "Save file without leaving insert mode" })

-- 3) Visual mode
map("v", "<S-Tab>", "<gv", { desc = "Unindent selection (visual mode)" })

-- 4) Visual block mode
map("x", "J", ":move '>+1<CR>gv-gv", { desc = "Move selection down" })
map("x", "K", ":move '<-2<CR>gv-gv", { desc = "Move selection up" })

-- 5) Navigation
map("n", "<C-d>", "<C-d>zz", { desc = "Page down and center cursor" })
map("n", "<C-u>", "<C-u>zz", { desc = "Page up and center cursor" })

-- 6) File navigation
map("n", "gg", "gg0", { desc = "Go to start of file (line 1, column 0)" })
map("n", "G", "G$", { desc = "Go to end of file (last line, end of line)" })
