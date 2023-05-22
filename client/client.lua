------------------------------------------------------------------------------------------------------
-------------------------------------------- CLIENT --------------------------------------------------
OpenStores = 0
CloseStores = 0
PlayerJob = 0
JobGrade = 0
shopStocks = {} 
PromptGroup = GetRandomIntInRange(0, 0xffffff)
PromptGroup2 = GetRandomIntInRange(0, 0xffffff)
isInMenu = false
MenuData = {}

TriggerEvent("menuapi:getData", function(call)
    MenuData = call
end)

function CheckJob(table, element)
    for k, v in pairs(table) do
        if v == element then
            return true
        end
    end
    return false
end

function fixNPCHeight(storeId)     
    Citizen.CreateThread(function()                            
        FreezeEntityPosition(Config.Stores[storeId].NPC, false)
        Citizen.Wait(3000)  -- 3 seconds          
        FreezeEntityPosition(Config.Stores[storeId].NPC, true)
    end) 
end 

------- STORES START ----------
Citizen.CreateThread(function()
    Citizen.Wait(20000)
    while characterselected == false do 
        Citizen.Wait(1000)
    end
    PromptSetUp()
    PromptSetUp2()

    while true do
        Citizen.Wait(0)
        local player = PlayerPedId()
        local coords = GetEntityCoords(player)
        local sleep = true
        local dead = IsEntityDead(player)
        local hour = GetClockHours()

        if isInMenu == false and not dead then
            for storeId, storeConfig in pairs(Config.Stores) do
                if storeConfig.StoreHoursAllowed then
                    if hour >= storeConfig.StoreClose or hour < storeConfig.StoreOpen then
                        if Config.Stores[storeId].BlipHandle then
                            RemoveBlip(Config.Stores[storeId].BlipHandle)
                            Config.Stores[storeId].BlipHandle = nil
                        end
                        if Config.Stores[storeId].NPC then
                            DeleteEntity(Config.Stores[storeId].NPC)
                            DeletePed(Config.Stores[storeId].NPC)
                            SetEntityAsNoLongerNeeded(Config.Stores[storeId].NPC)
                            Config.Stores[storeId].NPC = nil
                        end
                        local coordsDist = vector3(coords.x, coords.y, coords.z)
                        local coordsStore = vector3(storeConfig.x, storeConfig.y, storeConfig.z)
                        local distance = #(coordsDist - coordsStore)

                        if (distance <= storeConfig.distanceOpenStore) then
                            sleep = false
                            local label2 = CreateVarString(10, 'LITERAL_STRING',
                                _U("closed") .. storeConfig.StoreOpen .. _U("am") .. storeConfig.StoreClose .. _U("pm"))
                            PromptSetActiveGroupThisFrame(PromptGroup2, label2)
                            if Citizen.InvokeNative(0xC92AC953F0A982AE, CloseStores) then
                            --if _UiPromptHasStandardModeCompleted(CloseStores) then
                                Wait(100)
                                TriggerEvent("vorp:TipRight",
                                    _U("closed") ..
                                    storeConfig.StoreOpen .. _U("am") .. storeConfig.StoreClose .. _U("pm"), 3000)
                            end
                        end
                    elseif hour >= storeConfig.StoreOpen then
                        if not Config.Stores[storeId].BlipHandle and storeConfig.blipAllowed then
                            AddBlip(storeId)
                        end
                        if not Config.Stores[storeId].NPC and storeConfig.NpcAllowed then
                            SpawnNPC(storeId) 
                        end   
                        -- ## run this before distance check  no need to run a code that is no meant for the client ## --
                        if not next(storeConfig.AllowedJobs) then -- if jobs empty then everyone can use
                            local coordsDist = vector3(coords.x, coords.y, coords.z)
                            local coordsStore = vector3(storeConfig.x, storeConfig.y, storeConfig.z)
                            local distance = #(coordsDist - coordsStore)

                            if (distance <= storeConfig.distanceOpenStore) then -- check distance                                
                                fixNPCHeight(storeId)
                                sleep = false
                                local label = CreateVarString(10, 'LITERAL_STRING', storeConfig.PromptName)
                                PromptSetActiveGroupThisFrame(PromptGroup, label)
                                if Citizen.InvokeNative(0xC92AC953F0A982AE, OpenStores) then -- if all pass open menu
                                --if _UiPromptHasStandardModeCompleted(OpenStores) then                                    
                                    OpenCategory(storeId)
                                    DisplayRadar(false)
                                    TaskStandStill(player, -1)
                                end
                            end
                        else -- job only
                            local coordsDist = vector3(coords.x, coords.y, coords.z)
                            local coordsStore = vector3(storeConfig.x, storeConfig.y, storeConfig.z)
                            local distance = #(coordsDist - coordsStore)

                            if (distance <= storeConfig.distanceOpenStore) then                          
                                fixNPCHeight(storeId)
                                TriggerServerEvent(GetCurrentResourceName()..":getPlayerJob")
                                Wait(200)
                                if PlayerJob then
                                    if CheckJob(storeConfig.AllowedJobs, PlayerJob) then
                                        if tonumber(storeConfig.JobGrade) <= tonumber(JobGrade) then
                                            sleep = false
                                            local label = CreateVarString(10, 'LITERAL_STRING', storeConfig.PromptName)

                                            PromptSetActiveGroupThisFrame(PromptGroup, label)
                                            if Citizen.InvokeNative(0xC92AC953F0A982AE, OpenStores) then
                                            --if _UiPromptHasStandardModeCompleted(OpenStores) then                                                 
                                                OpenCategory(storeId)
                                                DisplayRadar(false)
                                                TaskStandStill(player, -1)
                                            end
                                        end
                                    end
                                 end
                            end
                        end
                    end
                else
                    if not Config.Stores[storeId].BlipHandle and storeConfig.blipAllowed then
                        AddBlip(storeId)
                    end
                    if not Config.Stores[storeId].NPC and storeConfig.NpcAllowed then
                        SpawnNPC(storeId)             
                    end  
                    -- ## run this before distance check  no need to run a code that is no meant for the client ## --
                    if not next(storeConfig.AllowedJobs) then -- if jobs empty then everyone can use
                        local coordsDist = vector3(coords.x, coords.y, coords.z)
                        local coordsStore = vector3(storeConfig.x, storeConfig.y, storeConfig.z)
                        local distance = #(coordsDist - coordsStore)
                        if (distance <= storeConfig.distanceOpenStore) then -- check distance                          
                            fixNPCHeight(storeId)                            
                            sleep = false
                            local label = CreateVarString(10, 'LITERAL_STRING', storeConfig.PromptName)
                            PromptSetActiveGroupThisFrame(PromptGroup, label)
                            --if _UiPromptHasStandardModeCompleted(OpenStores) then
                            if Citizen.InvokeNative(0xC92AC953F0A982AE, OpenStores) then -- iff all pass open menu
                                OpenCategory(storeId)
                                DisplayRadar(false)
                                TaskStandStill(player, -1)
                            end
                        end
                    else -- job only
                        local coordsDist = vector3(coords.x, coords.y, coords.z)
                        local coordsStore = vector3(storeConfig.x, storeConfig.y, storeConfig.z)
                        local distance = #(coordsDist - coordsStore)
                        if (distance <= storeConfig.distanceOpenStore) then                          
                            fixNPCHeight(storeId)                        
                            TriggerServerEvent(GetCurrentResourceName()..":getPlayerJob")
                            Citizen.Wait(200)
                            if PlayerJob then
                                if CheckJob(storeConfig.AllowedJobs, PlayerJob) then
                                    if tonumber(storeConfig.JobGrade) <= tonumber(JobGrade) then
                                        sleep = false
                                        local label = CreateVarString(10, 'LITERAL_STRING', storeConfig.PromptName)
                                        PromptSetActiveGroupThisFrame(PromptGroup, label)
                                        --if _UiPromptHasStandardModeCompleted(OpenStores) then
                                        if Citizen.InvokeNative(0xC92AC953F0A982AE, OpenStores) then
                                            OpenCategory(storeId)
                                            DisplayRadar(false)
                                            TaskStandStill(player, -1)
                                        end
                                    end
                                end
                            end        
                        end 
                    end
                end
            end
        end
        if sleep then
            Citizen.Wait(1000)
        end
    end
end)