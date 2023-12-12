return {
    {
        "catppuccin/nvim",
        name = "catppuccin",
        config = function()
            require("catppuccin").setup({
                flavour = "mocha",
                transparent_background = true,
                show_end_of_buffer = false,
                no_italic = true,
                term_colors = true,
            })

            vim.cmd.colorscheme("catppuccin")
        end,
    },
}
