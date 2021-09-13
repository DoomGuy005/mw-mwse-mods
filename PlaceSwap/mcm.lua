local config = require("bigJayB.PlaceSwap.config")

local function createMCM()
    local template = mwse.mcm.createTemplate("Jay's Place Swap & Move Away")
    template:saveOnClose("placeSwap", config)

    local page = template:createPage()
    page:createKeyBinder {
        label = "Assign key to use with the mod",
        allowCombinations = false,
        variable = mwse.mcm.createTableVariable {
            id = "key",
            table = config,
            defaultSetting = {
                keyCode = tes3.scanCode.q,
                isShiftDown = false,
                isAltDown = false,
                isControlDown = false,
            },
            restartRequired = true
        }
    }
    template:register()
end

event.register("modConfigReady", createMCM)