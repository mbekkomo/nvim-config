local plugins = {
  { "catppuccin/nvim",
    name = "catppuccin",
    config = function()
      require("catppuccin").setup({ no_italic = true })
      vim.cmd.colorscheme("catppuccin")
    end,
  },
  { "romgrk/barbar.nvim",
    dependencies = "nvim-tree/nvim-web-devicons",
    config = function()
      require("bufferline").setup({
        icons = { modified = { button = "£" } },
      })
    end,
  },
  { "glepnir/lspsaga.nvim", event = "BufRead" },
  { "VonHeikemen/lsp-zero.nvim",
    branch = "v1.x",
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
    },
    config = function()
      -- Config lsp-zero
      local lsp = require("lsp-zero").preset({
        name = "minimal",
        set_lsp_keymaps = true,
        manage_nvim_cmp = true,
        suggest_lsp_servers = false,
      })

      lsp.setup_servers({
        "clangd",
        "grammarly",
        "teal_ls",
        "jsonls",
      })

      lsp.configure("bashls", {
        cmd_env = { SHELLCHECK_PATH = "/usr/local/bin/shellcheck" },
      })

      lsp.configure("yamlls", {
        settings = {
          yaml = {
            ["https://json.schemastore.org/github-workflow.json"] = "/.github/workflows/*",
          },
        },
      })

      lsp.nvim_workspace()
      lsp.setup()

      -- Config lspsaga
      require("lspsaga").setup({})

      local cmp = require("cmp")

      cmp.setup({
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
          markdown = os.getenv("NVIMDIR") .. "/dict/en.dict",
        },
      })

      -- Config autopairs
      local cmp_autopairs = require("nvim-autopairs.completion.cmp")
      cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
    end,
  },
  { "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
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
        },
        highlight = {
          enable = true,
          disable = function(_, buf)
            local max_filesize = 100 * 1024
            local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
            if ok and stats and stats.size > max_filesize then
              return true
            end
          end,
          additional_vim_regex_highlighting = false,
        },
      })
    end,
  },
  { "brenoprata10/nvim-highlight-colors",
    config = function()
      vim.opt.termguicolors = true

      require("nvim-highlight-colors").setup({})
    end,
  },
  { "mg979/vim-visual-multi" },
  { "glepnir/galaxyline.nvim" },
  { "jeffkreeftmeijer/vim-numbertoggle",
    config = function()
      vim.opt.number = true
    end,
  },
  { "xigoi/vim-arturo" },
  { "edubart/nelua-vim" },
}

require("lazy").setup(plugins)

local cmd = io.popen "ls $NVIMAFTERLUA"
---@diagnostic disable:need-check-nil
for f in cmd:lines() do
    dofile(os.getenv "NVIMAFTERLUA"..'/'..f)
end; cmd:close()
---@diagnostic enable:need-check-nil
