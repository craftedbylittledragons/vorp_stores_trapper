
---- items category ------
function OpenCategory(storeId)
     
    MenuData.CloseAll()
    isInMenu = true

    local elements = {}

    for k, v in pairs(Config.Stores[storeId].category) do
         
        elements[#elements + 1] = {
            label = v,
            value = v,
            desc = _U("choose_category")
        }
    end

    MenuData.Open('default', GetCurrentResourceName(), 'menuapi' .. storeId, {
        title = Config.Stores[storeId].storeName,
        subtext = _U("SubMenu"),
        align = Config.Align,
        elements = elements

    }, function(data, menu)
        OpenSubMenu(storeId, data.current.value)
    end, function(data, menu)
        menu.close()
        isInMenu = false
        ClearPedTasksImmediately(PlayerPedId())
        DisplayRadar(true)
    end)

end

-- sell only
function OpenSubMenu(storeId, category)
     
    MenuData.CloseAll()
    isInMenu = true
    local elements = {}

    for k, v in pairs(Config.Stores[storeId].storeType) do
         
        elements[#elements + 1] = {
            label = v,
            value = v,
            desc = _U("chooseoption")
        }
    end

    MenuData.Open('default', GetCurrentResourceName(), 'menuapi' .. storeId .. category, {
        title = Config.Stores[storeId].storeName,
        subtext = _U("SubMenu"),
        align = Config.Align,
        elements = elements,
        lastmenu = "OpenCategory"

    }, function(data, menu)
        if (data.current == "backup") then
            _G[data.trigger](storeId, category)
        end

        if (data.current.value == "Sell") then --translate here same as the config
             
            OpenSellMenu(storeId, category)
        end

        if (data.current.value == "Buy") then --translate here same as the config
             
            OpenBuyMenu(storeId, category)
        end

    end, function(data, menu)
        menu.close()
        isInMenu = false
        ClearPedTasksImmediately(PlayerPedId())
        DisplayRadar(true)
    end)
end

