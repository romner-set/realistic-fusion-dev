if script.active_mods["gvv"] then require("__gvv__.gvv")() end --for debugging
require("__RealisticFusionCore__/try-catch")

-- #region INIT GLOBAL(-ISH) TABLE --
rfpower = {
    icf_offsets = {
        ["rf-m-reactor-icf"] = {
            ["-hx-west"] = {-11.5, 0},
            ["-hx-east"] = {11.5, 0},
            ["-hx-north"] = {0, -11},
            ["-hx-south"] = {0, 11}
        },
        ["rf-m-reactor-icf-hx-west"] = {
            [""] = {11.5, 0},
            ["-hx-east"] = {23, 0},
            ["-hx-north"] = {11.5, -11.5},
            ["-hx-south"] = {11.5, 11.5}
        },
        ["rf-m-reactor-icf-hx-east"] = {
            [""] = {-11.5, 0},
            ["-hx-west"] = {-23, 0},
            ["-hx-north"] = {-11.5, -11.5},
            ["-hx-south"] = {-11.5, 11.5}
        },
        ["rf-m-reactor-icf-hx-north"] = {
            [""] = {0, 11.5},
            ["-hx-east"] = {11.5, 11.5},
            ["-hx-west"] = {-11.5, 11.5},
            ["-hx-south"] = {0, 23}
        },
        ["rf-m-reactor-icf-hx-south"] = {
            [""] = {0, -11.5},
            ["-hx-east"] = {11.5, -11.5},
            ["-hx-west"] = {-11.5, -11.5},
            ["-hx-north"] = {0, -23}
        }
    },
    icf_reactors = {["rf-m-reactor-icf"] = true, ["rf-m-reactor-icf-aneutronic"] = true},
    reactors = {["rf-m-reactor"] = true, ["rf-m-reactor-aneutronic"] = true}
}

rfpower.icf_offsets_aneutronic = {
    ["rf-m-reactor-icf-aneutronic"] = rfpower.icf_offsets["rf-m-reactor-icf"],
    ["rf-m-reactor-icf-aneutronic-hx-west"] = rfpower.icf_offsets["rf-m-reactor-icf-hx-west"],
    ["rf-m-reactor-icf-aneutronic-hx-east"] = rfpower.icf_offsets["rf-m-reactor-icf-hx-east"],
    ["rf-m-reactor-icf-aneutronic-hx-north"] = rfpower.icf_offsets["rf-m-reactor-icf-hx-north"],
    ["rf-m-reactor-icf-aneutronic-hx-south"] = rfpower.icf_offsets["rf-m-reactor-icf-hx-south"]
}
-- #endregion --

-- #region INIT MOD INTERFACE --
local function get_nested_value(...)
    local current = rfpower
    for _,k in pairs{...} do current = current[k] end
    return current
end

remote.add_interface("rfpower", { --make sure to call both on_init and on_load
    add_values = function(values, ...) --ex. add_values({["rf-m-reactor"] = true, ["rf-m-reactor-aneutronic"] = true}, "reactors")
        local current = get_nested_value(...)
        for k,v in pairs(values) do current[k] = v end --let's hope that lua adds it to the actual table rather than the local
    end,
    remove_value = function(value, ...)
        local current = rfpower
        for _,k in pairs{...} do
            if type(current[k] == "table") then current = current[k] --tables should get copied by reference
            else current[k] = nil return end --removes value
        end
        current = nil --removes table, again hopefully the actual one in rfpower
    end,
    return_value = function(...) return get_nested_value(...) end,
    call_func = function(func, ...) return rfpower[func](...) end,
    copy_all = function(key) return rfpower end,
    overwrite_all = function(overwrite) rfpower = overwrite end --I don't recommend using this, but it might be useful in some cases
})
-- #endregion --

-- #region SCRIPT IMPORTS --
-- control stage doesn't have any nested requires, everything's here
local plasma_anim_func   = require("scripts.gui")           -- creates the GUI when a player opens a reactor/heater, returned func animates the plasma visualization
local reactor_logic_func = require("scripts.reactor-logic") -- simulates the fusion reactions/heating/etc of reactors
require("scripts.entity-management")                        -- manages reactor/heater networks, ICF reactors, etc.
require("scripts.gui-events")                               -- handles GUI sliders, switches, buttons etc.
-- #endregion --

-- #region REGISTER EVENT HANDLERS --
-- make sure you don't handle an event twice, look in ./scripts/ for an EVENT HANDLERS #region
script.on_event(defines.events.on_tick, function(event)
    try_catch(function()
        for unit_number, network in pairs(global.networks) do
            plasma_anim_func(network, unit_number, event.tick)
            reactor_logic_func(network, event.tick)
        end
    end)
end)

local function remote_calls() --has to be called twice for reasons long forgotten
    remote.call("rfcore", "add_values", { --adds these to RFC's script
        "rf-fusion-results",
        "rf-tritiated-fusion-results",
        "rf-aneutronic-fusion-results",
        "rf-laser-photons"
    }, "fluids_forbidden")
end
script.on_init(function()
    remote_calls()
    global.networks = {}
    global.networks_len = 0 --lua's # computes the result, this is more performant
    global.entities = {} --only stores which networks reactors/heaters are connected to
end)
script.on_load(remote_calls)
-- #endregion --