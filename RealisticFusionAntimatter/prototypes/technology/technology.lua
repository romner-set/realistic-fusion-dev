data:extend{
    {
        type = "technology",
        name = "rf-particle-acceleration",
        icon = "__RealisticFusionAntimatter__/graphics/particle-accelerator/accelerator-icon.png",
        icon_size = 64,
        unit = {
            count = rfcore.sm * 250000,
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
        prerequisites = {"rf-tritium-decay", "rf-d-he3-heating-efficiency-4", "rf-d-he3-fusion-efficiency-9"},
        effects = {
            {type = "unlock-recipe", recipe = "rf-hydrogen-ionization"},
            {type = "unlock-recipe", recipe = "rf-particle-accelerator"},
            {type = "unlock-recipe", recipe = "rf-antimatter-science-pack"},
        },
        localised_description = {"rf.particle-acceleration", "rf-protons", "rf-electrons"}
    },
    {
        type = "technology",
        name = "rf-antimatter-theory",
        icon = "__RealisticFusionAntimatter__/graphics/technology/antimatter-theory.png",
        icon_size = 64, icon_mipmaps = 5,
        unit = {
            count = rfcore.sm * 200000,
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
        prerequisites = {"rf-particle-acceleration"},
        effects = {
            {type = "unlock-recipe", recipe = "rf-antiproton-production-4"},
            {type = "unlock-recipe", recipe = "rf-positron-production-4"}
        },
        localised_description = {"rf.antimatter-theory", "rf-antiprotons", "rf-positrons", "rf-protons", "rf-electrons"}
    },
    {
        type = "technology",
        name = "rf-antimatter-processing",
        icon = "__RealisticFusionAntimatter__/graphics/icons/antimatter-processor.png",
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
        prerequisites = {"rf-antimatter-theory", "rf-particle-deceleration"},
        effects = {
            {type = "unlock-recipe", recipe = "rf-antimatter-processor"},
            {type = "unlock-recipe", recipe = "rf-antihydrogen"},
            {type = "unlock-recipe", recipe = "rf-matter-antimatter-fuel-cell-empty"},
            {type = "unlock-recipe", recipe = "rf-matter-antimatter-fuel-cell"},
        }
    },
    {
        type = "technology",
        name = "rf-particle-deceleration",
        icon = "__RealisticFusionAntimatter__/graphics/particle-accelerator/decelerator-icon.png",
        icon_size = 128,
        unit = {
            count = rfcore.sm * 250000,
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
        prerequisites = {"rf-antimatter-theory"},
        effects = {
            {type = "unlock-recipe", recipe = "rf-particle-decelerator"},
            {type = "unlock-recipe", recipe = "rf-antiproton-deceleration-4"},
            {type = "unlock-recipe", recipe = "rf-positron-deceleration-4"}
        },
        localised_description = {"rf.particle-deceleration", "rf-high-energy-antiprotons", "rf-high-energy-positrons"}
    },
    {
        type = "technology",
        name = "rf-antimatter-reactor",
        icon = "__RealisticFusionAntimatter__/graphics/technology/antimatter-reactor.png",
        icon_size = 64, icon_mipmaps = 4,
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
        prerequisites = {"rf-antimatter-processing", "rf-particle-deceleration"},
        effects = {
            {type = "unlock-recipe", recipe = "rf-antimatter-reactor"},
            {type = "unlock-recipe", recipe = "rf-water-electrolysis"}
        }
    }
}