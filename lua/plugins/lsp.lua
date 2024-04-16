local utils = require("utils.utils")
local is_executable = utils.is_executable

return {
    {
        "nvimdev/lspsaga.nvim",
        name = "lspsaga.nvim",
        event = "LspAttach",
        keys = {

            { "gh", "<cmd>Lspsaga lsp_finder<CR>", silent = true },

            { "<leader>ca", "<cmd>Lspsaga code_action<CR>", mode = { "v", "n" }, silent = true },

            { "gr", "<cmd>Lspsaga rename<CR>", silent = true },
            { "gR", "<cmd>Lspsaga rename ++project<CR>", silent = true },

            { "gd", "<cmd>Lspsaga peek_definition<CR>", silent = true },
            { "gD", "<cmd>Lspsaga goto_definition<CR>", silent = true },
            { "gt", "<cmd>Lspsaga peek_type_definition<CR>", silent = true },
            { "gT", "<cmd>Lspsaga goto_type_definition<CR>", silent = true },

            { "<leader>sl", "<cmd>Lspsaga show_line_diagnostics<CR>", silent = true },
            { "<leader>sc", "<cmd>Lspsaga show_cursor_diagnostics<CR>", silent = true },
            { "<leader>sb", "<cmd>Lspsaga show_buf_diagnostics<CR>", silent = true },
            { "<leader>pe", "<cmd>Lspsaga diagnostic_jump_prev<CR>", silent = true },
            { "<leader>ne", "<cmd>Lspsaga diagnostic_jump_next<CR>", silent = true },

            {
                "<leader>Pe",
                function()
                    require("lspsaga.diagnostic"):goto_prev({ severity = vim.diagnostic.severity.ERROR })
                end,
                silent = true,
            },
            {
                "<leader>Ne",
                function()
                    require("lspsaga.diagnostic"):goto_next({ severity = vim.diagnostic.severity.ERROR })
                end,
                silent = true,
            },

            { "<leader>o", "<cmd>Lspsaga outline<CR>", silent = true },

            { "K", "<cmd>Lspsaga hover_doc<CR>", silent = true },
            { "K", "<cmd>Lspsaga hover_doc ++keep<CR>", silent = true },

            { "<Leader>ci", "<cmd>Lspsaga incoming_calls<CR>", silent = true },
            { "<Leader>co", "<cmd>Lspsaga outgoing_calls<CR>", silent = true },
        },
    },
    {
        "hrsh7th/nvim-cmp",
        name = "nvim-cmp",
        dependencies = {
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-path",
            "saadparwaiz1/cmp_luasnip",
            "hrsh7th/cmp-nvim-lua",
            "L3MON4D3/LuaSnip",
            "rafamadriz/friendly-snippets",
            { "windwp/nvim-autopairs", event = "InsertEnter", opts = {} },
            "onsails/lspkind.nvim",
            "uga-rosa/cmp-dictionary",
            { "ray-x/cmp-treesitter", dependencies = { "nvim-treesitter/nvim-treesitter" } },
            "hrsh7th/cmp-nvim-lsp-signature-help",
            "hrsh7th/cmp-nvim-lsp-document-symbol",
            "lukas-reineke/cmp-under-comparator",
        },
        config = false,
    },
    {
        "VonHeikemen/lsp-zero.nvim",
        branch = "v3.x",
        dependencies = {
            "lspsaga.nvim",
            "nvim-cmp",
            "neovim/nvim-lspconfig",
        },
        config = function()
            local cmp = require("cmp")
            local lspconf = require("lspconfig")
            local zero = require("lsp-zero")

            zero.on_attach(function(_, bufnr)
                zero.default_keymaps({ buffer = bufnr })
            end)

            zero.set_sign_icons({
                error = "›",
                warn = "›",
                hint = "󰌵›",
                info = "›",
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

            zero.setup_servers({
                "clangd",
                "teal_ls",
                "jsonls",
                "tsserver",
                "bashls",
                "zls",
            })

            if is_executable("glas") then
                lspconf.gleam.setup({
                    cmd = { "glas", "--stdio" },
                })
            end

            lspconf.yamlls.setup({
                settings = {
                    yaml = {
                        ["https://json.schemastore.org/github-workflow.json"] = "/.github/workflows/*",
                        ["https://github.com/catppuccin/catppuccin/raw/main/resources/ports.schema.json"] = "/resources/ports.yml",
                    },
                },
            })

            lspconf.lua_ls.setup(zero.nvim_lua_ls())

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

            require("lspsaga").setup({})

            local cmp_action = require("lsp-zero").cmp_action()
            local luasnip = require("luasnip")
            require("luasnip.loaders.from_vscode").lazy_load()
            require("luasnip.loaders.from_snipmate").lazy_load()

            local function has_words_before()
                unpack = unpack or table.unpack
                local line, col = unpack(vim.api.nvim_win_get_cursor(0))
                return col ~= 0
                    and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
            end

            cmp.setup(vim.tbl_deep_extend("force", cmp.get_config(), {
                snippet = {
                    expand = function(args)
                        require("luasnip").lsp_expand(args.body)
                    end,
                },
                mapping = cmp.mapping.preset.insert({
                    ["<CR>"] = cmp.mapping(function(fallback)
                        if cmp.visible() then
                            if luasnip.expandable() then
                                luasnip.expand()
                            else
                                cmp.confirm({
                                    select = true,
                                })
                            end
                        else
                            fallback()
                        end
                    end),

                    ["<C-Space>"] = cmp.mapping.complete(),

                    ["<C-f>"] = cmp_action.luasnip_jump_forward(),
                    ["<C-b>"] = cmp_action.luasnip_jump_backward(),

                    ["<C-u>"] = cmp.mapping.scroll_docs(-4),
                    ["<C-d>"] = cmp.mapping.scroll_docs(4),
                    ["<Tab>"] = cmp.mapping(function(fallback)
                        if cmp.visible() then
                            cmp.select_next_item()
                        elseif luasnip.expand_or_jumpable() then
                            luasnip.expand_or_jump()
                        elseif has_words_before() then
                            cmp.complete()
                        else
                            fallback()
                        end
                    end, { "i", "s" }),

                    ["<S-Tab>"] = cmp.mapping(function(fallback)
                        if cmp.visible() then
                            cmp.select_prev_item()
                        elseif luasnip.jumpable(-1) then
                            luasnip.jump(-1)
                        else
                            fallback()
                        end
                    end, { "i", "s" }),
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
                    { name = "nvim_lsp" },
                    { name = "buffer" },
                    { name = "luasnip", option = { show_autosnippets = true } },
                    { name = "nvim_lua" },
                    { name = "path" },
                    { name = "treesitter" },
                    { name = "nvim_lsp_signature_help" },
                },
                sorting = {
                    comparators = {
                        cmp.config.compare.offset,
                        cmp.config.compare.exact,
                        cmp.config.compare.score,
                        require("cmp-under-comparator").under,
                        cmp.config.compare.kind,
                        cmp.config.compare.sort_text,
                        cmp.config.compare.length,
                        cmp.config.compare.order,
                    },
                },
            }))

            require("cmp").setup.cmdline("/", {
                sources = cmp.config.sources({
                    { name = "nvim_lsp_document_symbol" },
                }, {
                    { name = "buffer" },
                }),
            })

            local dict_dir = vim.fn.stdpath("config") .. "/dict"
            local dict = {
                ft = {
                    markdown = { dict_dir .. "/en.dict", dict_dir .. "/id.dict" },
                },
            }

            vim.api.nvim_create_autocmd("FileType", {
                pattern = "*",
                callback = function(ev)
                    local paths = dict.ft[ev.match] or {}
                    require("cmp_dictionary").setup({
                        paths = paths,
                    })
                end,
            })

            local cmp_autopairs = require("nvim-autopairs.completion.cmp")
            cmp_autopairs.filetypes = vim.tbl_deep_extend("force", cmp_autopairs.filetypes, {
                bash = false,
                sh = false,
            })
            cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
        end,
    },
}
