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
MyStoreIsOpen = {}
MyStoreIsClosed = {}
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

------- STORES STORE BLIPS ONLY ----------
Citizen.CreateThread(function()
    Citizen.Wait(20000)
    while characterselected == false do 
        Citizen.Wait(1000)
    end 
    while true do
        Citizen.Wait(0)
        local player = PlayerPedId()
        local coords = GetEntityCoords(player)
        local sleep = true
        local dead = IsEntityDead(player)
        local hour = GetClockHours()

        -- make sure the player alive and menu is not open
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
                        MyStoreIsOpen[storeId] = 0
                        MyStoreIsClosed[storeId] = 1
                    elseif hour >= storeConfig.StoreOpen then
                        if not Config.Stores[storeId].BlipHandle and storeConfig.blipAllowed then
                            AddBlip(storeId)
                        end
                        if not Config.Stores[storeId].NPC and storeConfig.NpcAllowed then
                            SpawnNPC(storeId) 
                            Citizen.Wait(3000)
                            fixNPCHeight(storeId) 
                        end 
                        MyStoreIsOpen[storeId] = 1
                        MyStoreIsClosed[storeId] = 0  
                    end 
                else
                    if not Config.Stores[storeId].BlipHandle and storeConfig.blipAllowed then
                        AddBlip(storeId)
                    end
                    if not Config.Stores[storeId].NPC and storeConfig.NpcAllowed then
                        SpawnNPC(storeId)     
                        Citizen.Wait(3000)
                        fixNPCHeight(storeId)         
                    end             
                    MyStoreIsOpen[storeId] = 1
                    MyStoreIsClosed[storeId] = 0                
                end
            end
        end
        if sleep then
            Citizen.Wait(1000)
        end
    end
end)

------- STORES START prompt and menu calls ----------
Citizen.CreateThread(function()
    Citizen.Wait(20000)
    while characterselected == false do 
        Citizen.Wait(1000)
    end
    TriggerServerEvent(GetCurrentResourceName()..":getPlayerJob")  
    PromptSetUp()
    PromptSetUp2()
    local JustEnteredRange = 0
    local job_check_ran = 0
    local loopcounters = 0
    while true do
        Citizen.Wait(0)
        local player = PlayerPedId()
        local coords = GetEntityCoords(player)
        local sleep = false
        local dead = IsEntityDead(player)
        local hour = GetClockHours() 

        if isInMenu == false and not dead then
            for storeId, storeConfig in pairs(Config.Stores) do                
                local coordsDist = vector3(coords.x, coords.y, coords.z)
                local coordsStore = vector3(storeConfig.x, storeConfig.y, storeConfig.z)
                local distance = Vdist(coordsDist, coordsStore) 
                --local distance = #(coordsDist - coordsStore)  -- does not return distance.                
                if (distance <= storeConfig.distanceOpenStore) then                       
                    if MyStoreIsOpen[storeId] == 1 and MyStoreIsClosed[storeId] == 0 then                         
                        if JustEnteredRange == 0 and storeConfig.NpcAllowed == true then 
                            JustEnteredRange = 1                                        
                            Citizen.CreateThread(function()                                 
                                SetBlockingOfNonTemporaryEvents(Config.Stores[storeId].NPC, false)
                                FreezeEntityPosition(Config.Stores[storeId].NPC, false)
                                TaskTurnPedToFaceEntity(Config.Stores[storeId].NPC, player, -1) 
                                --print("NPC face players")
                            end)                                         
                        end                         
                        if type(storeConfig.AllowedJobs) == "table" then 
                            if #storeConfig.AllowedJobs >= 1 then  
                                -- add a call so that if job set in vorp core, it updates store as well.
                                if PlayerJob and CheckJob(storeConfig.AllowedJobs, PlayerJob) then                                    
                                    --print("Job Lock set, and player has the correct job.")      
                                    if tonumber(storeConfig.JobGrade) <= tonumber(JobGrade) then  
                                        local label = CreateVarString(10, 'LITERAL_STRING', storeConfig.PromptName)    
                                        PromptSetActiveGroupThisFrame(PromptGroup, label)
                                        if Citizen.InvokeNative(0xC92AC953F0A982AE, OpenStores) then
                                        --if _UiPromptHasStandardModeCompleted(OpenStores) then    
                                            sleep = true                                             
                                            OpenCategory(storeId)
                                            DisplayRadar(false)
                                            TaskStandStill(player, -1) 
                                        end 
                                    end  
                                else 
                                    --print("Job Lock set, and player job does not match.")      
                                    local label = CreateVarString(10, 'LITERAL_STRING', "Access Denied")    
                                    PromptSetActiveGroupThisFrame(PromptGroup, label)                                    
                                end  
                            else -- no job lock, table is empty {}    
                                --print("Job Lock is empty table.")      
                                local label = CreateVarString(10, 'LITERAL_STRING', storeConfig.PromptName)
                                PromptSetActiveGroupThisFrame(PromptGroup, label)
                                if Citizen.InvokeNative(0xC92AC953F0A982AE, OpenStores) then -- if all pass open menu
                                --if _UiPromptHasStandardModeCompleted(OpenStores) then                                       
                                    sleep = true                                                         
                                    OpenCategory(storeId)
                                    DisplayRadar(false)
                                    TaskStandStill(player, -1)
                                end 
                            end
                        else -- some people set the job lock to 0, this is so it doesn't break the store     
                            --print("Job Lock set to 0.")     
                            local label = CreateVarString(10, 'LITERAL_STRING', storeConfig.PromptName)
                            PromptSetActiveGroupThisFrame(PromptGroup, label)
                            if Citizen.InvokeNative(0xC92AC953F0A982AE, OpenStores) then -- if all pass open menu
                            --if _UiPromptHasStandardModeCompleted(OpenStores) then                                 
                                sleep = true                                                           
                                OpenCategory(storeId)
                                DisplayRadar(false)
                                TaskStandStill(player, -1)
                            end 
                        end
                    end 
                else          
                    if JustEnteredRange == 1 and storeConfig.NpcAllowed == true then                              
                        ClearPedTasksImmediately(Config.Stores[storeId].NPC)  
                        SetBlockingOfNonTemporaryEvents(Config.Stores[storeId].NPC, true)
                        FreezeEntityPosition(Config.Stores[storeId].NPC, true) 
                        --print("Player left, freeze npc")
                        JustEnteredRange = 0   
                    end 
                end
            end
        else 
            if sleep == true then
                Citizen.Wait(1000)
            end
        end 
    end
end)