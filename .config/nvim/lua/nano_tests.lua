local global_options = {
	cache = {
		last_run = nil,
	},
}

local function setup(_) end

local function open_terminal()
	local pane_index = "2"
	local check_cmd = "tmux list-panes -F '#{pane_index} #{pane_in_mode}' | grep '^"
		.. pane_index
		.. "\\b' | awk '{print $2}'"
	local in_mode = vim.fn.system(check_cmd)

	if in_mode == nil or in_mode == "" then
		os.execute("tmux split-window -dv -l 20%")
	else
		in_mode = in_mode:match("^%s*(.-)%s*$")

		if in_mode == "1" then
			os.execute("tmux send -t 2 -X cancel")
		end
	end
end

local function run(command)
	local terminal_cmd = "tmux send -t 2 'bundle exec rspec " .. command .. "' Enter"

	open_terminal()

	os.execute(terminal_cmd)
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
	open_terminal = open_terminal,
	run_file = run_file,
	run_line = run_line,
	run_last = run_last,
}
