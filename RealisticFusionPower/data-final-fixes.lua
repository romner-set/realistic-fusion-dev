for k,_ in pairs(mods) do pcall(require, "compatibility-patches."..k..".data-final-fixes") end

if data.raw.recipe["nuclear-fuel"] and not data.raw.recipe["nuclear-fuel"].hidden and not mods["Krastorio2"] then
    data:extend{
        {
            type = "item",
            name = "rf-fuel-thermonuclear",
            icon = "__RealisticFusionPower__/graphics/icons/fuel-thermonuclear.png",
            icon_size = 64, icon_mipmaps = 4,
            pictures =
            {
            layers =
            {
                {
                size = 64,
                filename = "__RealisticFusionPower__/graphics/icons/fuel-thermonuclear.png",
                scale = 0.25,
                mipmap_count = 4
                },
                {
                draw_as_light = true,
                flags = {"light"},
                size = 64,
                filename = "__base__/graphics/icons/nuclear-fuel-light.png",
                scale = 0.25,
                mipmap_count = 4
                }
            }
            },
            fuel_category = "chemical",
            fuel_value = "2.5GJ",
            fuel_acceleration_multiplier = 3.5,
            fuel_top_speed_multiplier = 1.25,
            -- fuel_glow_color = {r = 0.1, g = 1, b = 0.1},
            subgroup = "intermediate-product",
            order = "q[uranium-rocket-fuel]-a[thermonuclear-rocket-fuel]",
            stack_size = 1
        },
        {
            type = "item",
            name = "rf-fuel-fusion",
            icon = "__RealisticFusionPower__/graphics/icons/fuel-fusion.png",
            icon_size = 64, icon_mipmaps = 4,
            pictures =
            {
            layers =
            {
                {
                size = 64,
                filename = "__RealisticFusionPower__/graphics/icons/fuel-fusion.png",
                scale = 0.25,
                mipmap_count = 4
                },
                {
                draw_as_light = true,
                flags = {"light"},
                size = 64,
                filename = "__base__/graphics/icons/nuclear-fuel-light.png",
                scale = 0.25,
                mipmap_count = 4
                }
            }
            },
            fuel_category = "chemical",
            fuel_value = "10GJ",
            fuel_acceleration_multiplier = 5,
            fuel_top_speed_multiplier = 1.5,
            -- fuel_glow_color = {r = 0.1, g = 1, b = 0.1},
            subgroup = "intermediate-product",
            order = "q[uranium-rocket-fuel]-b[fusion-rocket-fuel]",
            stack_size = 1
        },

        {
            type = "recipe",
            name = "rf-fuel-thermonuclear",
            energy_required = 60,
            enabled = true--[[CHANGELATER]],
            category = "crafting-with-fluid",
            ingredients = {{"nuclear-fuel", 1}, {type="fluid", name="rf-d-t-mix", amount=100}},
            icon = "__RealisticFusionPower__/graphics/icons/fuel-thermonuclear.png",
            icon_size = 64, icon_mipmaps = 4,
            result = "rf-fuel-thermonuclear"
        },
        {
            type = "recipe",
            name = "rf-fuel-fusion",
            energy_required = 200,
            enabled = true--[[CHANGELATER]],
            category = "crafting-with-fluid",
            ingredients = {{"rocket-fuel", 1}, {type="fluid", name="rf-d-he3-mix", amount=100}},
            icon = "__RealisticFusionPower__/graphics/icons/fuel-fusion.png",
            icon_size = 64, icon_mipmaps = 4,
            result = "rf-fuel-fusion"
        },
    }
    --TODO table.insert(data.raw.technology["rf-fusion-d-t"].effects, {type = "unlock-recipe", recipe = "rf-fuel-thermonuclear"})
    --TODO table.insert(data.raw.technology["rf-fusion-d-he3"].effects, {type = "unlock-recipe", recipe = "rf-fuel-fusion"})
end