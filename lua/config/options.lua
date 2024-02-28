local g, o = vim.g, vim.o

o.number = true
o.relativenumber = true

o.shell = "bash"

o.autoindent = true
o.expandtab = true
o.tabstop = 4
o.shiftwidth = 4

o.clipboard = "unnamedplus"

o.undofile = true

o.exrc = true

o.mouse = o.mouse .. "a"
o.mousemodel = "extend"

o.termguicolors = true

---@diagnostic disable-next-line:undefined-field
local uname = vim.loop.os_uname()
if uname.sysname == "Linux" and uname.release:find("Microsoft") then
    local copy = [[/mnt/c/Windows/System32/cmd.exe /q /u /c win32yank -i]]
    local paste = [[/mnt/c/Windows/System32/cmd.exe /q/ u /c win32yank -o]]

    vim.g.clipboard = {
        name = "WslClipboard",
        copy = {
            ["+"] = copy,
            ["*"] = copy,
        },
        paste = {
            ["+"] = paste,
            ["*"] = paste,
        },
        cache_enabled = 0,
    }
end

local cmd_fmt = {
    Stylua = "stylua",
    Shfmt = "shfmt -w",
}

for usr_cmd, sh_cmd in pairs(cmd_fmt) do
    vim.api.nvim_create_user_command(usr_cmd, function(opts)
        local filename = table.remove(opts.fargs, 1) or "%"

        vim.cmd(("silent !%s %s %s"):format(sh_cmd, filename, table.concat(opts.fargs, " ")))
    end, { nargs = "*" })

    vim.api.nvim_create_user_command("S" .. usr_cmd, function(opts)
        local filename = table.remove(opts.fargs, 1) or "%"

        vim.cmd(("w|silent !%s %s %s"):format(sh_cmd, filename, table.concat(opts.fargs, " ")))
    end, { nargs = "*" })
end

local Terminal = require("toggleterm.terminal").Terminal

vim.api.nvim_create_user_command("RunFile", function(opts)
    local runners = require("config.coderunner").runners
    local oldshell = vim.o.shell
    local bufft = vim.bo.filetype
    local fmt = {
        ["%f"] = vim.fn.expand("%"),
        ["%*"] = table.concat(opts.fargs, " "),
    }
    local ft_command = runners[bufft]
    if not ft_command then
        vim.notify(("No runner for filetype '%s'"):format(bufft), vim.log.levels.ERROR)
        return
    end
    o.shell = "bash"
    local process = Terminal:new({
        cmd = ft_command:gsub("%%.", fmt),
        close_on_exit = false,
        direction = "horizontal",
        on_open = function()
            vim.cmd.file(fmt["%f"])
            vim.cmd("startinsert!")
        end,
        on_exit = function()
            vim.cmd("startinsert!")
        end,
    })
    process:toggle()
    o.shell = oldshell
end, { nargs = "*" })

vim.api.nvim_create_autocmd("TermOpen", { command = "tabdo set nonumber norelativenumber" })
vim.api.nvim_create_autocmd("WinNew", {
    callback = function()
        if vim.bo.filetype == "qf" then
            vim.cmd.tabdo("set nonumber norelativenumber")
        end
    end,
})

if g.neovide then
    o.guifont = "Hasklug Nerd Font Mono:h10"
    g.neovide_transparency = 0.95
    g.neovide_hide_mouse_when_typing = true
end
