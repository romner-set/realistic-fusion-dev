-- #region MAGNETIC PIPES --
local pipe = table.deepcopy(data.raw.item["pipe"])
pipe.name = "rf-magnetic-pipe"
pipe.place_result = "rf-magnetic-pipe"
pipe.icons = nil
pipe.icon = "__RealisticFusionCore__/graphics/icons/magnetic-pipe.png"
pipe.icon_size = 64; pipe.icon_mipmaps = 4
pipe.order = "b[pipe]-x[magnetic-pipe]"

local pipeToGround = table.deepcopy(data.raw.item["pipe-to-ground"])
pipeToGround.name = "rf-magnetic-pipe-to-ground"
pipeToGround.place_result = "rf-magnetic-pipe-to-ground"
pipeToGround.icons = nil
pipeToGround.icon = "__RealisticFusionCore__/graphics/icons/magnetic-pipe-to-ground.png"
pipeToGround.icon_size = 64; pipe.icon_mipmaps = 4
pipeToGround.order = "b[pipe]-y[magnetic-pipe-to-ground]"

local pump = table.deepcopy(data.raw.item["pump"])
pump.name = "rf-magnetic-pump"
pump.place_result = "rf-magnetic-pump"
pump.icons = nil
pump.icon = "__RealisticFusionCore__/graphics/icons/magnetic-pump.png"
pump.icon_size = 64; pipe.icon_mipmaps = 4
pump.order = "b[pipe]-z[magnetic-pump]"
-- #endregion --

-- #region DATA --
data:extend{pipe, pipeToGround, pump,
    -- #region ENTITY ITEMS --
    {
        type = "item",
        name = "rf-heater",
        order = "g[realistic-fusion]-a[heater]",
        --group = "production",
        subgroup = "energy",
        icon = "__RealisticFusionCore__/graphics/icons/heater.png",
        icon_size = 64,
        stack_size = 1,
        place_result = "rf-heater",
    },
    {
        type = "item",
        name = "rf-light-isotope-processor",
        subgroup = "production-machine",
        order = "g[centrifuge]z[realistic-fusion]-z[general]-a[light-isotope-processor]",
        icon = "__RealisticFusionCore__/graphics/icons/light-isotope-processor.png",
        icon_size = 64,
        stack_size = 10,
        place_result = "rf-light-isotope-processor",
    },
    {
        type = "item",
        name = "rf-thermal-evaporation-plant",
        order = "g[centrifuge]z[realistic-fusion]-b[lithium]-a[thermal-evaporation-plant]",
        --group = "production",
        subgroup = "production-machine",
        icon = "__RealisticFusionCore__/graphics/icons/thermal-evaporation-plant.png",
        icon_size = 64,
        stack_size = 1,
        place_result = "rf-thermal-evaporation-plant",
    },
    {
        type = "item",
        name = "rf-electrolyser",
        subgroup = "production-machine",
        order = "g[centrifuge]z[realistic-fusion]-a[deuterium]-a[electrolyser]",
        icon = "__RealisticFusionCore__/graphics/icons/electrolyser.png",
        icon_size = 32,
        stack_size = 10,
        place_result = "rf-electrolyser",
    },
    {
        type = "item",
        name = "rf-discharge-pump",
        icons = {{icon = "__base__/graphics/icons/offshore-pump.png", tint = {0,0.5,1}}},
        icon_size = 64, icon_mipmaps = 4,
        subgroup = "extraction-machine",
        order = "b[fluids]-a[offshore-pump]z[rf-discharge-pump]",
        place_result = "rf-discharge-pump",
        stack_size = 20,
        localised_description = {"rf.discharge-pump", "rf-depleted-water"}
    },
    -- #endregion --

    -- #region ITEMS --
    {
      type = "item",
      name = "rf-breeder-uranium-fuel-cell",
      icon = "__RealisticFusionCore__/graphics/icons/breeder-uranium-fuel-cell.png",
      icon_size = 64, icon_mipmaps = 4,
      pictures =
      {
        layers =
        {
          {
            size = 64,
            filename = "__RealisticFusionCore__/graphics/icons/breeder-uranium-fuel-cell.png",
            scale = 0.25,
            mipmap_count = 4
          },
          {
            draw_as_light = true,
            flags = {"light"},
            size = 64,
            filename = "__base__/graphics/icons/uranium-fuel-cell-light.png",
            scale = 0.25,
            mipmap_count = 4
          }
        }
      },
      subgroup = "intermediate-product",
      order = "r[uranium-processing]-a[uranium-fuel-cell]-z[rf-tritium-breeding]",
      fuel_category = "nuclear",
      burnt_result = "rf-used-up-breeder-uranium-fuel-cell",
      fuel_value = "4GJ",
      stack_size = 50
    },
    {
      type = "item",
      name = "rf-used-up-breeder-uranium-fuel-cell",
      icon = "__RealisticFusionCore__/graphics/icons/used-up-breeder-uranium-fuel-cell.png",
      icon_size = 64, icon_mipmaps = 4,
      subgroup = "intermediate-product",
      order = "r[used-up-uranium-fuel-cell]-z[rf-tritium-breeding]",
      stack_size = 50
    },

    -- #region LITHIUM-RELATED STUFF --
    {
        type = "item",
        name = "rf-potassium-chloride",
        icon = "__RealisticFusionCore__/graphics/icons/krastorio-2/potassium-chloride.png",
        icon_size = 64, icon_mipmaps = 4,
        subgroup = "fluid-recipes",
        order = "g[centrifuge]z[realistic-fusion]-b[lithium]-a[potassium-chloride]",
        stack_size = 200,
    },
    {
        type = "item",
        name = "rf-lithium-carbonate",
        icon = "__RealisticFusionCore__/graphics/icons/krastorio-2/lithium-carbonate.png",
        icon_size = 64, icon_mipmaps = 4,
        subgroup = "fluid-recipes",
        order = "g[centrifuge]z[realistic-fusion]-b[lithium]-b[lithium-carbonate]",
        stack_size = 200,
    },
    {
        type = "item",
        name = "rf-lithium-titanate",
        icon = "__RealisticFusionCore__/graphics/icons/krastorio-2/lithium-titanate.png",
        icon_size = 64, icon_mipmaps = 4,
        --subgroup = "fluid-recipes",
        --order = "b[lithium]-c[lithium-titanate]",
        subgroup = "raw-material",
        order = "g[centrifuge]z[realistic-fusion]-b[lithium]-b[lithium-titanate]",
        stack_size = 200,
    },
    {
        type = "item",
        name = "rf-lithium-metal",
        icon = "__RealisticFusionCore__/graphics/icons/krastorio-2/lithium-2.png",
        icon_size = 64, icon_mipmaps = 4,
        pictures = {
            {
                size = 64,
                filename = "__RealisticFusionCore__/graphics/icons/krastorio-2/lithium.png",
                scale = 0.25,
                mipmap_count = 4,
            },
            {
                size = 64,
                filename = "__RealisticFusionCore__/graphics/icons/krastorio-2/lithium-1.png",
                scale = 0.25,
                mipmap_count = 4,
            },
            {
                size = 64,
                filename = "__RealisticFusionCore__/graphics/icons/krastorio-2/lithium-2.png",
                scale = 0.25,
                mipmap_count = 4,
            },
        },
        subgroup = "raw-material",
        order = "g[centrifuge]z[realistic-fusion]-b[lithium]-a[lithium-metal]",
        stack_size = 100,
    },
    -- #endregion --

    -- #endregion --
}
-- #endregion --