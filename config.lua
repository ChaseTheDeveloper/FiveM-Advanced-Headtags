Config = {}

-- there is also a command for this
Config.Keybind = "HOME"
Config.TagDistance = 10
Config.DefaultColor = { r = 0, g = 172, b = 255 }

Config.DiscordRoles = {
    ["123"] = {
        tag = "Owner",
        color = { r = 255, g = 94, b = 0 }
    },
    ["123"] = {
        tag = "Co Owner",
        color = { r = 255, g = 171, b = 0 }
    },
    ["123"] = {
        tag = "Development Team",
        color = { r = 162, g = 255, b = 0 }
    },
    ["123"] = {
        tag = "High Staff Team",
        color = { r = 194, g = 245, b = 26 }
    },
    ["123"] = {
        tag = "Senior Staff Team",
        color = { r = 245, g = 26, b = 26 }
    },
    ["123"] = {
        tag = "Staff Team",
        color = { r = 196, g = 0, b = 255 }
    },
    ["123"] = {
        tag = "Booster",
        color = { r = 128, g = 0, b = 255 }
    },
    ["123"] = {
        tag = "Civilian",
        color = { r = 0, g = 172, b = 255 }
    }
}

Config.TagFormat = {
    brackets = true,
    separator = " | ",
    showId = true
}

-- COLOR
Config.ShowSelfTag = true
Config.LeftBracket = { r = 87, g = 173, b = 255 }
Config.RightBracket = { r = 87, g = 173, b = 255 }
Config.SeparatorColor = { r = 87, g = 173, b = 255 }
Config.IDColor = { r = 255, g = 255, b = 255 }
Config.NameColor = { r = 255, g = 255, b = 255 }

-- Mythic Notify
Config.EnableNotify = "HeadTags Enabled"
Config.DisableNotify = "HeadTags Disabled"
Config.BackGroundColor = '#1e00ff'
Config.TextColor = '#00ff22'
Config.Length = "5000" -- in MS