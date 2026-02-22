# Neovim Setup Summary

This document summarizes all key configurations and shortcuts used in your Neovim setup, structured using `init.lua` and modular files under `lua/user-settings`.

---

## File Structure

```
~/.config/nvim/
├── init.lua
└── lua/
    └── user-settings/
        ├── options.lua
        ├── keymaps.lua
        ├── commands.lua
        ├── plugins.lua
        └── plugins/
            ├── neotree.lua
            └── toggleterm.lua
```

---

## init.lua

```lua
require("user-settings.options")   -- core options should come first
require("user-settings.keymaps")   -- key mappings next, they rely on options sometimes
require("user-settings.commands")  -- autocmds or custom commands
require("user-settings.plugins")   -- plugin manager and plugin configs come last
```

---

## options.lua

```lua
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
opt.number = true               -- show the absolute line number on the current line
opt.relativenumber = true       -- show relative line numbers on the other lines
```

---

## Keymaps

### Normal Mode

| Shortcut         | Description                                      |
|------------------|--------------------------------------------------|
| `<leader>w`      | Save file                                        |
| `<leader>q`      | Quit Neovim                                      |
| `<leader>Q`      | Save all and quit (closes everything at once)    |
| `<leader>L`      | Open the Lazy plugin window                      |
| `<S-Tab>`        | Unindent current line                            |
| `<leader>rel`    | Remove all `^M` (`\r`) characters on current line |
| `<C-d>`          | Page down and center the cursor                  |
| `<C-u>`          | Page up and center the cursor                    |
| `gg`             | Go to first line and first column                |
| `G`              | Go to last line and end of line                  |
| `\`              | Toggle Neotree file browser                      |

---

### Window Navigation

| Action                | Shortcut   |
|-----------------------|------------|
| Focus left split      | `<C-h>`    |
| Focus right split     | `<C-l>`    |
| Focus bottom split    | `<C-j>`    |
| Focus top split       | `<C-k>`    |

> Use `<C-h>` and `<C-l>` to switch focus between Neotree and the open file quickly.

---

### Regex Macros (Normal / Visual)

| Shortcut         | Mode   | Description                                      |
|------------------|--------|--------------------------------------------------|
| `<leader>rel`    | Normal | Remove `\r` occurrences on current line          |
| `<leader>rms`    | Visual | Remove leading whitespace from selected lines    |
| `<leader>rmc`    | Visual | Remove trailing comma from selected lines        |

---

### Insert Mode

| Shortcut   | Description                               |
|------------|-------------------------------------------|
| `jk`       | Exit insert mode                          |
| `<C-s>`    | Save file without leaving insert mode     |

---

### Visual Mode

| Shortcut   | Description                     |
|------------|---------------------------------|
| `<S-Tab>`  | Unindent selected block         |

---

### Visual Block Mode

| Shortcut   | Description                     |
|------------|---------------------------------|
| `J`        | Move selection down one line    |
| `K`        | Move selection up one line      |

---

## commands.lua

```lua
local api = vim.api

-- Auto-remove Windows-style carriage return characters (^M) on file read
api.nvim_create_autocmd("BufReadPost", {
  pattern = "*",
  callback = function()
    vim.cmd([[%s/\r//ge]])
  end,
})
```

---

## plugins.lua (Lazy Plugin Manager)

```lua
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
  local out = vim.fn.system { 'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath }
  if vim.v.shell_error ~= 0 then
    error('Error cloning lazy.nvim:\n' .. out)
  end
end
vim.opt.rtp:prepend(lazypath)

require('lazy').setup({
    require('user-settings.plugins.neotree'),
    require('user-settings.plugins.toggleterm'),
})
```

---

## Plugins

### Neotree
File explorer sidebar. Toggle with `\`.

### Toggleterm
Integrated terminal, similar to VS Code's built-in terminal.

| Shortcut      | Description             |
|---------------|-------------------------|
| `<C-\>`       | Toggle terminal (horizontal) |
| `<leader>tf`  | Open floating terminal  |
| `<leader>th`  | Open horizontal terminal |
| `<leader>tv`  | Open vertical terminal  |
| `Esc` / `jk`  | Exit terminal insert mode (without closing) |

> Tip: prefix the toggle with a number to open multiple terminal instances, e.g. `2<C-\>` opens terminal #2. Useful to run a dev server in one and git commands in another.

---

## Useful Neovim Shortcuts

| Action                      | Shortcut                        |
|-----------------------------|---------------------------------|
| Save (Normal mode)          | `<leader>w`                     |
| Save (Insert mode)          | `<C-s>`                         |
| Quit current window         | `<leader>q`                     |
| Save all and quit           | `<leader>Q`                     |
| Undo                        | `u`                             |
| Redo                        | `<C-r>`                         |
| Go to beginning of file     | `gg`                            |
| Go to end of file           | `G`                             |
| Go to end of line           | `$`                             |
| Start visual block mode     | `<C-v>`                         |
| Move block up/down          | `J / K` in visual block         |
| Toggle Neotree              | `\`                             |
| Search forward              | `/text`                         |
| Search backward             | `?text`                         |
| Next search result          | `n`                             |
| Previous search result      | `N`                             |
| Search word under cursor    | `*` (forward) / `#` (backward)  |

---

## Notes

- `gg` goes to the first line and first column; `G` goes to the last line and end of line.
- The `jk` mapping in insert mode allows quick escape without reaching for `<Esc>`.
- Line ending cleanup (`\r`) happens automatically on file read via `commands.lua`.
- Use `<C-h>` / `<C-l>` to switch focus between Neotree and your file without closing anything.
- `<leader>Q` closes all splits and the terminal at once — no need to close each window individually.
