-- i think i don't have to explain this section lol...

local closest = nil

RegisterServerEvent('wx_headbag:closest')
AddEventHandler('wx_headbag:closest', function()
    TriggerClientEvent('wx_headbag:putOn', closest)
end)

RegisterServerEvent('wx_headbag:closestPlayer')
AddEventHandler('wx_headbag:closestPlayer', function(closestPlayer)
    closest = closestPlayer
end)

RegisterServerEvent('wx_headbag:takeOff')
AddEventHandler('wx_headbag:takeOff', function()
    TriggerClientEvent('wx_headbag:takeOff', closest)
end)
