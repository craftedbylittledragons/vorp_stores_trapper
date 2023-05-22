function _UiPromptSetUrgentPulsingEnabled(prompt, toggle)
    --UiPromptSetUrgentPulsingEnabled(prompt, toggle)
    Citizen.InvokeNative(0xC5F428EE08FA7F2C, prompt, toggle)  
end

function _UiPromptHasStandardModeCompleted(prompt)
    --UiPromptHasStandardModeCompleted(prompt, toggle) -- toggle = 0
    Citizen.InvokeNative(0xC92AC953F0A982AE, prompt)  
end

------------------ PROMPTS ------------------
function PromptSetUp()
    local str = _U("SubPrompt")
    OpenStores = PromptRegisterBegin()
    PromptSetControlAction(OpenStores, Config.Key)
    str = CreateVarString(10, 'LITERAL_STRING', str)
    PromptSetText(OpenStores, str)
    PromptSetEnabled(OpenStores, 1)
    PromptSetVisible(OpenStores, 1)
    PromptSetStandardMode(OpenStores, 1)
    PromptSetGroup(OpenStores, PromptGroup)
    _UiPromptSetUrgentPulsingEnabled(OpenStores, true)
    --Citizen.InvokeNative(0xC5F428EE08FA7F2C, OpenStores, true)
    PromptRegisterEnd(OpenStores)
end

function PromptSetUp2()
    local str = _U("SubPrompt")
    CloseStores = PromptRegisterBegin()
    PromptSetControlAction(CloseStores, Config.Key)
    str = CreateVarString(10, 'LITERAL_STRING', str)
    PromptSetText(CloseStores, str)
    PromptSetEnabled(CloseStores, 1)
    PromptSetVisible(CloseStores, 1)
    PromptSetStandardMode(CloseStores, 1)
    PromptSetGroup(CloseStores, PromptGroup2)
    _UiPromptSetUrgentPulsingEnabled(CloseStores, true)
    --Citizen.InvokeNative(0xC5F428EE08FA7F2C, CloseStores, true)
    PromptRegisterEnd(CloseStores)
end