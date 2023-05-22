---------------- NPC ---------------------
function LoadModel(model)
    local model = GetHashKey(model)
    RequestModel(model)
    while not HasModelLoaded(model) do
        RequestModel(model)
        Citizen.Wait(100)
    end
end

function SpawnNPC(Store)
    local v = Config.Stores[Store]
    LoadModel(v.NpcModel)
    if v.NpcAllowed then
        local npc = CreatePed(v.NpcModel, v.x, v.y, v.z, v.h, false, true, true, true)
        _SetRandomOutfitVariation(npc)    
        _PlaceEntityOnGroundProperly(npc)   
        SetEntityCanBeDamaged(npc, false)
        SetEntityInvincible(npc, true)  
        SetBlockingOfNonTemporaryEvents(npc, true)
        Config.Stores[Store].NPC = npc
    end
end


function _SetRandomOutfitVariation(npc)
    --SetRandomOutfitVariation(npc, true)
    Citizen.InvokeNative(0x283978A15512B2FE, npc, true)   
end 
  