-- sell
function OpenSellMenu(storeId, category)
     
    MenuData.CloseAll()
    isInMenu = true
    local menuElements = {}
    local player = PlayerPedId()
    local storeConfig = Config.Stores[storeId]
    local elementIndex = 1
    TriggerServerEvent(GetCurrentResourceName()..":getShopStock")
    Citizen.Wait(100)
     
    for index, storeItem in ipairs(Config.SellItems[storeId]) do
         
        local itemFound = false

        if storeItem.category == category then
            local ctp = ""
            if storeItem.currencyType == "gold" then
                ctp = "#"
            else
                ctp = "$"
            end
            if shopStocks[storeId] then
                for k, items in pairs(shopStocks[storeId]) do
                    if items.itemName == storeItem.itemName and items.type == "sell" then
                        itemFound = true
                        menuElements[elementIndex] = {
                            itemHeight = "2vh",
                            label = "<span style=font-size:15px;text-align:center;>" ..
                            items.amount .. "</span>".."<img style='max-height:45px;max-width:45px;float: left;text-align: center; margin-top: -5px;' src='nui://vorp_inventory/html/img/items/" ..
                                storeItem.itemName .. ".png'><span style=margin-left:40px;font-size:25px;text-align:center;>" ..
                                storeItem.itemLabel .. "</span>",
                            value = "sell" .. tostring(elementIndex),
                            desc = "" ..
                                '<span style="font-family: crock; src:nui://menuapi/html/fonts/crock.ttf) format("truetype")</span>' ..
                                _U("sellfor") .. '<span style="margin-left:90px;">' .. '<span style="font-size:25px;">' .. ctp ..
                                '</span>' .. '<span style="font-size:30px;">' .. string.format("%.2f", storeItem.sellprice) ..
                                "</span><span style='color: Yellow;'>  " .. storeItem.currencyType .. "</span><br><br><br>" ..
                                storeItem.desc,
                            info = storeItem
            
                        }            
                        elementIndex = elementIndex + 1    
                    end
                end  
            end
            
            if not itemFound then
                menuElements[elementIndex] = {
                    itemHeight = "2vh",
                    label = "<span style=font-size:15px;text-align:left;>∞</span>".."<img style='max-height:45px;max-width:45px;float: left;text-align: center; margin-top: -5px;' src='nui://vorp_inventory/html/img/items/" ..
                        storeItem.itemName .. ".png'><span style=margin-left:40px;font-size:25px;text-align:center;>" ..
                        storeItem.itemLabel .. "</span>",
                    value = "sell" .. tostring(elementIndex),
                    desc = "" ..
                        '<span style="font-family: crock; src:nui://menuapi/html/fonts/crock.ttf) format("truetype")</span>' ..
                        _U("sellfor") .. '<span style="margin-left:90px;">' .. '<span style="font-size:25px;">' .. ctp ..
                        '</span>' .. '<span style="font-size:30px;">' .. string.format("%.2f", storeItem.sellprice) ..
                        "</span><span style='color: Yellow;'>  " .. storeItem.currencyType .. "</span><br><br><br>" ..
                        storeItem.desc,
                    info = storeItem
    
                }    
                elementIndex = elementIndex + 1               
            end            
        end
    end

    MenuData.Open('default', GetCurrentResourceName(), 'menuapi' .. storeId .. category, {
        title = storeConfig.storeName,
        subtext = _U("sellmenu"),
        align = Config.Align,
        elements = menuElements,
        lastmenu = "OpenSubMenu"
    }, function(data, menu)
        if (data.current == "backup") then
            _G[data.trigger](storeId, category)
        else

            local ItemName = data.current.info.itemName
            local ItemLabel = data.current.info.itemLabel
            local currencyType = data.current.info.currencyType
            local sellPrice = data.current.info.sellprice

            local myInput = {
                type = "enableinput", -- dont touch
                inputType = "input",
                button = _U("confirm"), -- button name
                placeholder = _U("insertamount"), -- placeholdername
                style = "block", --- dont touch
                attributes = {
                    inputHeader = _U("amount"), -- header
                    type = "number", -- inputype text, number,date.etc if number comment out the pattern
                    pattern = "[0-9]", -- regular expression validated for only numbers "[0-9]", for letters only [A-Za-z]+   with charecter limit  [A-Za-z]{5,20}     with chareceter limit and numbers [A-Za-z0-9]{5,}
                    title = _U("must"), -- if input doesnt match show this message
                    style = "border-radius: 10px; background-color: ; border:none;" -- style  the inptup
                }
            }
            if Config.Align == "center" then
                MenuData.CloseAll()
                ClearPedTasksImmediately(player)
                isInMenu = false
                DisplayRadar(true)
            end

            TriggerEvent("vorpinputs:advancedInput", json.encode(myInput), function(result)
                local qty = tonumber(result)
                if qty ~= nil and qty ~= 0 and qty > 0 then
                    TriggerServerEvent(GetCurrentResourceName()..":sell", ItemLabel, ItemName, currencyType, sellPrice, qty,storeId) -- sell it
                else
                    TriggerEvent("vorp:TipRight", _U("insertamount"), 3000)
                end
            end)
        end
    end, function(data, menu)
        menu.close()
        ClearPedTasksImmediately(player)
        isInMenu = false
        DisplayRadar(true)
    end)

end

