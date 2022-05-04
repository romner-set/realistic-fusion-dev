-- #region NETWORK FUNCTIONS --

local fcr_processed
local current_network
-- finds entities in a pipe network, if any of them are a heater or reactor returns true & puts the network index in current_network
-- it might cause a stack overflow for huge pipe networks, but let's hope that won't an issue?
local function find_connections_recursive(entity)
    for _,e in pairs(entity.neighbours) do
        for _,_e in pairs(e) do
            if _e.name:sub(1,5) == "rf-m-" then
                local ok = true
                for _,k in ipairs(fcr_processed) do --make sure to not check an entity twice
                    if _e.unit_number == k then ok = false; break end
                end

                if ok then
                    table.insert(fcr_processed, _e.unit_number)
                    if _e.name == "rf-m-heater" or _e.name == "rf-m-reactor" then --TODO aneutronic
                        --if global.entities[_e.unit_number] then --connect to existing network
                            current_network = global.entities[_e.unit_number]
                            return true --recursively exit
                        --end
                    end
                    --game.print(serpent.line{_e.name, _e.unit_number})
                    --log(serpent.line{_e.name, _e.unit_number})
                    if find_connections_recursive(_e) then --found a heater/reactor in an existing network, no need to check for anything else
                        return true --recursively exit
                    end
                end
            end
        end
    end
    return false --couldn't find exisiting network, create a new one
end

local function add_to_network(network, entity)
    if entity.name == "rf-m-heater" then network.heaters[entity.unit_number] = entity
    elseif entity.name == "rf-m-reactor" then network.reactors[entity.unit_number] = entity end --TODO aneutronic
end

-- constructs a network from reactors and/or heaters
local function new_network(...)
    local network = {
        reactors = {},
        heaters = {},
        reactor_count = 1,
        heater_count = 0,

        plasma_heating = 0,
        divertor_strength = 0,
        magnetic_field_strength = 0,
        plasma_flow_speed = 20,

        fusion_rate = 0, --TODO? calculated
        energy_input = 0,
        energy_output = 0,
        total_plasma = 0.5,
        plasma_density = 0.5,
        plasma_temperature = 0,
        wall_integrity = 100,

        systems = "left",
        heating = "left",
        magnetic_field = "left",

        deuterium_input = 0,
        deuterium_removal = 0,
        tritium_input = 0,
        tritium_removal = 0,
        helium_3_input = 0,
        helium_3_removal = 0,

        deuterium = 0,
        tritium = 0,
        helium_3 = 0,
        helium_4 = 0,

        lithium_stored = 0,

        recipe = nil,
        controller = nil,

        guis = {sliders = {}, bars = {}, switches = {}, choice_elems = {}, sprites = {}, sprite_idxs = {}},

        cached_reactivity = {}, --indexes in datasets
    }

    for k,_ in pairs(rfp_datasets) do network.cached_reactivity[k] = 5 end

    for _,v in pairs{...} do add_to_network(network, v) end

    return network
end

local function register_entity(entity)
    fcr_processed = {entity.unit_number}
    if find_connections_recursive(entity) then --connect to existing network
        add_to_network(global.networks[current_network], entity)
        global.entities[entity.unit_number] = global.networks_len
        game.print(
            "reactor added to network #"..current_network
            .." ("..table_size(global.networks[current_network].reactors).." reactors, " --https://lua-api.factorio.com/latest/Libraries.html
            ..table_size(global.networks[current_network].heaters).." heaters)"
        )
    else --create new network
        global.networks_len = global.networks_len + 1
        global.entities[entity.unit_number] = global.networks_len
        global.networks[global.networks_len] = new_network(entity)
        game.print("reactor added to new network #"..global.networks_len)
    end

    --log(serpent.block{len = global.networks_len, e = global.entities, n = global.networks})
    --[[for k,v in pairs(global.networks[global.networks_len].reactors) do
        log(k..": "..v.name)
        game.print(k..": "..v.name)
    end]]
