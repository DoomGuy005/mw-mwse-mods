local config = require('bigJayB.DynamicPotionSizeAdjuster.config')
local modName = config.modName
local mcmConfig = mwse.loadConfig(modName, config.mcmDefaultValues)
local data--saved on tes3.player.data

local function debug(message, ...)
    if mcmConfig.debug then
        local output = string.format("[%s] %s", modName, tostring(message):format(...) )
        mwse.log(output)
    end
end


local function modEnabled()
    return mcmConfig.enabled == true
end

local function isPotion(reference)
    return reference.object.objectType == tes3.objectType.alchemy
        --and reference.object.type == 0
end
local function onItemDrop(e)
    if modEnabled() then
        if isPotion(e.reference) then
            e.reference.scale = (mcmConfig.potionScale / 100)
        end
    end
end
event.register("itemDropped", onItemDrop, { priority = -10 })


--MCM MENU
local function registerModConfig()
    local template = mwse.mcm.createTemplate{ name = modName }
    template:saveOnClose(modName, mcmConfig)
    template:register()

    local settings = template:createSideBarPage("Settings")
    settings.description = config.modDescription

    settings:createOnOffButton{
        label = string.format("Enable %s", modName),
        description = "Turn the mod on or off.",
        variable = mwse.mcm.createTableVariable{id = "enabled", table = mcmConfig}
    }
    settings:createSlider{
        label = "Potion Scale: %s%%",
        description = "The scale placed potions should be adjusted to.",
        min = 1, max = 100,
        step = 1, jump = 10,
        variable = mwse.mcm.createTableVariable{ id = "potionScale", table = mcmConfig}
    }
    settings:createOnOffButton{
        label = "Debug Mode",
        description = "Prints debug messages to mwse.log.",
        variable = mwse.mcm.createTableVariable{id = "debug", table = mcmConfig}
    }
end
event.register("modConfigReady", registerModConfig)