--- buy
function OpenBuyMenu(storeId, category)
     
    MenuData.CloseAll()
    isInMenu = true
    local menuElements = {}
    local player = PlayerPedId()
    local storeConfig = Config.Stores[storeId]
    local elementIndex = 1
    TriggerServerEvent(GetCurrentResourceName()..":getShopStock")
    Citizen.Wait(100)

    for index, storeItem in ipairs(Config.BuyItems[storeId]) do
         
        local itemFound = false

        if storeItem.category == category then
            local ctp = ""
            if storeItem.currencyType == "gold" then
                ctp = "#"
            else
                ctp = "$"
            end
            if shopStocks[storeId] then
                for k, items in pairs(shopStocks[storeId]) do
                    if items.itemName == storeItem.itemName and items.type == "buy" then
                        itemFound = true
                        menuElements[elementIndex] = {
                            itemHeight = "2vh",
                            label = "<span style=font-size:15px;text-align:center;>" ..
                            items.amount .. "</span>".." <img style='max-height: 40px;max-width: 40px;float: left;text-align: center;margin-top: -5px;' src='nui://vorp_inventory/html/img/items/" ..
                                storeItem.itemName .. ".png'><span style=margin-left:40px;font-size:25px;text-align:center;>" ..
                                storeItem.itemLabel .. "</span>",
                            value = "sell" .. tostring(elementIndex),
                            desc = "" ..
                                '<span style="font-family: crock; src:nui://menuapi/html/fonts/crock.ttf) format("truetype")</span>' ..
                                _U("buyfor") .. '<span style="margin-left:90px;">' .. '<span style="font-size:25px;">' .. ctp ..
                                '</span>' .. '<span style="font-size:30px;">' .. string.format("%.2f", storeItem.buyprice) ..
                                "</span><span style='color:Yellow;'>  " .. storeItem.currencyType .. "</span><br><br><br>" ..
                                storeItem.desc,
                            info = storeItem            
                        }            
                        elementIndex = elementIndex + 1    
                    end
                end  
            end
            
            if not itemFound then
                menuElements[elementIndex] = {
                    itemHeight = "2vh",
                    label = "<span style=font-size:15px;text-align:left;>∞</span>".. "<img style='max-height: 40px;max-width: 40px;float: left;text-align: center;margin-top: -5px;' src='nui://vorp_inventory/html/img/items/" ..
                        storeItem.itemName .. ".png'><span style=margin-left:40px;font-size:25px;text-align:center;>" ..
                        storeItem.itemLabel .. "</span>",
                    value = "sell" .. tostring(elementIndex),
                    desc = "" ..
                        '<span style="font-family: crock; src:nui://menuapi/html/fonts/crock.ttf) format("truetype")</span>' ..
                        _U("buyfor") .. '<span style="margin-left:90px;">' .. '<span style="font-size:25px;">' .. ctp ..
                        '</span>' .. '<span style="font-size:30px;">' .. string.format("%.2f", storeItem.buyprice) ..
                        "</span><span style='color:Yellow;'>  " .. storeItem.currencyType .. "</span><br><br><br>" ..
                        storeItem.desc,
                    info = storeItem
    
                }    
                elementIndex = elementIndex + 1                
            end            
        end
    end

    MenuData.Open('default', GetCurrentResourceName(), 'menuapi' .. storeId .. category, {
        title = storeConfig.storeName,
        subtext = "buy menu",
        align = Config.Align,
        elements = menuElements,
        lastmenu = "OpenSubMenu"

    }, function(data, menu)
        if (data.current == "backup") then
            _G[data.trigger](storeId, category)
        else

            local ItemName = data.current.info.itemName
            local ItemLabel = data.current.info.itemLabel
            local currencyType = data.current.info.currencyType
            local buyPrice = data.current.info.buyprice

            local myInput = {
                type = "enableinput", -- dont touch
                inputType = "input",
                button = _U("confirm"), -- button name
                placeholder = _U("insertamount"), -- placeholdername
                style = "block", --- dont touch
                attributes = {
                    inputHeader = _U("amount"), -- header
                    type = "number", -- inputype text, number,date.etc if number comment out the pattern
                    pattern = "[0-9]", -- regular expression validated for only numbers "[0-9]", for letters only [A-Za-z]+   with charecter limit  [A-Za-z]{5,20}     with chareceter limit and numbers [A-Za-z0-9]{5,}
                    title = _U("must"), -- if input doesnt match show this message
                    style = "border-radius: 10px; background-color: ; border:none;" -- style  the inptup
                }
            }
            if Config.Align == "center" then
                MenuData.CloseAll()
                ClearPedTasksImmediately(player)
                isInMenu = false
                DisplayRadar(true)
            end

            TriggerEvent("vorpinputs:advancedInput", json.encode(myInput), function(result)

                local qty = tonumber(result)
                if qty ~= nil and qty ~= 0 and qty > 0 then

                    TriggerServerEvent(GetCurrentResourceName()..":buy", ItemLabel, ItemName, currencyType, buyPrice, qty,storeId) -- sell it
                else
                    TriggerEvent("vorp:TipRight", _U("insertamount"), 3000)
                end

            end)

        end
    end, function(data, menu)
        menu.close()
        ClearPedTasksImmediately(player)
        isInMenu = false
        DisplayRadar(true)
    end)

end
 