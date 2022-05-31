-- #region CONSTANTS & FUNCTIONS --
require("try-catch")
rfcore = {
    fluids_am = {},
    fluids_plasma = {},
    fluids_forbidden = {},
    fluid_filter_prototypes = {}
}

for _,v in ipairs{"rf-deuterium-plasma", "rf-d-t-plasma", "rf-helium-3-plasma", "rf-d-he3-plasma"} do rfcore.fluids_plasma[v] = true end
--for _,v in ipairs{"rf-high-energy-positrons", "rf-high-energy-antiprotons", "rf-antiprotons", "rf-positrons", "rf-antihydrogen"} do fluids_am[v] = true end
for _,v in ipairs{"pipe", "storage-tank", "pipe-to-ground", "pump"} do rfcore.fluid_filter_prototypes[v] = true end
-- #endregion --

-- #region INIT MOD INTERFACE --
local function get_nested_value(...)
    local current = rfcore
    for _,k in pairs{...} do current = current[k] end
    return current
end

remote.add_interface("rfcore", { --make sure to call both on_init and on_load
    add_values = function(values, ...) --ex. add_values({["rf-deuterium-plasma"] = true, ["rf-tritium-plasma"] = true}, "fluids_plasma")
        local current = get_nested_value(...)
        for k,v in pairs(values) do current[k] = v end --let's hope that lua adds it to the actual table rather than the local
    end,
    remove_value = function(value, ...)
        local current = rfcore
        for _,k in pairs{...} do
            if type(current[k] == "table") then current = current[k] --tables should get copied by reference
            else current[k] = nil return end --removes value
        end
        current = nil --removes table, again hopefully the actual one in rfcore
    end,
    return_value = function(...) return get_nested_value(...) end,
    call_func = function(func, ...) return rfcore[func](...) end,
    copy_all = function(key) return rfcore end,
    overwrite_all = function(overwrite) rfcore = overwrite end --I don't recommend using this, but it might be useful in some cases
})
-- #endregion --

-- #region ON EVENT --
script.on_event({defines.events.script_raised_built, defines.events.on_robot_built_entity, defines.events.on_built_entity}, function(event) if not global.stop then
    try_catch(function()
        if global.entities and rfcore.fluid_filter_prototypes[event.created_entity.type] and string.sub(event.created_entity.name, 1, 3) ~= "rf-" then
            global.entities[event.created_entity.unit_number] = event.created_entity
        end
    end)

    --print_table(rfcore.fluids_am)
    --print_table(rfcore.fluids_plasma)
    --print_table(rfcore.fluids_forbidden)
end end)

script.on_event({defines.events.on_entity_died, defines.events.on_robot_pre_mined, defines.events.on_pre_player_mined_item}, function(event) if not global.stop then
    try_catch(function()
        if global.entities then table.remove(global.entities, event.entity.unit_number) end
    end)
end end)

script.on_event({
    defines.events.on_robot_mined_entity, defines.events.on_player_mined_entity,
    defines.events.script_raised_destroy, defines.events.on_entity_destroyed
}, function(event) try_catch(function()
    if event.setting == "rf-operations-per-tick" then
        if settings.global["rf-operations-per-tick"].value == 0 then global.stop = true else global.stop = false end
    end
end) end)
-- #endregion --

-- #region INIT --
script.on_init(function() try_catch(function()
        global.k = 0
        global.entities = {}
        if settings.global["rf-operations-per-tick"].value == 0 then global.stop = true else
            global.stop = false

            for _,surface in pairs(game.surfaces) do
                for prototype,_ in pairs(rfcore.fluid_filter_prototypes) do
                    for _k,v in pairs(surface.find_entities_filtered{type = prototype}) do global.entities[_k] = v end
                end
            end
        end
    end)
end)
-- #endregion --

-- #region ON TICK --
script.on_event(defines.events.on_tick, function(_) if not global.stop then
    try_catch(function()
        if global.entities and next(global.entities) then
            for _=1, settings.global["rf-operations-per-tick"].value do
                if next(global.entities) ~= nil then
                    if global.k == 0 or next(global.entities, global.k) == nil then global.k,_ = next(global.entities, nil) else global.k,_ = next(global.entities, global.k) end

                    if global.entities[global.k] and global.entities[global.k].valid then
                        --print_table(global.entities[global.k].get_fluid_contents())
                        for _k,_ in pairs(global.entities[global.k].get_fluid_contents()) do
                            if rfcore.fluids_am[_k] then
                                global.entities[global.k].surface.create_entity{
                                    name = "rf-antimatter-pipe-explosion-projectile",
                                    position = global.entities[global.k].position,
                                    force = global.entities[global.k].force,
                                    target = global.entities[global.k],
                                    speed = 0.0
                                }
                            elseif rfcore.fluids_plasma[_k] then
                                global.entities[global.k].die(global.entities[global.k].force)
                                table.remove(global.entities, global.k)
                            elseif rfcore.fluids_forbidden[_k] then
                                global.entities[global.k].clear_fluid_inside()
                            end
                        end
                    end
                end
            end
        end
    end)
end end)
-- #endregion --