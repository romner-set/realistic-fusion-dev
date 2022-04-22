data:extend{
    {
        type = "recipe",
        name = "rf-matter-antimatter-fuel-cell-empty",
        energy_required = 90,
        category = "rf-antimatter-processing",
        ingredients =
        {
            {"low-density-structure", 25},
            {"copper-cable", 50},
            {"steel-plate", 20},
            {"battery", 10},
            {"processing-unit", 20},
        },
        result = "rf-matter-antimatter-fuel-cell-empty",
        result_count = 1,
        enabled = true--[[CHANGELATER]]
    },
    {
        type = "recipe",
        name = "rf-matter-antimatter-fuel-cell",
        energy_required = 30,
        category = "rf-antimatter-processing",
        ingredients =
        {
            {"rf-matter-antimatter-fuel-cell-empty", 1},
            {type="fluid", name="rf-hydrogen", amount=20},
            {type="fluid", name="rf-antihydrogen", amount=20}
        },
        result = "rf-matter-antimatter-fuel-cell",
        result_count = 1,
        enabled = true--[[CHANGELATER]]
    },
    {
        type = "recipe",
        name = "rf-antimatter-processor",
        energy_required = 30,
        ingredients =
        {
            {"low-density-structure", 250},
            {"copper-cable", 500},
            {"steel-plate", 2000},
            {"iron-stick", 1000},
            {"processing-unit", 100},
            {"refined-concrete", 5000}
        },
        result = "rf-antimatter-processor",
        result_count = 1,
        enabled = true--[[CHANGELATER]]
    },
    {
        type = "recipe",
        name = "rf-antimatter-reactor",
        energy_required = 60,
        ingredients =
        {
            {"low-density-structure", 4000},
            {"copper-cable", 3000},
            {"steel-plate", 5000},
            {"iron-stick", 2500},
            {"processing-unit", 4500},
            {"refined-concrete", 10000}
        },
        result = "rf-antimatter-reactor",
        result_count = 1,
        enabled = true--[[CHANGELATER]]
    },
    {
        type = "recipe",
        name = "rf-particle-accelerator",
        energy_required = 45,
        ingredients =
        {
            {"low-density-structure", 2000},
            {"copper-cable", 8000},
            {"steel-plate", 3000},
            {"iron-stick", 1000},
            {"processing-unit", 1250},
            {"refined-concrete", 10000}
        },
        result = "rf-particle-accelerator",
        result_count = 1,
        enabled = true--[[CHANGELATER]]
    },
    {
        type = "recipe",
        name = "rf-particle-decelerator",
        energy_required = 35,
        ingredients =
        {
            {"low-density-structure", 2000},
            {"copper-cable", 2000},
            {"steel-plate", 1000},
            {"iron-stick", 500},
            {"processing-unit", 1250},
            {"refined-concrete", 5000}
        },
        result = "rf-particle-decelerator",
        result_count = 1,
        enabled = true--[[CHANGELATER]]
    },
    {
        type = "recipe",
        name = "rf-antimatter-science-pack",
        category = "rf-particle-acceleration",
        energy_required = 1,
        ingredients = {{type = "fluid", name = "rf-protons", amount = 100}, {type = "fluid", name = "rf-electrons", amount = 100}},
        results = {{"rf-antimatter-science-pack", 100}},
        enabled = true--[[CHANGELATER]]
    },
}