return {
	{
		"nvim-lualine/lualine.nvim",
		init = function()
			require("lualine").setup({
				options = {
					icons_enabled = true,
					theme = "auto",
					component_separators = { left = "", right = "" },
					section_separators = { left = "", right = "" },
					disabled_filetypes = {
						statusline = {},
						winbar = {},
					},
					ignore_focus = {},
					always_divide_middle = true,
					globalstatus = false,
					refresh = {
						statusline = 1000,
						tabline = 1000,
						winbar = 1000,
					},
				},
				sections = {
					lualine_a = {
						"mode",
					},
					lualine_b = {
						function()
							local function run(cmd)
								local h = io.popen(cmd .. " 2>/dev/null")
								local out = h:read("*l")
								h:close()
								return out
							end

							-- If we're inside a linked worktree, .git will point to
							-- something like: <root>/.git/worktrees/<worktree-name>
							local gitdir = run("git rev-parse --git-dir")

							local prefix = gitdir:match("(.*/)worktrees/([^/]+)")
							if prefix then
								local wt = gitdir:match("worktrees/([^/]+)")

								return "  " .. wt
							else
								return ""
							end
						end,
						"branch",
						"diff",
						"diagnostics",
						function()
							local reg = vim.fn.reg_recording()
							-- If a macro is being recorded, show "Recording @<register>"
							if reg ~= "" then
								return "Recording @" .. reg
							else
								return ""
							end
						end,
					},
					lualine_c = {
						{
							"filename",
							file_status = true,
							path = 1,
						},
					},
					lualine_x = { "encoding", "filetype" },
					lualine_y = { "progress" },
					lualine_z = { "location" },
				},
				inactive_sections = {
					lualine_a = {},
					lualine_b = {},
					lualine_c = { "filename" },
					lualine_x = { "location" },
					lualine_y = {},
					lualine_z = {},
				},
				tabline = {},
				winbar = {},
				inactive_winbar = {},
				extensions = {},
			})
		end,
	},
}
