data:extend{
    -- Production --
    {
        type = "technology",
        name = "rf-fusion-reactor",
        icon = "__RealisticFusionPower__/graphics/technology/reactor.png",
        icon_size = 128,
        unit = {
            count = rfcore.sm * 4000,
            time = 15,
            ingredients = {
                {"automation-science-pack", 1},
                {"logistic-science-pack", 1},
                {"chemical-science-pack", 1},
                {"production-science-pack", 1}
            }
        },
        prerequisites = {"rf-fusion-theory", "rf-plasma-handling", "production-science-pack"},
        effects = {
            {type = "unlock-recipe", recipe = "rf-reactor"},
        },
    },
    {
        type = "technology",
        name = "rf-heat-exchanger",
        icon = "__RealisticFusionPower__/graphics/icons/heat-exchanger.png",
        icon_size = 64,
        unit = {
            count = rfcore.sm * 2000,
            time = 15,
            ingredients = {
                {"automation-science-pack", 1},
                {"logistic-science-pack", 1},
                {"chemical-science-pack", 1},
                {"production-science-pack", 1}
            }
        },
        prerequisites = {"rf-fusion-reactor"},
        effects = {
            {type = "unlock-recipe", recipe = "rf-heat-exchanger"},
        },
    },
    {
        type = "technology",
        name = "rf-fusion-d-d",
        icon = "__RealisticFusionPower__/graphics/technology/fusion-d-d.png",
        icon_size = 128,
        unit = {
            count = rfcore.sm * 5000,
            time = 15,
            ingredients = {
                {"automation-science-pack", 1},
                {"logistic-science-pack", 1},
                {"chemical-science-pack", 1},
                {"production-science-pack", 1}
            }
        },
        prerequisites = {"rf-d-d-heating", "rf-fusion-reactor", "rf-heat-exchanger"},
        effects = {
            {type = "unlock-recipe", recipe = "rf-fusion-d-d-2-9"},
        },
    },

    -- Utility --
    {
        type = "technology",
        name = "rf-fusion-d-t",
        icon = "__RealisticFusionCore__/graphics/technology/fusion-d-t.png",
        icon_size = 128,
        unit = {
            count = rfcore.sm * 15000,
            time = 15,
            ingredients = {
                {"automation-science-pack", 1},
                {"logistic-science-pack", 1},
                {"chemical-science-pack", 1},
                {"production-science-pack", 1},
                {"utility-science-pack", 1}
            }
        },
        prerequisites = {"rf-d-t-heating"},
        effects = {{type = "unlock-recipe", recipe = "rf-fusion-d-t-9"}}
    },
    {
        type = "technology",
        name = "rf-fusion-aneutronic-theory",
        icon = "__RealisticFusionPower__/graphics/technology/fusion-d-he3.png",
        icon_size = 128,
        unit = {
            count = rfcore.sm * 15000,
            time = 15,
            ingredients = {
                {"automation-science-pack", 1},
                {"logistic-science-pack", 1},
                {"chemical-science-pack", 1},
                {"production-science-pack", 1},
                {"utility-science-pack", 1}
            }
        },
        prerequisites = {"rf-fusion-d-t", "rf-fusion-d-t-efficiency-3"},
        effects = {},
    },
    {
        type = "technology",
        name = "rf-reactor-aneutronic",
        icon = "__RealisticFusionPower__/graphics/technology/reactor-aneutronic.png",
        icon_size = 128,
        unit = {
            count = rfcore.sm * 40000,
            time = 15,
            ingredients = {
                {"automation-science-pack", 1},
                {"logistic-science-pack", 1},
                {"chemical-science-pack", 1},
                {"production-science-pack", 1},
                {"utility-science-pack", 1}
            }
        },
        prerequisites = {"rf-fusion-aneutronic-theory"},
        effects = {
            {type = "unlock-recipe", recipe = "rf-reactor-aneutronic"}
        },
    },
    {
        type = "technology",
        name = "rf-direct-energy-conversion",
        icon = "__RealisticFusionPower__/graphics/icons/dec.png",
        icon_size = 64,
        unit = {
            count = rfcore.sm * 15000,
            time = 15,
            ingredients = {
                {"automation-science-pack", 1},
                {"logistic-science-pack", 1},
                {"chemical-science-pack", 1},
                {"production-science-pack", 1},
                {"utility-science-pack", 1}
            }
        },
        prerequisites = {"rf-reactor-aneutronic"},
        effects = {
            {type = "unlock-recipe", recipe = "rf-direct-energy-converter"}
        },
    },
    {
        type = "technology",
        name = "rf-fusion-he3-he3",
        icon = "__RealisticFusionPower__/graphics/technology/fusion-he3-he3.png",
        icon_size = 128,
        unit = {
            count = rfcore.sm * 20000,
            time = 15,
            ingredients = {
                {"automation-science-pack", 1},
                {"logistic-science-pack", 1},
                {"chemical-science-pack", 1},
                {"production-science-pack", 1},
                {"utility-science-pack", 1}
            }
        },
        prerequisites = {"rf-helium-3-heating", "rf-direct-energy-conversion"},
        effects = {
            {type = "unlock-recipe", recipe = "rf-fusion-he3-he3-9"}
        },
    },

    -- Space --
    {
        type = "technology",
        name = "rf-fusion-d-he3",
        icon = "__RealisticFusionPower__/graphics/technology/fusion-d-he3.png",
        icon_size = 128,
        unit = {
            count = rfcore.sm * 150000,
            time = 15,
            ingredients = {
                {"automation-science-pack", 1},
                {"logistic-science-pack", 1},
                {"chemical-science-pack", 1},
                {"production-science-pack", 1},
                {"utility-science-pack", 1},
                {"space-science-pack", 1}
            }
        },
        prerequisites = {"rf-d-he3-mix"},
        effects = {
            {type = "unlock-recipe", recipe = "rf-fusion-d-he3-9"},
        },
    },
}

if settings.startup["rf-hc-stuff"].value then
    table.insert(data.raw.technology["rf-fusion-d-t"].effects, {type = "unlock-recipe", recipe = "rf-hc-exchanger"})
    table.insert(data.raw.technology["rf-fusion-d-t"].effects, {type = "unlock-recipe", recipe = "rf-hc-turbine"})
end