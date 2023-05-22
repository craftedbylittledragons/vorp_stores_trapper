
RegisterNetEvent(GetCurrentResourceName()..":sendShopStock")
AddEventHandler(GetCurrentResourceName()..":sendShopStock", function(stock)
    shopStocks = stock
end)

RegisterNetEvent(GetCurrentResourceName()..":sendPlayerJob")
AddEventHandler(GetCurrentResourceName()..":sendPlayerJob", function(Job, grade)
    PlayerJob = Job
    JobGrade = grade
end)

RegisterNetEvent(GetCurrentResourceName()..":RefreshStorePrices")
AddEventHandler(GetCurrentResourceName()..":RefreshStorePrices", function(SellItems, BuyItems)
    print("refresh")
    Config.SellItems = SellItems
    Config.BuyItems = BuyItems
end)

characterselected = false

RegisterNetEvent("vorp:SelectedCharacter")
AddEventHandler("vorp:SelectedCharacter", function(charid)
	Wait(5000)
	characterselected = true 
end)

AddEventHandler('onClientResourceStart', function(resourceName)
    if (GetCurrentResourceName() ~= resourceName) then
        return
    end
    Wait(1000)
    TriggerServerEvent(GetCurrentResourceName()..":GetRefreshedPrices")       
	Wait(10000)
    if characterselected == false then -- restarted after character selected
	    characterselected = true  
    end
end)

AddEventHandler('onResourceStop', function(resourceName)
    if (GetCurrentResourceName() ~= resourceName) then
        return
    end
    if isInMenu == true then
        ClearPedTasksImmediately(PlayerPedId())
        PromptDelete(OpenStores)
        MenuData.CloseAll()
    end
    for i, v in pairs(Config.Stores) do
        if v.BlipHandle then
            RemoveBlip(v.BlipHandle)
        end
        if v.NPC then
            DeleteEntity(v.NPC)
            DeletePed(v.NPC)
            SetEntityAsNoLongerNeeded(v.NPC)
        end
    end
end)
