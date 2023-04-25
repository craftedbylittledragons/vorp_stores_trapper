
Config = {}
Config.ScriptName = GetCurrentResourceName() 

-- TODO
-- CAMERA FACE NPC
-- NPC ANIMATION

--menu position
-- "center" / "top-left" / "top-right"
Config.Align = "top-left"

--Webhook Section, description is in translation
Config.UseWebhook = false -- Use webhook

--Mandatory Webhook Parts
Config.WebhookTitle = ""
Config.Webhook = ""

--Optional Webhook Parts, if not filled will default vorp_core config
Config.WebhookColor = ""
Config.WebhookName = ""
Config.WebhookLogo = ""
Config.WebhookLogo2 = ""
Config.WebhookAvatar = ""

Config.defaultlang = "en_lang"

-- open stores
Config.Key = 0x760A9C6F --[G]


    --- STORES ---

Config.Stores = { 
-----------------------------------------------------------------------------
--------------------------------------Valentine------------------------------
-----------------------------------------------------------------------------
    ValBlacksmith = {
        blipAllowed = true,
        BlipName = "Blacksmith Shop",
        storeName = "Valentine Blacksmith Shop",
        PromptName = "Blacksmith Shop",
        sprite = -758970771,
        x = -360.44, y = 794.71, z = 116.24, h = 336.49,
        distanceOpenStore = 3.0,
        NpcAllowed = true,
        NpcModel = "S_M_M_LiveryWorker_01",
        AllowedJobs = {}, -- jobs allowed
        JobGrade = 0,
        category = { "Tools" }, -- you need to add the same words to the buyitems and buyitems category you can add new categories as long the items have the category names
        storeType = {  "Buy","Sell" }, -- choose the storetype if you translate this you must do the same in the client.lua file
        StoreHoursAllowed = false, -- if you want the stores to use opening and closed hours
        RandomPrices = false,
        StoreOpen = 7, -- am
        StoreClose = 21 -- pm

    }, 
}

-----------------------------------------------------------------------------
-------------------------------------ITEMS-----------------------------------
-----------------------------------------------------------------------------

    -- ItemLable = translate here
    -- itemName = same as in your databse
    -- curencytype = "cash" or "gold" only use one.
    -- price = numbers only
    -- desc = a description of the item
    -- category = where the item will be displayed at 

BlackSmith_ShopItems_SELL = {         
       -- Tools
    { itemLabel = "Pickaxe", itemName = "pickaxe", currencyType = "cash", sellprice = 5, randomprice = math.random(30, 55), desc = "Sell a Pickaxe", category = "Tools" },
    { itemLabel = "Hatchet", itemName = "hatchet", currencyType = "cash", sellprice = 5, randomprice = math.random(30, 55), desc = "Sell a Garden Hoe", category = "Tools" }       
} 

-----------------------------------------------------------------------------
--------------------------------------SELL ITEMS ----------------------------
-----------------------------------------------------------------------------
Config.SellItems = {       
    -----------------------------------------------------------------------------
    --------------------------------------Valentine------------------------------
    -----------------------------------------------------------------------------        
        ValBlacksmith = BlackSmith_ShopItems_SELL,  
}
-----------------------------------------------------------------------------
-------------------------------------ITEMS-----------------------------------
-----------------------------------------------------------------------------

    -- ItemLable = translate here
    -- itemName = same as in your databse
    -- curencytype = "cash" or "gold" only use one.
    -- price = numbers only
    -- desc = a description of the item
    -- category = where the item will be displayed at
    BlackSmith_ShopItems_BUY = {
            -- Tools
           { itemLabel = "Pickaxe", itemName = "pickaxe", currencyType = "cash", buyprice = 20, randomprice = math.random(30, 55), desc = "Buy a Pickaxe", category = "Tools" },
            { itemLabel = "Hatchet", itemName = "hatchet", currencyType = "cash", buyprice = 20, randomprice = math.random(30, 55), desc = "Buy a Garden Hoe", category = "Tools" }            
     }
-----------------------------------------------------------------------------
--------------------------------------BUY ITEMS ----------------------------
-----------------------------------------------------------------------------
Config.BuyItems = {     
    -----------------------------------------------------------------------------
    --------------------------------------Valentine------------------------------
    -----------------------------------------------------------------------------       
        ValBlacksmith = BlackSmith_ShopItems_BUY, 
}

--- Want the pre configured data for the stores? 
--- Little Creek -- Admin an dConcept Owner of Little Creek, Tillie 
------- has put together an amazing set of stores and items.

--- Purchase her configuration files for vorp_stores at our website.
--- https://craftedbylittledragons.net/vorp-store-configuration-files-by-tillie-little-creek/

--- The config file for this specific store.
--- https://craftedbylittledragons.net/product/vorp_store_blacksmith-config-lua/

--- The related crafting files.
--- https://craftedbylittledragons.net/product/vorp_crafting_blacksmith-config-lua/

--- All crafting files. 
--- https://craftedbylittledragons.net/vorp-crafting-configuration-files-by-tillie-little-creek/

--- Bundles are available here:
--- https://craftedbylittledragons.net/vorp-configuration-files-bundles-by-tillie-little-creek/