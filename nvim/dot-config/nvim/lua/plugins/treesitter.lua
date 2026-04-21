return {
	{ "nvim-treesitter/nvim-treesitter-context", opts = {
		enable = false,
	} },
	{
		"nvim-treesitter/nvim-treesitter-textobjects",
		opts = {
			select = {
				lookahead = true,
				selection_modes = {
					["@parameter.outer"] = "v",
					["@function.outer"] = "V",
					["@class.outer"] = "<c-v>",
				},
				include_surrounding_whitespace = true,
			},
		},
		config = function(_, opts)
			require("nvim-treesitter-textobjects").setup(opts)

			local select = require("nvim-treesitter-textobjects.select").select_textobject
			vim.keymap.set({ "x", "o" }, "af", function()
				select("@function.outer", "textobjects")
			end, { desc = "Select outer function" })
			vim.keymap.set({ "x", "o" }, "if", function()
				select("@function.inner", "textobjects")
			end, { desc = "Select inner function" })
			vim.keymap.set({ "x", "o" }, "ac", function()
				select("@class.outer", "textobjects")
			end, { desc = "Select outer class" })
			vim.keymap.set({ "x", "o" }, "ic", function()
				select("@class.inner", "textobjects")
			end, { desc = "Select inner part of a class region" })
			vim.keymap.set({ "x", "o" }, "as", function()
				select("@local.scope", "locals")
			end, { desc = "Select language scope" })
		end,
	},
	"windwp/nvim-ts-autotag", -- Automatically close tags
	"RRethy/nvim-treesitter-endwise", -- Automatically close blocks
	{
		"nvim-treesitter/nvim-treesitter",
		branch = "main",
		lazy = false,
		build = ":TSUpdate",
		opts = {
			install_dir = vim.fn.stdpath("data") .. "/site",
		},
		config = function(_, opts)
			local parsers = {
				"sql",
				"lua",
				"vim",
				"query",
				"javascript",
				"typescript",
				"ruby",
				"markdown",
				"markdown_inline",
				"glimmer",
			}
			require("nvim-treesitter").setup(opts)

			local installed = require("nvim-treesitter").get_installed("parsers")
			local missing = vim.tbl_filter(function(parser)
				return not vim.list_contains(installed, parser)
			end, parsers)

			if #missing > 0 then
				require("nvim-treesitter").install(missing, { max_jobs = 1 })
			end

			local group = vim.api.nvim_create_augroup("treesitter-highlight", { clear = true })
			vim.api.nvim_create_autocmd("FileType", {
				group = group,
				callback = function(args)
					local max_filesize = 100 * 1024
					local ok, stats = pcall(vim.uv.fs_stat, vim.api.nvim_buf_get_name(args.buf))
					if ok and stats and stats.size > max_filesize then
						return
					end

					pcall(vim.treesitter.start, args.buf)
				end,
			})
		end,
	},
}
