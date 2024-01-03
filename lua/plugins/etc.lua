return {
    { "jeffkreeftmeijer/vim-numbertoggle" },
    {
        "rcarriga/nvim-notify",
        config = function()
            vim.notify = require("notify")
        end
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
        "mg979/vim-visual-multi",
        config = function()
            vim.g.VM_maps = {
                ["Select Cursor Up"] = "<C-s><Up>",
                ["Select Cursor Down"] = "<C-s><Down>",
            }
        end,
    },
}
