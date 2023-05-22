--------------------------------------------------
-- Printed Messages on Screen --------------------
-------------------------------------------------- 
--- This one is smaller and attached to a fixed point, regardless of camera angle.  
 function DrawText3D(x, y, z, text)
    ---- older version
    if Config.Language == 1 then 
        local onScreen,_x,_y=GetScreenCoordFromWorldCoord(x, y, z)
        local px,py,pz=table.unpack(GetGameplayCamCoord())  
        local dist = GetDistanceBetweenCoords(px,py,pz, x,y,z, 1)
        local str = CreateVarString(10, "LITERAL_STRING", text, Citizen.ResultAsLong())
        if onScreen then
        SetTextScale(0.30, 0.30)
        SetTextFontForCurrentCommand(1)
        SetTextColor(255, 255, 255, 215)
        SetTextCentre(1)
        DisplayText(str,_x,_y)
        local factor = (string.len(text)) / 225
        DrawSprite("feeds", "hud_menu_4a", _x, _y+0.0125,0.015+ factor, 0.03, 0.1, 35, 35, 35, 190, 0) -- grey background
        end
    else    
        -- newer version   
        local onScreen,_x,_y=GetScreenCoordFromWorldCoord(x, y, z)
        local px,py,pz=table.unpack(GetGameplayCamCoord())  
        local dist = GetDistanceBetweenCoords(px,py,pz, x,y,z, 1)
        local str = CreateVarString(10, "LITERAL_STRING", message, Citizen.ResultAsLong())
        if onScreen then
           _BgSetTextScale(0.30, 0.30)
          --SetTextFontForCurrentCommand(1) -- function disconntinued post 1436?
          _BgSetTextColor(255, 255, 255, 215)
          --SetTextCentre(1) -- function disconntinued post 1436?
          _BgDisplayText(str,_x,_y)
        end    
    end 
end
 
RegisterNetEvent(Config.ScriptName..':message')
AddEventHandler(Config.ScriptName..':message', function(--[[source]] FeedBackString)	
    if(Config.debug== 1) then   print("Event Triggered",Config.ScriptName..':message') end 
    duration = 3000
    if Config.REDEM == true then       
        TriggerEvent("redem_roleplay:NotifyRight", FeedBackString, duration)          
	elseif Config.VORP == true then  
        TriggerEvent("vorp:TipRight", FeedBackString, duration)  
        --[[
        TriggerEvent('vorp:NotifyLeft', function(firsttext, secondtext, dict, icon, duration, color)
        TriggerEvent('vorp:Tip', function(text, duration)   -- upper left corner
        TriggerEvent('vorp:NotifyTop', function(text, location, duration) 
        TriggerEvent('vorp:TipRight', function(text, duration) 
        TriggerEvent('vorp:TipBottom', function(text, duration)  
        TriggerEvent('vorp:ShowTopNotification', function(tittle, subtitle, duration)
        TriggerEvent('vorp:ShowAdvancedRightNotification', function(text, dict, icon, text_color, duration, quality)
        TriggerEvent('vorp:ShowBasicTopNotification', function(text, duration)
        TriggerEvent('vorp:ShowSimpleCenterText', function(text, duration)
        TriggerEvent('vorp:ShowBottomRight', function(text, duration)
        TriggerEvent('vorp:failmissioNotifY', function(title, subtitle, duration)
        TriggerEvent('vorp:deadplayerNotifY', function(title, audioRef, audioName, duration)
        TriggerEvent('vorp:updatemissioNotify', function(utitle, umsg, duration)
        TriggerEvent('vorp:warningNotify', function(title, msg, audioRef, audioName, duration)
        --]] 
    else     
        print("Config issue. Core failed to be set. ")             
	end    
end)

function _BgSetTextScale(scaleX, scaleY)
    --print("function _BgSetTextScale")
    -- BgSetTextScale 0xA1253A3C870B6843 _BG_SET_TEXT_SCALE
    -- BgSetTextScale( scaleX, scaleY )
    -- https://vespura.com/doc/natives/?_0xA1253A3C870B6843
    if Citizen.InvokeNative(0xA1253A3C870B6843, scaleX, scaleY) then
        return true
    else
        return false
    end    
end

function _BgSetTextColor(red, green, blue, alpha )
    --print("function _BgSetTextColor")
    -- BgSetTextColor 0x16FA5CE47F184F1E _BG_SET_TEXT_COLOR
    -- BgSetTextColor( red, green, blue, alpha )    
    -- https://github.com/femga/rdr3_discoveries/tree/master/useful_info_from_rpfs/colours
    -- https://vespura.com/doc/natives/?_0x16FA5CE47F184F1E
    if Citizen.InvokeNative(0x16FA5CE47F184F1E, red, green, blue, alpha) then
        return true
    else
        return false
    end    
end


function _BgDisplayText( message, x, y )
    --print("function _BgDisplayText")
    -- BgDisplayText 0x16794E044C9EFB58 _BG_SET_TEXT_COLOR
    -- BgDisplayText( message, x, y ) 
    -- https://vespura.com/doc/natives/?_0x16794E044C9EFB58   
    if Citizen.InvokeNative(0x16794E044C9EFB58, message, x, y ) then
        return true
    else
        return false
    end    
end
 

function _VarString( message )
    --print("function _VarString")
    -- VarString 0xFA925AC00EB830B9 VAR_STRING
    -- VarString( 10, "LITERAL_STRING", str, Citizen.ResultAsLong() ) 
    -- https://vespura.com/doc/natives/?_0x16794E044C9EFB58  
    local Formatted_Message = Citizen.InvokeNative(0xFA925AC00EB830B9, 10, "LITERAL_STRING", message, Citizen.ResultAsLong() )
    if Formatted_Message then
        return Formatted_Message
    else
        return false
    end    
end 

 