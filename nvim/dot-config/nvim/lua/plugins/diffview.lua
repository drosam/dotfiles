return {
  {
    "sindrets/diffview.nvim",
    dependencies = "nvim-lua/plenary.nvim",
    opts = function()
      local actions = require("diffview.actions")

      return {
        enhanced_diff_hl = true,
        keymaps = {
          file_panel = {
            -- Open selected file and move focus into the diff pane.
            ["<cr>"] = actions.focus_entry,
            -- Close whole Diffview from the file tree.
            ["<esc>"] = function()
              vim.cmd("DiffviewClose")
            end,
          },
          view = {
            -- Return focus to the file tree from the diff pane.
            ["<esc>"] = actions.focus_files,
          },
        },
      }
    end,
    init = function()
      -- Better intra-line diffs and less noisy filler blocks in Diffview.
      vim.opt.diffopt = {
        "internal",
        "filler",
        "closeoff",
        "algorithm:histogram",
        "indent-heuristic",
        "linematch:60",
        "context:999999",
      }
      vim.opt.fillchars:append({ diff = " " })

      -- Mouse hover changes active window. Needed so wheel scroll over either
      -- diff pane scrolls that pane and keeps scrollbind synced, no <C-l> first.
      vim.opt.mousefocus = true

      vim.api.nvim_create_autocmd("User", {
        pattern = "DiffviewDiffBufWinEnter",
        callback = function(event)
          -- Show full files in Diffview; don't fold unchanged sections.
          vim.wo.foldenable = false
          vim.wo.foldlevel = 999
          vim.wo.scrollbind = true

          -- VS Code-like chunk navigation inside Diffview.
          vim.keymap.set("n", "<Down>", function()
            vim.cmd.normal({ "]c", bang = true })
          end, { buffer = event.buf, desc = "Next diff chunk" })
          vim.keymap.set("n", "<Up>", function()
            vim.cmd.normal({ "[c", bang = true })
          end, { buffer = event.buf, desc = "Previous diff chunk" })
        end,
      })

      local function git_output(args)
        local output = vim.fn.systemlist(args)

        if vim.v.shell_error ~= 0 or output[1] == nil or output[1] == "" then
          return nil
        end

        return output[1]
      end

      local function git_output_lines(args)
        local output = vim.fn.systemlist(args)

        if vim.v.shell_error ~= 0 or output[1] == nil or output[1] == "" then
          return nil
        end

        return output
      end

      local function resolve_base_ref(base_ref)
        local resolved_base = git_output({ "git", "rev-parse", "--verify", "--quiet", base_ref })

        if resolved_base ~= nil then
          return base_ref
        end

        if not vim.startswith(base_ref, "origin/") then
          resolved_base = git_output({ "git", "rev-parse", "--verify", "--quiet", "origin/" .. base_ref })

          if resolved_base ~= nil then
            return "origin/" .. base_ref
          end
        end

        return nil
      end

      local function open_diff_from_base(base_ref)
        local resolved_base = resolve_base_ref(base_ref)

        if resolved_base == nil then
          vim.notify("Unable to resolve diff base: " .. base_ref, vim.log.levels.ERROR)
          return
        end

        vim.cmd("DiffviewOpen " .. resolved_base .. "...HEAD --imply-local")
      end

      local function branch_sort_key(branch)
        if branch == "main" then
          return "0"
        end

        if branch == "master" then
          return "1"
        end

        return "2" .. branch
      end

      local function open_branch_diff()
        local branches = git_output_lines({ "git", "branch", "--format=%(refname:short)" })

        if branches == nil then
          vim.notify("Unable to list local branches", vim.log.levels.ERROR)
          return
        end

        table.sort(branches, function(a, b)
          return branch_sort_key(a) < branch_sort_key(b)
        end)

        local default_base = branches[1]

        vim.ui.select(branches, { prompt = "Base branch (default: " .. default_base .. "): " }, function(base_ref)
          if base_ref == nil then
            return
          end

          open_diff_from_base(base_ref)
        end)
      end

      vim.keymap.set("n", "<leader>ghh", "::DiffviewFileHistory %<CR>", { desc = "[GIT] Diff view current file" })
      vim.keymap.set("n", "<leader>ghah", "::DiffviewFileHistory<CR>", { desc = "[GIT] Diff view all file" })
      vim.keymap.set("n", "<leader>dc", ":DiffviewClose<CR>", { desc = "[GIT] Diff view close" })
      vim.keymap.set("n", "<leader>do", ":DiffviewOpen<CR>", { desc = "[GIT] Diff view open" })
      vim.keymap.set("n", "<leader>db", open_branch_diff, { desc = "[GIT] Diff branch view open" })
    end,
  },
}
