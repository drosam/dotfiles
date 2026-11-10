local global_options = {
	cache = {
		last_run = nil,
		herdr_pane = nil,
	},
}

local function setup(_) end

local function herdr(args)
	local cmd = { vim.env.HERDR_BIN_PATH or "herdr" }
	vim.list_extend(cmd, args)
	local output = vim.fn.system(cmd)
	if vim.v.shell_error ~= 0 then
		vim.notify("Herdr: " .. output, vim.log.levels.ERROR)
		return nil
	end
	local ok, response = pcall(vim.json.decode, output)
	if output ~= "" and (not ok or type(response) ~= "table" or type(response.result) ~= "table") then
		vim.notify("Herdr returned invalid JSON", vim.log.levels.ERROR)
		return nil
	end
	return output == "" and {} or response.result
end

local function open_herdr_terminal(focus)
	local source = vim.env.HERDR_PANE_ID
	if not source or source == "" or not vim.env.HERDR_WORKSPACE_ID or not vim.env.HERDR_TAB_ID then
		vim.notify("Herdr pane context is missing", vim.log.levels.ERROR)
		return nil
	end

	local panes = herdr({ "pane", "list", "--workspace", vim.env.HERDR_WORKSPACE_ID })
	if not panes then
		return nil
	end
	local pane = global_options.cache.herdr_pane
	local exists = false
	for _, item in ipairs(panes.panes) do
		if item.pane_id == pane and item.tab_id == vim.env.HERDR_TAB_ID then
			exists = true
			break
		end
	end
	if not exists then
		local result = herdr({
			"pane", "split", "--pane", source, "--direction", "down",
			"--ratio", "0.75", "--cwd", vim.fn.getcwd(), "--no-focus",
		})
		if not result then
			return nil
		end
		pane = result.pane.pane_id
		global_options.cache.herdr_pane = pane
	end
	if focus then
		herdr({ "pane", "focus", "--pane", source, "--direction", "down" })
	end
	return pane
end

local function open_terminal(focus)
	if vim.env.HERDR_ENV == "1" then
		return open_herdr_terminal(focus)
	end
	local pane_index = "2"
	local check_cmd = "tmux list-panes -F '#{pane_index} #{pane_in_mode}' | grep '^"
		.. pane_index
		.. "\\b' | awk '{print $2}'"
	local in_mode = vim.fn.system(check_cmd)

	if in_mode == nil or in_mode == "" then
		os.execute("tmux split-window -dv -l 25%")
	else
		in_mode = in_mode:match("^%s*(.-)%s*$")

		if in_mode == "1" then
			os.execute("tmux send -t 2 -X cancel")
		end
	end
	if focus then
		vim.cmd("TmuxNavigateDown")
	end
end

local function get_test_runner(file)
	if vim.fn.getcwd():match("booqable") and file:match("^spec/system/.+_spec%.rb") then
		return "bin/system-test"
	elseif file:match("%.feature$") or file:match("%.feature:") then
		return "cucumber"
	elseif file:match("%.[jt]sx?$") and (file:match("%.test%.[jt]sx?") or file:match("%.spec%.[jt]sx?")) then
		return "jest"
	else
		return "rspec"
	end
end

local function run(command)
	local runner = get_test_runner(command)
	local terminal_cmd

	if vim.env.HERDR_ENV == "1" then
		local pane = open_terminal()
		if not pane then
			return
		end
		local test_command
		if runner == "jest" then
			local file = command:match("^(.-):%d+$") or command
			test_command = "pnpm test " .. vim.fn.shellescape(file)
		elseif runner == "bin/system-test" then
			test_command = runner .. " " .. vim.fn.shellescape(command)
		else
			test_command = "bundle exec " .. runner .. " " .. vim.fn.shellescape(command)
		end
		herdr({ "pane", "run", pane, "cd " .. vim.fn.shellescape(vim.fn.getcwd()) .. " && " .. test_command })
		return
	end

	if runner == "jest" then
		local file = command:match("^(.-):%d+$") or command
		terminal_cmd = "tmux send -t 2 'pnpm test " .. file .. "' Enter"
	elseif runner == "bin/system-test" then
		terminal_cmd = "tmux send -t 2 '" .. runner .. " " .. command .. "' Enter"
	else
		terminal_cmd = "tmux send -t 2 'bundle exec " .. runner .. " " .. command .. "' Enter"
	end

	open_terminal()
	os.execute(terminal_cmd)
end

local function run_file()
	local command = vim.fn.fnamemodify(vim.fn.expand("%:p"), ":.")
	global_options.cache.last_run = command
	run(command)
end

local function run_line()
	local file = vim.fn.fnamemodify(vim.fn.expand("%:p"), ":.")
	local command = file .. ":" .. vim.fn.line(".")
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
