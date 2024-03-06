return {
    formatter = {
        Stylua = "stylua",
        Shfmt = "shfmt -w",
    },
    refresh = function()
        for usr_cmd, sh_cmd in pairs(require("config.formatter").formatter) do
            vim.api.nvim_create_user_command(usr_cmd, function(opts)
                local filename = table.remove(opts.fargs, 1) or "%"

                vim.cmd(("silent !%s %s %s"):format(sh_cmd, filename, table.concat(opts.fargs, " ")))
            end, { nargs = "*" })

            vim.api.nvim_create_user_command("S" .. usr_cmd, function(opts)
                local filename = table.remove(opts.fargs, 1) or "%"

                vim.cmd(("w|silent !%s %s %s"):format(sh_cmd, filename, table.concat(opts.fargs, " ")))
            end, { nargs = "*" })
        end
    end,
}
