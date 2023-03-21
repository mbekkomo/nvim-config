vim.treesitter.language.register("teal","nelua")

local parser_config = require "nvim-treesitter.parsers".get_parser_configs()
parser_config.haxe = {
    install_info = {
        url = "~/build/tree-sitter-haxe",
        files = {"src/parser.c"}
    },
    filetype = "hx",
}

vim.filetype.add {
    extension = {
        hx = "haxe"
    },
    pattern = {
        ["*.hx"] = "haxe"
    }
}
