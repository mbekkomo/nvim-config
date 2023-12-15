local silent_keymap = require("utils.utils").silent_keymap

return {
    {
        "christoomey/vim-tmux-navigator",
        config = function()
            vim.g.tmux_navigator_no_mappings = 1

            silent_keymap("n", "<C-t><Up>", ":<C-U>TmuxNavigateUp<CR>")
            silent_keymap("n", "<C-t><Down>", ":<C-U>TmuxNavigateDown<CR>")
            silent_keymap("n", "<C-t><Left>", ":<C-U>TmuxNavigateLeft<CR>")
            silent_keymap("n", "<C-t><Right>", ":<C-U>TmuxNavigateRight<CR>")
            silent_keymap("n", "<C-t>\\", ":<C-U>TmuxNavigatePrevious<CR>")
        end,
    },
}
