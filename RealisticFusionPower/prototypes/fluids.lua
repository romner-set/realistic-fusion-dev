data:extend{
    -- If you can pipe these 'fluids' something has gone very wrong --
    {
        type = "fluid",
        name = "rf-fusion-results",
        fuel_value = "10MJ", --actual value is 1MJ due to the 0.1 effectivity of DECs and HXs
        icon = "__RealisticFusionPower__/graphics/icons/energy.png",
        icon_size = 64,
        default_temperature = 0xDECADE, --0xDECADE (14600926) is the "temperature code" for neutronic fusion results (D-D and D-T fusion)
        max_temperature = 0xDECADE,     --0xFACADE (16435934) is for aneutronic fusion results (He3-He3 and D-He3 fusion)
        flow_color = {1, 1, 0},         --0xACCEDE (11325150) is for laser photons
        base_color = {1, 1, 0},         --nothing to do with irl fusion, 0xDECADE and 0xFACADE because they're easy to remember and a big enough number to not cause problems
        auto_barrel = false,            --they're used instead of a filter in the heat exchanger and DEC fluid boxes because filter only supports 1 fluid
        gas_temperature = 0xDECADE,     --...and apparently minimum_temperature and maximum_temperature don't work if a filter is not set, so this does nothing
        hidden = true,                  --still going to keep it in the mod in case that ever changes
    },
    {
        type = "fluid",
        name = "rf-aneutronic-fusion-results",
        fuel_value = "10MJ",
        icon = "__RealisticFusionPower__/graphics/icons/energy.png",
        icon_size = 64,
        default_temperature = 0xFACADE,
        max_temperature = 0xFACADE,
        base_color = {1, 1, 0},
        flow_color = {1, 1, 0},
        auto_barrel = false,
        gas_temperature = 0xFACADE,
        hidden = true,
    },
    {
        type = "fluid",
        name = "rf-laser-photons",
        fuel_value = "10MJ",
        icon = "__RealisticFusionPower__/graphics/icons/laser-energy.png",
        icon_size = 64,
        default_temperature = 0xACCEDE,
        max_temperature = 0xACCEDE,
        base_color = {1, 1, 0},
        flow_color = {1, 1, 0},
        auto_barrel = false,
        gas_temperature = 0xACCEDE,
        hidden = true,
    },
}
t = {"heliated", "tritiated", "heliated-tritiated"}
local overlays = {
    {icon = "__RealisticFusionCore__/graphics/icons/tritium-plasma.png", icon_size = 64, scale = 0.25, shift = {-10,8}},
    {icon = "__RealisticFusionCore__/graphics/icons/helium-3-plasma.png", icon_size = 64, scale = 0.25, shift = {-10,8}},
}
for i=1,3 do
    local icons = {
        {icon = "__RealisticFusionPower__/graphics/icons/energy.png", icon_size = 64}, --TODO
        overlays[i%2+1] --1%2+1 == 2  2%2+1 == 1  3%2+1 == 2
    }
    if i==3 then table.insert(icons, overlays[1]); icons[2].shift = {10,8} end
    data:extend{
        {
            type = "fluid",
            name = "rf-"..t[i].."-fusion-results",
            fuel_value = "10MJ",
            icons = icons,
            default_temperature = 0xDECADE,
            max_temperature = 0xDECADE,
            base_color = {1, 1, 0},
            flow_color = {1, 1, 0},
            auto_barrel = false,
            gas_temperature = 0xDECADE,
            hidden = true,
        },
    }
end