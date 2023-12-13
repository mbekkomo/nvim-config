return {
    { "jeffkreeftmeijer/vim-numbertoggle" },
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
