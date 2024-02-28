return {
    { "jeffkreeftmeijer/vim-numbertoggle" },
    {
        "rcarriga/nvim-notify",
        config = function()
            vim.notify = require("notify")
        end,
    },
    {
        "brenoprata10/nvim-highlight-colors",
        config = true,
    },
    {
        "vincent178/nvim-github-linker",
        config = true,
    },
    {
        "terrortylor/nvim-comment",
        config = true,
        main = "nvim_comment",
    },
    {
        "akinsho/toggleterm.nvim",
        opts = {
            open_mapping = "<A-d>",
            insert_mappings = false,
            on_create = function()
                vim.uv.os_setenv("ZSHRC_SKIP_INTRO", "1")
            end,
            on_exit = function()
                vim.uv.os_unsetenv("ZSHRC_SKIP_INTRO")
            end,
            shell = function()
                local f = io.popen([[echo "$SHELL"]])
                if not f then
                    return vim.o.shell
                end
                local shell = f:read("*a"):gsub("%s*$", "")
                f:close()
                return shell
            end,
        },
    },
    {
        "radenling/vim-dispatch-neovim",
        dependencies = { "tpope/vim-dispatch" }
    }
}
