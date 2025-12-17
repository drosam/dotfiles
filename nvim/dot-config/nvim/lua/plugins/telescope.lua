return {
	{
		"nvim-telescope/telescope.nvim",
		version = false, -- telescope did only one release, so use HEAD for now
		dependencies = { "nvim-lua/plenary.nvim" },
		config = function()
			local builtin = require("telescope.builtin")
			local telescope = require("telescope")
			local lga_actions = require("telescope-live-grep-args.actions")

			telescope.setup({
				pickers = {
					find_files = {
						-- `hidden = true` will still show the inside of `.git/` as it's not `.gitignore`d.
						find_command = { "rg", "--files", "--hidden", "--glob", "!**/.git/*" },
					},
				},
				extensions = {
					live_grep_args = {
						auto_quoting = true, -- enable/disable auto-quoting
						-- define mappings, e.g.
						mappings = { -- extend mappings
							i = {
								["<C-k>"] = lga_actions.quote_prompt(),
								["<C-i>"] = lga_actions.quote_prompt({ postfix = " --iglob " }),
							},
						},
						-- ... also accepts theme settings, for example:
						-- theme = "dropdown", -- use dropdown theme
						-- theme = { }, -- use own theme spec
						-- layout_config = { mirror=true }, -- mirror preview pane
					},
					fzf = {
						fuzzy = true, -- false will only do exact matching
						override_generic_sorter = true, -- override the generic sorter
						override_file_sorter = true, -- override the file sorter
						case_mode = "smart_case", -- or "ignore_case" or "respect_case"
						-- the default case_mode is "smart_case"
					},
					file_browser = {
						hidden = true,
						grouped = true,
					},
				},
			})
			telescope.load_extension("live_grep_args")
			telescope.load_extension("fzf")
			telescope.load_extension("file_browser")

			vim.keymap.set(
				"n",
				"<leader>,",
				"<cmd>Telescope buffers sort_mru=true sort_lastused=true<cr>",
				{ desc = "Switch Buffer" }
			)
			vim.keymap.set(
				"n",
				"<leader>/",
				"<cmd>lua require('telescope').extensions.live_grep_args.live_grep_args({ vimgrep_arguments = { 'rg', '--color=never', '--no-heading', '--with-filename', '--line-number', '--column', '--smart-case', '--hidden' } })<CR>",
				{ desc = "Grep" }
			)
			vim.keymap.set("n", "<leader><space>", function()
				builtin.find_files({ hidden = true })
			end, { desc = "Find Files" })
			vim.keymap.set(
				"n",
				"<leader>fb",
				"<cmd>Telescope buffers sort_mru=true sort_lastused=true ignore_current_buffer=true<cr>",
				{ desc = "Buffers" }
			)
			vim.keymap.set("n", "<leader>ff", function()
				builtin.find_files({ hidden = true })
			end, { desc = "Find Files" })
			-- git
			vim.keymap.set("n", "<leader>gs", "<cmd>Telescope git_status<CR>", { desc = "Status" })
			-- search
			vim.keymap.set("n", "<leader>sb", "<cmd>Telescope current_buffer_fuzzy_find<cr>", { desc = "Buffer" })
			vim.keymap.set("n", "<leader>sc", "<cmd>Telescope command_history<cr>", { desc = "Command History" })
			vim.keymap.set(
				"n",
				"<leader>sd",
				"<cmd>Telescope diagnostics bufnr=0<cr>",
				{ desc = "Document Diagnostics" }
			)
			vim.keymap.set(
				"n",
				"<leader>sg",
				"<cmd>lua require('telescope').extensions.live_grep_args.live_grep_args({ vimgrep_arguments = { 'rg', '--color=never', '--no-heading', '--with-filename', '--line-number', '--column', '--smart-case', '--hidden' } })<CR>",
				{ desc = "Grep" }
			)
			vim.keymap.set("n", "<leader>sk", "<cmd>Telescope keymaps<cr>", { desc = "Key Maps" })
			vim.keymap.set(
				"n",
				"<leader>sw",
				"<cmd>lua require('telescope.builtin').grep_string({word_match = '-w'})<CR>",
				{ desc = "Word" }
			)
			vim.keymap.set(
				"v",
				"<leader>sw",
				"<cmd>lua require('telescope.builtin').grep_string()<CR>",
				{ desc = "Word" }
			)
			vim.keymap.set("n", "<leader>ds", vim.lsp.buf.document_symbol, { desc = "Goto Symbol" })
      			vim.keymap.set(
				"n",
				"<leader>cs",
				"<cmd>lua require('telescope.builtin').lsp_document_symbols()<CR>",
				{ desc = "Symbols" }
			)


			local file_browser = require("telescope").extensions.file_browser
			vim.keymap.set("n", "<leader>fd", function()
				file_browser.file_browser({ path = "%:p:h", select_buffer = true, respect_gitignore = false })
			end, { desc = "[TELESCOPE] File browser" })
		end,
	},
	{
		"nvim-telescope/telescope-file-browser.nvim",
		dependencies = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim" },
	},
	"nvim-telescope/telescope-live-grep-args.nvim",
	{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
	-- better vim.ui with telescope
	{
		"stevearc/dressing.nvim",
		lazy = true,
		init = function()
			---@diagnostic disable-next-line: duplicate-set-field
			vim.ui.select = function(...)
				require("lazy").load({ plugins = { "dressing.nvim" } })
				return vim.ui.select(...)
			end
			---@diagnostic disable-next-line: duplicate-set-field
			vim.ui.input = function(...)
				require("lazy").load({ plugins = { "dressing.nvim" } })
				return vim.ui.input(...)
			end
		end,
	},
}
