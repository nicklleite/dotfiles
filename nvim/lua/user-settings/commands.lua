local api = vim.api

-- Auto-remove Windows-style carriage return characters (^M) on file read
api.nvim_create_autocmd("BufReadPost", {
  pattern = "*",
  callback = function()
    vim.cmd([[%s/\r//ge]])
  end,
})
