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
wk.add({
  { "<leader>t", group = "Tests" },
  { "<leader>tl", "<cmd>lua require'david_tests'.run_line()<CR>", desc = "Run tests for line" },
  { "<leader>tt", "<cmd>lua require'david_tests'.run_file()<CR>", desc = "Run tests for file" },
  { "<leader>ty", "<cmd>lua require'david_tests'.run_last()<CR>", desc = "Run last test" },
})

-- Close other buffers
vim.keymap.set("n", "<leader>bo", ":%bd|e#|bd#<CR>|'", { desc = "Delete other buffers", silent = true })

-- Close all buffers
vim.keymap.set("n", "<leader>ba", ":%bd<CR>|'", { desc = "Delete all buffers", silent = true })
