return {
    {
        "kylechui/nvim-surround",
        event = "VeryLazy",
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
