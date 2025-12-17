return {
	{
		"NickvanDyke/opencode.nvim",
		dependencies = {
			-- Recommended for `ask()` and `select()`.
			-- Required for `snacks` provider.
			---@module 'snacks' <- Loads `snacks.nvim` types for configuration intellisense.
			{ "folke/snacks.nvim" },
		},
		keys = {
			{
				"<leader>oa",
				function()
					require("opencode").ask("@this: ", { submit = true })
				end,
				desc = "Ask opencode",
				mode = { "n", "v" },
			},
      {
        "<leader>os",
        function()
          require("opencode").select()
        end,
        desc = "Execute opencode action…",
        mode = { "n", "v" },
      },
      {
        "<leader>op",
        function()
          require("opencode").prompt("@this")
        end,
        desc = "Add to opencode",
        mode = { "n", "v" },
      },
      {
        "<leader>ot",
        function()
          require("opencode").toggle()
        end,
        desc = "Toggle opencode",
        mode = { "n", "v" },
      }
		},
	},
}
