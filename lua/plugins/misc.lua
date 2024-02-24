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
            open_mapping = "<Leader>te",
        },
    },
}
