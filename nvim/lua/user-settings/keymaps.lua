local map = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }

-- Set <Space> as leader key
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Disable the spacebar key's default behavior in Normal and Visual modes
vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })

-- 1) Normal mode
map("n", "<leader>w", ":w<CR>", { desc = "Save file" })
map("n", "<leader>q", ":q<CR>", { desc = "Quit nvim" })
map("n", "<leader>Q", ":wqa<CR>", { desc = "Save and quit all" })
-- map("n", "<leader>wq", ":wq<CR>", { desc = "Save and quit" })
map("n", "<leader>L", ":Lazy<CR>", { desc = "Opens the Lazy window" })
map("n", "<S-Tab>", "<<", { desc = "Unindent line (normal mode)" })
map("n", "<C-h>", "<C-w>h", { desc = "Focus on the left split" })
map("n", "<C-l>", "<C-w>l", { desc = "Focus on the right split" })
map("n", "<C-j>", "<C-w>j", { desc = "Focus on the bottom split" })
map("n", "<C-k>", "<C-w>k", { desc = "Focus on the top split" })

-- 1.1) Regex macros
map("n", "<leader>rel", ":s/\\r//ge<CR>", { desc = "Removes any occurrence of '\r' on files" })
map("v", "<leader>rms",  ":s/^\\s\\+//<CR>", { desc = "Remove indentation in selection" })
map("v", "<leader>rmc", ":s/,$//<CR>", { desc = "Remove comma at the end of each line in selection" })

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

map("n", "\\", ":Neotree toggle<CR>", { desc = "Open file browser" })
