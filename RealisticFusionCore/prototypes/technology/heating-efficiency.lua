data:extend{
-- #region D-D --
    {
        type = "technology",
        name = "rf-d-d-heating-efficiency-1",
        icon = "__RealisticFusionCore__/graphics/technology/deuterium-plasma.png",
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
        upgrade = true,
        prerequisites = {"rf-d-d-heating"},
        effects = {
            {type = "nothing", effect_description = "Deuterium heating: -25MW [375MW]"},
            {type = "unlock-recipe", recipe = "rf-d-d-heating-3"}
        },
        localised_description = {"rf.heating", "deuterium", "rf-deuterium", "D-D"}
    },
    {
        type = "technology",
        name = "rf-d-d-heating-efficiency-2",
        icon = "__RealisticFusionCore__/graphics/technology/deuterium-plasma.png",
        icon_size = 128,
        unit = {
            count = rfcore.sm * 6000,
            time = 15,
            ingredients = {
                {"automation-science-pack", 1},
                {"logistic-science-pack", 1},
                {"chemical-science-pack", 1},
                {"production-science-pack", 1}
            }
        },
        upgrade = true,
        prerequisites = {"rf-d-d-heating-efficiency-1"},
        effects = {
            {type = "nothing", effect_description = "Deuterium heating: -50MW [325MW]"},
            {type = "unlock-recipe", recipe = "rf-d-d-heating-2"}
        },
        localised_description = {"rf.heating", "deuterium", "rf-deuterium", "D-D"}
    },
    {
        type = "technology",
        name = "rf-d-d-heating-efficiency-3",
        icon = "__RealisticFusionCore__/graphics/technology/deuterium-plasma.png",
        icon_size = 128,
        unit = {
            count = rfcore.sm * 8000,
            time = 15,
            ingredients = {
                {"automation-science-pack", 1},
                {"logistic-science-pack", 1},
                {"chemical-science-pack", 1},
                {"production-science-pack", 1},
                {"utility-science-pack", 1}
            }
        },
        upgrade = true,
        prerequisites = {"rf-d-d-heating-efficiency-2", "utility-science-pack"},
        effects = {
            {type = "nothing", effect_description = "Deuterium heating: -50MW [275MW]"},
            {type = "unlock-recipe", recipe = "rf-d-d-heating-1"}
        },
        localised_description = {"rf.heating", "deuterium", "rf-deuterium", "D-D"}
    },
    {
        type = "technology",
        name = "rf-d-d-heating-efficiency-4",
        icon = "__RealisticFusionCore__/graphics/technology/deuterium-plasma.png",
        icon_size = 128,
        unit = {
            count = rfcore.sm * 10000,
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
        upgrade = true,
        prerequisites = {"rf-d-d-heating-efficiency-3", "space-science-pack"},
        effects = {
            {type = "nothing", effect_description = "Deuterium heating: -75MW [200MW]"},
            {type = "unlock-recipe", recipe = "rf-d-d-heating-0"}
        },
        localised_description = {"rf.heating", "deuterium", "rf-deuterium", "D-D"}
    },
-- #endregion --

-- #region D-T --
    {
        type = "technology",
        name = "rf-d-t-heating-efficiency-1",
        icon = "__RealisticFusionCore__/graphics/technology/d-t-plasma.png",
        icon_size = 128,
        unit = {
            count = rfcore.sm * 12000,
            time = 15,
            ingredients = {
                {"automation-science-pack", 1},
                {"logistic-science-pack", 1},
                {"chemical-science-pack", 1},
                {"production-science-pack", 1},
                {"utility-science-pack", 1}
            }
        },
        upgrade = true,
        prerequisites = {"rf-d-t-heating", "rf-d-d-heating-efficiency-1"},
        effects = {
            {type = "nothing", effect_description = "D-T heating: -50MW [150MW]"},
            {type = "unlock-recipe", recipe = "rf-d-t-heating-3"}
        },
        localised_description = {"rf.heating", "the D-T mix", "rf-d-t-mix", "D-T"}
    },
    {
        type = "technology",
        name = "rf-d-t-heating-efficiency-2",
        icon = "__RealisticFusionCore__/graphics/technology/d-t-plasma.png",
        icon_size = 128,
        unit = {
            count = rfcore.sm * 16000,
            time = 15,
            ingredients = {
                {"automation-science-pack", 1},
                {"logistic-science-pack", 1},
                {"chemical-science-pack", 1},
                {"production-science-pack", 1},
                {"utility-science-pack", 1}
            }
        },
        upgrade = true,
        prerequisites = {"rf-d-t-heating-efficiency-1", "rf-d-d-heating-efficiency-2"},
        effects = {
            {type = "nothing", effect_description = "D-T heating: -25MW [125MW]"},
            {type = "unlock-recipe", recipe = "rf-d-t-heating-2"}
        },
        localised_description = {"rf.heating", "the D-T mix", "rf-d-t-mix", "D-T"}
    },
    {
        type = "technology",
        name = "rf-d-t-heating-efficiency-3",
        icon = "__RealisticFusionCore__/graphics/technology/d-t-plasma.png",
        icon_size = 128,
        unit = {
            count = rfcore.sm * 20000,
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
        upgrade = true,
        prerequisites = {"rf-d-t-heating-efficiency-2", "rf-d-d-heating-efficiency-3", "space-science-pack"},
        effects = {
            {type = "nothing", effect_description = "D-T heating: -15MW [110MW]"},
            {type = "unlock-recipe", recipe = "rf-d-t-heating-1"}
        },
        localised_description = {"rf.heating", "the D-T mix", "rf-d-t-mix", "D-T"}
    },
    {
        type = "technology",
        name = "rf-d-t-heating-efficiency-4",
        icon = "__RealisticFusionCore__/graphics/technology/d-t-plasma.png",
        icon_size = 128,
        unit = {
            count = rfcore.sm * 30000,
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
        upgrade = true,
        prerequisites = {"rf-d-t-heating-efficiency-3", "rf-d-d-heating-efficiency-4"},
        effects = {
            {type = "nothing", effect_description = "D-T heating: -10MW [100MW]"},
            {type = "unlock-recipe", recipe = "rf-d-t-heating-0"}
        },
        localised_description = {"rf.heating", "the D-T mix", "rf-d-t-mix", "D-T"}
    },
-- #endregion

-- #region He3-He3 --
    {
        type = "technology",
        name = "rf-he3-he3-heating-efficiency-1",
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
        upgrade = true,
        prerequisites = {"rf-helium-3-heating", "rf-d-t-heating-efficiency-1"},
        effects = {
            {type = "nothing", effect_description = "Helium-3 heating: -500MW [6.5GW]"},
            {type = "unlock-recipe", recipe = "rf-he3-he3-heating-3"}
        },
        localised_description = {"rf.heating", "helium-3", "rf-helium-3", "He3-He3"}
    },
    {
        type = "technology",
        name = "rf-he3-he3-heating-efficiency-2",
        icon = "__RealisticFusionCore__/graphics/technology/helium-3-plasma.png",
        icon_size = 128,
        unit = {
            count = rfcore.sm * 25000,
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
        upgrade = true,
        prerequisites = {"rf-he3-he3-heating-efficiency-1", "rf-d-t-heating-efficiency-2", "space-science-pack"},
        effects = {
            {type = "nothing", effect_description = "Helium-3 heating: -500MW [6GW]"},
            {type = "unlock-recipe", recipe = "rf-he3-he3-heating-2"}
        },
        localised_description = {"rf.heating", "helium-3", "rf-helium-3", "He3-He3"}
    },
    {
        type = "technology",
        name = "rf-he3-he3-heating-efficiency-3",
        icon = "__RealisticFusionCore__/graphics/technology/helium-3-plasma.png",
        icon_size = 128,
        unit = {
            count = rfcore.sm * 40000,
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
        upgrade = true,
        prerequisites = {"rf-he3-he3-heating-efficiency-2", "rf-d-t-heating-efficiency-3"},
        effects = {
            {type = "nothing", effect_description = "Helium-3 heating: -500MW [5.5GW]"},
            {type = "unlock-recipe", recipe = "rf-he3-he3-heating-1"}
        },
        localised_description = {"rf.heating", "helium-3", "rf-helium-3", "He3-He3"}
    },
    {
        type = "technology",
        name = "rf-he3-he3-heating-efficiency-4",
        icon = "__RealisticFusionCore__/graphics/technology/helium-3-plasma.png",
        icon_size = 128,
        unit = {
            count = rfcore.sm * 60000,
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
        upgrade = true,
        prerequisites = {"rf-he3-he3-heating-efficiency-3", "rf-d-t-heating-efficiency-4"},
        effects = {
            {type = "nothing", effect_description = "Helium-3 heating: -500MW [5GW]"},
            {type = "unlock-recipe", recipe = "rf-he3-he3-heating-0"}
        },
        localised_description = {"rf.heating", "helium-3", "rf-helium-3", "He3-He3"}
    },
-- #endregion --

-- #region D-He3 --
    {
        type = "technology",
        name = "rf-d-he3-heating-efficiency-1",
        icon = "__RealisticFusionCore__/graphics/technology/d-he3-plasma.png",
        icon_size = 128,
        unit = {
            count = rfcore.sm * 30000,
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
        upgrade = true,
        prerequisites = {"rf-d-he3-mix", "rf-he3-he3-heating-efficiency-1"},
        effects = {
            {type = "nothing", effect_description = "D-He3 heating: -1GW [4GW]"},
            {type = "unlock-recipe", recipe = "rf-d-he3-heating-3"}
        },
        localised_description = {"rf.heating", "the D-He3 mixture", "rf-d-he3-mix", "D-He3"}
    },
    {
        type = "technology",
        name = "rf-d-he3-heating-efficiency-2",
        icon = "__RealisticFusionCore__/graphics/technology/d-he3-plasma.png",
        icon_size = 128,
        unit = {
            count = rfcore.sm * 50000,
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
        upgrade = true,
        prerequisites = {"rf-d-he3-heating-efficiency-1", "rf-he3-he3-heating-efficiency-2"},
        effects = {
            {type = "nothing", effect_description = "D-He3 heating: -1GW [3GW]"},
            {type = "unlock-recipe", recipe = "rf-d-he3-heating-2"}
        },
        localised_description = {"rf.heating", "the D-He3 mixture", "rf-d-he3-mix", "D-He3"}
    },
    {
        type = "technology",
        name = "rf-d-he3-heating-efficiency-3",
        icon = "__RealisticFusionCore__/graphics/technology/d-he3-plasma.png",
        icon_size = 128,
        unit = {
            count = rfcore.sm * 80000,
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
        upgrade = true,
        prerequisites = {"rf-d-he3-heating-efficiency-2", "rf-he3-he3-heating-efficiency-3"},
        effects = {
            {type = "nothing", effect_description = "D-He3 heating: -1GW [2GW]"},
            {type = "unlock-recipe", recipe = "rf-d-he3-heating-1"}
        },
        localised_description = {"rf.heating", "the D-He3 mixture", "rf-d-he3-mix", "D-He3"}
    },
    {
        type = "technology",
        name = "rf-d-he3-heating-efficiency-4",
        icon = "__RealisticFusionCore__/graphics/technology/d-he3-plasma.png",
        icon_size = 128,
        unit = {
            count = rfcore.sm * 120000,
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
        upgrade = true,
        prerequisites = {"rf-d-he3-heating-efficiency-3", "rf-he3-he3-heating-efficiency-4"},
        effects = {
            {type = "nothing", effect_description = "D-He3 heating: -500MW [1.5GW]"},
            {type = "unlock-recipe", recipe = "rf-d-he3-heating-0"}
        },
        localised_description = {"rf.heating", "the D-He3 mixture", "rf-d-he3-mix", "D-He3"}
    },
-- #endregion --
}