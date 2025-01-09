return {
	{
		"stevearc/conform.nvim",
		event = { "BufWritePre" },
		cmd = { "ConformInfo" },
		keys = {
			{
				"<leader>cf",
				function()
					require("conform").format({ async = true, lsp_fallback = true })
				end,
				mode = "",
				desc = "Format buffer",
			},
		},
		-- Everything in opts will be passed to setup()
		opts = {
			formatters_by_ft = {
				lua = { "stylua" },
				fish = { "fish_indent" },
				sh = { "shfmt" },
				ruby = { "prettier" },
				javascript = { "prettier" },
				handlebars = { "prettier" },
			},
			formatters = {
				prettier = {
					condition = false,
				},
			},
			-- Set up format-on-save
			format_on_save = false,
		},
	},
}
