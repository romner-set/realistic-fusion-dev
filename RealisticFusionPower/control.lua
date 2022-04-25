require("__RealisticFusionCore__/try-catch")

-- #region INIT GLOBAL(-ISH) TABLE --
rfpower = {
    icf_offsets = {
        ["rf-reactor-icf"] = {
            ["-hx-west"] = {-11.5, 0},
            ["-hx-east"] = {11.5, 0},
            ["-hx-north"] = {0, -11},
            ["-hx-south"] = {0, 11}
        },
        ["rf-reactor-icf-hx-west"] = {
            [""] = {11.5, 0},
            ["-hx-east"] = {23, 0},
            ["-hx-north"] = {11.5, -11.5},
            ["-hx-south"] = {11.5, 11.5}
        },
        ["rf-reactor-icf-hx-east"] = {
            [""] = {-11.5, 0},
            ["-hx-west"] = {-23, 0},
            ["-hx-north"] = {-11.5, -11.5},
            ["-hx-south"] = {-11.5, 11.5}
        },
        ["rf-reactor-icf-hx-north"] = {
            [""] = {0, 11.5},
            ["-hx-east"] = {11.5, 11.5},
            ["-hx-west"] = {-11.5, 11.5},
            ["-hx-south"] = {0, 23}
        },
        ["rf-reactor-icf-hx-south"] = {
            [""] = {0, -11.5},
            ["-hx-east"] = {11.5, -11.5},
            ["-hx-west"] = {-11.5, -11.5},
            ["-hx-north"] = {0, -23}
        }
    },
    icf_reactors = {["rf-reactor-icf"] = true, ["rf-reactor-icf-aneutronic"] = true},
    reactors = {["rf-reactor"] = true, ["rf-reactor-aneutronic"] = true}
}

rfpower.icf_offsets_aneutronic = {
    ["rf-reactor-icf-aneutronic"] = rfpower.icf_offsets["rf-reactor-icf"],
    ["rf-reactor-icf-aneutronic-hx-west"] = rfpower.icf_offsets["rf-reactor-icf-hx-west"],
    ["rf-reactor-icf-aneutronic-hx-east"] = rfpower.icf_offsets["rf-reactor-icf-hx-east"],
    ["rf-reactor-icf-aneutronic-hx-north"] = rfpower.icf_offsets["rf-reactor-icf-hx-north"],
    ["rf-reactor-icf-aneutronic-hx-south"] = rfpower.icf_offsets["rf-reactor-icf-hx-south"]
}

function rfpower.read_file(file)
    local f = io.open(file, "rb")
    local content = f:read("*all")
    f:close()
    return content
end
-- #endregion --

-- #region INIT MOD INTERFACE --
remote.add_interface("rfpower", { --make sure to call both on_init and on_load
    add_to_list = function(key, values) for k,v in pairs(values) do rfpower[key][k] = v end end,
    remove_from_list = function(key, value) rfpower[key][value] = nil end,
    return_list = function(key) return rfpower[key] end,
    return_value = function(key, value) return rfpower[key][value] end,
    return_nested_value = function(key, value, _value) return rfpower[key][value][_value] end,
})
-- #endregion --

-- #region SCRIPT IMPORTS --
-- only here for control stage, no nested requires
require("scripts.entity-placement")
require("scripts.gui")                                      -- creates the GUI when a player opens a reactor
local plasma_anim_func   = require("scripts.gui-events")    -- animates the GUI's plasma visualization
local reactor_logic_func = require("scripts.reactor-logic") -- simulates the fusion reactions/heating/etc of reactors
-- #endregion --

-- #region REGISTER EVENT HANDLERS --
-- make sure you don't handle an event twice, search in ./scripts for an EVENT HANDLERS section

script.on_event(defines.events.on_tick, function(event)
    try_catch(function()
        for unit_number, reactor in pairs(global.reactors) do
            plasma_anim_func(reactor, unit_number, event.tick)
            reactor_logic_func(reactor, event.tick)
        end
    end)
end)

local function remote_calls() --has to be called twice for reasons long forgotten
    remote.call("rfcore", "add_to_list", "fluids_forbidden", { --adds these to RFC's script
        "rf-fusion-results",
        "rf-tritiated-fusion-results",
        "rf-aneutronic-fusion-results",
        "rf-laser-photons"
    })
end
script.on_init(function()
    remote_calls()
    --global.reactors = {}
    global.reactors = {}
end)
script.on_load(remote_calls)
-- #endregion --