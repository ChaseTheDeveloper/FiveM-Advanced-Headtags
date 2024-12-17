Config = {}
-- there is also a command for this
Config.Keybind = "HOME"
Config.TagDistance = 10
Config.DefaultColor = { r = 0, g = 172, b = 255 }
Config.DefaultTag = {
    tag = "Civilian",
    color = Config.DefaultColor,
    spacing = 0.037
}
-- if you reset the resource while in server it will put you on the defualt tag

-- to test these to get the spacing correct go down and set your developer role to use the command tagtest 
-- here is an example /tagtest Owner so its like this /tagtest {your_tag_name} 
Config.DiscordRoles = {
    ["ROLE-ID"] = {
        tag = "Owner",
        color = { r = 255, g = 94, b = 0 },
        spacing = 0.035,
        priority = 8
    },
    ["ROLE-ID"] = {
        tag = "Co-Owner",
        color = { r = 255, g = 171, b = 0 },
        spacing = 0.054,
        priority = 7
    },
    ["ROLE-ID"] = {
        tag = "Development Team",
        color = { r = 162, g = 255, b = 0 },
        spacing = 0.100,
        priority = 6
    },
    ["ROLE-ID"] = {
        tag = "High Staff Team",
        color = { r = 194, g = 245, b = 26 },
        spacing = 0.083,
        priority = 5
    },
    ["ROLE-ID"] = {
        tag = "Senior Staff Team",
        color = { r = 245, g = 26, b = 26 },
        spacing = 0.092,
        priority = 4
    },
    ["ROLE-ID"] = {
        tag = "Staff Team",
        color = { r = 196, g = 0, b = 255 },
        spacing = 0.056,
        priority = 3
    },
    ["ROLE-ID"] = {
        tag = "Booster",
        color = { r = 128, g = 0, b = 255 },
        spacing = 0.041,
        priority = 2
    },
    ["ROLE-ID"] = {
        tag = "Civilian",
        color = { r = 0, g = 172, b = 255 },
        spacing = 0.035,
        priority = 1
    }
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
Config.BackGroundColor = '#FCFCFC'
Config.TextColor = '#070707'
Config.Length = "5000" -- in MS

-- developers
Config.DeveloperRole = "1297732795224952852"
-- this allows you to use the command /tagtest and you can set your tag as any tag for 10 seconds