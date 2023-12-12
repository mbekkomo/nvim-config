local is_executable = require("utils.utils").is_executable

return {
    {
        "andweeb/presence.nvim",
        cond = is_executable(os.getenv("DISCORD_PATH") or "discord"),
        config = function()
            require("presence").setup({
                client_id = os.getenv("DISCORD_CLIENT_ID"),

                editing_text = "Me ewditing %s :3",
                file_explorer_text = "Me bwosing dwirectwowy %s OωO",
                git_commit_text = "Me cwommiting cwanghes =ω=",
                plugin_manager_text = "Me mwanagwing pwugins ^ω^",
                reading_text = "Me rweading %s -oωo-",
                workspace_text = "Me on gwit repwo %s >ω<",
                line_number_text = "Me in line %s \\+ω+",
            })
        end,
    },
}
