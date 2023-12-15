local keymaps = {
    [{ "n", "<Leader>q" }] = "<cmd>q<CR>",
    [{ "n", "<Leader>wq" }] = "<cmd>wq<CR>",
    [{ "n", "<Leader>aq" }] = "<cmd>qa<CR>",
    [{ "n", "<Leader>awq" }] = "<cmd>wqa<CR>",
    [{ "n", "<Leader>sv" }] = "<cmd>w<CR>",
    [{ "n", "<Leader>sva" }] = "<cmd>wa<CR>",
    [{ "n", "<Leader>.q" }] = "<cmd>q!<CR>",
    [{ "n", "<Leader>.wq" }] = "<cmd>wq!<CR>",
    [{ "n", "<Leader>.aq" }] = "<cmd>qa!<CR>",
    [{ "n", "<Leader>.awq" }] = "<cmd>wqa!<CR>",
    [{ "n", "<Leader>.sv" }] = "<cmd>w!<CR>",
    [{ "n", "<Leader>.sva" }] = "<cmd>wa!<CR>",

    [{ "n", "<Leader>bq" }] = "<cmd>BufferClose<CR>",
    [{ "n", "<Leader>baq" }] = "<cmd>BufferCloseAllButPinned<CR>",
    [{ "n", "<Leader>bwq" }] = "<cmd>w|BufferClose<CR>",

    [{ "n", "<Leader>cl" }] = "<cmd>close<CR>",
}

for opts, cb in pairs(keymaps) do
    local map = table.remove(opts, #opts)

    vim.keymap.set(opts, map, cb)
end
