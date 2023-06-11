local tbl = {
	-- Set indent to 4 spaces
	autoindent = true,
	expandtab = true,
	tabstop = 4,
	shiftwidth = 4,
}

for i, v in pairs(tbl) do
	vim.opt[i] = v
end

-- patch WSL clipboard
vim.g.clipboard = {
	name = "WslClipboard",
	copy = {
		["+"] = "clip.exe",
		["*"] = "clip.exe",
	},
	paste = {
		["+"] = [[powershell.exe -c [Console]::Out.Write($(Get-Clipboard -Raw).tostring().replace("`r", ""))]],
		["*"] = [[powershell.exe -c [Console]::Out.Write($(Get-Clipboard -Raw).tostring().replace("`r", ""))]],
	},
	cache_enabled = 0,
}

local function cmd_fmt(cmd_name, cmd_str, save)
	return save and "S" .. cmd_name or cmd_name,
		function(opts)
			local filename = opts.fargs[1] or nil

			if save and vim.fn.getbufinfo("%")[1].changed == 1 then
				vim.cmd("w")
			end

			if not filename then
				vim.cmd("!" .. cmd_str .. " %")
			else
				vim.cmd("!" .. cmd_str .. " " .. table.concat(opts.fargs, " "))
			end
		end,
		{ nargs = "*" }
end

vim.api.nvim_create_user_command(cmd_fmt("Stylua", "stylua", true))
vim.api.nvim_create_user_command(cmd_fmt("Stylua", "stylua"))

vim.api.nvim_create_user_command(cmd_fmt("Shfmt", "shfmt -w", true))
vim.api.nvim_create_user_command(cmd_fmt("Shfmt", "shfmt -w"))
