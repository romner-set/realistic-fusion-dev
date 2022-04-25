-- #region DATASETS --
rfcore.ddhpower = {400, 375, 325, 275, 200}
rfcore.dthpower = {200, 150, 125, 110, 100}
rfcore.he3he3hpower = {7, 6.5, 6, 5.5, 5}
rfcore.dhe3hpower = {5, 4, 3, 2, 1.5}
-- #endregion --

-- #region DATA --

-- #region HEATING --
local stuff = {}
for i = 1, 5 do
    table.insert(stuff, {
        type = "recipe",
        name = "rf-d-d-heating-" .. i,
        category = "rf-heating",
        icons = {
            {icon = "__RealisticFusionCore__/graphics/icons/deuterium-plasma-big.png", icon_size = 673,},
            {icon = "__RealisticFusionCore__/graphics/icons/angels-numerals/num-"..i.."-outline.png", icon_size = 64, icon_mipmaps = 2,},
            {icon = "__RealisticFusionCore__/graphics/icons/angels-numerals/num-"..i..".png", icon_size = 64, icon_mipmaps = 2,},
        },
        hide_from_player_crafting = true,
        enabled = true--[[CHANGELATER]],
        energy_required = rfcore.ddhpower[i]/400,
        ingredients = {{type = "fluid", name = "rf-deuterium", amount = 11}},
        results = {{type = "fluid", name = "rf-deuterium-plasma", amount = 11}},
        order = "A[realistic-fusion]-a[d-d]-"..i-1
    })
    table.insert(stuff, {
        type = "recipe",
        name = "rf-d-t-heating-" .. i,
        category = "rf-heating",
        icons = {
            {icon = "__RealisticFusionCore__/graphics/icons/d-t-plasma-big.png", icon_size = 673,},
            {icon = "__RealisticFusionCore__/graphics/icons/angels-numerals/num-"..i.."-outline.png", icon_size = 64, icon_mipmaps = 2,},
            {icon = "__RealisticFusionCore__/graphics/icons/angels-numerals/num-"..i..".png", icon_size = 64, icon_mipmaps = 2,},
        },
        hide_from_player_crafting = true,
        enabled = true--[[CHANGELATER]],
        energy_required = rfcore.dthpower[i]/400,
        ingredients = {{type = "fluid", name = "rf-d-t-mix", amount = 10}},
        results = {{type = "fluid", name = "rf-d-t-plasma", amount = 10}},
        order = "A[realistic-fusion]-b[d-t]-"..i-1
    })
    table.insert(stuff, {
        type = "recipe",
        name = "rf-he3-he3-heating-" .. i,
        category = "rf-heating",
        icons = {
            {icon = "__RealisticFusionCore__/graphics/icons/helium-3-plasma-big.png", icon_size = 673,},
            {icon = "__RealisticFusionCore__/graphics/icons/angels-numerals/num-"..i.."-outline.png", icon_size = 64, icon_mipmaps = 2,},
            {icon = "__RealisticFusionCore__/graphics/icons/angels-numerals/num-"..i..".png", icon_size = 64, icon_mipmaps = 2,},
        },
        hide_from_player_crafting = true,
        enabled = true--[[CHANGELATER]],
        energy_required = rfcore.he3he3hpower[i]/0.4,
        ingredients = {{type = "fluid", name = "rf-helium-3", amount = 10}},
        results = {{type = "fluid", name = "rf-helium-3-plasma", amount = 10}},
        order = "A[realistic-fusion]-a[he3-he3]-"..i-1
    })
    table.insert(stuff, {
        type = "recipe",
        name = "rf-d-he3-heating-" .. i,
        category = "rf-heating",
        icons = {
            {icon = "__RealisticFusionCore__/graphics/icons/d-he3-plasma-big.png", icon_size = 673,},
            {icon = "__RealisticFusionCore__/graphics/icons/angels-numerals/num-"..i.."-outline.png", icon_size = 64, icon_mipmaps = 2,},
            {icon = "__RealisticFusionCore__/graphics/icons/angels-numerals/num-"..i..".png", icon_size = 64, icon_mipmaps = 2,},
        },
        hide_from_player_crafting = true,
        enabled = true--[[CHANGELATER]],
        energy_required = rfcore.dhe3hpower[i]/0.4,
        ingredients = {{type = "fluid", name = "rf-d-he3-mix", amount = 20}},
        results = {{type = "fluid", name = "rf-d-he3-plasma", amount = 20}},
        order = "A[realistic-fusion]-a[d-he3]-"..i-1
    })
