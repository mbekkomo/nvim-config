local C = require("kanagawa.colors").setup({ theme = "wave" }).palette
local cond = require("utils.conditions")

local config = {
    options = {
        component_separators = "",
        section_separators = "",
        theme = {
            normal = { c = { fg = C.fujiWhite, bg = C.sumiInk0 } },
            inactive = { c = { fg = C.fujiWhite, bg = C.sumiInk0 } },
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
    config.sections.lualine_c[#config.sections.lualine_c + 1] = component
end

local function right(component)
    config.sections.lualine_x[#config.sections.lualine_x + 1] = component
end

left({
    function()
        return "▌"
    end,
    color = { fg = C.crystalBlue },
    padding = 0,
})

left({
    function()
        return "󰄛"
    end,
    color = function()
        local mcolor = {
            n = C.crystalBlue,
            i = C.autumnGreen,
            v = C.oniViolet,
            V = C.oniViolet,
            ["\22"] = C.oniViolet,
            c = C.surimiOrange,
            no = C.crystalBlue,
            s = C.oniViolet,
            S = C.oniViolet,
            ["\19"] = C.oniViolet,
            ic = C.autumnYellow,
            R = C.autumnRed,
            Rv = C.autumnRed,
            cv = C.surimiOrange,
            ce = C.surimiOrange,
            r = C.springBlue,
            rm = C.springBlue,
            ["r?"] = C.springBlue,
            ["!"] = C.crystalBlue,
            t = C.autumnGreen,
        }

        return { fg = mcolor[vim.fn.mode()], gui = "bold" }
    end,
    padding = { right = 1 },
})

left({
    "filesize",
    cond = cond.buffer_not_empty,
})

left({
    "filetype",
    cond = cond.buffer_not_empty,
    icon_only = true,
    padding = { left = 1, right = 0 },
    color = { gui = "bold" },
})

left({
    "filename",
    cond = cond.buffer_not_empty,
    symbols = {
        modified = "󰏫",
        readonly = "󰏯",
    },
    color = { gui = "bold" },
})

left({ "location" })

left({
    "progress",
    color = { gui = "bold" },
})

left({
    "diagnostics",
    sources = { "nvim_diagnostic" },
    symbols = { error = " ", warn = " ", info = " ", hint = "󰌵 " },
    diagnostics_color = {
        color_error = { fg = C.samuraiRed },
        color_warn = { fg = C.roninYellow },
        color_info = { fg = C.waveAqua1 },
    },
})

right({
    "o:encoding",
    cond = cond.hide_in_width,
    fmt = string.upper,
    color = { fg = C.autumnRed, gui = "bold" },
})

right({
    "fileformat",
    color = { fg = C.autumnRed, gui = "bold" },
})

right({
    "branch",
    icon = "",
    color = { fg = C.springViolet1, gui = "bold" },
    padding = { left = 1 },
})

right({
    function()
        return "▐"
    end,
    color = { fg = C.crystalBlue },
    padding = 0,
})

return config
