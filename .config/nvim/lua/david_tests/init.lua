local global_options = {
  cache = {
    last_run = nil,
  },
}

local function setup(_) end

-- file = vim.fn.expand('%')
-- line = vim.fn.line('.')
local function run(command)
  local terminal_cmd = "!tmux send -t 2 'bundle exec rspec " .. command .. "' Enter"
  vim.api.nvim_command("!tmux send -t 2 -X cancel")
  vim.api.nvim_command(terminal_cmd)
end

local function run_file()
  local command = vim.fn.expand("%")
  global_options.cache.last_run = command
  run(command)
end

local function run_line()
  local command = vim.fn.expand("%") .. ":" .. vim.fn.line(".")
  global_options.cache.last_run = command
  run(command)
end

local function run_last()
  run(global_options.cache.last_run)
end

return {
  setup = setup,
  run_file = run_file,
  run_line = run_line,
  run_last = run_last,
}
