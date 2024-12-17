Config = {}

local function getRoleFromDiscord(source)
    local discordRoles = exports.Badger_Discord_API:GetDiscordRoles(source)
    print("Discord Roles for player: ", json.encode(discordRoles))
    
    for _, roleId in pairs(discordRoles) do
        if tostring(roleId) and Config.DiscordRoles[tostring(roleId)] then
            return Config.DiscordRoles[tostring(roleId)]
        end
    end
    return { tag = "Civilian", color = Config.DefaultColor }
end

RegisterNetEvent('headtags:getRoles')
AddEventHandler('headtags:getRoles', function()
    local source = source
    local role = getRoleFromDiscord(source)
    TriggerClientEvent('headtags:setRole', source, role)
end)

-- Initial role check when player connects
AddEventHandler('playerConnecting', function()
    local source = source
    Wait(1000) -- Give Discord API time to fetch roles
    local role = getRoleFromDiscord(source)
    TriggerClientEvent('headtags:setRole', source, role)
end)

exports('GetDiscordRole', getRoleFromDiscord)