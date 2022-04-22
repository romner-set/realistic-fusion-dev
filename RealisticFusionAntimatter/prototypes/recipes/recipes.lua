data:extend{
    {
        type = "recipe",
        name = "rf-antihydrogen",
        category = "rf-antimatter-processing",
        hide_from_player_crafting = true,
        energy_required = 7.5,
        ingredients = {{type = "fluid", name = "rf-antiprotons", amount = 1}, {type = "fluid", name = "rf-positrons", amount = 1}},
        results = {{type = "fluid", name = "rf-antihydrogen", amount = 1}},
        enabled = true--[[CHANGELATER]]
    },
    {
        type = "recipe",
        name = "rf-hydrogen-ionization",
        category = "chemistry",
        icon = "__RealisticFusionAntimatter__/graphics/icons/hydrogen-ionization.png",
        icon_size = 128,
        hide_from_player_crafting = true,
        energy_required = 7.5,
        ingredients = {{type = "fluid", name = "rf-hydrogen", amount = 1}},
        results = {{type = "fluid", name = "rf-protons", amount = 1}, {type = "fluid", name = "rf-electrons", amount = 1}},
        subgroup = "fluid",
        always_show_made_in = true,
        enabled = true--[[CHANGELATER]]
    },
    {
        type = "recipe",
        name = "rf-water-electrolysis",
        category = "rf-electrolysis",
        icon = "__RealisticFusionAntimatter__/graphics/icons/hydrogen.png",
        icon_size = 64, icon_mipmaps = 4,
        hide_from_player_crafting = true,
        energy_required = 1,
        ingredients = {{type = "fluid", name = "water", amount = 3}},
        results = {{type = "fluid", name = "rf-hydrogen", amount = 2}},
        subgroup = "fluid",
        always_show_made_in = true,
        enabled = true--[[CHANGELATER]]
    }
}
for i = 0, 4 do
    data:extend{
        {
            type = "recipe",
            name = "rf-antiproton-production-"..i,
            category = "rf-particle-acceleration",
            hide_from_player_crafting = true,
            energy_required = 1+i, --1+i*1
            ingredients = {{type = "fluid", name = "rf-protons", amount = 1}},
            results = {{type = "fluid", name = "rf-high-energy-antiprotons", amount = 1}},
            enabled = true--[[CHANGELATER]]
        },
        {
            type = "recipe",
            name = "rf-antiproton-deceleration-"..i,
            category = "rf-particle-deceleration",
            hide_from_player_crafting = true,
            energy_required = 2+i*2,
            ingredients = {{type = "fluid", name = "rf-high-energy-antiprotons", amount = 1}},
            results = {{type = "fluid", name = "rf-antiprotons", amount = 1}},
            enabled = true--[[CHANGELATER]]
        },
        {
            type = "recipe",
            name = "rf-positron-production-"..i,
            category = "rf-particle-acceleration",
            hide_from_player_crafting = true,
            energy_required = 1+i, --1+i*1
            ingredients = {{type = "fluid", name = "rf-electrons", amount = 1}},
            results = {{type = "fluid", name = "rf-high-energy-positrons", amount = 1}},
            enabled = true--[[CHANGELATER]]
        },
        {
            type = "recipe",
            name = "rf-positron-deceleration-"..i,
            category = "rf-particle-deceleration",
            hide_from_player_crafting = true,
            energy_required = 2+i*2,
            ingredients = {{type = "fluid", name = "rf-high-energy-positrons", amount = 1}},
            results = {{type = "fluid", name = "rf-positrons", amount = 1}},
            enabled = true--[[CHANGELATER]]
        },
    }
end