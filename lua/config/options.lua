local g, o = vim.g, vim.o

o.number = true

o.shell = "bash"

o.autoindent = true
o.expandtab  = true
o.tabstop    = 4
o.shiftwidth = 4

o.clipboard = "unnamedplus"

o.undofile = true

o.exrc = true

o.mouse      = o.mouse .. "a"
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

    vim.api.nvim_create_user_command("S"..usr_cmd, function(opts)
        local filename = table.remove(opts.fargs, 1) or "%"

        vim.cmd(("w|silent !%s %s %s"):format(sh_cmd, filename, table.concat(opts.fargs, " ")))
    end, { nargs = "*" })
end

if g.neovide then
    o.guifont = "JetBrainsMono Nerd Font Mono:h10"
    g.neovide_transparency = 0.8
    g.neovide_hide_mouse_when_typing = true
end
