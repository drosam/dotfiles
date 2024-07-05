return {
  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      {
        "nvim-telescope/telescope-live-grep-args.nvim",
      },
    },
    opts = function(_, opts)
      local lga_actions = require("telescope-live-grep-args.actions")
      opts.extensions = {
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
        file_browser = {
          hidden = true,
        },
      }
      opts.pickers = {
        find_files = {
          hidden = true,
        },
        grep_string = {
          additional_args = { "--hidden" },
        },
        live_grep = {
          additional_args = { "--hidden" },
        },
      }
    end,
    keys = {
      {
        "<leader>sg",
        "<cmd>lua require('telescope').extensions.live_grep_args.live_grep_args({ vimgrep_arguments = { 'rg', '--color=never', '--no-heading', '--with-filename', '--line-number', '--column', '--smart-case', '--hidden' } })<CR>",
        desc = "Grep (root dir)",
      },
      {
        "<leader>/",
        "<cmd>lua require('telescope').extensions.live_grep_args.live_grep_args({ vimgrep_arguments = { 'rg', '--color=never', '--no-heading', '--with-filename', '--line-number', '--column', '--smart-case', '--hidden' } })<CR>",
        desc = "Grep (root dir)",
      },
    },
    config = function(_, opts)
      local tele = require("telescope")
      tele.setup(opts)
      -- tele.load_extension("live_grep_args")
      --
      require("telescope").load_extension("file_browser")
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
}
