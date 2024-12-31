local function getRoleFromDiscord(source)
    local discordRoles = exports.Badger_Discord_API:GetDiscordRoles(source)
    local highestPriority = 0
    local selectedRole = Config.DefaultTag
    
    print("Discord Roles for player: ", json.encode(discordRoles))
    
    if discordRoles then
        for _, roleId in pairs(discordRoles) do
            local roleIdString = tostring(roleId)
            if Config.DiscordRoles[roleIdString] then
                local rolePriority = Config.DiscordRoles[roleIdString].priority or 0
                if rolePriority > highestPriority then
                    highestPriority = rolePriority
                    selectedRole = Config.DiscordRoles[roleIdString]
                end
            end
        end
    end
    
    return selectedRole
end

RegisterNetEvent('headtags:getRoles')
AddEventHandler('headtags:getRoles', function()
    local source = source
    local role = getRoleFromDiscord(source)
    TriggerClientEvent('headtags:setRole', source, role)
end)

AddEventHandler('playerConnecting', function()
    local source = source
    Wait(1000) 
    local role = getRoleFromDiscord(source)
    TriggerClientEvent('headtags:setRole', source, role)
end)

exports('GetDiscordRole', getRoleFromDiscord)

RegisterServerEvent('headtags:checkDeveloper')
AddEventHandler('headtags:checkDeveloper', function(args)
    local source = source
    local playerRoles = exports.Badger_Discord_API:GetDiscordRoles(source)
    
    local isDeveloper = false
    for _, roleId in pairs(playerRoles) do
        if tostring(roleId) == Config.DeveloperRole then
            isDeveloper = true
            break
        end
    end

    TriggerClientEvent('headtags:developerCheck', source, isDeveloper, args)
end)

RegisterCommand('settag', function(source, args)
    local playerRoles = exports.Badger_Discord_API:GetDiscordRoles(source)
    local highestRolePriority = 0
    local currentRole = nil
    
    for _, roleId in pairs(playerRoles) do
        local roleIdString = tostring(roleId)
        if Config.DiscordRoles[roleIdString] then
            if not Config.DiscordRoles[roleIdString].priority then
                print("Missing priority for role: " .. roleIdString)
                return
            end
            if Config.DiscordRoles[roleIdString].priority > highestRolePriority then
                highestRolePriority = Config.DiscordRoles[roleIdString].priority
                currentRole = Config.DiscordRoles[roleIdString]
            end
        end
    end

    if not currentRole then return end

    if args[1] then
        local requestedTag = table.concat(args, " ")
        local targetRole = nil

        for _, role in pairs(Config.DiscordRoles) do
            if role.tag:lower() == requestedTag:lower() then
                targetRole = role
                break
            end
        end

        if targetRole and targetRole.priority <= highestRolePriority then
            TriggerClientEvent('headtags:setRole', source, targetRole)
            TriggerClientEvent('mythic_notify:client:SendAlert', source, {
                type = 'inform',
                text = "Tag set to: " .. targetRole.tag,
                style = {
                    ['background-color'] = Config.BackGroundColor,
                    ['color'] = Config.TextColor
                },
                length = tonumber(Config.Length)
            })
        else
            TriggerClientEvent('mythic_notify:client:SendAlert', source, {
                type = 'inform',
                text = "Invalid tag or insufficient permissions",
                style = {
                    ['background-color'] = Config.BackGroundColor,
                    ['color'] = Config.TextColor
                },
                length = tonumber(Config.Length)
            })
        end
    end
end)
