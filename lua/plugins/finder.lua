local utils = require("utils.utils")
local is_executable, silent_keymap = utils.is_executable, utils.silent_keymap

return {
    {
        cond = is_executable("rg") or is_executable("fd"),
        "nvim-telescope/telescope.nvim",
        dependencies = "nvim-lua/plenary.nvim",
        branch = "0.1.x",
        main = "telescope",
        config = true,
    },
    {
        "ahmedkhalf/project.nvim",
        dependencies = "nvim-telescope/telescope.nvim",
        config = function()
            require("project_nvim").setup({})
            require("telescope").load_extension("projects")
            silent_keymap("n", "<Leader>prj", ":Telescope projects<CR>")
        end,
    },
}
