# THIS FILE HAS BEEN CREATED BY Chase OR Chaseman8228 ON DISCORD. DO NOT RE RELEASE IT! 

# INSTALLATION
# 1. Drag and drop into you folder
# 2. make sure you have Badger_Discord_API and Mythic_Notify correctly configured.
# 3. Edit the config file to your liking

# CONTACT
# you can contact me by joining my discord! https://discord.gg/EgctWPu7St
# Feel free to ask any questions you make have or any concerns 
# Please please please let us know if you find any bugs at all!

# EXAMPLE CONFIG 

Config = {}

-- there is also a command for this
Config.Keybind = "HOME"
Config.TagDistance = 10
Config.DefaultColor = { r = 0, g = 172, b = 255 }

Config.DiscordRoles = {
    ["1297283486591221781"] = {
        tag = "Owner",
        color = { r = 255, g = 94, b = 0 }
    },
    ["1297283492903915672"] = {
        tag = "Co-Owner",
        color = { r = 255, g = 171, b = 0 }
    },
    ["1297732795224952852"] = {
        tag = "Development Team",
        color = { r = 162, g = 255, b = 0 }
    },
    ["1297284458520641709"] = {
        tag = "High Staff Team",
        color = { r = 194, g = 245, b = 26 }
    },
    ["1297285789268316221"] = {
        tag = "Senior Staff Team",
        color = { r = 245, g = 26, b = 26 }
    },
    ["1297290946366406707"] = {
        tag = "Staff Team",
        color = { r = 196, g = 0, b = 255 }
    },
    ["1297591837556609105"] = {
        tag = "Booster",
        color = { r = 128, g = 0, b = 255 }
    },
    ["1297351691657809971"] = {
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