return {
    {
        "romgrk/barbar.nvim",
        dependencies = "nvim-tree/nvim-web-devicons",
        config = function()
            require("bufferline").setup({
                icons = { modified = { button = "£" } },
            })
        end,
    },
    {
        "glepnir/galaxyline.nvim",
        config = function()
            local gl = require("galaxyline")
            local gls = gl.section
            gl.short_line_list = { "NvimTree", "vista", "dbui" }

            local colors = {
                bg = "#313244",
                fg = "#cdd6f4",
                yellow = "#f9e2af",
                cyan = "#89dceb",
                darkblue = "#181825",
                green = "#a6e3a1",
                orange = "#fab387",
                violet = "#f5c2e7",
                magenta = "#cba6f7",
                blue = "#89b4fa",
                red = "#f38ba8",
            }

            local buffer_not_empty = function()
                if vim.fn.empty(vim.fn.expand("%:t")) ~= 1 then
                    return true
                end
                return false
            end

            gls.left[1] = {
                ViMode = {
                    provider = function()
                        -- auto change color according the vim mode
                        local mode_color = {
                            n = colors.magenta,
                            i = colors.green,
                            v = colors.blue,
                            ["␖"] = colors.blue,
                            V = colors.blue,
                            c = colors.red,
                            no = colors.magenta,
                            s = colors.orange,
                            S = colors.orange,
                            ["␓"] = colors.orange,
                            ic = colors.yellow,
                            R = colors.violet,
                            Rv = colors.violet,
                            cv = colors.red,
                            ce = colors.red,
                            r = colors.cyan,
                            rm = colors.cyan,
                            ["r?"] = colors.cyan,
                            ["!"] = colors.red,
                            t = colors.red,
                        }
                        vim.cmd("hi GalaxyViMode guibg=" .. mode_color[vim.fn.mode()])
                        return "  🐱 "
                    end,
                    highlight = { colors.fg, colors.red, "bold" },
                },
            }

            gls.left[2] = {
                Separator = {
                    provider = function() return " " end,
                    highlight = { "NONE", colors.bg },
                }
            }

            gls.left[3] = {
                FileSize = {
                    provider = "FileSize",
                    condition = buffer_not_empty,
                    highlight = { colors.fg, colors.bg },
                },
            }
            gls.left[4] = {
                FileIcon = {
                    provider = "FileIcon",
                    condition = buffer_not_empty,
                    highlight = { require("galaxyline.provider_fileinfo").get_file_icon_color, colors.bg },
                },
            }

            gls.left[5] = {
                FileName = {
                    provider = { "FileName" },
                    condition = buffer_not_empty,
                    highlight = { colors.green, colors.bg, "bold" },
                },
            }

            gls.left[6] = {
                LineInfo = {
                    provider = "LineColumn",
                    separator = " ",
                    separator_highlight = { "NONE", colors.bg },
                    highlight = { colors.fg, colors.bg },
                },
            }

            gls.left[7] = {
                DiagnosticError = {
                    provider = "DiagnosticError",
                    icon = "  ",
                    highlight = { colors.red, colors.bg },
                },
            }
            gls.left[8] = {
                DiagnosticWarn = {
                    provider = "DiagnosticWarn",
                    icon = "  ",
                    highlight = { colors.yellow, colors.bg },
                },
            }

            gls.left[9] = {
                DiagnosticHint = {
                    provider = "DiagnosticHint",
                    icon = "  ",
                    highlight = { colors.cyan, colors.bg },
                },
            }

            gls.left[10] = {
                DiagnosticInfo = {
                    provider = "DiagnosticInfo",
                    icon = "  ",
                    highlight = { colors.blue, colors.bg },
                },
            }

            gls.right[1] = {
                FileEncode = {
                    provider = "FileEncode",
                    separator = " ",
                    separator_highlight = { "NONE", colors.bg },
                    highlight = { colors.cyan, colors.bg, "bold" },
                },
            }

            gls.right[2] = {
                FileFormat = {
                    provider = "FileFormat",
                    separator = " ",
                    separator_highlight = { "NONE", colors.bg },
                    highlight = { colors.cyan, colors.bg, "bold" },
                },
            }

            gls.right[3] = {
                GitIcon = {
                    provider = function()
                        return " "
                    end,
                    condition = require("galaxyline.provider_vcs").check_git_workspace,
                    separator = " ",
                    separator_highlight = { "NONE", colors.bg },
                    highlight = { colors.violet, colors.bg, "bold" },
                },
            }

            gls.right[4] = {
                GitBranch = {
                    provider = "GitBranch",
                    condition = require("galaxyline.provider_vcs").check_git_workspace,
                    highlight = { colors.violet, colors.bg, "bold" },
                },
            }

            local checkwidth = function()
                local squeeze_width = vim.fn.winwidth(0) / 2
                if squeeze_width > 40 then
                    return true
                end
                return false
            end

            gls.right[5] = {
                DiffAdd = {
                    provider = "DiffAdd",
                    condition = checkwidth,
                    icon = "  ",
                    highlight = { colors.green, colors.bg },
                },
            }
            gls.right[6] = {
                DiffModified = {
                    provider = "DiffModified",
                    condition = checkwidth,
                    icon = " 柳",
                    highlight = { colors.orange, colors.bg },
                },
            }
            gls.right[7] = {
                DiffRemove = {
                    provider = "DiffRemove",
                    condition = checkwidth,
                    icon = "  ",
                    highlight = { colors.red, colors.bg },
                },
            }

            gls.short_line_left[1] = {
                BufferType = {
                    provider = "FileTypeName",
                    separator = " ",
                    separator_highlight = { "NONE", colors.bg },
                    highlight = { colors.blue, colors.bg, "bold" },
                },
            }

            gls.short_line_left[2] = {
                SFileName = {
                    provider = function()
                        local fileinfo = require("galaxyline.provider_fileinfo")
                        local fname = fileinfo.get_current_file_name()
                        for _, v in ipairs(gl.short_line_list) do
                            if v == vim.bo.filetype then
                                return ""
                            end
                        end
                        return fname
                    end,
                    condition = buffer_not_empty,
                    highlight = { colors.white, colors.bg, "bold" },
                },
            }

            gls.short_line_right[1] = {
                BufferIcon = {
                    provider = "BufferIcon",
                    highlight = { colors.fg, colors.bg },
                },
            }
        end
    }
}
