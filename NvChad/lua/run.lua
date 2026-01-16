vim.g.mapleader = " "

local function run_with_input()
	local file = vim.fn.expand("%:p")
	local ext = vim.fn.expand("%:e")
	local filename = vim.fn.expand("%:t:r")

	if file == "" then
		vim.notify("No file open", vim.log.levels.ERROR)
		return
	end

	-- Check if input.txt exists in the current directory and has content
	local has_input = vim.fn.filereadable("input.txt") == 1 and vim.fn.getfsize("input.txt") > 0

	local is_cargo = vim.fn.filereadable("Cargo.toml") == 1
	local is_go_mod = vim.fn.filereadable("go.mod") == 1

	local cmd

	-- C++
	if ext == "cpp" then
		if has_input then
			-- Compile; if success (&&), run with input redirection
			cmd = string.format('g++ "%s" -o output && ./output < input.txt', file)
		else
			cmd = string.format('g++ "%s" -o output && ./output', file)
		end

	-- Python (Using python3 by default for Zsh environments)
	elseif ext == "py" then
		if has_input then
			cmd = string.format('python3 "%s" < input.txt', file)
		else
			cmd = string.format('python3 "%s"', file)
		end

	-- Rust
	elseif ext == "rs" then
		if is_cargo then
			if has_input then
				cmd = "cargo run < input.txt"
			else
				cmd = "cargo run"
			end
		else
			-- Single file Rust
			if has_input then
				cmd = string.format('rustc "%s" -o "%s" && ./"%s" < input.txt', file, filename, filename)
			else
				cmd = string.format('rustc "%s" -o "%s" && ./"%s"', file, filename, filename)
			end
		end

	-- Go 🐹
	elseif ext == "go" then
		if is_go_mod then
			if has_input then
				cmd = "go run . < input.txt"
			else
				cmd = "go run ."
			end
		else
			if has_input then
				cmd = string.format('go run "%s" < input.txt', file)
			else
				cmd = string.format('go run "%s"', file)
			end
		end
	else
		vim.notify("Unsupported file type: " .. ext, vim.log.levels.ERROR)
		return
	end

	local width = math.floor(vim.o.columns * 0.8)
	local height = math.floor(vim.o.lines * 0.7)

	local buf = vim.api.nvim_create_buf(false, true)

	local win = vim.api.nvim_open_win(buf, true, {
		relative = "editor",
		width = width,
		height = height,
		col = (vim.o.columns - width) / 2,
		row = (vim.o.lines - height) / 2,
		style = "minimal",
		border = "rounded",
	})

	vim.keymap.set("n", "q", function()
		vim.api.nvim_win_close(win, true)
	end, { buffer = buf, silent = true })

	-- Use Zsh to execute the command string
	vim.fn.termopen({ "zsh", "-c", cmd }, { cwd = vim.fn.getcwd() })
end

vim.keymap.set(
	"n",
	"<leader>i",
	run_with_input,
	{ desc = "Run (C++ / Python / Rust / Go, auto input + project)", silent = true }
)
