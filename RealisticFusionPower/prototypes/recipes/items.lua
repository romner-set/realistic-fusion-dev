-- #region DATA --
data:extend{
    {
        type = "recipe",
        name = "rf-m-reactor",
        icon = "__RealisticFusionPower__/graphics/icons/reactor.png",
        icon_size = 64,
        energy_required = 15,
        ingredients = {
			{"steel-plate", 2000},
			{"iron-plate", 1000},
			{"copper-plate", 2000},
			{"advanced-circuit", 150},
			{"stone-brick", 5000},
			{"plastic-bar", 1000}
        },
        result = "rf-m-reactor",
        enabled = true--[[CHANGELATER]]
    },
    {
        type = "recipe",
        name = "rf-m-reactor-aneutronic",
        icon = "__RealisticFusionPower__/graphics/icons/reactor-aneutronic.png",
        icon_size = 64,
        energy_required = 30,
        ingredients = {
			{"steel-plate", 5000},
			{"iron-stick", 2000},
			{"copper-cable", 2000},
			{"processing-unit", 500},
			{"concrete", 5000},
			{"plastic-bar", 1000},
        },
        result = "rf-m-reactor-aneutronic",
        enabled = true--[[CHANGELATER]]
    },
    {
        type = "recipe",
        name = "rf-heat-exchanger",
        icon = "__RealisticFusionPower__/graphics/icons/heat-exchanger.png",
        icon_size = 64,
        energy_required = 10,
        ingredients = {
			{"steel-plate", 500},
			{"iron-plate", 550},
			{"copper-plate", 200},
			{"advanced-circuit", 5},
			{"stone-brick", 1000},
			{"plastic-bar", 600}
        },
        result = "rf-heat-exchanger",
        enabled = true--[[CHANGELATER]]
    },
    {
        type = "recipe",
        name = "rf-direct-energy-converter",
        icon = "__RealisticFusionPower__/graphics/icons/dec.png",
        icon_size = 64,
        energy_required = 20,
        ingredients = {
			{"steel-plate", 500},
			{"iron-stick", 200},
			{"copper-cable", 750},
			{"processing-unit", 20},
			{"concrete", 800},
			{"plastic-bar", 600}
        },
        result = "rf-direct-energy-converter",
        enabled = true--[[CHANGELATER]]
    },

    {
        type = "recipe",
        name = "rf-icf-laser",
        icon = "__RealisticFusionPower__/graphics/icons/laser.png",
        icon_size = 64,
        energy_required = 15,
        ingredients = { --TODO
			{"steel-plate", 500},
			{"iron-plate", 300},
			{"copper-plate", 500},
			{"advanced-circuit", 30},
			{"stone-brick", 1500},
			{"plastic-bar", 400}
        },
        result = "rf-icf-laser",
        enabled = true--[[CHANGELATER]]
    },
    {
        type = "recipe",
        name = "rf-m-reactor-icf",
        icon = "__RealisticFusionPower__/graphics/icons/reactor-icf.png",
        icon_size = 64,
        energy_required = 15,
        ingredients = { --TODO
			{"steel-plate", 2000},
			{"iron-plate", 1000},
			{"copper-plate", 2000},
			{"advanced-circuit", 150},
			{"stone-brick", 5000},
			{"plastic-bar", 1000}
        },
        result = "rf-m-reactor-icf",
        enabled = true--[[CHANGELATER]]
    },
    {
        type = "recipe",
        name = "rf-m-reactor-icf-aneutronic",
        icon = "__RealisticFusionPower__/graphics/icons/reactor-icf-aneutronic.png",
        icon_size = 64,
        energy_required = 30,
        ingredients = { --TODO
			{"steel-plate", 5000},
			{"iron-stick", 2000},
			{"copper-cable", 2000},
			{"processing-unit", 500},
			{"concrete", 5000},
			{"plastic-bar", 1000},
        },
        result = "rf-m-reactor-icf-aneutronic",
        enabled = true--[[CHANGELATER]]
    },
}
-- #endregion --

-- #region HIGH-CAPACITY EXCHANGER & TURBINE --
if settings.startup["rf-hc-stuff"].value then
    data:extend{
        {
            type = "recipe",
            name = "rf-hc-exchanger",
            energy_required = 10,
            ingredients = {{"steel-plate", 100}, {"copper-plate", 1000}, {"iron-stick", 100}, {"pipe", 100}},
            result = "rf-hc-exchanger",
            enabled = true--[[CHANGELATER]]
        },
        {
            type = "recipe",
            name = "rf-hc-turbine",
            energy_required = 10,
            ingredients = {{"iron-gear-wheel", 500}, {"copper-plate", 500}, {"iron-stick", 50}, {"pipe", 200}},
            result = "rf-hc-turbine",
            enabled = true--[[CHANGELATER]]
        }
    }
end
-- #endregion --