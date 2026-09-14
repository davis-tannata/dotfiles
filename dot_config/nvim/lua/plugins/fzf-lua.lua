return {
    "ibhagwan/fzf-lua",
    -- optional for icon support
    dependencies = { "nvim-tree/nvim-web-devicons" },
    -- or if using mini.icons/mini.nvim
    -- dependencies = { "echasnovski/mini.icons" },
    opts = function()
        local actions = require("fzf-lua.actions")
        return {
            -- Shared by the files + grep pickers. Alacritty here doesn't send
            -- Option as Alt, so the built-in alt-i / alt-h toggles never fire;
            -- mirror them onto ctrl-g / ctrl-y so you can flip .gitignore /
            -- hidden files on and off mid-search.
            actions = {
                files = {
                    true, -- inherit fzf-lua's default file actions (enter, splits, …)
                    ["ctrl-g"] = { fn = actions.toggle_ignore, reuse = true },
                    ["ctrl-y"] = { fn = actions.toggle_hidden, reuse = true },
                },
            },
        }
    end,
}
