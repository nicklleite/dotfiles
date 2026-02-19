-- user-settings/options.lua

local opt = vim.opt

-- General
opt.number = true               -- show line numbers
opt.relativenumber = true       -- show relative line numbers
opt.cursorline = true           -- highlight current line
opt.termguicolors = true        -- enable true colors
opt.clipboard = "unnamedplus"   -- use system clipboard
opt.swapfile = false            -- disable swap files
opt.mouse = "a"                 -- enable mouse mode (default: '')

-- Indentation
opt.tabstop = 4                 -- number of spaces for a tab
opt.shiftwidth = 4              -- number of spaces for autoindent
opt.expandtab = true            -- convert tabs to spaces
opt.smartindent = true          -- smart autoindent
opt.autoindent = true           -- keeps the indentation from previous line

-- Search
opt.ignorecase = true           -- ignore case in search
opt.smartcase = true            -- override ignorecase if uppercase present
opt.hlsearch = false            -- don't highlight search by default
opt.incsearch = true            -- show search matches as you type

-- Splits
opt.splitbelow = true           -- horizontal splits below
opt.splitright = true           -- vertical splits to the right

-- Scrolling
opt.scrolloff = 8               -- minimal lines above/below cursor
opt.signcolumn = "yes"          -- always show sign column

-- Performance
opt.timeoutlen = 300            -- faster mapping timeout

-- Text files
opt.wrap = true                 -- wrap long lines
opt.linebreak = true            -- wrap lines at word boundaries

-- Encoding
opt.encoding = "utf-8"
opt.fileencoding = "utf-8"

-- Line numbers
opt.number = true            	-- show the absolute line number on the current line
opt.relativenumber = true    	-- show relative line numbers on the other lines
