return {
  {
    "sindrets/diffview.nvim",
    depencencies = "nvim-lua/plenary.nvim",
    init = function()
      vim.keymap.set("n", "<leader>ghh", "::DiffviewFileHistory %<CR>", { desc = "[GIT] Diff view current file" })
      vim.keymap.set("n", "<leader>ghah", "::DiffviewFileHistory<CR>", { desc = "[GIT] Diff view all file" })
      vim.keymap.set("n", "<leader>dc", ":DiffviewClose<CR>", { desc = "[GIT] Diff view close" })
      vim.keymap.set("n", "<leader>do", ":DiffviewOpen<CR>", { desc = "[GIT] Diff view open" })
      vim.keymap.set("n", "<leader>db", ":DiffviewOpen origin/main...HEAD<CR>", { desc = "[GIT] Diff branch view open" })
    end,
  },
}
