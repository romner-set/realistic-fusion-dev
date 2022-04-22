require("__RealisticFusionCore__/try-catch")

-- Init global(-ish) table --
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


remote.add_interface("rfpower", { --make sure to call both on_init and on_load
    add_to_list = function(key, values) for k,v in pairs(values) do rfpower[key][k] = v end end,
    remove_from_list = function(key, value) rfpower[key][value] = nil end,
    return_list = function(key) return rfpower[key] end,
    return_value = function(key, value) return rfpower[key][value] end,
    return_nested_value = function(key, value, _value) return rfpower[key][value][_value] end,
})

require("scripts.entity-placement")
require("scripts.gui")

local function remote_calls()
    remote.call("rfcore", "add_to_list", "fluids_forbidden", { --add these to RFC's script
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