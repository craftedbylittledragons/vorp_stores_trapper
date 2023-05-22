function _PlaceEntityOnGroundProperly(npc)
    --PlaceEntityOnGroundProperly(npc, true)
    local bool_return_value = Citizen.InvokeNative(0x9587913B9E772D29, npc, true) 
    return(bool_return_value)       
end 
function _PlaceEntityOnGroundProperly2(npc)
    --PlaceEntityOnGroundProperly(npc, true)
    local bool_return_value = PlaceEntityOnGroundProperly(npc, true)     
    return(bool_return_value) 
end 

function _GetEntityHeightAboveGround(npc)
    -- GET_ENTITY_HEIGHT_ABOVE_GROUND
    --GetEntityHeightAboveGround(npc)
    local num_return_value = Citizen.InvokeNative(0x0D3B5BAEA08F63E9, npc) 
    return(num_return_value)   
end  

function _GetEntityHeightAboveGround2(npc)
    -- GET_ENTITY_HEIGHT_ABOVE_GROUND
    --GetEntityHeightAboveGround(npc)    
    local num_return_value = GetEntityHeightAboveGround(npc)
    return(num_return_value) 	
end   