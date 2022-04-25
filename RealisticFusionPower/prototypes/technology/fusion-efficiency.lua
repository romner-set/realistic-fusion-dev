-- #region DATA --

data:extend{
-- #region D-D-2 --
    {
        type = "technology",
        name = "rf-fusion-d-d-2-efficiency-1",
        icon = "__RealisticFusionPower__/graphics/technology/fusion-d-d.png",
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
        upgrade = true,
        prerequisites = {"rf-fusion-d-d"},
        effects = {
            {type = "nothing", effect_description  = "D-D fusion: +30MW [430MW]"},
            {type = "unlock-recipe", recipe = "rf-fusion-d-d-2-8"}
        }
    },
    {
        type = "technology",
        name = "rf-fusion-d-d-2-efficiency-2",
        icon = "__RealisticFusionPower__/graphics/technology/fusion-d-d.png",
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
        prerequisites = {"rf-fusion-d-d-2-efficiency-1"},
        effects = {
            {type = "nothing", effect_description  = "D-D fusion: +30MW [460MW]"},
            {type = "unlock-recipe", recipe = "rf-fusion-d-d-2-7"}
        }
    },
    {
        type = "technology",
        name = "rf-fusion-d-d-2-efficiency-3",
        icon = "__RealisticFusionPower__/graphics/technology/fusion-d-d.png",
        icon_size = 128,
        unit = {
            count = rfcore.sm * 8000,
            time = 15,
            ingredients = {
                {"automation-science-pack", 1},
                {"logistic-science-pack", 1},
                {"chemical-science-pack", 1},
                {"production-science-pack", 1}
            }
        },
        upgrade = true,
        prerequisites = {"rf-fusion-d-d-2-efficiency-2"},
        effects = {
            {type = "nothing", effect_description  = "D-D fusion: +20MW [480MW]"},
            {type = "unlock-recipe", recipe = "rf-fusion-d-d-2-6"}
        }
    },
    {
        type = "technology",
        name = "rf-fusion-d-d-2-efficiency-4",
        icon = "__RealisticFusionPower__/graphics/technology/fusion-d-d.png",
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
        upgrade = true,
        prerequisites = {"rf-fusion-d-d-2-efficiency-3", "utility-science-pack"},
        effects = {
            {type = "nothing", effect_description  = "D-D fusion: +20MW [500MW]"},
            {type = "unlock-recipe", recipe = "rf-fusion-d-d-2-5"}
        }
    },
    {
        type = "technology",
        name = "rf-fusion-d-d-2-efficiency-5",
        icon = "__RealisticFusionPower__/graphics/technology/fusion-d-d.png",
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
        prerequisites = {"rf-fusion-d-d-2-efficiency-4"},
        effects = {
            {type = "nothing", effect_description  = "D-D fusion: +20MW [520MW]"},
            {type = "unlock-recipe", recipe = "rf-fusion-d-d-2-4"}
        }
    },
    {
        type = "technology",
        name = "rf-fusion-d-d-2-efficiency-6",
        icon = "__RealisticFusionPower__/graphics/technology/fusion-d-d.png",
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
        prerequisites = {"rf-fusion-d-d-2-efficiency-5"},
        effects = {
            {type = "nothing", effect_description  = "D-D fusion: +20MW [540MW]"},
            {type = "unlock-recipe", recipe = "rf-fusion-d-d-2-3"}
        }
    },
    {
        type = "technology",
        name = "rf-fusion-d-d-2-efficiency-7",
        icon = "__RealisticFusionPower__/graphics/technology/fusion-d-d.png",
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
        prerequisites = {"rf-fusion-d-d-2-efficiency-6", "space-science-pack"},
        effects = {
            {type = "nothing", effect_description  = "D-D fusion: +20MW [560MW]"},
            {type = "unlock-recipe", recipe = "rf-fusion-d-d-2-2"}
        }
    },
    {
        type = "technology",
        name = "rf-fusion-d-d-2-efficiency-8",
        icon = "__RealisticFusionPower__/graphics/technology/fusion-d-d.png",
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
        prerequisites = {"rf-fusion-d-d-2-efficiency-7"},
        effects = {
            {type = "nothing", effect_description  = "D-D fusion: +20MW [580MW]"},
            {type = "unlock-recipe", recipe = "rf-fusion-d-d-2-1"}
        }
    },
    {
        type = "technology",
        name = "rf-fusion-d-d-2-efficiency-9",
        icon = "__RealisticFusionPower__/graphics/technology/fusion-d-d.png",
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
        prerequisites = {"rf-fusion-d-d-2-efficiency-8"},
        effects = {
            {type = "nothing", effect_description  = "D-D fusion: +20MW [600MW]"},
            {type = "unlock-recipe", recipe = "rf-fusion-d-d-2-0"}
        }
    },
-- #endregion --

-- #region D-D-1 --
    {
        type = "technology",
        name = "rf-fusion-d-d-1-efficiency-1",
        icon = "__RealisticFusionPower__/graphics/technology/fusion-d-d.png",
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
        prerequisites = {"rf-tritium-breeding", "rf-fusion-d-d-2-efficiency-1", "utility-science-pack"},
        effects = {
            {type = "nothing", effect_description  = "Tritium suppressed D-D fusion: +15MW [215MW]"},
            {type = "unlock-recipe", recipe = "rf-fusion-d-d-1-8"}
        }
    },
    {
        type = "technology",
        name = "rf-fusion-d-d-1-efficiency-2",
        icon = "__RealisticFusionPower__/graphics/technology/fusion-d-d.png",
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
        prerequisites = {"rf-fusion-d-d-1-efficiency-1", "rf-fusion-d-d-2-efficiency-2"},
        effects = {
            {type = "nothing", effect_description  = "Tritium suppressed D-D fusion: +15MW [230MW]"},
            {type = "unlock-recipe", recipe = "rf-fusion-d-d-1-7"}
        }
    },
    {
        type = "technology",
        name = "rf-fusion-d-d-1-efficiency-3",
        icon = "__RealisticFusionPower__/graphics/technology/fusion-d-d.png",
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
        prerequisites = {"rf-fusion-d-d-1-efficiency-2", "rf-fusion-d-d-2-efficiency-3"},
        effects = {
            {type = "nothing", effect_description  = "Tritium suppressed D-D fusion: +10MW [240MW]"},
            {type = "unlock-recipe", recipe = "rf-fusion-d-d-1-6"}
        }
    },
    {
        type = "technology",
        name = "rf-fusion-d-d-1-efficiency-4",
        icon = "__RealisticFusionPower__/graphics/technology/fusion-d-d.png",
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
        upgrade = true,
        prerequisites = {"rf-fusion-d-d-1-efficiency-3", "rf-fusion-d-d-2-efficiency-4"},
        effects = {
            {type = "nothing", effect_description  = "Tritium suppressed D-D fusion: +10MW [250MW]"},
            {type = "unlock-recipe", recipe = "rf-fusion-d-d-1-5"}
        }
    },
    {
        type = "technology",
        name = "rf-fusion-d-d-1-efficiency-5",
        icon = "__RealisticFusionPower__/graphics/technology/fusion-d-d.png",
        icon_size = 128,
        unit = {
            count = rfcore.sm * 24000,
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
        prerequisites = {"rf-fusion-d-d-1-efficiency-4", "rf-fusion-d-d-2-efficiency-5"},
        effects = {
            {type = "nothing", effect_description  = "Tritium suppressed D-D fusion: +10MW [260MW]"},
            {type = "unlock-recipe", recipe = "rf-fusion-d-d-1-4"}
        }
    },
    {
        type = "technology",
        name = "rf-fusion-d-d-1-efficiency-6",
        icon = "__RealisticFusionPower__/graphics/technology/fusion-d-d.png",
        icon_size = 128,
        unit = {
            count = rfcore.sm * 30000,
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
        prerequisites = {"rf-fusion-d-d-1-efficiency-5", "rf-fusion-d-d-2-efficiency-6"},
        effects = {
            {type = "nothing", effect_description  = "Tritium suppressed D-D fusion: +10MW [270MW]"},
            {type = "unlock-recipe", recipe = "rf-fusion-d-d-1-3"}
        }
    },
    {
        type = "technology",
        name = "rf-fusion-d-d-1-efficiency-7",
        icon = "__RealisticFusionPower__/graphics/technology/fusion-d-d.png",
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
        prerequisites = {"rf-fusion-d-d-1-efficiency-6", "rf-fusion-d-d-2-efficiency-7"},
        effects = {
            {type = "nothing", effect_description  = "Tritium suppressed D-D fusion: +10MW [280MW]"},
            {type = "unlock-recipe", recipe = "rf-fusion-d-d-1-2"}
        }
    },
    {
        type = "technology",
        name = "rf-fusion-d-d-1-efficiency-8",
        icon = "__RealisticFusionPower__/graphics/technology/fusion-d-d.png",
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
        prerequisites = {"rf-fusion-d-d-1-efficiency-7", "rf-fusion-d-d-2-efficiency-8"},
        effects = {
            {type = "nothing", effect_description  = "Tritium suppressed D-D fusion: +10MW [290MW]"},
            {type = "unlock-recipe", recipe = "rf-fusion-d-d-1-1"}
        }
    },
    {
        type = "technology",
        name = "rf-fusion-d-d-1-efficiency-9",
        icon = "__RealisticFusionPower__/graphics/technology/fusion-d-d.png",
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
        prerequisites = {"rf-fusion-d-d-1-efficiency-8", "rf-fusion-d-d-2-efficiency-9"},
        effects = {
            {type = "nothing", effect_description  = "Tritium suppressed D-D fusion: +10MW [300MW]"},
            {type = "unlock-recipe", recipe = "rf-fusion-d-d-1-0"}
        }
    },
-- #endregion --

-- #region D-T --
    {
        type = "technology",
        name = "rf-fusion-d-t-efficiency-1",
        icon = "__RealisticFusionCore__/graphics/technology/fusion-d-t.png",
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
        prerequisites = {"rf-fusion-d-t"},
        effects = {
            {type = "nothing", effect_description  = "D-T fusion: +50MW [1450MW]"},
            {type = "unlock-recipe", recipe = "rf-fusion-d-t-8"}
        }
    },
    {
        type = "technology",
        name = "rf-fusion-d-t-efficiency-2",
        icon = "__RealisticFusionCore__/graphics/technology/fusion-d-t.png",
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
        prerequisites = {"rf-fusion-d-t-efficiency-1"},
        effects = {
            {type = "nothing", effect_description  = "D-T fusion: +50MW [1450MW]"},
            {type = "unlock-recipe", recipe = "rf-fusion-d-t-7"}
        }
    },
    {
        type = "technology",
        name = "rf-fusion-d-t-efficiency-3",
        icon = "__RealisticFusionCore__/graphics/technology/fusion-d-t.png",
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
        prerequisites = {"rf-fusion-d-t-efficiency-2"},
        effects = {
            {type = "nothing", effect_description  = "D-T fusion: +50MW [1500MW]"},
            {type = "unlock-recipe", recipe = "rf-fusion-d-t-6"}
        }
    },
    {
        type = "technology",
        name = "rf-fusion-d-t-efficiency-4",
        icon = "__RealisticFusionCore__/graphics/technology/fusion-d-t.png",
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
        upgrade = true,
        prerequisites = {"rf-fusion-d-t-efficiency-3"},
        effects = {
            {type = "nothing", effect_description  = "D-T fusion: +100MW [1600MW]"},
            {type = "unlock-recipe", recipe = "rf-fusion-d-t-5"}
        }
    },
    {
        type = "technology",
        name = "rf-fusion-d-t-efficiency-5",
        icon = "__RealisticFusionCore__/graphics/technology/fusion-d-t.png",
        icon_size = 128,
        unit = {
            count = rfcore.sm * 24000,
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
        prerequisites = {"rf-fusion-d-t-efficiency-4"},
        effects = {
            {type = "nothing", effect_description  = "D-T fusion: +100MW [1700MW]"},
            {type = "unlock-recipe", recipe = "rf-fusion-d-t-4"}
        }
    },
    {
        type = "technology",
        name = "rf-fusion-d-t-efficiency-6",
        icon = "__RealisticFusionCore__/graphics/technology/fusion-d-t.png",
        icon_size = 128,
        unit = {
            count = rfcore.sm * 30000,
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
        prerequisites = {"rf-fusion-d-t-efficiency-5"},
        effects = {
            {type = "nothing", effect_description  = "D-T fusion: +100MW [1800MW]"},
            {type = "unlock-recipe", recipe = "rf-fusion-d-t-3"}
        }
    },
    {
        type = "technology",
        name = "rf-fusion-d-t-efficiency-7",
        icon = "__RealisticFusionCore__/graphics/technology/fusion-d-t.png",
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
        prerequisites = {"rf-fusion-d-t-efficiency-6", "space-science-pack"},
        effects = {
            {type = "nothing", effect_description  = "D-T fusion: +100MW [1900MW]"},
            {type = "unlock-recipe", recipe = "rf-fusion-d-t-2"}
        }
    },
    {
        type = "technology",
        name = "rf-fusion-d-t-efficiency-8",
        icon = "__RealisticFusionCore__/graphics/technology/fusion-d-t.png",
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
        prerequisites = {"rf-fusion-d-t-efficiency-7"},
        effects = {
            {type = "nothing", effect_description  = "D-T fusion: +50MW [1950MW]"},
            {type = "unlock-recipe", recipe = "rf-fusion-d-t-1"}
        }
    },
    {
        type = "technology",
        name = "rf-fusion-d-t-efficiency-9",
        icon = "__RealisticFusionCore__/graphics/technology/fusion-d-t.png",
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
        prerequisites = {"rf-fusion-d-t-efficiency-8"},
        effects = {
            {type = "nothing", effect_description  = "D-T fusion: +50MW [2000MW]"},
            {type = "unlock-recipe", recipe = "rf-fusion-d-t-0"}
        }
    },
-- #endregion --

-- #region D-D-0 --
    {
        type = "technology",
        name = "rf-fusion-d-d-0-efficiency-1",
        icon = "__RealisticFusionPower__/graphics/technology/fusion-d-d.png",
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
        prerequisites = {"rf-helium-3-breeding", "rf-fusion-d-d-1-efficiency-1"},
        effects = {
            {type = "nothing", effect_description  = "T+He3 suppressed D-D fusion: +15MW [115MW]"},
            {type = "unlock-recipe", recipe = "rf-fusion-d-d-0-8"}
        }
    },
    {
        type = "technology",
        name = "rf-fusion-d-d-0-efficiency-2",
        icon = "__RealisticFusionPower__/graphics/technology/fusion-d-d.png",
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
        prerequisites = {"rf-fusion-d-d-0-efficiency-1", "rf-fusion-d-d-1-efficiency-2"},
        effects = {
            {type = "nothing", effect_description  = "T+He3 suppressed D-D fusion: +15MW [130MW]"},
            {type = "unlock-recipe", recipe = "rf-fusion-d-d-0-7"}
        }
    },
    {
        type = "technology",
        name = "rf-fusion-d-d-0-efficiency-3",
        icon = "__RealisticFusionPower__/graphics/technology/fusion-d-d.png",
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
        prerequisites = {"rf-fusion-d-d-0-efficiency-2", "rf-fusion-d-d-1-efficiency-3"},
        effects = {
            {type = "nothing", effect_description  = "T+He3 suppressed D-D fusion: +10MW [140MW]"},
            {type = "unlock-recipe", recipe = "rf-fusion-d-d-0-6"}
        }
    },
    {
        type = "technology",
        name = "rf-fusion-d-d-0-efficiency-4",
        icon = "__RealisticFusionPower__/graphics/technology/fusion-d-d.png",
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
        upgrade = true,
        prerequisites = {"rf-fusion-d-d-0-efficiency-3", "rf-fusion-d-d-1-efficiency-4"},
        effects = {
            {type = "nothing", effect_description  = "T+He3 suppressed D-D fusion: +10MW [150MW]"},
            {type = "unlock-recipe", recipe = "rf-fusion-d-d-0-5"}
        }
    },
    {
        type = "technology",
        name = "rf-fusion-d-d-0-efficiency-5",
        icon = "__RealisticFusionPower__/graphics/technology/fusion-d-d.png",
        icon_size = 128,
        unit = {
            count = rfcore.sm * 24000,
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
        prerequisites = {"rf-fusion-d-d-0-efficiency-4", "rf-fusion-d-d-1-efficiency-5"},
        effects = {
            {type = "nothing", effect_description  = "T+He3 suppressed D-D fusion: +10MW [160MW]"},
            {type = "unlock-recipe", recipe = "rf-fusion-d-d-0-4"}
        }
    },
    {
        type = "technology",
        name = "rf-fusion-d-d-0-efficiency-6",
        icon = "__RealisticFusionPower__/graphics/technology/fusion-d-d.png",
        icon_size = 128,
        unit = {
            count = rfcore.sm * 30000,
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
        prerequisites = {"rf-fusion-d-d-0-efficiency-5", "rf-fusion-d-d-1-efficiency-6"},
        effects = {
            {type = "nothing", effect_description  = "T+He3 suppressed D-D fusion: +10MW [170MW]"},
            {type = "unlock-recipe", recipe = "rf-fusion-d-d-0-3"}
        }
    },
    {
        type = "technology",
        name = "rf-fusion-d-d-0-efficiency-7",
        icon = "__RealisticFusionPower__/graphics/technology/fusion-d-d.png",
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
        prerequisites = {"rf-fusion-d-d-0-efficiency-6", "rf-fusion-d-d-1-efficiency-7"},
        effects = {
            {type = "nothing", effect_description  = "T+He3 suppressed D-D fusion: +10MW [180MW]"},
            {type = "unlock-recipe", recipe = "rf-fusion-d-d-0-2"}
        }
    },
    {
        type = "technology",
        name = "rf-fusion-d-d-0-efficiency-8",
        icon = "__RealisticFusionPower__/graphics/technology/fusion-d-d.png",
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
        prerequisites = {"rf-fusion-d-d-0-efficiency-7", "rf-fusion-d-d-1-efficiency-8"},
        effects = {
            {type = "nothing", effect_description  = "T+He3 suppressed D-D fusion: +10MW [190MW]"},
            {type = "unlock-recipe", recipe = "rf-fusion-d-d-0-1"}
        }
    },
    {
        type = "technology",
        name = "rf-fusion-d-d-0-efficiency-9",
        icon = "__RealisticFusionPower__/graphics/technology/fusion-d-d.png",
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
        prerequisites = {"rf-fusion-d-d-0-efficiency-8", "rf-fusion-d-d-1-efficiency-9"},
        effects = {
            {type = "nothing", effect_description  = "T+He3 suppressed D-D fusion: +10MW [200MW]"},
            {type = "unlock-recipe", recipe = "rf-fusion-d-d-0-0"}
        }
    },
-- #endregion --

-- #region He3-He3 --
    {
        type = "technology",
        name = "rf-fusion-he3-he3-efficiency-1",
        icon = "__RealisticFusionPower__/graphics/technology/fusion-he3-he3.png",
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
        prerequisites = {"rf-fusion-he3-he3"},
        effects = {
            {type = "nothing", effect_description  = "He3-He3 fusion: +1GW [8GW]"},
            {type = "unlock-recipe", recipe = "rf-fusion-he3-he3-8"}
        }
    },
    {
        type = "technology",
        name = "rf-fusion-he3-he3-efficiency-2",
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
        upgrade = true,
        prerequisites = {"rf-fusion-he3-he3-efficiency-1"},
        effects = {
            {type = "nothing", effect_description  = "He3-He3 fusion: +1GW [9GW]"},
            {type = "unlock-recipe", recipe = "rf-fusion-he3-he3-7"}
        }
    },
    {
        type = "technology",
        name = "rf-fusion-he3-he3-efficiency-3",
        icon = "__RealisticFusionPower__/graphics/technology/fusion-he3-he3.png",
        icon_size = 128,
        unit = {
            count = rfcore.sm * 22000,
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
        prerequisites = {"rf-fusion-he3-he3-efficiency-2"},
        effects = {
            {type = "nothing", effect_description  = "He3-He3 fusion: +1GW [10GW]"},
            {type = "unlock-recipe", recipe = "rf-fusion-he3-he3-6"}
        }
    },
    {
        type = "technology",
        name = "rf-fusion-he3-he3-efficiency-4",
        icon = "__RealisticFusionPower__/graphics/technology/fusion-he3-he3.png",
        icon_size = 128,
        unit = {
            count = rfcore.sm * 28000,
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
        prerequisites = {"rf-fusion-he3-he3-efficiency-3", "space-science-pack"},
        effects = {
            {type = "nothing", effect_description  = "D-D fusion: +1GW [11GW]"},
            {type = "unlock-recipe", recipe = "rf-fusion-he3-he3-5"}
        }
    },
    {
        type = "technology",
        name = "rf-fusion-he3-he3-efficiency-5",
        icon = "__RealisticFusionPower__/graphics/technology/fusion-he3-he3.png",
        icon_size = 128,
        unit = {
            count = rfcore.sm * 35000,
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
        prerequisites = {"rf-fusion-he3-he3-efficiency-4"},
        effects = {
            {type = "nothing", effect_description  = "D-D fusion: +1GW [12GW]"},
            {type = "unlock-recipe", recipe = "rf-fusion-he3-he3-4"}
        }
    },
    {
        type = "technology",
        name = "rf-fusion-he3-he3-efficiency-6",
        icon = "__RealisticFusionPower__/graphics/technology/fusion-he3-he3.png",
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
        prerequisites = {"rf-fusion-he3-he3-efficiency-5"},
        effects = {
            {type = "nothing", effect_description  = "D-D fusion: +1GW [13GW]"},
            {type = "unlock-recipe", recipe = "rf-fusion-he3-he3-3"}
        }
    },
    {
        type = "technology",
        name = "rf-fusion-he3-he3-efficiency-7",
        icon = "__RealisticFusionPower__/graphics/technology/fusion-he3-he3.png",
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
        prerequisites = {"rf-fusion-he3-he3-efficiency-6"},
        effects = {
            {type = "nothing", effect_description  = "D-D fusion: +1GW [14GW]"},
            {type = "unlock-recipe", recipe = "rf-fusion-he3-he3-2"}
        }
    },
    {
        type = "technology",
        name = "rf-fusion-he3-he3-efficiency-8",
        icon = "__RealisticFusionPower__/graphics/technology/fusion-he3-he3.png",
        icon_size = 128,
        unit = {
            count = rfcore.sm * 70000,
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
        prerequisites = {"rf-fusion-he3-he3-efficiency-7"},
        effects = {
            {type = "nothing", effect_description  = "D-D fusion: +500MW [14.5GW]"},
            {type = "unlock-recipe", recipe = "rf-fusion-he3-he3-1"}
        }
    },
    {
        type = "technology",
        name = "rf-fusion-he3-he3-efficiency-9",
        icon = "__RealisticFusionPower__/graphics/technology/fusion-he3-he3.png",
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
        prerequisites = {"rf-fusion-he3-he3-efficiency-8"},
        effects = {
            {type = "nothing", effect_description  = "D-D fusion: +500MW [15GW]"},
            {type = "unlock-recipe", recipe = "rf-fusion-he3-he3-0"}
        }
    },
-- #endregion --

-- #region D-He3 --
    {
        type = "technology",
        name = "rf-fusion-d-he3-efficiency-1",
        icon = "__RealisticFusionPower__/graphics/technology/fusion-d-he3.png",
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
        prerequisites = {"rf-fusion-d-he3", "rf-fusion-he3-he3-efficiency-1"},
        effects = {
            {
                type = "nothing",
                effect_description = "D-He3 fusion: +100MW [10.1GW]"},
            {type = "unlock-recipe", recipe = "rf-fusion-d-he3-8"}
        }
    },
    {
        type = "technology",
        name = "rf-fusion-d-he3-efficiency-2",
        icon = "__RealisticFusionPower__/graphics/technology/fusion-d-he3.png",
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
        prerequisites = {"rf-fusion-d-he3-efficiency-1", "rf-fusion-he3-he3-efficiency-2"},
        effects = {
            {
                type = "nothing",
                effect_description = "D-He3 fusion: +150MW [10.25GW]"},
            {type = "unlock-recipe", recipe = "rf-fusion-d-he3-7"}
        }
    },
    {
        type = "technology",
        name = "rf-fusion-d-he3-efficiency-3",
        icon = "__RealisticFusionPower__/graphics/technology/fusion-d-he3.png",
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
        prerequisites = {"rf-fusion-d-he3-efficiency-2", "rf-fusion-he3-he3-efficiency-3"},
        effects = {
            {
                type = "nothing",
                effect_description = "D-He3 fusion: +250MW [10.5GW]"},
            {type = "unlock-recipe", recipe = "rf-fusion-d-he3-6"}
        }
    },
    {
        type = "technology",
        name = "rf-fusion-d-he3-efficiency-4",
        icon = "__RealisticFusionPower__/graphics/technology/fusion-d-he3.png",
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
        prerequisites = {"rf-fusion-d-he3-efficiency-3", "rf-fusion-he3-he3-efficiency-4"},
        effects = {
            {
                type = "nothing",
                effect_description = "D-He3 fusion: +300MW [10.8GW]"},
            {type = "unlock-recipe", recipe = "rf-fusion-d-he3-5"}
        }
    },
    {
        type = "technology",
        name = "rf-fusion-d-he3-efficiency-5",
        icon = "__RealisticFusionPower__/graphics/technology/fusion-d-he3.png",
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
                {"space-science-pack", 1}
            }
        },
        upgrade = true,
        prerequisites = {"rf-fusion-d-he3-efficiency-4", "rf-fusion-he3-he3-efficiency-5"},
        effects = {
            {
                type = "nothing",
                effect_description = "D-He3 fusion: +1GW [11.8GW]"},
            {type = "unlock-recipe", recipe = "rf-fusion-d-he3-4"}
        }
    },
    {
        type = "technology",
        name = "rf-fusion-d-he3-efficiency-6",
        icon = "__RealisticFusionPower__/graphics/technology/fusion-d-he3.png",
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
                {"space-science-pack", 1}
            }
        },
        upgrade = true,
        prerequisites = {"rf-fusion-d-he3-efficiency-5", "rf-fusion-he3-he3-efficiency-6"},
        effects = {
            {
                type = "nothing",
                effect_description = "D-He3 fusion: +1.2GW [13GW]"},
            {type = "unlock-recipe", recipe = "rf-fusion-d-he3-3"}
        }
    },
    {
        type = "technology",
        name = "rf-fusion-d-he3-efficiency-7",
        icon = "__RealisticFusionPower__/graphics/technology/fusion-d-he3.png",
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
        prerequisites = {"rf-fusion-d-he3-efficiency-6", "rf-fusion-he3-he3-efficiency-7"},
        effects = {
            {
                type = "nothing",
                effect_description = "D-He3 fusion: +1.5GW [14.5GW]"},
            {type = "unlock-recipe", recipe = "rf-fusion-d-he3-2"}
        }
    },
    {
        type = "technology",
        name = "rf-fusion-d-he3-efficiency-8",
        icon = "__RealisticFusionPower__/graphics/technology/fusion-d-he3.png",
        icon_size = 128,
        unit = {
            count = rfcore.sm * 130000,
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
        prerequisites = {"rf-fusion-d-he3-efficiency-7", "rf-fusion-he3-he3-efficiency-8"},
        effects = {
            {
                type = "nothing",
                effect_description = "D-He3 fusion: +2.5GW [17GW]"},
            {type = "unlock-recipe", recipe = "rf-fusion-d-he3-1"}
        }
    },
    {
        type = "technology",
        name = "rf-fusion-d-he3-efficiency-9",
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
        upgrade = true,
        prerequisites = {"rf-fusion-d-he3-efficiency-8", "rf-fusion-he3-he3-efficiency-9"},
        effects = {
            {
                type = "nothing",
                effect_description = "D-He3 fusion: +3GW [20GW]"},
            {type = "unlock-recipe", recipe = "rf-fusion-d-he3-0"}
        }
    },
-- #endregion --
}

-- #endregion --