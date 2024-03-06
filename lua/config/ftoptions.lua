return {
    ft = {
        sh = {
            tabstop = 2,
            shiftwidth = 2,
        },
        zsh = {
            tabstop = 2,
            shiftwidth = 2,
        },
        qf = {
            number = false,
            relativenumber = false,
        },
    },
    refresh = function()
        for ft, opts in pairs(require("config.ftoptions").ft) do
            vim.api.nvim_create_autocmd("FileType", {
                pattern = ft,
                callback = function()
                    for opt, val in pairs(opts) do
                        vim.opt_local[opt] = val
                    end
                end,
                group = "ftoptions",
            })
        end
    end,
}
