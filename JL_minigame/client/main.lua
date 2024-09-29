local isSequenceComplete = false

RegisterNUICallback('sequenceCompleted', function(data, cb)
    Citizen.Wait(1000)
    closeUI()
    isSequenceComplete = true
    cb('ok')
end)

RegisterNUICallback('game_failed', function(data, cb)
    Citizen.Wait(1000)
    closeUI()
    cb('ok')
end)

function closeUI()
    SetNuiFocus(false, false)
    SendNUIMessage({ type = 'close' })
end
exports('OpenGame', function(action, timer, title, steps)
    if action == 'open' then
        isSequenceComplete = false
        SendNUIMessage({
            type = 'open',
            action = 'updateConfig',
            timer = timer or 10,
            title = title or 'Default Title',
            steps = steps or 1
        })
        SetNuiFocus(true, false)
        
        while not isSequenceComplete do
            Wait(100)
        end
        return true
    elseif action == 'isSequenceComplete' then
        return isSequenceComplete
    else
        print("Error: " .. action)
    end
end)
