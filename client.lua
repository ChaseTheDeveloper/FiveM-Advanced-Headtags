local headTagsEnabled = false
local currentRole = { tag = "Civilian", color = Config.DefaultColor }

local function getTagOffset(tag)
    local offsets = {
        ["Development Team"] = 0.042,
        ["Senior Staff Team"] = 0.040,
        ["High Staff Team"] = 0.038,
        ["Staff Team"] = 0.032,
        ["Co Owner"] = 0.035,
        ["Owner"] = 0.025,
        ["Booster"] = 0.025,
        ["Civilian"] = 0.022
    }
    return offsets[tag] or 0.022
end

function DrawText3D(x, y, z, id, role, name)
    local onScreen, _x, _y = GetScreenCoordFromWorldCoord(x, y, z)
    local dist = #(GetGameplayCamCoords() - vec(x, y, z))
    
    if onScreen then
        local textScale = 0.32
        local idLength = string.len(id) * 0.002
        
        SetTextFont(0)
        SetTextProportional(0)
        SetTextCentre(false)
        SetTextDropshadow(0, 0, 0, 0, 255)
        SetTextEdge(4, 0, 0, 0, 255)
        SetTextOutline()
        
        SetTextScale(textScale, textScale)
        SetTextColour(Config.LeftBracket.r, Config.LeftBracket.g, Config.LeftBracket.b, 255)
        SetTextEntry("STRING")
        SetTextEdge(4, 0, 0, 0, 255)
        SetTextOutline()
        AddTextComponentString("[")
        DrawText(_x - 0.018, _y)
    
        SetTextScale(textScale, textScale)
        SetTextColour(Config.IDColor.r, Config.IDColor.g, Config.IDColor.b, 255)
        SetTextEntry("STRING")
        SetTextEdge(4, 0, 0, 0, 255)
        SetTextOutline()
        AddTextComponentString(id)
        DrawText(_x - (0.016 - idLength), _y)
        
        SetTextScale(textScale, textScale)
        SetTextColour(Config.RightBracket.r, Config.RightBracket.g, Config.RightBracket.b, 255)
        SetTextEntry("STRING")
        SetTextEdge(4, 0, 0, 0, 255)
        SetTextOutline()
        AddTextComponentString("]")
        DrawText(_x - (0.014 - idLength * 3.3), _y)
        
        SetTextScale(textScale, textScale)
        SetTextColour(role.color.r, role.color.g, role.color.b, 255)
        SetTextEntry("STRING")
        SetTextEdge(4, 0, 0, 0, 255)
        SetTextOutline()
        AddTextComponentString(" " .. role.tag)
        DrawText(_x - (0.008 - idLength * 3.3), _y)
        
        SetTextScale(textScale, textScale)
        SetTextColour(Config.SeparatorColor.r, Config.SeparatorColor.g, Config.SeparatorColor.b, 255)
        SetTextEntry("STRING")
        SetTextEdge(4, 0, 0, 0, 255)
        SetTextOutline()
        AddTextComponentString("    |")
        DrawText(_x + (0.022 + idLength), _y)
        
        SetTextScale(textScale, textScale)
        SetTextColour(Config.NameColor.r, Config.NameColor.g, Config.NameColor.b, 255)
        SetTextEntry("STRING")
        SetTextEdge(4, 0, 0, 0, 255)
        SetTextOutline()
        AddTextComponentString("    " .. name)
        DrawText(_x + (0.028 + idLength), _y)
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