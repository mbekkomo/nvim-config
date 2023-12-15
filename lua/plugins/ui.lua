return {
    {
        "romgrk/barbar.nvim",
        dependencies = "nvim-tree/nvim-web-devicons",
        config = function()
            require("bufferline").setup({
                icons = { modified = { button = "£" } },
            })
        end,
    },
    {
        "nvim-lualine/lualine.nvim",
        main = "lualine",
        config = true,
        opts = require("config.lualine"),
    },
}
