local function add_to_lab(lab)
    if data.raw.lab[lab] then
        for _, _v in ipairs(data.raw.lab[lab].inputs) do
            if _v == "rf-antimatter-science-pack" then
                return
            end
        end
        table.insert(data.raw.lab[lab].inputs, "rf-antimatter-science-pack")
    end
end

if not mods["Krastorio2"] then add_to_lab("lab")
    if data.raw.recipe["nuclear-fuel"] and not data.raw.recipe["nuclear-fuel"].hidden then
        data:extend{
            {
                type = "item",
                name = "rf-antimatter-fuel",
                icon = "__RealisticFusionAntimatter__/graphics/icons/antimatter-fuel.png",
                icon_size = 64, icon_mipmaps = 4,
                pictures =
                {
                layers =
                {
                    {
                    size = 64,
                    filename = "__RealisticFusionAntimatter__/graphics/icons/antimatter-fuel.png",
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
                fuel_value = "100GJ",
                fuel_acceleration_multiplier = 10,
                fuel_top_speed_multiplier = 2,
                -- fuel_glow_color = {r = 0.1, g = 1, b = 0.1},
                subgroup = "intermediate-product",
                order = "q[uranium-rocket-fuel]-c[antimatter-rocket-fuel]",
                stack_size = 1
            },

            {
                type = "recipe",
                name = "rf-antimatter-fuel",
                energy_required = 400,
                enabled = true--[[CHANGELATER]],
                category = "rf-antimatter-processing",
                ingredients = {{"rocket-fuel", 1}, {type="fluid", name="rf-antihydrogen", amount=10}, {type="fluid", name="rf-hydrogen", amount=10}},
                icon = "__RealisticFusionAntimatter__/graphics/icons/antimatter-fuel.png",
                icon_size = 64, icon_mipmaps = 4,
                result = "rf-antimatter-fuel"
            },
        }
        --TODO table.insert(data.raw.technology["rf-antimatter-processing"].effects, {type = "unlock-recipe", recipe = "rf-antimatter-fuel"})
    end
end