---------------- BLIPS ---------------------
function AddBlip(Store)
    if Config.Stores[Store].blipAllowed then
        Config.Stores[Store].BlipHandle = N_0x554d9d53f696d002(1664425300, Config.Stores[Store].x,
            Config.Stores[Store].y, Config.Stores[Store].z)
        SetBlipSprite(Config.Stores[Store].BlipHandle, Config.Stores[Store].sprite, 1)
        SetBlipScale(Config.Stores[Store].BlipHandle, 0.2)
        _SetBlipName( Config.Stores[Store].BlipHandle, Config.Stores[Store].BlipName )
        --Citizen.InvokeNative(0x9CB1A1623062F402, Config.Stores[Store].BlipHandle, Config.Stores[Store].BlipName)
    end
end
 
function _SetBlipName( blip, name )
    --SetBlipName(blip, name )
    Citizen.InvokeNative(0x9CB1A1623062F402, blip, name )  
    Wait(500)
end  
 