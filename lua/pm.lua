local plugins =
	{
        { "catppuccin/nvim"
        ; name = "catppuccin"
        ; config = function()
            require "catppuccin".setup {
                no_italic = true
            }

            vim.cmd.colorscheme "catppuccin"
          end
        },
        { "romgrk/barbar.nvim"
        ; dependencies = "nvim-tree/nvim-web-devicons"
        ; config = function()
            require "bufferline".setup {
                icon_close_tab_modified = "£"
            }
          end
        },
        { "glepnir/lspsaga.nvim"
        ; event = "BufRead"
  	    },
        { "VonHeikemen/lsp-zero.nvim"
        ; branch = "v1.x"
        ; dependencies = {
            "neovim/nvim-lspconfig",
            "hrsh7th/nvim-cmp",
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-path",
            "saadparwaiz1/cmp_luasnip",
            "hrsh7th/cmp-nvim-lua",
            "L3MON4D3/LuaSnip",
            "rafamadriz/friendly-snippets"
          }
        ; config = function()
            -- Config lsp-zero
            local lsp = require "lsp-zero".preset {
                name = 'minimal',
                set_lsp_keymaps = true,
                manage_nvim_cmp = true,
                suggest_lsp_servers = false
            }

            lsp.nvim_workspace()
            lsp.setup()

            -- Config lspsaga
            require "lspsaga".setup {}
          end
	    },
        { "nvim-treesitter/nvim-treesitter"
        ; build = ":TSUpdate"
        ; config = function ()
            require "nvim-treesitter.configs".setup {
                ensure_installed = { "lua", "fennel", "c", "cpp",
                "javascript", "typescript", "cue" },

                highlight = {
                    enable = true,
                    disable = function(_, buf)
                        local max_filesize = 100 * 1024
                        local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
                        if ok and stats and stats.size > max_filesize then
                            return true
                        end
                    end,

                    additional_vim_regex_highlighting = false
                }
            }
          end
        },
	    { "mg979/vim-visual-multi"
	    },
        { "glepnir/galaxyline.nvim"
        },
        { "jeffkreeftmeijer/vim-numbertoggle"
        },
        { "kongo2002/fsharp-vim"
        }
    }

require "lazy".setup(plugins)

local cmd = io.popen "ls $NVIMAFTERLUA"
---@diagnostic disable:need-check-nil
for f in cmd:lines() do
    dofile(os.getenv "NVIMAFTERLUA"..'/'..f)
end; cmd:close()
---@diagnostic enable:need-check-nil
