-- vim.treesitter.language.register("teal","nelua")
vim.treesitter.language.register("lua", "ravi")

local parser_config = require("nvim-treesitter.parsers").get_parser_configs()
parser_config.haxe = {
    install_info = {
        url = "~/build/tree-sitter-haxe",
        files = { "src/parser.c" },
    },
    filetype = "hx",
}

vim.filetype.add({
    extension = {
        hx = "haxe",
        ravi = "ravi",
    },
    pattern = {
        [".*%.hx"] = "haxe",
        [".*%.ravi"] = "ravi",
    },
})
