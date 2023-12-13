---@param tbl table
---@return table
local function table_copy(tbl)
    local buff = {}
    for k, v in pairs(tbl) do
        buff[k] = v
    end
    return buff
end

---@param tbl table
---@param ... any
---@return ...
local function table_remval(tbl, ...)
    local return_val = {}
    for i, v in ipairs(tbl) do
        for j = 1, select("#", ...) do
            if select(j, ...) == v then
                return_val[#return_val + 1] = table.remove(tbl, i)
            end
        end
    end
    return unpack(return_val)
end

---@param fn function
---@param ... table
---@return ...any
local function with(fn, ...)
    local tbl = { ... }
    setfenv(
        fn,
        setmetatable({}, {
            __index = function(_, ind)
                return _G[ind]
                    or (function()
                        for _, v in pairs(tbl) do
                            if v[ind] then
                                return v[ind]
                            end
                        end
                    end)()
            end,
        })
    )
    return fn()
end

---@param cmd string
---@return boolean
local function is_executable(cmd)
    return vim.fn.executable(cmd) == 1
end


---@param mode string|table
---@param lhs string
---@param rhs string|function
---@param opts table?
---@return table
local function silent_keymap(mode, lhs, rhs, opts)
    vim.keymap.set(mode, lhs, rhs, vim.tbl_deep_extend("force", { silent = true }, opts or {}))
end

return {
    table_copy = table_copy,
    table_remval = table_remval,
    with = with,
    is_executable = is_executable,
    silent_keymap = silent_keymap,
}