end
-- #endregion --

-- #region EVENT HANDLERS --

 -- #region ON REACTOR BUILT --
script.on_event({defines.events.script_raised_built, defines.events.on_robot_built_entity, defines.events.on_built_entity}, function(event)
    try_catch(function()
        if event.created_entity.name == "rf-m-heater" or rfpower.reactors[event.created_entity.name] then --TODO
            register_entity(event.created_entity)
            event.created_entity.active = false
            --[[local name = "rf-m-reactor-controller"
            if event.created_entity.name == "rf-m-reactor-aneutronic" then name = name.."-aneutronic" end

            event.created_entity.surface.create_entity{name=name, position={event.created_entity.position.x, event.created_entity.position.y}, force=event.created_entity.force}]]
        elseif rfpower.icf_reactors[event.created_entity.name] then
            local x,y = event.created_entity.position.x, event.created_entity.position.y

            --[[
            local name = "rf-m-reactor-controller-icf"
            if event.created_entity.name == "rf-m-reactor-icf-aneutronic" then name = name.."-aneutronic" end
            event.created_entity.surface.create_entity{name=name, position={x,y}, force=event.created_entity.force}
            --]]

            local can_place = true
            local positions = {
                ["west"] = {x - 11.5, y},
                ["east"] = {x + 11.5, y},
                ["north"] = {x, y - 11},
                ["south"] = {x, y + 11}
            }
            local bounding_boxes = {
                ["west"] = {{x-11.5-2.5, y-3.5}, {x-11.5+2.5, y+3.5}},
                ["east"] = {{x+11.5-2.5, y-3.5}, {x+11.5+2.5, y+3.5}},
                ["north"] = {{x-3, y-2-11}, {x+3, y+2-11}},
                ["south"] = {{x-3, y-2+11}, {x+3, y+2+11}}
            }

            for dir,pos in pairs(positions) do if not event.created_entity.surface.can_place_entity{
                name = event.created_entity.name.."-hx-"..dir,
                position = pos,
                build_check_type = defines.build_check_type.manual
            } then
                can_place = false
                event.created_entity.surface.create_entity{
                    name = "flying-text",
                    position = event.created_entity.position,
                    force = event.created_entity.force,
                    text = {"cant-build-reason.entity-in-the-way", event.created_entity.surface.find_entities(bounding_boxes[dir])[1].localised_name}
                }
            end end

            if can_place then
                for dir,pos in pairs(positions) do event.created_entity.surface.create_entity{
                    name=event.created_entity.name.."-hx-"..dir, position=pos, force=event.created_entity.force
                } end
            else
                if game.players[event.player_index] then
                    game.players[event.player_index].get_main_inventory().insert{name=event.created_entity.name}
                    event.created_entity.destroy()
                else
                    event.created_entity.mine()
                end
            end
        end
    end)
end)
 -- #endregion --

 -- #region ON REACTOR DESTROYED --
script.on_event({
    defines.events.on_robot_mined_entity, defines.events.on_player_mined_entity,
    defines.events.script_raised_destroy, defines.events.on_entity_destroyed
}, function(event)
    try_catch(function()
        if rfpower.icf_offsets[event.entity.name] then
            for k,v in pairs(rfpower.icf_offsets[event.entity.name]) do
                local entity = event.entity.surface.find_entity("rf-m-reactor-icf"..k, {event.entity.position.x + v[1], event.entity.position.y + v[2]})
                if entity ~= nil then entity.destroy() end
            end
        elseif rfpower.icf_offsets_aneutronic[event.entity.name] then
            for k,v in pairs(rfpower.icf_offsets_aneutronic[event.entity.name]) do
                local entity = event.entity.surface.find_entity("rf-m-reactor-icf-aneutronic"..k, {event.entity.position.x + v[1], event.entity.position.y + v[2]})
                if entity ~= nil then entity.destroy() end
            end
        end
    end)
end)
 -- #endregion --