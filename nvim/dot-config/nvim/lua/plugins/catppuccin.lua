return {
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    opts = {
      flavour = "mocha",
      custom_highlights = function(colors)
        return {
          -- High-contrast diffs. Catppuccin defaults are too subtle in side-by-side Diffview.
          DiffAdd = { bg = "#244B3A" },
          DiffDelete = { bg = "#5A2733" },
          DiffChange = { bg = "#313A5C" },
          DiffText = { bg = "#5B4F24", style = { "bold" } },

          DiffviewDiffAdd = { bg = "#244B3A" },
          DiffviewDiffDelete = { bg = "#5A2733" },
          DiffviewDiffAddAsDelete = { bg = "#5A2733" },
          DiffviewDiffDeleteDim = { fg = colors.overlay1, bg = "#352334" },
          DiffviewDiffChange = { bg = "#313A5C" },
          DiffviewDiffText = { bg = "#5B4F24", style = { "bold" } },
        }
      end,
      integrations = {
        aerial = true,
        alpha = true,
        cmp = true,
        dashboard = true,
        flash = true,
        fzf = true,
        grug_far = true,
        gitsigns = true,
        headlines = true,
        illuminate = true,
        indent_blankline = { enabled = true },
        leap = true,
        lsp_trouble = true,
        mason = true,
        markdown = true,
        mini = true,
        native_lsp = {
          enabled = true,
          underlines = {
            errors = { "undercurl" },
            hints = { "undercurl" },
            warnings = { "undercurl" },
            information = { "undercurl" },
          },
        },
        navic = { enabled = true, custom_bg = "lualine" },
        neotest = true,
        neotree = true,
        noice = true,
        notify = true,
        semantic_tokens = true,
        snacks = true,
        telescope = true,
        treesitter = true,
        treesitter_context = true,
        which_key = true,
      },
    },
    specs = {
      {
        "akinsho/bufferline.nvim",
        optional = true,
        opts = function(_, opts)
          opts.highlights = require("catppuccin.groups.integrations.bufferline").get()
        end,
      },
    },
    config = function(_, opts)
      require("catppuccin").setup(opts)

      -- setup must be called before loading
      vim.cmd.colorscheme("catppuccin-mocha")
    end,
  },
}
