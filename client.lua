local headTagsEnabled = false
local currentRole = Config.DefaultTag

local function DrawText3D(x, y, z, id, role, name)
    local onScreen, _x, _y = GetScreenCoordFromWorldCoord(x, y, z)
    local dist = #(GetGameplayCamCoords() - vec(x, y, z))
    
    if onScreen then
        local textScale = 0.32
        local idLength = string.len(id) * 0.002
        
        -- ID Bracket Left
        SetTextFont(0)
        SetTextProportional(0)
        SetTextScale(textScale, textScale)
        SetTextColour(Config.LeftBracket.r, Config.LeftBracket.g, Config.LeftBracket.b, 255)
        SetTextEntry("STRING")
        SetTextEdge(4, 0, 0, 0, 255)
        SetTextOutline()
        AddTextComponentString("[")
        DrawText(_x - 0.018, _y)
        
        -- ID Number
        SetTextScale(textScale, textScale)
        SetTextColour(Config.IDColor.r, Config.IDColor.g, Config.IDColor.b, 255)
        SetTextEntry("STRING")
        SetTextEdge(4, 0, 0, 0, 255)
        SetTextOutline()
        AddTextComponentString(id)
        DrawText(_x - (0.016 - idLength), _y)
        
        -- ID Bracket Right
        SetTextScale(textScale, textScale)
        SetTextColour(Config.RightBracket.r, Config.RightBracket.g, Config.RightBracket.b, 255)
        SetTextEntry("STRING")
        SetTextEdge(4, 0, 0, 0, 255)
        SetTextOutline()
        AddTextComponentString("]")
        DrawText(_x - (0.014 - idLength * 3.3), _y)
        
        -- Role Tag
        SetTextScale(textScale, textScale)
        SetTextColour(role.color.r, role.color.g, role.color.b, 255)
        SetTextEntry("STRING")
        SetTextEdge(4, 0, 0, 0, 255)
        SetTextOutline()
        AddTextComponentString(role.tag)
        DrawText(_x + (0.0000001 + idLength), _y)
        
        -- Separator
        SetTextScale(textScale, textScale)
        SetTextColour(Config.SeparatorColor.r, Config.SeparatorColor.g, Config.SeparatorColor.b, 255)
        SetTextEntry("STRING")
        SetTextEdge(4, 0, 0, 0, 255)
        SetTextOutline()
        AddTextComponentString(" |")
        DrawText(_x + (role.spacing + idLength), _y)
        
        -- Name
        SetTextScale(textScale, textScale)
        SetTextColour(Config.NameColor.r, Config.NameColor.g, Config.NameColor.b, 255)
        SetTextEntry("STRING")
        SetTextEdge(4, 0, 0, 0, 255)
        SetTextOutline()
        AddTextComponentString(" " .. name)
        DrawText(_x + (role.spacing + 0.006 + idLength), _y)
    end
end

function ManageHeadTags()
    if headTagsEnabled then
        local myId = PlayerId()
        for _, playerId in ipairs(GetActivePlayers()) do
            if NetworkIsPlayerActive(playerId) and (Config.ShowSelfTag or playerId ~= myId) then
                local ped = GetPlayerPed(playerId)
                local dist = #(GetEntityCoords(PlayerPedId()) - GetEntityCoords(ped))

                if dist < Config.TagDistance then
                    local id = GetPlayerServerId(playerId)
                    local name = GetPlayerName(playerId)
                    local coords = GetEntityCoords(ped)
                    DrawText3D(coords.x, coords.y, coords.z + 1.0, id, currentRole, name)
                end
            end
        end
    end
end

function ToggleHeadTags()
    headTagsEnabled = not headTagsEnabled
    local message = headTagsEnabled and Config.EnableNotify or Config.DisableNotify
    
    TriggerEvent('mythic_notify:client:SendAlert', {
        type = 'inform',
        text = message,
        style = {
            ['background-color'] = Config.BackGroundColor,
            ['color'] = Config.TextColor
        },
        length = tonumber(Config.Length)
    })
end

RegisterNetEvent('headtags:setRole')
AddEventHandler('headtags:setRole', function(role)
    currentRole = role
end)

RegisterCommand('headtags', function()
    ToggleHeadTags()
end, false)

RegisterKeyMapping('headtags', 'Toggle Head Tags', 'keyboard', Config.Keybind)

Citizen.CreateThread(function()
    while true do
        if headTagsEnabled then
            ManageHeadTags()
        end
        Citizen.Wait(0)
    end
end)

AddEventHandler('playerSpawned', function()
    TriggerServerEvent('headtags:getRoles')
end)

RegisterCommand('tagtest', function(source, args)
    -- Get player's roles from Badger Discord API using the server
    TriggerServerEvent('headtags:checkDeveloper', args)
end)

-- Add this event handler
RegisterNetEvent('headtags:developerCheck')
AddEventHandler('headtags:developerCheck', function(isDeveloper, args)
    if not isDeveloper then
        TriggerEvent('mythic_notify:client:SendAlert', {
            type = 'inform',
            text = "You don't have permission to use this command",
            style = {
                ['background-color'] = Config.BackGroundColor,
                ['color'] = Config.TextColor
            },
            length = tonumber(Config.Length)
        })
        return
    end

    if not args[1] then 
        TriggerEvent('mythic_notify:client:SendAlert', {
            type = 'inform',
            text = "Please specify a role to test",
            style = {
                ['background-color'] = Config.BackGroundColor,
                ['color'] = Config.TextColor
            },
            length = tonumber(Config.Length)
        })
        return
    end

    local testRole = nil
    local inputTag = table.concat(args, " ")

    for _, role in pairs(Config.DiscordRoles) do
        if role.tag:lower() == inputTag:lower() then
            testRole = role
            break
        end
    end

    if testRole then
        local oldRole = currentRole
        currentRole = testRole
        
        TriggerEvent('mythic_notify:client:SendAlert', {
            type = 'inform',
            text = "Testing tag: " .. testRole.tag,
            style = {
                ['background-color'] = Config.BackGroundColor,
                ['color'] = Config.TextColor
            },
            length = tonumber(Config.Length)
        })

        Citizen.SetTimeout(10000, function()
            currentRole = oldRole
            TriggerEvent('mythic_notify:client:SendAlert', {
                type = 'inform',
                text = "Tag test completed",
                style = {
                    ['background-color'] = Config.BackGroundColor,
                    ['color'] = Config.TextColor
                },
                length = tonumber(Config.Length)
            })
        end)
    else
        TriggerEvent('mythic_notify:client:SendAlert', {
            type = 'inform',
            text = "Invalid tag name",
            style = {
                ['background-color'] = Config.BackGroundColor,
                ['color'] = Config.TextColor
            },
            length = tonumber(Config.Length)
        })
    end
end)