end
data:extend(stuff)
-- #endregion --

data:extend{
    -- #region LIGHT ISOTOPE PROCESSING --
    {
        type = "recipe",
        name = "rf-d-t-mixing",
        category = "rf-light-isotope-processing",
        icon = "__RealisticFusionCore__/graphics/icons/d-t-mix.png",
        icon_size = 64, icon_mipmaps = 4,
        --hide_from_player_crafting = true,
        energy_required = 1,
		ingredients = {{type = "fluid", name = "rf-deuterium", amount = 10}, {type = "fluid", name = "rf-tritium", amount = 10}},
        results = {{type = "fluid", name = "rf-d-t-mix", amount = 20}},
        subgroup = "fluid-recipes",
        order = "z[realistic-fusion]-z[mixes]-a[deuterium-tritium]",
    },
    {
        type = "recipe",
        name = "rf-d-he3-mixing",
        category = "rf-light-isotope-processing",
        icon = "__RealisticFusionCore__/graphics/icons/d-he3-mix.png",
        icon_size = 64, icon_mipmaps = 4,
        --hide_from_player_crafting = true,
		energy_required = 1,
		ingredients = {{type = "fluid", name = "rf-deuterium", amount = 10}, {type = "fluid", name = "rf-helium-3", amount = 10},},
        results = {{type = "fluid", name = "rf-d-he3-mix", amount = 20}},
        subgroup = "fluid-recipes",
        order = "z[realistic-fusion]-z[mixes]-a[deuterium-helium-3]",
    },
    {
        type = "recipe",
        name = "rf-tritium-decay",
        category = "rf-light-isotope-processing",
        icon = "__RealisticFusionCore__/graphics/icons/helium-3.png",
        icon_size = 64, icon_mipmaps = 4,
        --hide_from_player_crafting = true,
        energy_required = 60, --1 min
        ingredients = {{type = "fluid", name = "rf-tritium", amount = 100}},
        results = {{type = "fluid", name = "rf-helium-3", amount = 100}},
        enabled = true--[[CHANGELATER]],
        subgroup = "fluid-recipes",
        order = "z[realistic-fusion]-d[helium-3]-a[tritium-decay]",
    },
    {
      type = "recipe",
      name = "rf-tritium-recovery",
      energy_required = 60,
      enabled = true--[[CHANGELATER]],
      category = "rf-light-isotope-processing",
      ingredients = {{"used-up-uranium-fuel-cell", 5}},
      icon = "__RealisticFusionCore__/graphics/icons/tritium-recovery.png",
      icon_size = 64, icon_mipmaps = 4,
      subgroup = "intermediate-product",
      order = "r[uranium-processing]-b[nuclear-fuel-reprocessing]-z[rf-tritium-recovery]",
      main_product = "",
      results = {{type = "fluid", name = "rf-tritium", amount = 1}},
      allow_decomposition = false
    },
    -- #endregion --

    -- #region BREEDER URANIUM CELLS
    {
      type = "recipe",
      name = "rf-breeder-tritium-recovery",
      energy_required = 60,
      enabled = true--[[CHANGELATER]],
      category = "rf-light-isotope-processing",
      ingredients = {{"rf-used-up-breeder-uranium-fuel-cell", 5}},
      icon = "__RealisticFusionCore__/graphics/icons/breeder-tritium-recovery.png",
      icon_size = 64, icon_mipmaps = 4,
      subgroup = "intermediate-product",
      order = "r[uranium-processing]-b[nuclear-fuel-reprocessing]-z[rf-tritium-recovery]a",
      main_product = "",
      results = {{type = "fluid", name = "rf-tritium", amount = 3}},
      allow_decomposition = false
    },
    {
      type = "recipe",
      name = "rf-breeder-uranium-fuel-cell",
      energy_required = 10,
      enabled = true--[[CHANGELATER]],
      ingredients =
      {
        {"rf-lithium-metal", 10},
        {"uranium-235", 1},
        {"uranium-238", 19}
      },
      result = "rf-breeder-uranium-fuel-cell",
      result_count = 10
    },
    -- #endregion --

    -- #region DEUTERIUM EXTRACTION --
    {
        type = "recipe",
        name = "rf-hydrogen-sulfide",
        category = "chemistry",
        energy_required = 1,
        enabled = true--[[CHANGELATER]],
        ingredients =
        {
            {type="item", name="sulfur", amount=5},
            {type="fluid", name="water", amount=100}
        },
        results=
        {
            {type="fluid", name="rf-hydrogen-sulfide", amount=5}
        },
        crafting_machine_tint =
        {
            primary = {r = 1.000, g = 0.958, b = 0.000, a = 1.000}, -- #fff400ff
            secondary = {r = 1.000, g = 0.852, b = 0.172, a = 1.000}, -- #ffd92bff
            tertiary = {r = 0.876, g = 0.869, b = 0.597, a = 1.000}, -- #dfdd98ff
            quaternary = {r = 0.969, g = 1.000, b = 0.019, a = 1.000}, -- #f7ff04ff
        },
        subgroup = "fluid-recipes",
        order = "z[realistic-fusion]-a[deuterium]-a[hydrogen-sulfide]",
    },
    {
        type = "recipe",
        name = "rf-girdler-sulfide-process-0",
        icons = {
            {icon = "__RealisticFusionCore__/graphics/icons/gs-process.png", icon_size = 64, icon_mipmaps = 4,},
            {icon = "__RealisticFusionCore__/graphics/icons/angels-numerals/num-1-outline.png", icon_size = 64, icon_mipmaps = 2,},
            {icon = "__RealisticFusionCore__/graphics/icons/angels-numerals/num-1.png", icon_size = 64, icon_mipmaps = 2,},
        },
        energy_required = 1,
        --TODO localised_name = {"rf.gs-process-name", hw_percentage[i], hw_percentage[i+1]},
        category = "oil-processing",
        ingredients = {
            {type="fluid", name="rf-hydrogen-sulfide", amount=100, catalyst_amount = 10},
            {type="fluid", name="water", amount=100}
        },
        results = {
            {type="fluid", name="rf-hydrogen-sulfide", amount=100*settings.startup["rf-gs-process-efficiency"].value, catalyst_amount = 100*settings.startup["rf-gs-process-efficiency"].value},
            {type="fluid", name="rf-depleted-water", amount=90},
            {type="fluid", name="rf-heavy-water-0", amount=10}
        },
        main_product = "rf-heavy-water-0",
        enabled = true--[[CHANGELATER]],
        --hide_from_player_crafting = true,
        subgroup = "fluid-recipes",
        order = "z[realistic-fusion]-a[deuterium]-b[girdler-sulfide-process]-0",
    },
    {
        type = "recipe",
        name = "rf-heavy-water-distillation-0",
        icons = {
            {icon = "__RealisticFusionCore__/graphics/icons/heavy-water-distillation.png", icon_size = 64, icon_mipmaps = 4},
            {icon = "__RealisticFusionCore__/graphics/icons/angels-numerals/num-1-outline.png", icon_size = 64, icon_mipmaps = 2,},
            {icon = "__RealisticFusionCore__/graphics/icons/angels-numerals/num-1.png", icon_size = 64, icon_mipmaps = 2,},
        },
        category = "rf-boiling",
        energy_required = 9.5,
        ingredients = {
            {type="fluid", name="water", amount=100}
        },
        results = {
            {type="fluid", name="steam", amount=90, temperature = 100},
            {type="fluid", name="rf-heavy-water-0", amount=10, temperature = 100}
        },
        main_product = "rf-heavy-water-0",
        enabled = true--[[CHANGELATER]],
        --hide_from_player_crafting = true,
        subgroup = "fluid-recipes",
        order = "z[realistic-fusion]-a[deuterium]-c[heavy-water-distillation]-0",
    },
    {
        type = "recipe",
        name = "rf-heavy-water-distillation-3",
        icons = {
            {icon = "__RealisticFusionCore__/graphics/icons/heavy-water-distillation.png", icon_size = 64, icon_mipmaps = 4},
            {icon = "__RealisticFusionCore__/graphics/icons/angels-numerals/num-4-outline.png", icon_size = 64, icon_mipmaps = 2,},
            {icon = "__RealisticFusionCore__/graphics/icons/angels-numerals/num-4.png", icon_size = 64, icon_mipmaps = 2,},
        },
        category = "rf-boiling",
        energy_required = 9,
        ingredients = {
            {type="fluid", name="rf-heavy-water-2", amount=100}
        },
        results = {
            {type="fluid", name="steam", amount=84.5, temperature = 100},
            {type="fluid", name="rf-heavy-water", amount=15.5, temperature = 100}
        },
        main_product = "rf-heavy-water",
        enabled = true--[[CHANGELATER]],
        --hide_from_player_crafting = true,
        subgroup = "fluid-recipes",
        order = "z[realistic-fusion]-a[deuterium]-c[heavy-water-distillation]-3",
    },
    {
        type = "recipe",
        name = "rf-depleted-water-boiling",
        category = "rf-boiling",
        energy_required = 1,
        ingredients = {{type="fluid", name="rf-depleted-water", amount=40}},
        results = {{type="fluid", name="steam", amount=40, temperature = 165}},
        enabled = true--[[CHANGELATER]],
        --hide_from_player_crafting = true,
        subgroup = "fluid-recipes",
        order = "z[realistic-fusion]-a[deuterium]-z[depleted-water-boiling]",
    },
    {
        type = "recipe",
        name = "rf-depleted-water-discharging",
        category = "rf-water-discharging",
        icons = {
            {icon = "__RealisticFusionCore__/graphics/icons/depleted-water.png", icon_size=64, icon_mipmaps=4},
            {icon = "__RealisticFusionCore__/graphics/icons/fluid-discharge-overlay.png", icon_size=64, icon_mipmaps=4},
        },
        energy_required = 1,
        ingredients = {{type="fluid", name="rf-depleted-water", amount=1200}},
        results = {{type="fluid", name="rf-depleted-water", amount=0}},
        --enabled = true--[[CHANGELATER]],
        --hide_from_player_crafting = true,
        subgroup = "fluid-recipes",
        order = "z[realistic-fusion]-a[deuterium]-z[depleted-water-discharging]",
    },
    {
        type = "recipe",
        name = "rf-water-discharging",
        category = "rf-water-discharging",
        icons = {
            {icon = "__base__/graphics/icons/fluid/water.png", icon_size=64, icon_mipmaps=4},
            {icon = "__RealisticFusionCore__/graphics/icons/fluid-discharge-overlay.png", icon_size=64, icon_mipmaps=4},
        },
        energy_required = 1,
        ingredients = {{type="fluid", name="water", amount=1200}},
        results = {{type="fluid", name="water", amount=0}},
        --enabled = true--[[CHANGELATER]],
        --hide_from_player_crafting = true,
        subgroup = "fluid-recipes",
        order = "z[realistic-fusion]-a[deuterium]-z[water-discharging]",
    },
    {
        type = "recipe",
        name = "rf-electrolysis",
        category = "rf-electrolysis",
        icon = "__RealisticFusionCore__/graphics/icons/deuterium.png",
        icon_size = 64, icon_mipmaps = 4,
        --hide_from_player_crafting = true,
        energy_required = 10,
        ingredients = {{type = "fluid", name = "rf-heavy-water", amount = 1}},
        results = {{type = "fluid", name = "rf-deuterium", amount = 4}},
        main_product = "rf-deuterium",
        enabled = true--[[CHANGELATER]],
        subgroup = "fluid-recipes",
        order = "z[realistic-fusion]-a[deuterium]-d[electrolysis]",
    },
    -- #endregion --

    -- #region LITHIUM EXTRACTION --
    {
        type = "recipe",
        name = "rf-thermal-evaporation",
        category = "rf-thermal-evaporation",
        icon = "__RealisticFusionCore__/graphics/icons/thermal-evaporation.png",
        icon_size = 64, icon_mipmaps = 4,
        --hide_from_player_crafting = true,
        energy_required = 5,
        ingredients = {{type = "fluid", name = "rf-brine", amount = 1200}},
        results = {
            {type = "fluid", name = "rf-lithium-rich-brine", amount = 400},
            {type = "item", name = "rf-potassium-chloride", amount = 30},
        },
        main_product = "rf-lithium-rich-brine",
        enabled = true--[[CHANGELATER]],
        subgroup = "fluid-recipes",
        order = "z[realistic-fusion]-b[lithium]-a[thermal-evaporation]",
    },
    {
        type = "recipe",
        name = "rf-lithium-carbonation",
        category = "chemistry",
        icon = "__RealisticFusionCore__/graphics/icons/lithium-carbonation.png",
        icon_size = 64, icon_mipmaps = 4,
        --hide_from_player_crafting = true,
        energy_required = 5,
        ingredients = {
            {type = "fluid", name = "rf-lithium-rich-brine", amount = 400},
            {type = "item", name = "coal", amount = 2}
        },
        results = {
            {type = "fluid", name = "water", amount = 200},
            {type = "item", name = "rf-lithium-carbonate", amount = 10},
        },
        main_product = "rf-lithium-carbonate",
        enabled = true--[[CHANGELATER]],
        subgroup = "fluid-recipes",
        order = "z[realistic-fusion]-b[lithium]-b[lithium-carbonation]",
    },
    {
        type = "recipe",
        name = "rf-molten-lithium-electrolyte",
        category = "rf-boiling",
        icon = "__RealisticFusionCore__/graphics/icons/molten-lithium-electrolyte.png",
        icon_size = 64, icon_mipmaps = 4,
        --hide_from_player_crafting = true,
        energy_required = 5,
        ingredients = {
            {type = "item", name = "rf-lithium-carbonate", amount = 5},
            {type = "item", name = "rf-potassium-chloride", amount = 5},
        },
        results = {
            {type = "fluid", name = "rf-molten-lithium-electrolyte", amount = 10},
        },
        enabled = true--[[CHANGELATER]],
        subgroup = "fluid-recipes",
        order = "z[realistic-fusion]-b[lithium]-c[molten-lithium-electrolyte]",
    },
    {
        type = "recipe",
        name = "rf-lithium-metal",
        category = "rf-electrolysis",
        icon = "__RealisticFusionCore__/graphics/icons/krastorio-2/lithium-2.png",
        icon_size = 64,
        --hide_from_player_crafting = true,
        energy_required = 5,
        ingredients = {{type = "fluid", name = "rf-molten-lithium-electrolyte", amount = 20}},
        results = {{type = "item", name = "rf-lithium-metal", amount = 2}},
        enabled = true--[[CHANGELATER]],
        subgroup = "raw-material",
        order = "z[realistic-fusion]-b[lithium]-a[lithium-metal]",
    },
    {
        type = "recipe",
        name = "rf-potassium-chloride-dissolution",
        category = "chemistry",
        icon = "__RealisticFusionCore__/graphics/icons/potassium-chloride-dissolution.png",
        icon_size = 64,
        --hide_from_player_crafting = true,
        energy_required = 5,
        ingredients = {
            {type = "fluid", name = "water", amount = 600},
            {type = "item", name = "rf-potassium-chloride", amount = 10},
        },
        results = {{type = "fluid", name = "water", amount = 500}},
        enabled = true--[[CHANGELATER]],
        subgroup = "fluid-recipes",
        order = "z[realistic-fusion]-b[lithium]-z[potassium-chloride-dissolution]",
    },
    -- #endregion --
}
-- #endregion --

