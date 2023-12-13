vim.g.mapleader = " "

local config_path = vim.fn.stdpath("config") .. "/lua/config"

require("config.lazy")({})

---@diagnostic disable-next-line:undefined-field
for name in vim.uv.fs_scandir_next, vim.uv.fs_scandir(config_path) do
    if not name:match("%.lua$") then break end

    local filename = config_path .. "/" .. name
    local fn, err = loadfile(filename, "t")
    if not fn and err then
        vim.notify(("failed loading config [%s]: %s"):format(filename, err), vim.log.levels.WARN)
    end

    fn() ---@diagnostic disable-line:need-check-nil
end
