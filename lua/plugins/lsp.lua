local utils = require("utils.utils")
local with = utils.with

return {
    {
        "VonHeikemen/lsp-zero.nvim",
        branch = "v3.x",
        dependencies = {
            "neovim/nvim-lspconfig",
            "hrsh7th/nvim-cmp",
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-path",
            "saadparwaiz1/cmp_luasnip",
            "hrsh7th/cmp-nvim-lua",
            "L3MON4D3/LuaSnip",
            "rafamadriz/friendly-snippets",
            "windwp/nvim-autopairs",
            "onsails/lspkind.nvim",
            "uga-rosa/cmp-dictionary",
            "PaterJason/cmp-conjure",
            { "nvimdev/lspsaga.nvim", event = "LspAttach" },
        },
        config = function()
            local cmp = require("cmp")

            -- Config lsp-zero
            ---@diagnostic disable:undefined-global
            with(function()
                on_attach(function(_, bufnr)
                    default_keymaps({ buffer = bufnr })
                end)

                set_sign_icons({
                    error = "",
                    warn = "▲",
                    hint = "󰌵",
                    info = "",
                })

                vim.diagnostic.config({
                    virtual_text = false,
                    severity_sort = true,
                    float = {
                        style = "minimal",
                        border = "rounded",
                        source = "always",
                        header = "",
                        prefix = "",
                    },
                })

                setup_servers({
                    "clangd",
                    "grammarly",
                    "teal_ls",
                    "jsonls",
                    "tsserver",
                    "bashls",
                    "gleam",
                })

                local nvim_lua_ls = nvim_lua_ls
                with(function()
                    yamlls.setup({
                        settings = {
                            yaml = {
                                ["https://json.schemastore.org/github-workflow.json"] = "/.github/workflows/*",
                                ["https://github.com/catppuccin/catppuccin/raw/main/resources/ports.schema.json"] = "/resources/ports.yml",
                            },
                        },
                    })

                    lua_ls.setup(nvim_lua_ls({
                        settings = {
                            workspace = {
                                library = { os.getenv("HOME") .. "/.local/share/lua/any" },
                            },
                        },
                    }))

                    grammarly.setup({
                        cmd = { "n", "run", "16", "/usr/local/bin/grammarly-languageserver", "--stdio" },
                    })

                    emmet_language_server.setup({
                        filetypes = {
                            "astro",
                            "css",
                            "eruby",
                            "html",
                            "htmldjango",
                            "javascriptreact",
                            "less",
                            "pug",
                            "sass",
                            "scss",
                            "svelte",
                            "typescriptreact",
                            "vue",
                            "etlua",
                        },
                    })
                end, require("lspconfig"))

                setup()

                -- Config lspsaga
                require("lspsaga").setup({})

                require("luasnip.loaders.from_vscode").lazy_load()

                cmp.setup(vim.tbl_deep_extend("force", cmp.get_config(), {
                    formatting = {
                        fields = { "abbr", "kind", "menu" },
                        format = require("lspkind").cmp_format({
                            mode = "symbol_text",
                            maxwidth = 50,
                            ellipsis_char = "...",
                        }),
                    },
                    sources = {
                        { name = "dictionary", keyword_length = 2 },

                        { name = "conjure" },

                        { name = "nvim_lsp" },
                        { name = "buffer" },
                        { name = "luasnip" },
                        { name = "nvim_lua" },
                        { name = "path" },
                    },
                }))
            end, require("lsp-zero"))
            ---@diagnostic enable:undefined-global

            -- Config cmp-dictionary
            local cmp_dict = require("cmp_dictionary")

            cmp_dict.setup({ async = true })
            cmp_dict.switcher({
                filetype = {
                    markdown = { os.getenv("NVIMDIR") .. "/dict/en.dict", os.getenv("NVIMDIR") .. "/dict/id.dict" },
                },
            })

            -- Config autopairs
            local cmp_autopairs = require("nvim-autopairs.completion.cmp")
            cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
        end,
    },
}
