local ESX = nil
local PlayerData = {}

Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        Citizen.Wait(0)
    end

    while ESX.GetPlayerData().job == nil do
        Citizen.Wait(10)
    end

    PlayerData = ESX.GetPlayerData()
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
    PlayerData = xPlayer
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
    PlayerData.job = job
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        local playerPed = PlayerPedId()
        local playerCoords = GetEntityCoords(playerPed)

        if PlayerData.job and PlayerData.job.name == Config.AmbulanceJobName then
            for _, playerId in ipairs(GetActivePlayers()) do
                local targetPed = GetPlayerPed(playerId)
                if targetPed ~= playerPed and IsPedDeadOrDying(targetPed, true) then
                    local targetCoords = GetEntityCoords(targetPed)
                    local distance = #(playerCoords - targetCoords)

                    if distance < Config.ReviveDistance then
                        DrawMarker(Config.MarkerSettings.Type, targetCoords.x, targetCoords.y, targetCoords.z - 1.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, Config.MarkerSettings.Scale.x, Config.MarkerSettings.Scale.y, Config.MarkerSettings.Scale.z, Config.MarkerSettings.Color.r, Config.MarkerSettings.Color.g, Config.MarkerSettings.Color.b, Config.MarkerSettings.Color.a, false, true, 2, nil, nil, false)

                        if distance < 1.5 then
                            ESX.ShowHelpNotification('Press ~INPUT_CONTEXT~ to revive the player')
                            if IsControlJustReleased(0, 38) then
                                TriggerServerEvent('ambulance:revivePlayer', GetPlayerServerId(playerId))
                            end
                        end
                    end
                end
            end
        end
    end
end)

RegisterNetEvent('ambulance:revive')
AddEventHandler('ambulance:revive', function()
    local playerPed = PlayerPedId()
    if IsPedDeadOrDying(playerPed, true) then
        local playerId = PlayerId()
        NetworkResurrectLocalPlayer(playerId, true, true, false)
        SetPlayerInvincible(playerId, false)
        ClearPedBloodDamage(playerPed)
        ESX.ShowNotification('You have been revived!')
    end
end)