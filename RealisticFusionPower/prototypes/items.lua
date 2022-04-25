-- #region HIGH-CAPACITY EXCHANGER & TURBINE --
if settings.startup["rf-hc-stuff"].value then
    local hc_hx = util.table.deepcopy(data.raw.item["heat-exchanger"])
    hc_hx.name = "rf-hc-exchanger"
    hc_hx.place_result = "rf-hc-exchanger"
    hc_hx.icon = nil
    hc_hx.icons = nil
    hc_hx.icons = {{icon = "__base__/graphics/icons/heat-boiler.png", tint = {r = 1, g = 0.5, b = 0, a = 1}, icon_size = 64}}
    hc_hx.order = "f[nuclear-energy]-z[rf-hc-exchanger]"

    local hc_t = util.table.deepcopy(data.raw.item["steam-turbine"])
    hc_t.name = "rf-hc-turbine"
    hc_t.place_result = "rf-hc-turbine"
    hc_t.icon = nil
    hc_t.icons = nil
    hc_t.icons = {{icon = "__base__/graphics/icons/steam-turbine.png", tint = {r = 1, g = 0.5, b = 0, a = 1}, icon_size = 64}}
    hc_t.order = "f[nuclear-energy]-z[rf-hc-turbine]"

    data:extend{hc_hx, hc_t}
end
-- #endregion --

-- #region DATA --
data:extend{
    -- #region ENTITY ITEMS --
    {
        type = "item",
        name = "rf-reactor",
        order = "g[realistic-fusion]-b[reactor]",
        --group = "production",
        subgroup = "energy",
        icon = "__RealisticFusionPower__/graphics/icons/reactor.png",
        icon_size = 64,
        stack_size = 1,
        place_result = "rf-reactor",
    },
    {
        type = "item",
        name = "rf-reactor-aneutronic",
        order = "g[realistic-fusion]-e[reactor-aneutronic]",
        --group = "production",
        subgroup = "energy",
        icon = "__RealisticFusionPower__/graphics/icons/reactor-aneutronic.png",
        icon_size = 64,
        stack_size = 1,
        place_result = "rf-reactor-aneutronic",
    },
    {
        type = "item",
        name = "rf-icf-laser",
        order = "g[realistic-fusion]-i[laser-icf]",
        --group = "production",
        subgroup = "energy",
        icon = "__RealisticFusionPower__/graphics/icons/laser.png",
        icon_size = 64,
        stack_size = 8,
        place_result = "rf-icf-laser",
    },
    {
        type = "item",
        name = "rf-reactor-icf",
        order = "g[realistic-fusion]-g[reactor-icf]",
        --group = "production",
        subgroup = "energy",
        icon = "__RealisticFusionPower__/graphics/icons/reactor-icf.png",
        icon_size = 64,
        stack_size = 1,
        place_result = "rf-reactor-icf",
    },
    {
        type = "item",
        name = "rf-reactor-icf-aneutronic",
        order = "g[realistic-fusion]-h[reactor-icf-aneutronic]",
        --group = "production",
        subgroup = "energy",
        icon = "__RealisticFusionPower__/graphics/icons/reactor-icf-aneutronic.png",
        icon_size = 64,
        stack_size = 1,
        place_result = "rf-reactor-icf-aneutronic",
    },
    {
        type = "item",
        name = "rf-heat-exchanger",
        order = "g[realistic-fusion]-d[heat-exchanger]",
        --group = "production",
        subgroup = "energy",
        icon = "__RealisticFusionPower__/graphics/icons/heat-exchanger.png",
        icon_size = 64,
        stack_size = 1,
        place_result = "rf-heat-exchanger",
    },
    {
        type = "item",
        name = "rf-ion-cyclotron",
        order = "g[realistic-fusion]-c[ion-cyclotron]",
        --group = "production",
        subgroup = "energy",
        icon = "__RealisticFusionPower__/graphics/icons/ion-cyclotron.png",
        icon_size = 64,
        stack_size = 1,
        place_result = "rf-ion-cyclotron",
    },
    {
        type = "item",
        name = "rf-direct-energy-converter",
        order = "g[realistic-fusion]-f[direct-energy-converter]",
        --group = "production",
        subgroup = "energy",
        icon = "__RealisticFusionPower__/graphics/icons/dec.png",
        icon_size = 64,
        stack_size = 1,
        place_result = "rf-direct-energy-converter",
    },
    -- #endregion --

    -- #region ITEMS --
    {
        type = "item",
        name = "rf-d-d-fuel-pellet",
        order = "x[realistic-fusion]-d[d-d-fuel-pellet]",
        --group = "production",
        subgroup = "intermediate-product",
        icon = "__RealisticFusionPower__/graphics/icons/icf-d-d-fuel-pellet.png",
        icon_size = 128, icon_mipmaps = 4,
        stack_size = 20,
    },
    {
        type = "item",
        name = "rf-d-t-fuel-pellet",
        order = "x[realistic-fusion]-d[d-t-fuel-pellet]",
        --group = "production",
        subgroup = "intermediate-product",
        icon = "__RealisticFusionPower__/graphics/icons/icf-d-t-fuel-pellet.png",
        icon_size = 128, icon_mipmaps = 4,
        stack_size = 20,
    },
    {
        type = "item",
        name = "rf-he3-he3-fuel-pellet",
        order = "x[realistic-fusion]-d[he3-he3-fuel-pellet]",
        --group = "production",
        subgroup = "intermediate-product",
        icon = "__RealisticFusionPower__/graphics/icons/icf-he3-he3-fuel-pellet.png",
        icon_size = 128, icon_mipmaps = 4,
        stack_size = 20,
    },
    {
        type = "item",
        name = "rf-d-he3-fuel-pellet",
        order = "x[realistic-fusion]-d[d-he3-fuel-pellet]",
        --group = "production",
        subgroup = "intermediate-product",
        icon = "__RealisticFusionPower__/graphics/icons/icf-d-he3-fuel-pellet.png",
        icon_size = 128, icon_mipmaps = 4,
        stack_size = 20,
    },
    -- #endregion --
}
-- #endregion --