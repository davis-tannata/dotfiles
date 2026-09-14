-- Constants
MODIFIERS = { "cmd" } -- Modifiers used for app shortcuts

-- App configuration
APPS = {
    -- { shortcut = "1", name = "iTerm" },
-- { shortcut = "1", name = "Ghostty" },
{ shortcut = "1", name = "Alacritty" },
    { shortcut = "2", name = "Safari" },
    { shortcut = "3", name = "Google Chrome" },
    { shortcut = "4", name = "Slack" },
    { shortcut = "5", name = "Bear" },
    { shortcut = "0", name = "Spotify" },
    { shortcut = "9", name = "Discord" },
}

-- Bind application shortcuts
for _, app in ipairs(APPS) do
    hs.hotkey.bind(MODIFIERS, app.shortcut, function()
        hs.application.launchOrFocus(app.name)
    end)
end
