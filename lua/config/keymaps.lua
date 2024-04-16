local keymaps = {
    [{ "n", "<Leader>q" }] = ":q<CR>",
    [{ "n", "<Leader>wq" }] = ":wq<CR>",
    [{ "n", "<Leader>aq" }] = ":qa<CR>",
    [{ "n", "<Leader>awq" }] = ":wqa<CR>",
    [{ "n", "<Leader>ww" }] = ":w<CR>",
    [{ "n", "<Leader>aww" }] = ":wa<CR>",
    [{ "n", "<Leader>.q" }] = ":q!<CR>",
    [{ "n", "<Leader>.wq" }] = ":wq!<CR>",
    [{ "n", "<Leader>.aq" }] = ":qa!<CR>",
    [{ "n", "<Leader>.awq" }] = ":wqa!<CR>",
    [{ "n", "<Leader>.ww" }] = ":w!<CR>",
    [{ "n", "<Leader>.aww" }] = ":wa!<CR>",

    [{ "n", "<Leader>bq" }] = ":BufferClose<CR>",
    [{ "n", "<Leader>b.q" }] = ":BufferClose!<CR>",
    [{ "n", "<Leader>baq" }] = ":BufferCloseAllButPinned<CR>",
    [{ "n", "<Leader>bwq" }] = ":w|BufferClose<CR>",

    [{ "n", "<Leader>cl" }] = ":close<CR>",
}

for opts, cb in pairs(keymaps) do
    local map = table.remove(opts, #opts)

    vim.keymap.set(opts, map, cb)
end
