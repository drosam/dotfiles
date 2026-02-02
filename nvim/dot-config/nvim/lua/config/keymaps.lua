local set = vim.keymap.set

-- save file
set({ "i", "x", "n", "s" }, "<C-s>", "<cmd>w<cr><esc>", { desc = "Save File" })

-- Prevent deleting from also copying
set({ "n", "v" }, "p", "P", { noremap = true })
set({ "n", "v" }, "c", '"_c', { noremap = true })
set({ "n", "v" }, "C", '"_C', { noremap = true })
set({ "n", "v" }, "<Del>", '"_x', { noremap = true })

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
-- set("n", "<S-h>", "<cmd>bprevious<cr>", { desc = "Prev Buffer" })
-- set("n", "<S-l>", "<cmd>bnext<cr>", { desc = "Next Buffer" })
-- set("n", "[b", "<cmd>bprevious<cr>", { desc = "Prev Buffer" })
-- set("n", "]b", "<cmd>bnext<cr>", { desc = "Next Buffer" })
set("n", "<leader>bb", "<cmd>e #<cr>", { desc = "Switch to Other Buffer" })
set("n", "<leader>`", "<cmd>e #<cr>", { desc = "Switch to Other Buffer" })
set("n", "<leader>bd", function()
	Snacks.bufdelete()
end, { desc = "Delete Buffer" })
set("n", "<leader>bo", function()
	Snacks.bufdelete.other()
end, { desc = "Delete Other Buffers" })
set("n", "<leader>ba", function()
	Snacks.bufdelete.all()
end, { desc = "Delete All Buffers" })
set("n", "<leader>bD", "<cmd>:bd<cr>", { desc = "Delete Buffer and Window" })
set("n", "<leader>bt", "<cmd>tabonly<cr>", { desc = "Close other tabs" })

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

-- Copy current relative path (relative)
set("n", "<leader>fp", function()
  vim.cmd("let @+=expand('%:.')")
  vim.notify("Copied file path to clipboard", vim.log.levels.INFO)
end, { desc = "Copy current file path (relative)", silent = true })
set("n", "<leader>fP", function()
  vim.cmd("let @+=expand('%:.') . ':' . line('.')")
  vim.notify("Copied file path:line to clipboard", vim.log.levels.INFO)
end, { desc = "Copy current file path:line (relative)", silent = true })
-- Create command to handle visual range properly
vim.api.nvim_create_user_command('CopyFilePathLineRange', function(opts)
  local start_line = opts.line1
  local end_line = opts.line2
  local file_path = vim.fn.expand('%:.')
  local range_str = file_path .. ':' .. start_line
  if start_line ~= end_line then
    range_str = range_str .. '-' .. end_line
  end
  vim.fn.setreg('+', range_str)
  vim.notify("Copied file path:line range to clipboard", vim.log.levels.INFO)
end, { range = true })

set("x", "<leader>fP", ":CopyFilePathLineRange<CR>", { desc = "Copy current file path:line-range (relative)", silent = true })

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
set("n", "<leader>gg", function()
	Snacks.lazygit()
end, { desc = "Lazygit" })
set("n", "<leader>gf", function()
	Snacks.lazygit.log_file()
end, { desc = "Lazygit Current File History" })
set("n", "<leader>gl", function()
	Snacks.lazygit.log()
end, { desc = "Lazygit Log" })
set("n", "<leader>gb", function()
	Snacks.git.blame_line()
end, { desc = "Git Blame Line" })
set({ "n", "x" }, "<leader>gB", function()
	Snacks.gitbrowse()
end, { desc = "Git Browse (open)" })
set('n', '<leader>gws', ':Telescope git_worktree git_worktrees<CR>')
set('n', '<leader>gwc', ':Telescope git_worktree create_git_worktree<CR>')

-- quit
set("n", "<leader>qq", "<cmd>qa<cr>", { desc = "Quit All" })

-- windows
-- Disable windows
set('n', '<C-w>', '<nop>')
-- set("n", "<leader>w", "<c-w>", { desc = "Windows", remap = true })
-- set("n", "<leader>-", "<C-W>s", { desc = "Split Window Below", remap = true })
-- set("n", "<leader>|", "<C-W>v", { desc = "Split Window Right", remap = true })
-- set("n", "<leader>wd", "<C-W>c", { desc = "Delete Window", remap = true })
-- Snacks.toggle.zoom():map("<leader>wm"):map("<leader>uZ")
-- Snacks.toggle.zen():map("<leader>uz")

-- Run tests
set("n", "<leader>tl", "<cmd>lua require'nano_tests'.run_line()<CR>", { desc = "Run tests for line", remap = true })
set("n", "<leader>tt", "<cmd>lua require'nano_tests'.run_file()<CR>", { desc = "Run tests for file", remap = true })
set("n", "<leader>ty", "<cmd>lua require'nano_tests'.run_last()<CR>", { desc = "Run last test", remap = true })

-- Enable/Disable
set("n", "<leader>uec", function ()
  vim.cmd("Copilot enable")
  vim.notify("Copilot enabled",  vim.log.levels.INFO)
end, { desc = "Enable copilot", remap = true })
set("n", "<leader>udc", function ()
  vim.cmd("Copilot disable")
  vim.notify("Copilot disabled",  vim.log.levels.INFO)
end, { desc = "Disable copilot", remap = true })
set("n", "<leader>uet", function ()
  vim.com("TSContext enable")
  vim.notify("Treesitter-context enabled", vim.log.levels.INFO)
end, { desc = "Enable treesitter-context", remap = true })
set("n", "<leader>uct", function ()
  vim.cmd("TSContext disable")
  vim.notify("Treesitter-context disable", vim.log.levels.INFO)
end, { desc = "Disable treesitter-context", remap = true })
set("n", "<leader>ut", function()
  require'nano_tests'.open_terminal()
  vim.cmd("TmuxNavigateDown")
end, { desc = "Open terminal" })

-- Clear search
set({ "i", "n", "s" }, "<esc>", function()
	vim.cmd("noh")
	return "<esc>"
end, { expr = true, desc = "Escape and Clear hlsearch" })
