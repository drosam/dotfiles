-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
vim.keymap.set(
  "n",
  "<leader>fp",
  ":let @+=expand('%')<CR>",
  { desc = "Copy current file path (relative)", silent = true }
)

-- Run tests
local wk = require("which-key")
wk.register({
  t = {
    name = "Tests",
    t = { "<cmd>lua require'david_tests'.run_file()<CR>", "Run tests for file" },
    l = { "<cmd>lua require'david_tests'.run_line()<CR>", "Run tests for line" },
    y = { "<cmd>lua require'david_tests'.run_last()<CR>", "Run last test" },
  },
}, { prefix = "<leader>" })

-- Close other buffers
vim.keymap.set(
  "n",
  "<leader>bo",
  ":%bd|e#|bd#<CR>|'",
  { desc = "Delete other buffers", silent = true }
)

-- Close all buffers
vim.keymap.set(
  "n",
  "<leader>ba",
  ":%bd<CR>|'",
  { desc = "Delete all buffers", silent = true }
)

