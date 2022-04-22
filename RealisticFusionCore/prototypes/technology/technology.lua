data:extend{
    {
        type = "technology",
        name = "rf-deuterium-extraction",
        icon = "__RealisticFusionCore__/graphics/technology/deuterium.png",
        icon_size = 128,
        unit = {
            count = rfcore.sm * 1000,
            time = 15,
            ingredients = {
                {"automation-science-pack", 1},
                {"logistic-science-pack", 1},
                {"chemical-science-pack", 1}
            }
        },
        prerequisites = {"rf-fusion-theory"},
        effects = {
            {type = "unlock-recipe", recipe = "rf-water-purification"},
            {type = "unlock-recipe", recipe = "angels-electric-boiler"},
            {type = "unlock-recipe", recipe = "rf-electrolyser"}
        },
        localised_description = {"rf.deuterium-extraction", "rf-deuterium"}
    },
    {
        type = "technology",
        name = "rf-gs-process-1",
        icon = "__RealisticFusionCore__/graphics/icons/gs-process.png",
        icon_size = 64,
        localised_name = {"rf.gs-process-name", "0.02", "5"},
        localised_description = {"rf.gs-process-description", "rf-hydrogen-sulfide", "rf-heavy-water"},
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
        prerequisites = {"rf-deuterium-extraction", "rf-d-d-fusion"},
        effects = {
            {type = "unlock-recipe", recipe = "rf-hydrogen-sulfide"},
            {type = "unlock-recipe", recipe = "rf-girdler-sulfide-process-0"},
            {type = "unlock-recipe", recipe = "rf-heavy-water-purification-0"},
            {type = "unlock-recipe", recipe = "rf-discharge-pump"},
            {type = "unlock-recipe", recipe = "rf-depleted-water-heating"}
        }
    },
    {
        type = "technology",
        name = "rf-gs-process-2",
        icon = "__RealisticFusionCore__/graphics/icons/gs-process.png",
        icon_size = 64,
        localised_name = {"rf.gs-process-name", "5", "10"},
        localised_description = {"rf.gs-process", "rf-heavy-water"},
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
        prerequisites = {"rf-gs-process-1", "rf-tritium-breeding"},
        effects = {
            {type = "unlock-recipe", recipe = "rf-girdler-sulfide-process-1"},
            {type = "unlock-recipe", recipe = "rf-heavy-water-purification-1"}
        },
    },
    {
        type = "technology",
        name = "rf-gs-process-3",
        icon = "__RealisticFusionCore__/graphics/icons/gs-process.png",
        icon_size = 64,
        localised_name = {"rf.gs-process-name", "10", "20"},
        localised_description = {"rf.gs-process", "rf-heavy-water"},
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
        prerequisites = {"rf-gs-process-2", "rf-helium-3-breeding"},
        effects = {
            {type = "unlock-recipe", recipe = "rf-girdler-sulfide-process-2"},
            {type = "unlock-recipe", recipe = "rf-heavy-water-purification-2"}
        },
    }
}

