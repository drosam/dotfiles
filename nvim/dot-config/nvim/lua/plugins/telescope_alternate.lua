return {
	{
		"otavioschwanck/telescope-alternate",
		init = function()
 		local function get_mappings()
				local cwd = vim.fn.getcwd()

				if cwd:find("/pulse%-app/") and cwd:find("/api") then
					return require("helpers.telescope_alternate.ruby_api_mappings")
				elseif cwd:find("/pulse%-app/") and cwd:find("/frontend") then
					return require("helpers.telescope_alternate.ember_mappings")
				else
					return require("helpers.telescope_alternate.ruby_fs_mappings")
				end
			end

			require("telescope-alternate").setup({
				mappings = get_mappings(),
				presets = {},
			})

			vim.keymap.set(
				"n",
				"<leader>fa",
				":Telescope telescope-alternate alternate_file<Cr>",
				{ desc = "[TELESCOPE] Alternate file" }
			)
		end,
	},
}
