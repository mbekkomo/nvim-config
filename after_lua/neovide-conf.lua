-- Neovide config, for my WSL2

if not vim.g.neovide then
    return
end

vim.o.guifont = "JetBrainsMono Nerd Font Mono:h10"

vim.g.neovide_transparency = 0.8

vim.g.neovide_hide_mouse_when_typing = false
