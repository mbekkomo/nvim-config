if vim.loader then
    vim.loader.enable()
end
vim.uv = vim.loop

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable",
        lazypath,
    })
end

vim.opt.rtp:prepend(lazypath)

return function(opts)
    opts = vim.tbl_deep_extend("force", {
        spec = {
            { import = "plugins" },
        },
        install = {
            colorscheme = { "kanagawa-dragon", "habamax" },
        },
    }, opts or {})

    require("lazy").setup(opts)
end