data:extend{
    -- Chemical --
    {
        type = "technology",
        name = "rf-fusion-theory",
        icon = "__RealisticFusionCore__/graphics/technology/d-t-fusion.png",
        icon_size = 128,
        unit = {
            count = rfcore.sm * 500,
            time = 15,
            ingredients = {
                {"automation-science-pack", 1},
                {"logistic-science-pack", 1},
                {"chemical-science-pack", 1}
            }
        },
        prerequisites = {"nuclear-power"}
    },

    -- Production --
    {
        type = "technology",
        name = "rf-plasma-handling",
        icons = {{
            icon = "__base__/graphics/technology/fluid-handling.png",
            icon_size = 64, icon_mipmaps = 4,
            tint = {r = 1, g = 0.5, b = 0}
        }},
        unit = {
            count = rfcore.sm * 1500,
            time = 15,
            ingredients = {
                {"automation-science-pack", 1},
                {"logistic-science-pack", 1},
                {"chemical-science-pack", 1},
                {"production-science-pack", 1}
            }
        },
        prerequisites = {"rf-fusion-theory", "production-science-pack"},
        effects = {
            {type = "unlock-recipe", recipe = "rf-pipe"},
            {type = "unlock-recipe", recipe = "rf-pipe-to-ground"},
            {type = "unlock-recipe", recipe = "rf-pump"}
        },
    },
    {
        type = "technology",
        name = "rf-d-d-heating",
        icon = "__RealisticFusionCore__/graphics/technology/deuterium-plasma.png",
        icon_size = 128,
        unit = {
            count = rfcore.sm * 1500,
            time = 15,
            ingredients = {
                {"automation-science-pack", 1},
                {"logistic-science-pack", 1},
                {"chemical-science-pack", 1},
                {"production-science-pack", 1}
            }
        },
        prerequisites = {"rf-plasma-handling", "rf-deuterium-extraction"},
        effects = {
            {type = "unlock-recipe", recipe = "rf-heater"},
            {type = "unlock-recipe", recipe = "rf-d-d-heating-4"}
        },
        localised_description = {"rf.d-d-heating", "rf-deuterium"}
    },

    -- Utility --
    {
        type = "technology",
        name = "rf-tritium-breeding",
        icon = "__RealisticFusionCore__/graphics/technology/tritium.png",
        icon_size = 128,
        unit = {
            count = rfcore.sm * 5000,
            time = 15,
            ingredients = {
                {"automation-science-pack", 1},
                {"logistic-science-pack", 1},
                {"chemical-science-pack", 1},
                {"production-science-pack", 1},
                {"utility-science-pack", 1}
            }
        },
        prerequisites = {"rf-d-d-fusion", "rf-d-d-fusion-2-efficiency-2", "utility-science-pack"},
        effects = {{
            type = "unlock-recipe",
            recipe = "rf-d-d-fusion-1-9"
        }},
        localised_description = {"rf.tritium-breeding", "rf-tritium"}
    },
    {
        type = "technology",
        name = "rf-light-isotope-processing",
        icon = "__RealisticFusionCore__/graphics/icons/light-isotope-processor.png",
        icon_size = 64,
        unit = {
            count = rfcore.sm * 1000,
            time = 15,
            ingredients = {
                {"automation-science-pack", 1},
                {"logistic-science-pack", 1},
                {"chemical-science-pack", 1},
                {"production-science-pack", 1},
                {"utility-science-pack", 1}
            }
        },
        prerequisites = {"rf-tritium-breeding"},
        effects = {
            {type = "unlock-recipe", recipe = "rf-d-t-mixing"},
            {type = "unlock-recipe", recipe = "rf-light-isotope-processor"}
        },
        localised_description = {"rf.gas-mixing", "rf-deuterium", "rf-tritium"}
    },
    {
        type = "technology",
        name = "rf-d-t-heating",
        icon = "__RealisticFusionCore__/graphics/technology/d-t-plasma.png",
        icon_size = 128,
        unit = {
            count = rfcore.sm * 10000,
            time = 15,
            ingredients = {
                {"automation-science-pack", 1},
                {"logistic-science-pack", 1},
                {"chemical-science-pack", 1},
                {"production-science-pack", 1},
                {"utility-science-pack", 1}
            }
        },
        prerequisites = {"rf-tritium-breeding", "rf-light-isotope-processing"},
        effects = {
            {type = "unlock-recipe", recipe = "rf-d-t-heating-4"}
        },
        localised_description = {"rf.d-t-heating", "rf-d-t-mix"}
    },
    {
        type = "technology",
        name = "rf-helium-3-breeding",
        icon = "__RealisticFusionCore__/graphics/technology/helium-3.png",
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
        prerequisites = {"rf-aneutronic-fusion-theory", "rf-d-t-fusion-efficiency-3"},
        effects = {
            {type = "unlock-recipe", recipe = "rf-d-d-fusion-0-9"}
        },
        localised_description = {"rf.helium-3-breeding", "rf-helium-3", "rf-tritium"}
    },
    {
        type = "technology",
        name = "rf-helium-3-heating",
        icon = "__RealisticFusionCore__/graphics/technology/helium-3-plasma.png",
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
        prerequisites = {"rf-helium-3-breeding"},
        effects = {
            {type = "unlock-recipe", recipe = "rf-he3-he3-heating-4"}
        },
        localised_description = {"rf.helium-3-heating", "rf-helium-3"}
    },

    -- Space --
    {
        type = "technology",
        name = "rf-d-he3-mix",
        icon = "__RealisticFusionCore__/graphics/technology/d-he3-mix.png",
        icon_size = 128,
        unit = {
            count = rfcore.sm * 75000,
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
        prerequisites = {"rf-he3-he3-fusion", "space-science-pack"},
        effects = {
            {type = "unlock-recipe", recipe = "rf-d-he3-mixing"},
            {type = "unlock-recipe", recipe = "rf-d-he3-heating-4"}
        },
    },
}

data:extend{
    {
        type = "technology",
        name = "rf-tritium-decay",
        icon = "__RealisticFusionCore__/graphics/technology/old/tritium-decay.png",
        icon_size = 128,
        unit = {
            count = rfcore.sm * 100000,
            time = 15,
            ingredients = {
                {"automation-science-pack", 1},
                {"logistic-science-pack", 1},
                {"chemical-science-pack", 1},
                {"production-science-pack", 1},
                {"utility-science-pack", 1},
                {"space-science-pack", 1},
            }
        },
        prerequisites = {"rf-d-he3-fusion", "rf-d-he3-fusion-efficiency-3"},
        effects = {
            {type = "unlock-recipe", recipe = "rf-tritium-decay"}
        },
        localised_description = {"rf.tritium-decay", "rf-tritium", "rf-helium-3"}
    }
}