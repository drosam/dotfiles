return {
  {
    "folke/snacks.nvim",
    opts = {
      indent = { enabled = true },
      input = { enabled = false },
      notifier = { enabled = true },
      scope = { enabled = false },
      scroll = { enabled = false },
      statuscolumn = { enabled = false }, -- we set this in options.lua
      toggle = { enabled = false },
      words = { enabled = true },
      git = { enabled = true },
      lazygit = { enabled = true },
      dashboard = {
        preset = {
          header = [[
███╗   ██╗ █████╗ ███╗   ██╗ ██████╗ ██╗   ██╗██╗███╗   ███╗
████╗  ██║██╔══██╗████╗  ██║██╔═══██║██║   ██║██║████╗ ████║
██╔██╗ ██║███████║██╔██╗ ██║██║   ██║██║   ██║██║██╔████╔██║
██║╚██╗██║██╔══██║██║╚██╗██║██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║
██║ ╚████║██║  ██║██║ ╚████║╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║
╚═╝  ╚═══╝╚═╝  ╚═╝╚═╝  ╚═══╝ ╚═════╝  ╚═════╝ ╚═╝╚═╝     ╚═╝
   ]],
          -- stylua: ignore
          ---@type snacks.dashboard.Item[]
          keys = {
            { icon = " ", key = "f", desc = "Find File", action = ":lua Snacks.dashboard.pick('files')" },
            { icon = " ", key = "n", desc = "New File", action = ":ene | startinsert" },
            { icon = " ", key = "g", desc = "Find Text", action = "<cmd>lua require('telescope').extensions.live_grep_args.live_grep_args({ vimgrep_arguments = { 'rg', '--color=never', '--no-heading', '--with-filename', '--line-number', '--column', '--smart-case', '--hidden' } })<CR>" },
            { icon = " ", key = "c", desc = "Config", action = ":lua Snacks.dashboard.pick('files', {cwd = vim.fn.stdpath('config')})" },
            { icon = " ", key = "s", desc = "Restore Session", section = "session" },
            { icon = "󰒲 ", key = "l", desc = "Lazy", action = ":Lazy" },
            { icon = " ", key = "q", desc = "Quit", action = ":qa" },
          },
        },
      },
    },
  },

}
