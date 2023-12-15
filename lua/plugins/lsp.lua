local utils = require("utils.utils")
local silent_keymap = utils.silent_keymap

return {
    {
        "nvimdev/lspsaga.nvim",
        event = "LspAttach",
        config = function()
            silent_keymap("n", "gh", "<cmd>Lspsaga lsp_finder<CR>")

            silent_keymap({ "n", "v" }, "<leader>ca", "<cmd>Lspsaga code_action<CR>")

            silent_keymap("n", "gr", "<cmd>Lspsaga rename<CR>")
            silent_keymap("n", "gR", "<cmd>Lspsaga rename ++project<CR>")

            silent_keymap("n", "gd", "<cmd>Lspsaga peek_definition<CR>")
            silent_keymap("n", "gD", "<cmd>Lspsaga goto_definition<CR>")
            silent_keymap("n", "gt", "<cmd>Lspsaga peek_type_definition<CR>")
            silent_keymap("n", "gT", "<cmd>Lspsaga goto_type_definition<CR>")

            silent_keymap("n", "<leader>sl", "<cmd>Lspsaga show_line_diagnostics<CR>")
            silent_keymap("n", "<leader>sc", "<cmd>Lspsaga show_cursor_diagnostics<CR>")
            silent_keymap("n", "<leader>sb", "<cmd>Lspsaga show_buf_diagnostics<CR>")
            silent_keymap("n", "<leader>pe", "<cmd>Lspsaga diagnostic_jump_prev<CR>")
            silent_keymap("n", "<leader>ne", "<cmd>Lspsaga diagnostic_jump_next<CR>")

            silent_keymap("n", "<leader>Pe", function()
                require("lspsaga.diagnostic"):goto_prev({ severity = vim.diagnostic.severity.ERROR })
            end)
            silent_keymap("n", "<leader>Ne", function()
                require("lspsaga.diagnostic"):goto_next({ severity = vim.diagnostic.severity.ERROR })
            end)

            silent_keymap("n", "<leader>o", "<cmd>Lspsaga outline<CR>")

            silent_keymap("n", "K", "<cmd>Lspsaga hover_doc<CR>")
            silent_keymap("n", "K", "<cmd>Lspsaga hover_doc ++keep<CR>")

            silent_keymap("n", "<Leader>ci", "<cmd>Lspsaga incoming_calls<CR>")
            silent_keymap("n", "<Leader>co", "<cmd>Lspsaga outgoing_calls<CR>")

            silent_keymap({ "n", "t" }, "<A-d>", "<cmd>Lspsaga term_toggle<CR>")
        end,
    },
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
        },
        config = function()
            local cmp = require("cmp")
            local lspconf = require("lspconfig")
            local zero = require("lsp-zero")

            zero.on_attach(function(_, bufnr)
                zero.default_keymaps({ buffer = bufnr })
            end)

            zero.set_sign_icons({
                error = "→",
                warn = "→",
                hint = "󰌵→",
                info = "→",
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

            require("lspconfig.configs").glas = {
                default_config = {
                    cmd = { "glas" },
                    filetypes = { "gleam" },
                    root_dir = lspconf.util.root_pattern("gleam.toml", ".git"),
                    settings = {},
                },
            }

            zero.setup_servers({
                "clangd",
                "grammarly",
                "teal_ls",
                "jsonls",
                "tsserver",
                "bashls",
                "glas",
                --"gleam",
            })

            lspconf.yamlls.setup({
                settings = {
                    yaml = {
                        ["https://json.schemastore.org/github-workflow.json"] = "/.github/workflows/*",
                        ["https://github.com/catppuccin/catppuccin/raw/main/resources/ports.schema.json"] = "/resources/ports.yml",
                    },
                },
            })

            lspconf.lua_ls.setup(zero.nvim_lua_ls({
                settings = {
                    workspace = {
                        library = { os.getenv("HOME") .. "/.local/share/lua/any" },
                    },
                },
            }))

            lspconf.grammarly.setup({
                cmd = { "n", "run", "16", "/usr/local/bin/grammarly-languageserver", "--stdio" },
            })

            lspconf.emmet_language_server.setup({
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

            zero.setup()

            -- Config lspsaga
            require("lspsaga").setup({})

            local cmp_action = require("lsp-zero").cmp_action()
            require("luasnip.loaders.from_vscode").lazy_load()

            cmp.setup(vim.tbl_deep_extend("force", cmp.get_config(), {
                mapping = cmp.mapping.preset.insert({
                    ["<CR>"] = cmp.mapping.confirm({ select = false }),

                    ["<C-Space>"] = cmp.mapping.complete(),

                    ["<C-f>"] = cmp_action.luasnip_jump_forward(),
                    ["<C-b>"] = cmp_action.luasnip_jump_backward(),

                    ["<C-u>"] = cmp.mapping.scroll_docs(-4),
                    ["<C-d>"] = cmp.mapping.scroll_docs(4),
                }),
                formatting = {
                    fields = { "abbr", "kind", "menu" },
                    format = require("lspkind").cmp_format({
                        mode = "symbol_text",
                        maxwidth = 50,
                        ellipsis_char = "~",
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

            -- Config cmp-dictionary
            local cmp_dict = require("cmp_dictionary")

            cmp_dict.setup({ async = true })
            cmp_dict.switcher({
                filetype = {
                    markdown = {
                        vim.fn.stdpath("config") .. "/dict/en.dict",
                        vim.fn.stdpath("config") .. "/dict/id.dict",
                    },
                },
            })

            -- Config autopairs
            local cmp_autopairs = require("nvim-autopairs.completion.cmp")
            cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
        end,
    },
}
