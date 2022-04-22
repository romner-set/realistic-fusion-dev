data:extend{
    --- Stuff ---
    {
        type = "fluid",
        name = "rf-deuterium",
        icon = "__RealisticFusionCore__/graphics/icons/deuterium.png",
        icon_size = 64, icon_mipmaps = 4,
        default_temperature = 15,
        max_temperature = 1000,
        base_color = {0.25,0.5,1,0.5},
        flow_color = {0.25,0.5,1,0.5},
        gas_temperature = -250,
    },
    {
        type = "fluid",
        name = "rf-tritium",
        icon = "__RealisticFusionCore__/graphics/icons/tritium.png",
        icon_size = 64, icon_mipmaps = 4,
        default_temperature = 15,
        max_temperature = 1000,
        base_color = {0,1,0.25,0.5},
        flow_color = {0,1,0.25,0.5},
        gas_temperature = -248,
    },
    {
        type = "fluid",
        name = "rf-helium-3",
        icon = "__RealisticFusionCore__/graphics/icons/helium-3.png",
        icon_size = 64, icon_mipmaps = 4,
        default_temperature = 15,
        max_temperature = 1000,
        base_color = {1,0.5,0,0.5},
        flow_color = {1,0.5,0,0.5},
        gas_temperature = -270,
    },

    --- Lithium stuff ---
    {
        type = "fluid",
        name = "rf-brine",
        icon = "__RealisticFusionCore__/graphics/icons/brine.png",
        icon_size = 64, icon_mipmaps = 4,
        default_temperature = 15,
        max_temperature = 1000,
        base_color = {185,162,129,128},
        flow_color = {185,162,129,128},
    },
    {
        type = "fluid",
        name = "rf-lithium-rich-brine",
        icon = "__RealisticFusionCore__/graphics/icons/lithium-rich-brine.png",
        icon_size = 64, icon_mipmaps = 4,
        default_temperature = 15,
        max_temperature = 1000,
        base_color = {181,169,153,128},
        flow_color = {181,169,153,128},
    },
    {
        type = "fluid",
        name = "rf-molten-lithium-electrolyte",
        icon = "__RealisticFusionCore__/graphics/icons/molten-lithium-electrolyte.png",
        icon_size = 64, icon_mipmaps = 4,
        default_temperature = 15,
        max_temperature = 1000,
        base_color = {40,180,100,128},
        flow_color = {40,180,100,128},
    },

    --- Mixes ---
    {
        type = "fluid",
        name = "rf-d-t-mix",
        icon = "__RealisticFusionCore__/graphics/icons/d-t-mix.png",
        icon_size = 64, icon_mipmaps = 4,
        default_temperature = 15,
        max_temperature = 1000,
        base_color = {0,0.8,1,0.5},
        flow_color = {0,0.8,1,0.5},
        auto_barrel = false,
        gas_temperature = -248
    },
    {
        type = "fluid",
        name = "rf-d-he3-mix",
        icon = "__RealisticFusionCore__/graphics/icons/d-he3-mix.png",
        icon_size = 64, icon_mipmaps = 4,
        default_temperature = 15,
        max_temperature = 1000,
        base_color = {0.5,0,1,0.5},
        flow_color = {0.5,0,1,0.5},
        gas_temperature = -270,
        auto_barrel = false,
    },

    --- Plasma ---
    {
        type = "fluid",
        name = "rf-deuterium-plasma",
        icon = "__RealisticFusionCore__/graphics/icons/deuterium-plasma.png",
        icon_size = 64, icon_mipmaps = 4,
        default_temperature = 1e8,
        max_temperature = 1.417e32, --1.417e32 = Planck's temperature, we don't want to break the laws of physics now do we
        base_color = {0.25,0.5,1,0.25},
        flow_color = {0.25,0.5,1,0.25},
        gas_temperature = -260,
        auto_barrel = false,
    },
    {
        type = "fluid",
        name = "rf-tritium-plasma",
        icon = "__RealisticFusionCore__/graphics/icons/tritium-plasma.png",
        icon_size = 64, icon_mipmaps = 4,
        default_temperature = 1e8, --D-D fusion result
        max_temperature = 1.417e32,
        base_color = {0,0.8,1,0.25},
        flow_color = {0,0.8,1,0.25},
        gas_temperature = -256,
        auto_barrel = false,
    },
    {
        type = "fluid",
        name = "rf-helium-3-plasma",
        icon = "__RealisticFusionCore__/graphics/icons/helium-3-plasma.png",
        icon_size = 64, icon_mipmaps = 4,
        default_temperature = 2e9,
        max_temperature = 1.417e32,
        base_color = {1,0.5,0,0.25},
        flow_color = {1,0.5,0,0.25},
        gas_temperature = -270,
        auto_barrel = false,
    },
    {
        type = "fluid",
        name = "rf-d-t-plasma",
        icon = "__RealisticFusionCore__/graphics/icons/d-t-plasma.png",
        icon_size = 64, icon_mipmaps = 4,
        default_temperature = 5e7,
        max_temperature = 1.417e32,
        base_color = {0,0.8,1,0.25},
        flow_color = {0,0.8,1,0.25},
        gas_temperature = -258,
        auto_barrel = false,
    },
    {
        type = "fluid",
        name = "rf-d-he3-plasma",
        icon = "__RealisticFusionCore__/graphics/icons/d-he3-plasma.png",
        icon_size = 64, icon_mipmaps = 4,
        default_temperature = 5e8,
        max_temperature = 1.417e32,
        base_color = {0.5,0,1,0.25},
        flow_color = {0.5,0,1,0.25},
        gas_temperature = -270,
        auto_barrel = false,
    },


    -- Deuterium extraction stuff --
    {
        type = "fluid",
        name = "rf-hydrogen-sulfide",
        icon = "__RealisticFusionCore__/graphics/icons/hydrogen-sulfide.png",
        icon_size = 64, icon_mipmaps = 4,
        default_temperature = 15,
        max_temperature = 100,
        base_color = {1,1,0},
        flow_color = {1,1,0},
        gas_temperature = -60
    },
    {
        type = "fluid",
        name = "rf-depleted-water",
        icon = "__RealisticFusionCore__/graphics/icons/depleted-water.png",
        icon_size = 64, icon_mipmaps = 4,
        default_temperature = 15,
        max_temperature = 100,
        base_color = {0,0.8,0.8},
        flow_color = {0,0.8,0.8},
    },
    {
        type = "fluid",
        name = "rf-heavy-water", --Pure HW
        icon = "__RealisticFusionCore__/graphics/icons/heavy-water.png",
        icon_size = 64, icon_mipmaps = 4,
        default_temperature = 15,
        max_temperature = 101,
        base_color = {0,0,0.8},
        flow_color = {0,0,0.8},
    }
}

for i=0, 2 do
    rfcore.hw_percentage = {5,10,20}
    data:extend{
        {
            type = "fluid",
            name = "rf-heavy-water-"..i, --Unpure HW
            icons = {
                {icon = "__RealisticFusionCore__/graphics/icons/heavy-water.png", icon_size = 64, icon_mipmaps = 4},
                {icon = "__RealisticFusionCore__/graphics/icons/angels-numerals/num-".. i+1 .."-outline.png", icon_size = 64, icon_mipmaps = 2,},
                {icon = "__RealisticFusionCore__/graphics/icons/angels-numerals/num-".. i+1 ..".png", icon_size = 64, icon_mipmaps = 2,},
            },
            localised_name = {"rf.heavy-water", rfcore.hw_percentage[i+1]},
            default_temperature = 15,
            max_temperature = 101,
            base_color = {0,0,0.8},
            flow_color = {0,0,0.8},
        }
    }
end