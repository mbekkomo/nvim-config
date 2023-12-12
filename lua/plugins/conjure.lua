return {
    {
        "Olical/conjure",
        dependencies = {
            "Olical/aniseed",
        },
        init = function()
            local g = vim.g

            g["conjure#extract#tree_sitter#enabled"] = true
        end,
    },
}