-- #region DEUTERIUM EXTRACTION --
for i=1, 2 do
    data:extend{
        {
            type = "recipe",
            name = "rf-girdler-sulfide-process-"..i,
            icons = {
                {icon = "__RealisticFusionCore__/graphics/icons/gs-process.png", icon_size = 64, icon_mipmaps = 4,},
                {icon = "__RealisticFusionCore__/graphics/icons/angels-numerals/num-".. i+1 .."-outline.png", icon_size = 64, icon_mipmaps = 2,},
                {icon = "__RealisticFusionCore__/graphics/icons/angels-numerals/num-".. i+1 ..".png", icon_size = 64, icon_mipmaps = 2,},
            },
            energy_required = 1,
            --TODO localised_name = {"rf.gs-process-name", hw_percentage[i], hw_percentage[i+1]},
            category = "oil-processing",
            ingredients = {
                {type="fluid", name="rf-hydrogen-sulfide", amount=100, catalyst_amount = 10},
                {type="fluid", name="rf-heavy-water-"..i-1, amount=100}
            },
            results = {
                {type="fluid", name="rf-hydrogen-sulfide", amount=100*settings.startup["rf-gs-process-efficiency"].value, catalyst_amount = 100*settings.startup["rf-gs-process-efficiency"].value},
                {type="fluid", name="rf-depleted-water", amount=90},
                {type="fluid", name="rf-heavy-water-"..i, amount=10}
            },
            main_product = "rf-heavy-water-"..i,
            enabled = true--[[CHANGELATER]],
            --hide_from_player_crafting = true,
            subgroup = "fluid-recipes",
            order = "z[realistic-fusion]-a[deuterium]-b[girdler-sulfide-process]-"..i,
        },
        {
            type = "recipe",
            name = "rf-heavy-water-distillation-"..i,
            icons = {
                {icon = "__RealisticFusionCore__/graphics/icons/heavy-water-distillation.png", icon_size = 64, icon_mipmaps = 4},
                {icon = "__RealisticFusionCore__/graphics/icons/angels-numerals/num-".. i+1 .."-outline.png", icon_size = 64, icon_mipmaps = 2,},
                {icon = "__RealisticFusionCore__/graphics/icons/angels-numerals/num-".. i+1 ..".png", icon_size = 64, icon_mipmaps = 2,},
            },
            category = "rf-boiling",
            energy_required = 9.5,
            ingredients = {
                {type="fluid", name="rf-heavy-water-"..i-1, amount=100}
            },
            results = {
                {type="fluid", name="steam", amount=90, temperature = 100},
                {type="fluid", name="rf-heavy-water-"..i, amount=10, temperature = 100}
            },
            main_product = "rf-heavy-water-"..i,
            enabled = true--[[CHANGELATER]],
            --hide_from_player_crafting = true,
            subgroup = "fluid-recipes",
            order = "z[realistic-fusion]-a[deuterium]-c[heavy-water-distillation]-"..i,
        },
    }
end
-- #endregion --