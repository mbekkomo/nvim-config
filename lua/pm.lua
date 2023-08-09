---@param tbl table
---@return table
local function table_copy(tbl)
    local buff = {}
    for k, v in pairs(tbl) do
        buff[k] = v
    end
    return buff
end

---@param tbl table
---@param ... any
---@return ...
local function table_remval(tbl, ...)
    local return_val = {}
    for i, v in ipairs(tbl) do
        for j = 1, select("#", ...) do
            if select(j, ...) == v then
                return_val[#return_val + 1] = table.remove(tbl, i)
            end
        end
    end
    return unpack(return_val)
end

local plugins = {
    {
        "catppuccin/nvim",
        name = "catppuccin",
        config = function()
            require("catppuccin").setup({
                no_italic = true,
                term_colors = true,
            })
            vim.cmd.colorscheme("catppuccin")
        end,
    },
    {
        "romgrk/barbar.nvim",
        dependencies = "nvim-tree/nvim-web-devicons",
        config = function()
            require("bufferline").setup({
                icons = { modified = { button = "£" } },
            })
        end,
    },
    { "glepnir/lspsaga.nvim", event = "BufRead" },
    {
        "VonHeikemen/lsp-zero.nvim",
        branch = "v2.x",
        dependencies = {
            "neovim/nvim-lspconfig",
            "hrsh7th/nvim-cmp",
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-path",
            "hrsh7th/cmp-nvim-lsp-signature-help",
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
            -- Config lsp-zero
            local lsp = require("lsp-zero").preset({})

            lsp.on_attach(function(_, bufnr)
                lsp.default_keymaps({ buffer = bufnr })
            end)

            lsp.setup_servers({
                "clangd",
                "grammarly",
                "teal_ls",
                "jsonls",
                "tsserver",
            })

            lsp.configure("bashls", {
                cmd_env = { SHELLCHECK_PATH = "/usr/local/bin/shellcheck" },
            })

            lsp.configure("yamlls", {
                settings = {
                    yaml = {
                        ["https://json.schemastore.org/github-workflow.json"] = "/.github/workflows/*",
                        ["https://github.com/catppuccin/catppuccin/raw/main/resources/ports.schema.json"] = "/resources/ports.yml",
                    },
                },
            })

            lsp.configure(
                "lua_ls",
                lsp.nvim_lua_ls({
                    settings = {
                        workspace = {
                            library = { os.getenv("HOME") .. "/.luarocks/share/lua/5.4" },
                        },
                    },
                })
            )

            lsp.configure("grammarly", {
                cmd = { "n", "run", "16", "/usr/local/bin/grammarly-languageserver", "--stdio" },
            })

            lsp.nvim_workspace()
            lsp.setup()

            -- Config lspsaga
            require("lspsaga").setup({})

            local cmp = require("cmp")
            local cmp_action = require("lsp-zero").cmp_action()

            cmp.setup({
                mapping = {
                    ["<CR>"] = cmp.mapping.confirm({ select = false }),
                    ["<C-Space>"] = cmp.mapping.complete(),
                    ["<C-f>"] = cmp_action.luasnip_jump_forward(),
                    ["<C-b>"] = cmp_action.luasnip_jump_backward(),
                },
                formatting = {
                    -- Config lspkind for cmp
                    format = require("lspkind").cmp_format({
                        maxwidth = 50,
                        ellipsis_char = "...",
                    }),
                },
                sources = {
                    -- lsp-signature-help
                    { name = "nvim_lsp_signature_help" },
                    -- dictionary
                    { name = "dictionary", keyword_length = 2 },
                    -- conjure
                    { name = "conjure" },
                    -- default lsp-zero
                    { name = "nvim_lsp" },
                    { name = "buffer" },
                    { name = "luasnip" },
                    { name = "nvim_lua" },
                    { name = "path" },
                },
            })

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
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        dependencies = {
            "nvim-treesitter/playground",
            "HiPhish/nvim-ts-rainbow2",
        },
        config = function()
            local lang = {
                "lua",
                "fennel",
                "c",
                "cpp",
                "javascript",
                "typescript",
                "cue",
                "teal",
                "json",
                "yaml",
                "bash",
                "query",
                "scheme",
            }

            require("nvim-treesitter.configs").setup({
                ensure_installed = {
                    "lua",
                    "fennel",
                    "c",
                    "cpp",
                    "javascript",
                    "typescript",
                    "cue",
                    "teal",
                    "json",
                    "yaml",
                    "bash",
                    "query",
                    "scheme",
                },
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
                rainbow = {
                    enable = true,
                    disable = (function()
                        local tmp_lang = table_copy(lang)
                        table_remval(tmp_lang, "scheme")
                        table_remval(tmp_lang, "fennel")
                        return tmp_lang
                    end)(),
                    query = "rainbow-parens",
                    strategy = require("ts-rainbow").strategy.global,
                },
            })
        end,
    },
    {
        "brenoprata10/nvim-highlight-colors",
        config = function()
            vim.opt.termguicolors = true

            require("nvim-highlight-colors").setup({})
        end,
    },
    {
        "Olical/conjure",
        dependencies = {
            "Olical/aniseed",
        },
    },
    { "mg979/vim-visual-multi" },
    { "glepnir/galaxyline.nvim" },
    {
        "jeffkreeftmeijer/vim-numbertoggle",
        config = function()
            vim.opt.number = true
        end,
    },
    { "xigoi/vim-arturo" },
    { "edubart/nelua-vim" },
    {
        name = "vim-arturo",
        dir = os.getenv("HOME") .. "/project/vim-arturo",
    },
    { "NoahTheDuke/vim-just" },
    {
        "christoomey/vim-tmux-navigator",
        lazy = false,
    },
    {
        "vincent178/nvim-github-linker",
        config = function()
            require("nvim-github-linker").setup()
        end,
    },
    {
        "bakpakin/janet.vim",
    },
}

require("lazy").setup(plugins)

local cmd = io.popen("ls $NVIMAFTERLUA")
---@diagnostic disable:need-check-nil
for f in cmd:lines() do
    dofile(os.getenv("NVIMAFTERLUA") .. "/" .. f)
end
cmd:close()
---@diagnostic enable:need-check-nil
