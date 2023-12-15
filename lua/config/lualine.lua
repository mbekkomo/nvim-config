local C = require("catppuccin.palettes").get_palette()
local cond = require("utils.conditions")

local config = {
  options = {
    component_separators = "",
    section_separators = "",
    theme = {
      normal = { c = { fg = C.text, bg = "#45475a" } },
      inactive = { c = { fg = C.text, bg = "#45475a" } },
    },
  },
  sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_y = {},
    lualine_z = {},
    lualine_c = {},
    lualine_x = {},
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_y = {},
    lualine_z = {},
    lualine_c = {},
    lualine_x = {},
  },
}

local function left(component)
  config.sections.lualine_c[#config.sections.lualine_c+1] = component
end

local function right(component)
    config.sections.lualine_x[#config.sections.lualine_x+1] = component
end

left {
    function()
        return "▌"
    end,
    color = { fg = C.blue },
    padding = 0,
}

left {
    function()
        return "󰄛"
    end,
    color = function()
        local mcolor = {
            n = C.blue,
            i = C.green,
            v = C.mauve,
            V = C.mauve,
            ["\22"] = C.mauve,
            c = C.peach,
            no = C.blue,
            s = C.mauve,
			S = C.mauve,
            ["\19"] = C.mauve,
            ic = C.yellow,
            R = C.red,
            Rv = C.red,
            cv = C.peach,
            ce = C.peach,
            r = C.sky,
            rm = C.sky,
            ["r?"] = C.sky,
            ["!"] = C.blue,
            t = C.green,
        }

        return { fg = mcolor[vim.fn.mode()], gui = "bold" }
    end,
    padding = { right = 1 },
}

left {
    "filesize",
    cond = cond.buffer_not_empty,
}

left {
    "filetype",
    cond = cond.buffer_not_empty,
    icon_only = true,
    padding = { left = 1, right = 0 },
    color = { gui = "bold" },
}

left {
    "filename",
    cond = cond.buffer_not_empty,
    symbols = {
        modified = "󰏫",
        readonly = "󰏯",
    },
    color = { gui = "bold" },
}

left { "location" }

left {
    "progress",
    color = { gui = "bold" },
}

left {
    "diagnostics",
    sources = { "nvim_diagnostic" },
    symbols = { error = " ", warn = " ", info = " ", hint = "󰌵 " },
    diagnostics_color = {
        color_error = { fg = C.red },
        color_warn = { fg = C.yellow },
        color_info = { fg = C.sky },
    },
}

right {
    "o:encoding",
    cond = cond.hide_in_width,
    fmt = string.upper,
    color = { fg = C.maroon, gui = "bold" },
}

right {
    "fileformat",
    color = { fg = C.maroon, gui = "bold" },
}

right {
    "branch",
    icon = "",
    color = { fg = C.lavender, gui = "bold" },
    padding = { left = 1 },
}

right {
    function()
        return "▐"
    end,
    color = { fg = C.blue },
    padding = 0
}

return config
