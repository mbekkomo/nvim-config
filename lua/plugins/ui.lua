local utils = require("utils.utils")
local is_executable, silent_keymap = utils.is_executable, utils.silent_keymap

return {
    {
        "romgrk/barbar.nvim",
        dependencies = "nvim-tree/nvim-web-devicons",
        main = "bufferline",
        config = { icons = { modified = { button = "£" } } }
    },
    {
        "nvim-lualine/lualine.nvim",
        main = "lualine",
        config = true,
        opts = require("config.lualine"),
    },
    {
        cond = is_executable("nnn"),
        "is0n/fm-nvim",
        config = function()
            require("fm-nvim").setup({})
            silent_keymap("n", "<Leader>fm", ":Nnn<CR>")
        end,
    },
}
