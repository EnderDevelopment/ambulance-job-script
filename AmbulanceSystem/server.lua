local ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

ESX.RegisterServerCallback('ambulance:checkReviveCooldown', function(source, cb, targetId)
    local xPlayer = ESX.GetPlayerFromId(source)
    local identifier = xPlayer.identifier

    MySQL.Async.fetchScalar('SELECT COUNT(*) FROM ambulance_revives WHERE player_id = @player_id AND target_id = @target_id AND revive_time > DATE_SUB(NOW(), INTERVAL @cooldown SECOND)', {
        ['@player_id'] = identifier,
        ['@target_id'] = targetId,
        ['@cooldown'] = Config.ReviveCooldown
    }, function(count)
        cb(count == 0)
    end)
end)

RegisterServerEvent('ambulance:revivePlayer')
AddEventHandler('ambulance:revivePlayer', function(targetId)
    local xPlayer = ESX.GetPlayerFromId(source)
    local identifier = xPlayer.identifier

    if xPlayer.job.name == Config.AmbulanceJobName then
        ESX.TriggerServerCallback('ambulance:checkReviveCooldown', source, function(canRevive)
            if canRevive then
                if xPlayer.getAccount('bank').money >= Config.ReviveCost then
                    xPlayer.removeAccountMoney('bank', Config.ReviveCost)
                    TriggerClientEvent('ambulance:revive', targetId)

                    MySQL.Async.execute('INSERT INTO ambulance_revives (player_id, target_id, revive_time) VALUES (@player_id, @target_id, NOW())', {
                        ['@player_id'] = identifier,
                        ['@target_id'] = targetId
                    })

                    TriggerClientEvent('esx:showNotification', source, 'You have revived the player for ~g~$' .. Config.ReviveCost)
                else
                    TriggerClientEvent('esx:showNotification', source, 'You do not have enough money in your bank account!')
                end
            else
                TriggerClientEvent('esx:showNotification', source, 'You can only revive this player once every ' .. Config.ReviveCooldown .. ' seconds!')
            end
        end, targetId)
    else
        TriggerClientEvent('esx:showNotification', source, 'You are not an ambulance!')
    end
end)