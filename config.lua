
Config = {}
Config.ScriptName = GetCurrentResourceName()

    -- TODO
    -- CAMERA FACE NPC
    -- NPC ANIMATION

    --menu position
    -- "center" / "top-left" / "top-right"
Config.Align = "top-left"

Config.defaultlang = "en_lang"

       -- open stores
Config.Key = 0x760A9C6F --[G]

    --- STORES ---

Config.Stores = {


-----------------------------------------------------------------------------
--------------------------------------Armadillo------------------------------
-----------------------------------------------------------------------------
  
-----------------------------------------------------------------------------
--------------------------------------Blackwater-----------------------------
-----------------------------------------------------------------------------
   
-----------------------------------------------------------------------------
--------------------------------------Rhodes---------------------------------
----------------------------------------------------------------------------- 
      
-----------------------------------------------------------------------------
--------------------------------------St-Denis-------------------------------
-----------------------------------------------------------------------------
 
-----------------------------------------------------------------------------
--------------------------------------Strawberry-----------------------------
-----------------------------------------------------------------------------
 
-----------------------------------------------------------------------------
--------------------------------------Tumbleweed-----------------------------
-----------------------------------------------------------------------------
 
-----------------------------------------------------------------------------
--------------------------------------Valentine------------------------------
-----------------------------------------------------------------------------
  
    ValTrapper = {
        blipAllowed = true,
        BlipName = "Trapper Store",
        storeName = "Valentine Trapper Store",
        PromptName = "Trapper Store",
        sprite = -1665418949,
         x = -335.01, y = 774.62, z = 116.07, h = 147.76, 
        distanceOpenStore = 2.5,
        NpcAllowed = true,
        NpcModel = "MP_CAMPDEF_gaptoothbreach_females_01",
        AllowedJobs = {}, -- jobs allowed
        JobGrade = 0,
        category = { "Misc","Claws"},
        storeType = { "Buy","Sell" }, -- only one type
        StoreHoursAllowed = false,
        RandomPrices = false,
        StoreOpen = 7, -- am
        StoreClose = 21 -- pm

    }, 
-----------------------------------------------------------------------------
--------------------------------------Vanhorn--------------------------------
-----------------------------------------------------------------------------
 

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

Trapper_Sell_Items = {
   
        --Misc
            { itemLabel = "Fish Eggs", itemName = "fish_eggs", currencyType = "cash", item_price = 1, randomprice = math.random(30, 55), desc = "Sell Fish Eggs", category = "Misc" },   
            { itemLabel = "Fish Head", itemName = "fish_head", currencyType = "cash", item_price = 1, randomprice = math.random(30, 55), desc = "Sell Fish Head", category = "Misc" },
            { itemLabel = "Snake Poison", itemName = "Snake_Poison", currencyType = "cash", item_price = 1, randomprice = math.random(30, 55), desc = "Sell Snake Poison", category = "Misc" },
            { itemLabel = "Wool", itemName = "wool", currencyType = "cash", item_price = 1, randomprice = math.random(30, 55), desc = "Sell Wool", category = "Misc" }    
}
-----------------------------------------------------------------------------
--------------------------------------SELL ITEMS ----------------------------
-----------------------------------------------------------------------------
Config.SellItems = {      
    -----------------------------------------------------------------------------
    --------------------------------------Armadillo------------------------------
    -----------------------------------------------------------------------------
   
    -----------------------------------------------------------------------------
    --------------------------------------Blackwater------------------------------
    ----------------------------------------------------------------------------- 
        BlackwaterTrapper = Trapper_Sell_Items , 
    -----------------------------------------------------------------------------
    --------------------------------------Rhodes--------------------------------- 
        RhodesTrapper = Trapper_Sell_Items , 
    -----------------------------------------------------------------------------
    --------------------------------------St-Denis-------------------------------
    ----------------------------------------------------------------------------- 
        StDenisTrapper = Trapper_Sell_Items , 
    -----------------------------------------------------------------------------
    --------------------------------------Strawberry-----------------------------
    ----------------------------------------------------------------------------- 
        StrawbTrapper = Trapper_Sell_Items , 
    -----------------------------------------------------------------------------
    --------------------------------------Tumbleweed-----------------------------
    -----------------------------------------------------------------------------
         TumbleTrapper = Trapper_Sell_Items , 
    -----------------------------------------------------------------------------
    --------------------------------------Valentine------------------------------
    ----------------------------------------------------------------------------- 
        ValTrapper = Trapper_Sell_Items , 
    -----------------------------------------------------------------------------
    --------------------------------------Vanhorn--------------------------------
    ----------------------------------------------------------------------------- 
        VanTrapper = Trapper_Sell_Items , 
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

Trapper_Buy_Items = {
 
    --Misc
        { itemLabel = "Fish Eggs", itemName = "fish_eggs", currencyType = "cash", item_price = 5, randomprice = math.random(30, 55), desc = "Buy Fish Eggs", category = "Misc" },   
        { itemLabel = "Fish Head", itemName = "fish_head", currencyType = "cash", item_price = 2, randomprice = math.random(30, 55), desc = "Buy Fish Head", category = "Misc" },
        { itemLabel = "Snake Poison", itemName = "Snake_Poison", currencyType = "cash", item_price = 25, randomprice = math.random(30, 55), desc = "Buy Snake Poison", category = "Misc" },
        { itemLabel = "Wool", itemName = "wool", currencyType = "cash", item_price = 10, randomprice = math.random(30, 55), desc = "Buy Wool", category = "Misc" }   
}

-----------------------------------------------------------------------------
--------------------------------------BUY ITEMS ----------------------------
-----------------------------------------------------------------------------
Config.BuyItems = {
    
    -----------------------------------------------------------------------------
    --------------------------------------Armadillo- ----------------------------
    -----------------------------------------------------------------------------
 
    -----------------------------------------------------------------------------
    --------------------------------------Blackwater------------------------------
    -----------------------------------------------------------------------------
         BlackwaterTrapper = Trapper_Buy_Items, 
    -----------------------------------------------------------------------------
    --------------------------------------Rhodes---------------------------------
    ----------------------------------------------------------------------------- 
        RhodesTrapper = Trapper_Buy_Items,  
    -----------------------------------------------------------------------------
    --------------------------------------St-Denis-------------------------------
    ----------------------------------------------------------------------------- 
        StDenisTrapper = Trapper_Buy_Items, 
    -----------------------------------------------------------------------------
    --------------------------------------Strawberry-----------------------------
    ----------------------------------------------------------------------------- 
        StrawbTrapper = Trapper_Buy_Items, 
    -----------------------------------------------------------------------------
    --------------------------------------Tumbleweed-----------------------------
    ----------------------------------------------------------------------------- 
        TumbleTrapper = Trapper_Buy_Items, 
    -----------------------------------------------------------------------------
    --------------------------------------Valentine------------------------------
    ----------------------------------------------------------------------------- 
        ValTrapper = Trapper_Buy_Items,  
    -----------------------------------------------------------------------------
    --------------------------------------Vanhorn--------------------------------
    -----------------------------------------------------------------------------    
        VanTrapper = Trapper_Buy_Items, 
 
    
}
