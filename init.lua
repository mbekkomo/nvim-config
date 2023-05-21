vim.opt.shell = "bash"

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
end

vim.opt.rtp:prepend(lazypath)

vim.g.mapleader = " " -- make sure mapping is correct

local cmd = io.popen("ls $NVIMLUA")
for f in cmd:lines() do
    require(f:gsub("%.lua$", ""))
end
cmd:close()
