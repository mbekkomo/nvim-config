-- For Visual-Multi
vim.cmd([[
let g:VM_maps = {}

let g:VM_maps["Select Cursor Up"] = "su"
let g:VM_maps["Select Cursor Down"] = "sd"
]])

local keymap = vim.keymap.set

local function n_keymap(...)
    local vararg = { ... }
    ---@type table
    local modes = table.remove(vararg, 1)

    if type(modes) == "table" then
        modes[#modes + 1] = "n"
        keymap(modes, unpack(vararg))
    else
        keymap("n", ...)
    end
end

-- For lspsaga
n_keymap("gh", "<cmd>Lspsaga lsp_finder<CR>")

n_keymap({ "v" }, "<leader>ca", "<cmd>Lspsaga code_action<CR>")

n_keymap("gr", "<cmd>Lspsaga rename<CR>")

n_keymap("gR", "<cmd>Lspsaga rename ++project<CR>")

n_keymap("gd", "<cmd>Lspsaga peek_definition<CR>")

n_keymap("gD", "<cmd>Lspsaga goto_definition<CR>")

n_keymap("gt", "<cmd>Lspsaga peek_type_definition<CR>")

n_keymap("gT", "<cmd>Lspsaga goto_type_definition<CR>")

n_keymap("<leader>sl", "<cmd>Lspsaga show_line_diagnostics<CR>")

n_keymap("<leader>sc", "<cmd>Lspsaga show_cursor_diagnostics<CR>")

n_keymap("<leader>sb", "<cmd>Lspsaga show_buf_diagnostics<CR>")

n_keymap("<leader>pe", "<cmd>Lspsaga diagnostic_jump_prev<CR>")
n_keymap("<leader>ne", "<cmd>Lspsaga diagnostic_jump_next<CR>")

n_keymap("<leader>Pe", function()
    require("lspsaga.diagnostic"):goto_prev({ severity = vim.diagnostic.severity.ERROR })
end)
n_keymap("<leader>Ne", function()
    require("lspsaga.diagnostic"):goto_next({ severity = vim.diagnostic.severity.ERROR })
end)

n_keymap("<leader>o", "<cmd>Lspsaga outline<CR>")

n_keymap("K", "<cmd>Lspsaga hover_doc<CR>")

n_keymap("K", "<cmd>Lspsaga hover_doc ++keep<CR>")

n_keymap("<Leader>ci", "<cmd>Lspsaga incoming_calls<CR>")
n_keymap("<Leader>co", "<cmd>Lspsaga outgoing_calls<CR>")

n_keymap({ "t" }, "<A-d>", "<cmd>Lspsaga term_toggle<CR>")

-- For vim-tmux-navigator
n_keymap("<C-h>", "<cmd>TmuxNavigatorLeft<CR>")
n_keymap("<C-l>", "<cmd>TmuxNavigatorRight<CR>")
n_keymap("<C-j>", "<cmd>TmuxNavigatorDown<CR>")
n_keymap("<C-k>", "<cmd>TmuxNavigatorUp<CR>")

-- For personal use
n_keymap("<Leader>q", "<cmd>q<CR>")
n_keymap("<Leader>wq", "<cmd>wq<CR>")
n_keymap("<Leader>aq", "<cmd>qa<CR>")
n_keymap("<Leader>awq", "<cmd>wqa<CR>")
n_keymap("<Leader>.q", "<cmd>q!<CR>")
n_keymap("<Leader>.wq", "<cmd>wq!<CR>")
n_keymap("<Leader>.aq", "<cmd>qa!<CR>")
n_keymap("<Leader>.awq", "<cmd>wqa!<CR>")

n_keymap("<Leader>bq", "<cmd>BufferClose<CR>")
n_keymap("<Leader>baq", "<cmd>BufferCloseAllButPinned<CR>")
n_keymap("<Leader>bwq", "<cmd>w|BufferClose<CR>")

n_keymap("<Leader>cl", "<cmd>close<CR>")
