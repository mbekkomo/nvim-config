local is_executable = require("utils.utils").is_executable

return {
    {
        "nvim-treesitter/nvim-treesitter",
        cond = is_executable("tree-sitter") and is_executable("c++") or is_executable("g++") or is_executable("clang++"),
        build = ":TSUpdate",
        dependencies = {
            "nvim-treesitter/playground",
        },
        config = function()
            local lang = {
                "lua",
                "janet_simple",
                "fennel",
                "c",
                "cpp",
                "teal",
                "json",
                "yaml",
                "bash",
                "scheme",
                "html",
                "javascript",
                "typescript",
                "etlua",
                "gleam",
            }

            local pc = require("nvim-treesitter.parsers").get_parser_configs()
            pc.etlua = {
                install_info = {
                    url = "https://github.com/UrNightmaree/tree-sitter-etlua",
                    files = { "src/parser.c" },
                    branch = "main",
                },
                filetype = "etlua",
            }

            pc.just = {
                install_info = {
                    url = "https://github.com/IndianBoy42/tree-sitter-just",
                    files = { "src/parser.c", "src/scanner.cc" },
                    branch = "main",
                },
                filetype = "just",
            }

            require("nvim-treesitter.configs").setup({
                ensure_installed = lang,
                highlight = {
                    enable = true,
                    disable = function(_, buf)
                        local max_filesize = 100 * 1024
                        local ok, stats = pcall(vim.uv.fs_stat, vim.api.nvim_buf_get_name(buf))
                        if ok and stats and stats.size > max_filesize then
                            return true
                        end
                    end,
                    additional_vim_regex_highlighting = false,
                },
                playground = {
                    enable = true,
                },
            })
        end,
    },
}
