return {
    --Mod name will be used for the MCM menu as well as the name of the config .json file.
    modName = "Dynamic Potion Size Adjuster",
    --Description for the MCM sidebar
    modDescription =
[[
The damn potions are so big, you can't fit one in your pocket. Use the slider to change the potion size scale. Doens't work on already placed potions.
]],
    mcmDefaultValues = {
        enabled = true, 
        potionScale = 75,
        debug = true,
    },

}