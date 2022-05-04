data:extend{
    {
        type = "recipe",
        name = "rf-m-heater",
        icon = "__RealisticFusionCore__/graphics/icons/heater.png",
        icon_size = 64,
        energy_required = 20,
        ingredients = {
			{"steel-plate", 500},
			{"iron-plate", 350},
			{"copper-plate", 750},
            {"advanced-circuit", 50},
			{"concrete", 200},
			{"plastic-bar", 500}
        },
        result = "rf-m-heater",
        enabled = true--[[CHANGELATER]]
    },
    {
        type = "recipe",
        name = "rf-light-isotope-processor",
        icon = "__RealisticFusionCore__/graphics/icons/light-isotope-processor.png",
        icon_size = 64,
        energy_required = 5,
        ingredients = {
			{"steel-plate", 120},
			{"iron-plate", 100},
			{"copper-plate", 200},
			{"advanced-circuit", 20},
			{"concrete", 200},
			{"plastic-bar", 250}
        },
        result = "rf-light-isotope-processor",
        enabled = true--[[CHANGELATER]]
    },
	{
		type = "recipe",
		name = "rf-m-magnetic-pipe",
		icon = "__RealisticFusionCore__/graphics/icons/magnetic-pipe.png",
        icon_size = 64, icon_mipmaps = 4,
		energy_required = 0.5,
		ingredients = {
			{"pipe", 1},
			{"steel-plate", 2},
			{"concrete", 5},
            {"plastic-bar", 10},
            {"copper-cable", 10}
		},
		result = "rf-m-magnetic-pipe",
        enabled = true--[[CHANGELATER]]
	},
	{
		type = "recipe",
		name = "rf-m-magnetic-pipe-to-ground",
		icon = "__RealisticFusionCore__/graphics/icons/magnetic-pipe-to-ground.png",
        icon_size = 64, icon_mipmaps = 4,
		energy_required = 0.5,
		ingredients =
		{
			{"pipe-to-ground", 1},
			{"steel-plate", 6},
			{"concrete", 15},
			{"plastic-bar", 30},
            {"copper-cable", 80}
		},
		result_count = 2,
		result = "rf-m-magnetic-pipe-to-ground",
        enabled = true--[[CHANGELATER]]
	},
	{
		type = "recipe",
		name = "rf-m-magnetic-pump",
		energy_required = 2,
		icon = "__RealisticFusionCore__/graphics/icons/magnetic-pump.png",
        icon_size = 64, icon_mipmaps = 4,
		ingredients =
		{
            {"pump", 1},
            {"electric-engine-unit", 1},
			{"steel-plate", 15},
			{"concrete", 20},
			{"plastic-bar", 50},
            {"copper-cable", 30}
		},
		result = "rf-m-magnetic-pump",
        enabled = true--[[CHANGELATER]]
    },
    {
        type = "recipe",
        name = "rf-electrolyser",
        icon = "__RealisticFusionCore__/graphics/icons/electrolyser.png",
        icon_size = 32,
        localised_description = {"rf.electrolyser", "rf-heavy-water", "rf-deuterium"},
        ingredients = {
            {"iron-plate", 30},
            {"copper-plate", 50},
            {"advanced-circuit", 10},
            {"concrete", 70},
            {"plastic-bar", 50}
        },
        result = "rf-electrolyser",
        enabled = true--[[CHANGELATER]]
    },
    {
        type = "recipe",
        name = "angels-electric-boiler",
        energy_required = 5,
        ingredients = {
            {type = "item", name = "steel-plate", amount = 3},
            {type = "item", name = "electronic-circuit", amount = 2},
            {type = "item", name = "pipe", amount = 15},
            {type = "item", name = "stone-brick", amount = 5}
        },
        result = "angels-electric-boiler",
        enabled = true--[[CHANGELATER]]
    },
    {
        type = "recipe",
        name = "rf-discharge-pump",
        ingredients = {
            {"electronic-circuit", 2},
            {"pipe", 1},
            {"iron-gear-wheel", 1}
        },
        result = "rf-discharge-pump",
        enabled = true--[[CHANGELATER]]
    },
    {
        type = "recipe",
        name = "rf-thermal-evaporation-plant",
        icon = "__RealisticFusionCore__/graphics/icons/thermal-evaporation-plant.png",
        icon_size = 64,
        energy_required = 10,
        ingredients = {
			{"steel-plate", 30},
			{"iron-plate", 150},
			{"copper-plate", 75},
            {"advanced-circuit", 20},
			{"concrete", 80},
			{"plastic-bar", 50}
        },
        result = "rf-thermal-evaporation-plant",
        enabled = true--[[CHANGELATER]]
    },
}