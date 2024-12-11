-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")
require("helpers/auto_inject_to_yard")

vim.cmd(":Copilot disable")

-- Prevent deleting from also copying
vim.keymap.set({'n', 'v'}, 'd', '"_d', { noremap = true })
vim.keymap.set({'n', 'v'}, 'D', '"_D', { noremap = true })
vim.keymap.set('n', 'dd', '"_dd', { noremap = true })
vim.keymap.set({'n', 'v'}, 'p', 'P', { noremap = true })
vim.keymap.set({'n', 'v'}, 'c', '"_c', { noremap = true })
vim.keymap.set({'n', 'v'}, 'c', '"_c', { noremap = true })
vim.keymap.set({'n', 'v'}, '<Del>', '"_x', { noremap = true })
