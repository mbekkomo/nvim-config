return {
    {
        "catppuccin/nvim",
        name = "catppuccin",
        config = function()
            require("catppuccin").setup({
                flavour = "mocha",
                transparent_background = not vim.g.neovide,
                show_end_of_buffer = false,
                no_italic = true,
                term_colors = true,
                integrations = {
                    cmp = true,
                    notify = true,
                    treesitter = true,
                    lsp_saga = true,
                },
            })

            vim.cmd.colorscheme("catppuccin")
        end,
    },
}
