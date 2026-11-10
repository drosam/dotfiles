-- Run from the repository root: nvim --headless -u NONE -l nvim/tests/nano_tests.lua
local module_path = "nvim/dot-config/nvim/lua/nano_tests.lua"
local calls, notices, panes, shell_calls
local cwd, file, fail, invalid
local original_execute = os.execute

local function reset(herdr)
	calls, notices, panes, shell_calls = {}, {}, {}, {}
	vim.v = { shell_error = 0 }
	cwd, file, fail, invalid = "/project", "spec/example_spec.rb", nil, false
	vim.env.HERDR_ENV = herdr and "1" or nil
	vim.env.HERDR_BIN_PATH = "/tools/herdr"
	vim.env.HERDR_PANE_ID = "w1:p1"
	vim.env.HERDR_WORKSPACE_ID = "w1"
	vim.env.HERDR_TAB_ID = "w1:t1"
	vim.fn.getcwd = function() return cwd end
	vim.fn.expand = function() return file end
	vim.fn.fnamemodify = function(value) return value end
	vim.fn.line = function() return 42 end
	vim.notify = function(message) table.insert(notices, message) end
	vim.fn.system = function(args)
		table.insert(calls, args)
		vim.v.shell_error = fail and 1 or 0
		if fail then return "API unavailable" end
		if invalid then return "not JSON" end
		if type(args) == "string" then return "" end
		assert(args[1] == "/tools/herdr")
		if args[3] == "list" then
			return vim.json.encode({ result = { panes = panes } })
		elseif args[3] == "split" then
			panes = { { pane_id = "w1:p2", tab_id = "w1:t1" } }
			return vim.json.encode({ result = { pane = panes[1] } })
		else
			return ""
		end
	end
	os.execute = function(cmd) table.insert(shell_calls, cmd) end
	return dofile(module_path)
end

local function commands(action)
	return vim.tbl_filter(function(args) return type(args) == "table" and args[3] == action end, calls)
end

local tests = {
	["create and reuse Herdr pane without stealing focus"] = function()
		local tests = reset(true)
		tests.run_file()
		tests.run_line()
		tests.run_last()
		assert(#commands("split") == 1)
		assert(#commands("focus") == 0)
		assert(#shell_calls == 0)
		local runs = commands("run")
		assert(#runs == 3)
		assert(runs[1][4] == "w1:p2")
		assert(runs[1][5] == "cd '/project' && bundle exec rspec 'spec/example_spec.rb'")
		assert(runs[2][5]:find("'spec/example_spec.rb:42'", 1, true))
		assert(runs[2][5] == runs[3][5])
	end,
	["recreate closed or moved test pane"] = function()
		local tests = reset(true)
		tests.run_file()
		panes = {}
		tests.run_file()
		panes[1].tab_id = "w1:t9"
		tests.run_file()
		assert(#commands("split") == 3)
	end,
	["terminal shortcut focuses below source pane"] = function()
		local tests = reset(true)
		tests.open_terminal(true)
		assert(vim.deep_equal(commands("focus")[1], {
			"/tools/herdr", "pane", "focus", "--pane", "w1:p1", "--direction", "down",
		}))
	end,
	["runner selection and shell quoting"] = function()
		local tests = reset(true)
		for _, case in ipairs({
			{ "/project", "test/widget.test.ts", "pnpm test 'test/widget.test.ts'" },
			{ "/project", "features/a.feature", "bundle exec cucumber 'features/a.feature:42'" },
			{ "/work/booqable/develop", "spec/system/a_spec.rb", "bin/system-test 'spec/system/a_spec.rb:42'" },
			{ "/work/with space", "spec/it's a_spec.rb", "bundle exec rspec " .. vim.fn.shellescape("spec/it's a_spec.rb:42") },
		}) do
			cwd, file = case[1], case[2]
			if file:match("%.ts$") then tests.run_file() else tests.run_line() end
			local runs = commands("run")
			assert(runs[#runs][5] == "cd " .. vim.fn.shellescape(cwd) .. " && " .. case[3], runs[#runs][5])
		end
	end,
	["API failures and invalid JSON do not dispatch tests"] = function()
		local tests = reset(true)
		fail = true
		tests.run_file()
		assert(#commands("run") == 0 and #commands("split") == 0 and #notices == 1)
		fail, invalid = false, true
		tests.run_file()
		assert(#commands("run") == 0 and #notices == 2)
	end,
	["tmux backend unchanged"] = function()
		local tests = reset(false)
		tests.run_file()
		assert(shell_calls[1] == "tmux split-window -dv -l 25%")
		assert(shell_calls[2] == "tmux send -t 2 'bundle exec rspec spec/example_spec.rb' Enter")
	end,
}

for name, test in pairs(tests) do
	local ok, err = pcall(test)
	if not ok then
		os.execute = original_execute
		error(name .. ": " .. tostring(err))
	end
	print("PASS " .. name)
end
os.execute = original_execute
