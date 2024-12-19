local set = vim.keymap.set

-- save file
set({ "i", "x", "n", "s" }, "<C-s>", "<cmd>w<cr><esc>", { desc = "Save File" })

-- Prevent deleting from also copying
set({'n', 'v'}, 'd', '"_d', { noremap = true })
set({'n', 'v'}, 'D', '"_D', { noremap = true })
set('n', 'dd', '"_dd', { noremap = true })
set({'n', 'v'}, 'p', 'P', { noremap = true })
set({'n', 'v'}, 'c', '"_c', { noremap = true })
set({'n', 'v'}, 'c', '"_c', { noremap = true })
set({'n', 'v'}, '<Del>', '"_x', { noremap = true })

-- Close other buffers
set("n", "<leader>bo", ":%bd|e#|bd#<CR>|'", { desc = "Delete other buffers", silent = true })

-- Close all buffers
set("n", "<leader>ba", ":%bd<CR>|'", { desc = "Delete all buffers", silent = true })

-- better up/down
set({ "n", "x" }, "j", "v:count == 0 ? 'gj' : 'j'", { desc = "Down", expr = true, silent = true })
set({ "n", "x" }, "<Down>", "v:count == 0 ? 'gj' : 'j'", { desc = "Down", expr = true, silent = true })
set({ "n", "x" }, "k", "v:count == 0 ? 'gk' : 'k'", { desc = "Up", expr = true, silent = true })
set({ "n", "x" }, "<Up>", "v:count == 0 ? 'gk' : 'k'", { desc = "Up", expr = true, silent = true })

-- Move to window using the <ctrl> hjkl keys
set("n", "<C-h>", "<C-w>h", { desc = "Go to Left Window", remap = true })
set("n", "<C-j>", "<C-w>j", { desc = "Go to Lower Window", remap = true })
set("n", "<C-k>", "<C-w>k", { desc = "Go to Upper Window", remap = true })
set("n", "<C-l>", "<C-w>l", { desc = "Go to Right Window", remap = true })

-- Resize window using <ctrl> arrow keys
set("n", "<C-Up>", "<cmd>resize +2<cr>", { desc = "Increase Window Height" })
set("n", "<C-Down>", "<cmd>resize -2<cr>", { desc = "Decrease Window Height" })
set("n", "<C-Left>", "<cmd>vertical resize -2<cr>", { desc = "Decrease Window Width" })
set("n", "<C-Right>", "<cmd>vertical resize +2<cr>", { desc = "Increase Window Width" })

-- Move Lines
set("n", "<A-j>", "<cmd>execute 'move .+' . v:count1<cr>==", { desc = "Move Down" })
set("n", "<A-k>", "<cmd>execute 'move .-' . (v:count1 + 1)<cr>==", { desc = "Move Up" })
set("i", "<A-j>", "<esc><cmd>m .+1<cr>==gi", { desc = "Move Down" })
set("i", "<A-k>", "<esc><cmd>m .-2<cr>==gi", { desc = "Move Up" })
set("v", "<A-j>", ":<C-u>execute \"'<,'>move '>+\" . v:count1<cr>gv=gv", { desc = "Move Down" })
set("v", "<A-k>", ":<C-u>execute \"'<,'>move '<-\" . (v:count1 + 1)<cr>gv=gv", { desc = "Move Up" })

-- buffers
set("n", "<S-h>", "<cmd>bprevious<cr>", { desc = "Prev Buffer" })
set("n", "<S-l>", "<cmd>bnext<cr>", { desc = "Next Buffer" })
set("n", "[b", "<cmd>bprevious<cr>", { desc = "Prev Buffer" })
set("n", "]b", "<cmd>bnext<cr>", { desc = "Next Buffer" })
set("n", "<leader>bb", "<cmd>e #<cr>", { desc = "Switch to Other Buffer" })
set("n", "<leader>`", "<cmd>e #<cr>", { desc = "Switch to Other Buffer" })
set("n", "<leader>bd", function()
  Snacks.bufdelete()
end, { desc = "Delete Buffer" })
set("n", "<leader>bo", function()
  Snacks.bufdelete.other()
end, { desc = "Delete Other Buffers" })
set("n", "<leader>bD", "<cmd>:bd<cr>", { desc = "Delete Buffer and Window" })

-- https://github.com/mhinz/vim-galore#saner-behavior-of-n-and-n
set("n", "n", "'Nn'[v:searchforward].'zv'", { expr = true, desc = "Next Search Result" })
set("x", "n", "'Nn'[v:searchforward]", { expr = true, desc = "Next Search Result" })
set("o", "n", "'Nn'[v:searchforward]", { expr = true, desc = "Next Search Result" })
set("n", "N", "'nN'[v:searchforward].'zv'", { expr = true, desc = "Prev Search Result" })
set("x", "N", "'nN'[v:searchforward]", { expr = true, desc = "Prev Search Result" })
set("o", "N", "'nN'[v:searchforward]", { expr = true, desc = "Prev Search Result" })

-- better indenting
set("v", "<", "<gv")
set("v", ">", ">gv")

-- new file
set("n", "<leader>fn", "<cmd>enew<cr>", { desc = "New File" })

-- Cupy current relative path (relative)
set(
  "n",
  "<leader>fp",
  ":let @+=expand('%')<CR>",
  { desc = "Copy current file path (relative)", silent = true }
)

-- diagnostic
local diagnostic_goto = function(next, severity)
  local go = next and vim.diagnostic.goto_next or vim.diagnostic.goto_prev
  severity = severity and vim.diagnostic.severity[severity] or nil
  return function()
    go({ severity = severity })
  end
end
set("n", "<leader>cd", vim.diagnostic.open_float, { desc = "Line Diagnostics" })
set("n", "]d", diagnostic_goto(true), { desc = "Next Diagnostic" })
set("n", "[d", diagnostic_goto(false), { desc = "Prev Diagnostic" })
set("n", "]e", diagnostic_goto(true, "ERROR"), { desc = "Next Error" })
set("n", "[e", diagnostic_goto(false, "ERROR"), { desc = "Prev Error" })
set("n", "]w", diagnostic_goto(true, "WARN"), { desc = "Next Warning" })
set("n", "[w", diagnostic_goto(false, "WARN"), { desc = "Prev Warning" })

-- lazygit
set("n", "<leader>gg", function() Snacks.lazygit() end, { desc = "Lazygit" })
set("n", "<leader>gf", function() Snacks.lazygit.log_file() end, { desc = "Lazygit Current File History" })
set("n", "<leader>gl", function() Snacks.lazygit.log() end, { desc = "Lazygit Log" })
set("n", "<leader>gb", function() Snacks.git.blame_line() end, { desc = "Git Blame Line" })
set({ "n", "x" }, "<leader>gB", function() Snacks.gitbrowse() end, { desc = "Git Browse (open)" })

-- quit
set("n", "<leader>qq", "<cmd>qa<cr>", { desc = "Quit All" })

-- windows
set("n", "<leader>w", "<c-w>", { desc = "Windows", remap = true })
set("n", "<leader>-", "<C-W>s", { desc = "Split Window Below", remap = true })
set("n", "<leader>|", "<C-W>v", { desc = "Split Window Right", remap = true })
set("n", "<leader>wd", "<C-W>c", { desc = "Delete Window", remap = true })
Snacks.toggle.zoom():map("<leader>wm"):map("<leader>uZ")
Snacks.toggle.zen():map("<leader>uz")
