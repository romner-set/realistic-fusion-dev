-- P. Acceleration --
data:extend{
    {
        type = "technology",
        name = "rf-particle-acceleration-efficiency-1",
        icon = "__RealisticFusionAntimatter__/graphics/particle-accelerator/accelerator-icon.png",
        icon_size = 64,
        unit = {
            count = rfcore.sm * 300000,
            time = 15,
            ingredients = {
                {"automation-science-pack", 1},
                {"logistic-science-pack", 1},
                {"chemical-science-pack", 1},
                {"production-science-pack", 1},
                {"utility-science-pack", 1},
                {"space-science-pack", 1},
                {"rf-antimatter-science-pack", 1},
            }
        },
        prerequisites = {"rf-particle-acceleration", "rf-antimatter-theory"},
        effects = {
            {type = "unlock-recipe", recipe = "rf-antiproton-production-3"},
            {type = "unlock-recipe", recipe = "rf-positron-production-3"}
        }
    },
    {
        type = "technology",
        name = "rf-particle-acceleration-efficiency-2",
        icon = "__RealisticFusionAntimatter__/graphics/particle-accelerator/accelerator-icon.png",
        icon_size = 64,
        unit = {
            count = rfcore.sm * 350000,
            time = 15,
            ingredients = {
                {"automation-science-pack", 1},
                {"logistic-science-pack", 1},
                {"chemical-science-pack", 1},
                {"production-science-pack", 1},
                {"utility-science-pack", 1},
                {"space-science-pack", 1},
                {"rf-antimatter-science-pack", 1},
            }
        },
        prerequisites = {"rf-particle-acceleration-efficiency-1"},
        effects = {
            {type = "unlock-recipe", recipe = "rf-antiproton-production-2"},
            {type = "unlock-recipe", recipe = "rf-positron-production-2"}
        }
    },
    {
        type = "technology",
        name = "rf-particle-acceleration-efficiency-3",
        icon = "__RealisticFusionAntimatter__/graphics/particle-accelerator/accelerator-icon.png",
        icon_size = 64,
        unit = {
            count = rfcore.sm * 400000,
            time = 15,
            ingredients = {
                {"automation-science-pack", 1},
                {"logistic-science-pack", 1},
                {"chemical-science-pack", 1},
                {"production-science-pack", 1},
                {"utility-science-pack", 1},
                {"space-science-pack", 1},
                {"rf-antimatter-science-pack", 1},
            }
        },
        prerequisites = {"rf-particle-acceleration-efficiency-2"},
        effects = {
            {type = "unlock-recipe", recipe = "rf-antiproton-production-1"},
            {type = "unlock-recipe", recipe = "rf-positron-production-1"}
        }
    }
}

-- P. Deceleration
data:extend{
    {
        type = "technology",
        name = "rf-particle-deceleration-efficiency-1",
        icon = "__RealisticFusionAntimatter__/graphics/particle-accelerator/decelerator-icon.png",
        icon_size = 128,
        unit = {
            count = rfcore.sm * 400000,
            time = 15,
            ingredients = {
                {"automation-science-pack", 1},
                {"logistic-science-pack", 1},
                {"chemical-science-pack", 1},
                {"production-science-pack", 1},
                {"utility-science-pack", 1},
                {"space-science-pack", 1},
                {"rf-antimatter-science-pack", 1},
            }
        },
        prerequisites = {"rf-particle-deceleration"},
        effects = {
            {type = "unlock-recipe", recipe = "rf-antiproton-deceleration-3"},
            {type = "unlock-recipe", recipe = "rf-positron-deceleration-3"}
        }
    },
    {
        type = "technology",
        name = "rf-particle-deceleration-efficiency-2",
        icon = "__RealisticFusionAntimatter__/graphics/particle-accelerator/decelerator-icon.png",
        icon_size = 128,
        unit = {
            count = rfcore.sm * 450000,
            time = 15,
            ingredients = {
                {"automation-science-pack", 1},
                {"logistic-science-pack", 1},
                {"chemical-science-pack", 1},
                {"production-science-pack", 1},
                {"utility-science-pack", 1},
                {"space-science-pack", 1},
                {"rf-antimatter-science-pack", 1},
            }
        },
        prerequisites = {"rf-particle-deceleration-efficiency-1"},
        effects = {
            {type = "unlock-recipe", recipe = "rf-antiproton-deceleration-2"},
            {type = "unlock-recipe", recipe = "rf-positron-deceleration-2"}
        }
    },
    {
        type = "technology",
        name = "rf-particle-deceleration-efficiency-3",
        icon = "__RealisticFusionAntimatter__/graphics/particle-accelerator/decelerator-icon.png",
        icon_size = 128,
        unit = {
            count = rfcore.sm * 500000,
            time = 15,
            ingredients = {
                {"automation-science-pack", 1},
                {"logistic-science-pack", 1},
                {"chemical-science-pack", 1},
                {"production-science-pack", 1},
                {"utility-science-pack", 1},
                {"space-science-pack", 1},
                {"rf-antimatter-science-pack", 1},
            }
        },
        prerequisites = {"rf-particle-deceleration-efficiency-2"},
        effects = {
            {type = "unlock-recipe", recipe = "rf-antiproton-deceleration-1"},
            {type = "unlock-recipe", recipe = "rf-positron-deceleration-1"}
        }
    }
}