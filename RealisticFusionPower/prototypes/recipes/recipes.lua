-- #region DATASETS --
--local dd0energy    = {100, 115, 130, 140, 150, 160, 170, 180, 190, 200} --TODO
local ddbreedingenergy = {200, 215, 230, 240, 205, 260, 270, 280, 290, 300} --TODO
local ddenergy         = {400, 430, 460, 480, 500, 520, 540, 560, 580, 600} --TODO
local dtenergy         = {1400, 1450, 1500, 1600, 1700, 1800, 1850, 1900, 1950, 2000} --TODO
local he3he3energy     = {7000, 8000, 9000, 10000, 11000, 12000, 13000, 14000, 145000, 15000} --TODO
local dhe3energy       = {10000, 10100, 10250, 10500, 10800, 11800, 13000, 14500, 17000, 20000} --TODO

local icfddenergy     = ddenergy --TODO
local icfdtenergy     = dtenergy --TODO
local icfhe3he3energy = he3he3energy --TODO
local icfdhe3energy   = dhe3energy --TODO
-- #endregion --

-- #region DATA --

local recipes = {}
for i=1, 10 do
    -- #region MCF --
    table.insert(recipes, {
        type = "recipe",
        name = "rf-fusion-d-d-"..i-1,
        category = "rf-fusion",
        icons = {
            {icon = "__RealisticFusionPower__/graphics/icons/fusion-d-d-big.png", icon_size = 1024, icon_mipmaps = 8},
            {icon = "__RealisticFusionCore__/graphics/icons/angels-numerals/num-"..i.."-outline.png", icon_size = 64, icon_mipmaps = 2,},
            {icon = "__RealisticFusionCore__/graphics/icons/angels-numerals/num-"..i..".png", icon_size = 64, icon_mipmaps = 2,},
        },
        energy_required = 1,
        hide_from_player_crafting = true, hide_from_stats = true,
        enabled = true--[[CHANGELATER]],
        ingredients = {{type = "fluid", name = "rf-deuterium-plasma", amount = 11}},
        results = {                          --1x fusion-results = 1MJ of energy
            {type = "fluid", name = "rf-heliated-tritiated-fusion-results", amount = ddenergy[i]}, --1mg of deuterium = 42MJ --TODO
            --{type = "fluid", name = "rf-helium-3", amount = 0}, --I take it as 1 fluid unit = ~47,784 ml or to be precise 47.78401624656552383227810297456ml (got that from the energy it takes to heat water irl vs ingame)
            {type = "fluid", name = "rf-tritium", amount = 0}   --1u of deuterium = ~8,6mg = ~361.25MJ/u *1.1 = ~400MW --TODO
        },
        main_product = "rf-heliated-tritiated-fusion-results",
        order = "A[realistic-fusion]-a[d-d]-c[basic]-"..i-1
    })
    table.insert(recipes, {
        type = "recipe",
        name = "rf-fusion-d-d-breeding-"..i-1,
        category = "rf-fusion",
        icons = {
            {icon = "__RealisticFusionPower__/graphics/icons/fusion-d-d-big.png", icon_size = 1024, icon_mipmaps = 8},
            {icon = "__RealisticFusionCore__/graphics/icons/krastorio-2/lithium-overlay.png", icon_size = 64},
            {icon = "__RealisticFusionCore__/graphics/icons/angels-numerals/num-"..i.."-outline.png", icon_size = 64, icon_mipmaps = 2,},
            {icon = "__RealisticFusionCore__/graphics/icons/angels-numerals/num-"..i..".png", icon_size = 64, icon_mipmaps = 2,},
        },
        hide_from_player_crafting = true, hide_from_stats = true,
        enabled = true--[[CHANGELATER]],
        energy_required = 1,
        ingredients = {
            {type = "fluid", name = "rf-deuterium-plasma", amount = 11},
            {type = "item", name = "rf-lithium-metal", amount = 11},
        },
        results = {
            {type = "fluid", name = "rf-heliated-tritiated-fusion-results", amount = ddbreedingenergy[i]},
            {type = "fluid", name = "rf-tritium", amount = 5.5} --TODO
        },
        main_product = "rf-heliated-tritiated-fusion-results",
        order = "A[realistic-fusion]-a[d-d]-c[breeding]-"..i-1
    })
    --[[table.insert(recipes, {
        type = "recipe",
        name = "rf-fusion-d-d-2-"..i-1, --tritium-suppressed w/o lithium
        category = "rf-fusion",
        icons = {
            {icon = "__RealisticFusionPower__/graphics/icons/fusion-d-d-big.png", icon_size = 1024, icon_mipmaps = 8},
            {icon = "__RealisticFusionPower__/graphics/icons/tritium-suppressed-fusion-overlay.png", icon_size = 64},
            {icon = "__RealisticFusionCore__/graphics/icons/angels-numerals/num-"..i.."-outline.png", icon_size = 64, icon_mipmaps = 2,},
            {icon = "__RealisticFusionCore__/graphics/icons/angels-numerals/num-"..i..".png", icon_size = 64, icon_mipmaps = 2,},
        },
        hide_from_player_crafting = true, hide_from_stats = true,
        enabled = true--[[CHANGELATER]]--[[,
        energy_required = 1,
        ingredients = {{type = "fluid", name = "rf-deuterium-plasma", amount = 11}},
        results = {
            {type = "fluid", name = "rf-fusion-results", amount = dd0energy[i]},
            --{type = "fluid", name = "rf-helium-3", amount = 0},
            {type = "fluid", name = "rf-tritium", amount = 0}
        },
        main_product = "rf-fusion-results",
        order = "A[realistic-fusion]-a[d-d]-c[tritium-suppressed]-a[without-lithium]-"..i-1
    })
    table.insert(recipes, {
        type = "recipe",
        name = "rf-fusion-d-d-3-"..i-1, --tritium-suppressed w/lithium
        category = "rf-fusion",
        icons = {
            {icon = "__RealisticFusionPower__/graphics/icons/fusion-d-d-big.png", icon_size = 1024, icon_mipmaps = 8},
            {icon = "__RealisticFusionCore__/graphics/icons/krastorio-2/lithium-overlay.png", icon_size = 64},
            {icon = "__RealisticFusionPower__/graphics/icons/tritium-suppressed-fusion-overlay.png", icon_size = 64},
            {icon = "__RealisticFusionCore__/graphics/icons/angels-numerals/num-"..i.."-outline.png", icon_size = 64, icon_mipmaps = 2,},
            {icon = "__RealisticFusionCore__/graphics/icons/angels-numerals/num-"..i..".png", icon_size = 64, icon_mipmaps = 2,},
        },
        hide_from_player_crafting = true, hide_from_stats = true,
        enabled = true--[[CHANGELATER]]--[[,
        energy_required = 1,
        ingredients = {{type = "fluid", name = "rf-deuterium-plasma", amount = 11}},
        results = {
            {type = "fluid", name = "rf-fusion-results", amount = dd0energy[i]},
            --{type = "fluid", name = "rf-helium-3", amount = 0},
            {type = "fluid", name = "rf-tritium", amount = 0}
        },
        main_product = "rf-fusion-results",
        order = "A[realistic-fusion]-a[d-d]-c[tritium-suppressed]-b[with-lithium]-"..i-1
    })]]

    table.insert(recipes, {
        type = "recipe",
        name = "rf-fusion-d-t-"..i-1,
        category = "rf-fusion",
        icons = {
            {icon = "__RealisticFusionPower__/graphics/icons/fusion-d-t-big.png", icon_size = 1024, icon_mipmaps = 8},
            {icon = "__RealisticFusionCore__/graphics/icons/angels-numerals/num-"..i.."-outline.png", icon_size = 64, icon_mipmaps = 2,},
            {icon = "__RealisticFusionCore__/graphics/icons/angels-numerals/num-"..i..".png", icon_size = 64, icon_mipmaps = 2,},
        },
        enabled = true--[[CHANGELATER]],
        energy_required = 1,
        hide_from_player_crafting = true, hide_from_stats = true,
        ingredients = {{type = "fluid", name = "rf-d-t-plasma", amount = 10}}, --D-T = 126MJ/mg
        results = {
            {type = "fluid", name = "rf-fusion-results", amount = dtenergy[i]}, --1u of a 1:1 D-T mix = ~10.75mg = ~1354.67686MJ/u ~= 1400MJ
            --{type = "fluid", name = "rf-helium-3", amount = 0},
            {type = "fluid", name = "rf-tritium", amount = 0}
        },
        main_product = "rf-fusion-results",
        order = "A[realistic-fusion]-b[d-t]-"..i-1
    })
    table.insert(recipes, {
        type = "recipe",
        name = "rf-fusion-he3-he3-"..i-1,
        category = "rf-fusion-aneutronic",
        icons = {
            {icon = "__RealisticFusionPower__/graphics/icons/fusion-he3-he3-big.png", icon_size = 1024, icon_mipmaps = 8},
            {icon = "__RealisticFusionCore__/graphics/icons/angels-numerals/num-"..i.."-outline.png", icon_size = 64, icon_mipmaps = 2,},
            {icon = "__RealisticFusionCore__/graphics/icons/angels-numerals/num-"..i..".png", icon_size = 64, icon_mipmaps = 2,},
        },
        enabled = true--[[CHANGELATER]],
        energy_required = 1,
        hide_from_player_crafting = true, hide_from_stats = true,
        ingredients = {{type = "fluid", name = "rf-helium-3-plasma", amount = 10}},
        results = {{type = "fluid", name = "rf-aneutronic-fusion-results", amount = he3he3energy[i]}},
        order = "A[realistic-fusion]-a[he3-he3]-"..i-1
    })
    table.insert(recipes, {
        type = "recipe",
        name = "rf-fusion-d-he3-"..i-1,
        category = "rf-fusion-aneutronic",
        icons = {
            {icon = "__RealisticFusionPower__/graphics/icons/fusion-d-he3-big.png", icon_size = 1024, icon_mipmaps = 8},
            {icon = "__RealisticFusionCore__/graphics/icons/angels-numerals/num-"..i.."-outline.png", icon_size = 64, icon_mipmaps = 2,},
            {icon = "__RealisticFusionCore__/graphics/icons/angels-numerals/num-"..i..".png", icon_size = 64, icon_mipmaps = 2,},
        },
        enabled = true--[[CHANGELATER]],
        energy_required = 1,
        hide_from_player_crafting = true, hide_from_stats = true,
        ingredients = {{type = "fluid", name = "rf-d-he3-plasma", amount = 20}},
        results = {{type = "fluid", name = "rf-aneutronic-fusion-results", amount = dhe3energy[i]}}, --D-He3 = ~5046.589MJ/u
        order = "A[realistic-fusion]-b[d-he3]-"..i-1
    })
    -- #endregion --

    -- #region ICF --
    table.insert(recipes, {
        type = "recipe",
        name = "rf-icf-fusion-d-d-"..i-1,
        category = "rf-fusion-icf",
        icons = {
            {icon = "__RealisticFusionPower__/graphics/icons/fusion-d-d-big.png", icon_size = 1024, icon_mipmaps = 8},
            {icon = "__RealisticFusionPower__/graphics/icons/icf-d-d-fuel-pellet-overlay.png", icon_size = 64},
            {icon = "__RealisticFusionCore__/graphics/icons/angels-numerals/num-"..i.."-outline.png", icon_size = 64, icon_mipmaps = 2,},
            {icon = "__RealisticFusionCore__/graphics/icons/angels-numerals/num-"..i..".png", icon_size = 64, icon_mipmaps = 2,},
        },
        energy_required = 1,
        hide_from_player_crafting = true, hide_from_stats = true,
        enabled = true--[[CHANGELATER]],
        ingredients = {
            {type = "fluid", name = "rf-laser-photons", amount = icfddenergy[i]}, --TODO
            {type = "item", name = "rf-d-d-fuel-pellet", amount = 11}
        }, --TODO
        results = {
            {type = "fluid", name = "rf-fusion-results", amount = icfddenergy[i]},
        },
        main_product = "rf-fusion-results",
        order = "A[realistic-fusion]-a[d-d]-"..i-1
    })
    table.insert(recipes, {
        type = "recipe",
        name = "rf-icf-fusion-d-t-"..i-1,
        category = "rf-fusion-icf",
        icons = {
            {icon = "__RealisticFusionPower__/graphics/icons/fusion-d-t-big.png", icon_size = 1024, icon_mipmaps = 8},
            {icon = "__RealisticFusionPower__/graphics/icons/icf-d-t-fuel-pellet-overlay.png", icon_size = 64},
            {icon = "__RealisticFusionCore__/graphics/icons/angels-numerals/num-"..i.."-outline.png", icon_size = 64, icon_mipmaps = 2,},
            {icon = "__RealisticFusionCore__/graphics/icons/angels-numerals/num-"..i..".png", icon_size = 64, icon_mipmaps = 2,},
        },
        enabled = true--[[CHANGELATER]],
        energy_required = 1,
        hide_from_player_crafting = true, hide_from_stats = true,
        ingredients = {
            {type = "fluid", name = "rf-laser-photons", amount = icfdtenergy[i]}, --TODO
            {type = "item", name = "rf-d-t-fuel-pellet", amount = 10}
        }, --D-T = 126MJ/mg
        results = {
            {type = "fluid", name = "rf-fusion-results", amount = icfdtenergy[i]}, --1u of a 1:1 D-T mix = ~10.75mg = ~1354.67686MJ/u ~= 1400MJ
        },
        main_product = "rf-fusion-results",
        order = "A[realistic-fusion]-b[d-t]-"..i-1
    })
    table.insert(recipes, {
        type = "recipe",
        name = "rf-icf-fusion-he3-he3-"..i-1,
        category = "rf-fusion-icf-aneutronic",
        icons = {
            {icon = "__RealisticFusionPower__/graphics/icons/fusion-he3-he3-big.png", icon_size = 1024, icon_mipmaps = 8},
            {icon = "__RealisticFusionPower__/graphics/icons/icf-he3-he3-fuel-pellet-overlay.png", icon_size = 64},
            {icon = "__RealisticFusionCore__/graphics/icons/angels-numerals/num-"..i.."-outline.png", icon_size = 64, icon_mipmaps = 2,},
            {icon = "__RealisticFusionCore__/graphics/icons/angels-numerals/num-"..i..".png", icon_size = 64, icon_mipmaps = 2,},
        },
        enabled = true--[[CHANGELATER]],
        energy_required = 1,
        hide_from_player_crafting = true, hide_from_stats = true,
        ingredients = {
            {type = "fluid", name = "rf-laser-photons", amount = icfhe3he3energy[i]}, --TODO
            {type = "item", name = "rf-he3-he3-fuel-pellet", amount = 10}
        },
        results = {{type = "fluid", name = "rf-aneutronic-fusion-results", amount = icfhe3he3energy[i]}},
        order = "A[realistic-fusion]-a[he3-he3]-"..i-1
    })
    table.insert(recipes, {
        type = "recipe",
        name = "rf-icf-fusion-d-he3-"..i-1,
        category = "rf-fusion-icf-aneutronic",
        icons = {
            {icon = "__RealisticFusionPower__/graphics/icons/fusion-d-he3-big.png", icon_size = 1024, icon_mipmaps = 8},
            {icon = "__RealisticFusionPower__/graphics/icons/icf-d-he3-fuel-pellet-overlay.png", icon_size = 64},
            {icon = "__RealisticFusionCore__/graphics/icons/angels-numerals/num-"..i.."-outline.png", icon_size = 64, icon_mipmaps = 2,},
            {icon = "__RealisticFusionCore__/graphics/icons/angels-numerals/num-"..i..".png", icon_size = 64, icon_mipmaps = 2,},
        },
        enabled = true--[[CHANGELATER]],
        energy_required = 1,
        hide_from_player_crafting = true, hide_from_stats = true,
        ingredients = {
            {type = "fluid", name = "rf-laser-photons", amount = icfdhe3energy[i]}, --TODO
            {type = "item", name = "rf-d-he3-fuel-pellet", amount = 20}
        },
        results = {{type = "fluid", name = "rf-aneutronic-fusion-results", amount = icfdhe3energy[i]}}, --D-He3 = ~5046.589MJ/u
        order = "A[realistic-fusion]-b[d-he3]-"..i-1
    })
    -- #endregion --

    -- #region LASER -- --TODO
    table.insert(recipes, {
        type = "recipe",
        name = "rf-icf-laser-"..i-1,
        category = "rf-icf-laser",
        icon = "__RealisticFusionPower__/graphics/icons/laser-energy.png",
        icon_size = 64,
        enabled = true--[[CHANGELATER]],
        energy_required = 1,
        hide_from_player_crafting = true, hide_from_stats = true,
        ingredients = {},
        results = {{type = "fluid", name = "rf-laser-photons", amount = 1000}}, --TODO
        order = "A[realistic-fusion]-b[d-he3]-"..i-1 --TODO
    })
    -- #endregion --
end

-- #region TRITIUM REHEATING --
for i=1, 5 do
    table.insert(recipes, { --TODO
        type = "recipe",
        name = "rf-d-t-from-plasma-" .. i-1,
        category = "rf-heating",
        icons = {
            {icon = "__RealisticFusionCore__/graphics/icons/d-t-plasma-big.png", icon_size = 673,},
            {icon = "__RealisticFusionCore__/graphics/icons/angels-numerals/num-"..i.."-outline.png", icon_size = 64, icon_mipmaps = 2,},
            {icon = "__RealisticFusionCore__/graphics/icons/angels-numerals/num-"..i..".png", icon_size = 64, icon_mipmaps = 2,},
        },
        hide_from_player_crafting = true,
        enabled = true--[[CHANGELATER]],
        energy_required = rfcore.dthpower[i]/800,
        ingredients = {
            {type = "fluid", name = "rf-tritium-plasma", amount = 5},
            {type = "fluid", name = "rf-deuterium", amount = 5}
        },
        results = {{type = "fluid", name = "rf-d-t-plasma", amount = 10}},
        order = "A[realistic-fusion]-b[d-t]-"..i-1 --TODO
    })
end
-- #endregion --

-- #region Cyclotron -- --TODO
local prefixes = {"-heliated", "", "-tritiated", ""}
local overlays = {
    {icon = "__RealisticFusionCore__/graphics/icons/helium-3-plasma.png", icon_size = 64, scale = 0.25, shift = {-10,8}},
    {icon = rfcore.empty_sprite.filename, icon_size = 1},
    {icon = "__RealisticFusionCore__/graphics/icons/tritium-plasma.png", icon_size = 64, scale = 0.25, shift = {-10,8}},
    {icon = rfcore.empty_sprite.filename, icon_size = 1},
}
for i=1, 2 do
    table.insert(recipes, {
        type = "recipe",
        name = "rf-tritium-extraction-"..i-1,
        category = "rf-ion-cyclotron",
        icons = {
            {icon = "__RealisticFusionCore__/graphics/icons/tritium-plasma-big.png", icon_size = 673},
            {icon = "__RealisticFusionPower__/graphics/icons/energy.png", icon_size = 64, scale = 0.25, shift = {10,8}},
            overlays[i]
        },
        enabled = true--[[CHANGELATER]],
        energy_required = 1,
        hide_from_player_crafting = true,
        ingredients = {{type = "fluid", name = "rf"..prefixes[i].."-tritiated-fusion-results", amount = 1000}}, --TODO
        results = {
            {type = "fluid", name = "rf"..prefixes[i].."-fusion-results", amount = 900},
            {type = "fluid", name = "rf-tritium-plasma", amount = 10},
        }, --TODO
        main_product = "rf-tritium-plasma",
        order = "A[realistic-fusion]-b[d-he3]" --TODO
    })
    table.insert(recipes, {
        type = "recipe",
        name = "rf-helium-extraction-"..i-1,
        category = "rf-ion-cyclotron",
        icons = {
            {icon = "__RealisticFusionCore__/graphics/icons/helium-3-plasma-big.png", icon_size = 673},
            {icon = "__RealisticFusionPower__/graphics/icons/energy.png", icon_size = 64, scale = 0.25, shift = {10,8}},
            overlays[i+2]
        },
        enabled = true--[[CHANGELATER]],
        energy_required = 1,
        hide_from_player_crafting = true,
        ingredients = {{type = "fluid", name = "rf-heliated"..prefixes[i+2].."-fusion-results", amount = 1000}}, --TODO
        results = {
            {type = "fluid", name = "rf"..prefixes[i+2].."-fusion-results", amount = 900},
            {type = "fluid", name = "rf-helium-3-plasma", amount = 10},
        }, --TODO
        main_product = "rf-helium-3-plasma",
        order = "A[realistic-fusion]-b[d-he3]-2" --TODO
    })
end
data:extend(recipes)
-- #endregion --

-- #endregion --