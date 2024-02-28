local runner = {
    lua = "lua %f %*",
}

return {
    add_runner = function(ft, cmd)
        runner[ft] = cmd
        return true
    end,
    append_runners = function(t)
        for ft, cmd in pairs(t) do
            runner[ft] = cmd
        end
        return true
    end,
    runners = runner,
}
