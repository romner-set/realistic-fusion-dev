local function print_log(str) game.print(str); log(str) end

-- #region NETWORK FUNCTIONS --

-- #region FIND_CONNECTIONS_RECURSIVE --
-- having all of these global instead of recursively passing all of them should have better performance and prevent passing by value
-- calling it properly is much easier with the helper rfpower.find_connections() function, everything should be documented well enough nonetheless
rfpower.fcr_mode = 0               -- 0 == looks for a reactor/heater in a pipe system, returns the first it finds & puts its network index in rfpower.current_network
                                   --      if it doesn't find anything, returns false
                                   -- 1 == looks for and outputs all reactors/heaters in a pipe system, if it doesn't find any returns false
                                   -- 2 == same as 1, except that it returns with 0 if it runs into an entity in the rfpower.fcr_forbidden table
                                   --      note that if it returned with 0 it likely didn't put all entities in a network to rfpower.fcr_output
rfpower.fcr_output = {}            -- table for mode 1 & 2
rfpower.fcr_forbidden = {}         -- table for mode 2
rfpower.fcr_processed = {}         -- table with already searched entities, should have starting entity's unit number at first
rfpower.fcr_processed_size = 0     -- faster than #rfpower.fcr_processed or table_size(rfpower.fcr_processed)
-- it might cause a stack overflow for huge pipe networks (with >~16000 pipes according to the internet), but let's hope that won't be an issue?
--TODO?: process straight sections only once instead of processing every pipe in them
function rfpower.find_connections_recursive(entity)
    for _,e in pairs(entity.neighbours) do
        for _,_e in pairs(e) do
            if _e.name:sub(1,5) == "rf-m-" then
                --print_log(serpent.block(rfpower.fcr_processed))
                local un = _e.unit_number
                for i=rfpower.fcr_processed_size,1,-1 do --make sure not to check an entity twice
                    if un == rfpower.fcr_processed[i] then goto continue end
                end
                --print_log(un)

                rfpower.fcr_processed_size = rfpower.fcr_processed_size+1
                rfpower.fcr_processed[rfpower.fcr_processed_size] = un
                if _e.name == "rf-m-heater" or _e.name == "rf-m-reactor" then --TODO aneutronic
                    if rfpower.fcr_mode == 2 then
                        for _,v in pairs(rfpower.fcr_forbidden) do
                            for _,_v in pairs(v) do
                                if _v.unit_number == un then return 0 end
                            end
                        end
                    elseif rfpower.fcr_mode == 0 then
                        rfpower.current_network = global.entities[un]
                        --print_log(un)
                        return _e
                    end
                    --print_log(serpent.line{_e.name, _e.unit_number})
                    table.insert(rfpower.fcr_output, _e)
                end
                --print_log(serpent.line{_e.name, _e.unit_number})
                local r = rfpower.find_connections_recursive(_e)
                if r and r ~= true then --found a heater/reactor in an existing network, no need to check for anything else
                    return r --recursively exit
                end
            end

            ::continue::
        end
    end
    if rfpower.fcr_mode ~= 0 and #rfpower.fcr_output > 0 then return true else return false end
end
-- #endregion --

-- function to make calling the above easier
function rfpower.find_connections(entity, processed, output_all, forbidden)
    if processed ~= 0 then --0 == keep from last call
        rfpower.fcr_processed = processed or {entity.unit_number}
        rfpower.fcr_processed_size = table_size(rfpower.fcr_processed)
    end
    rfpower.fcr_output = {}
    if output_all then
        if forbidden ~= nil then rfpower.fcr_mode = 2
        else rfpower.fcr_mode = 1 end
    else rfpower.fcr_mode = 0 end
    rfpower.fcr_forbidden = forbidden
    --print_log(serpent.line{rfpower.fcr_mode, output_all})
    local r = rfpower.find_connections_recursive(entity)
    if rfpower.fcr_mode == 1 then return rfpower.fcr_output[1] or false else return r end
end

function rfpower.add_to_network(network, entity)
    if entity.name == "rf-m-heater" then
        network.heaters[entity.unit_number] = entity
        --network.heater_count = network.heater_count + 1
        rfpower.update_heater_power(network)
        network.heater_override[entity.unit_number] = "left"
    elseif entity.name == "rf-m-reactor" then
        network.reactors[entity.unit_number] = entity
        --network.reactor_count = network.reactor_count + 1
        network.reactor_volume = rfpower.const.reactor_volume*table_size(network.reactors)
    end --TODO elseif aneutronic
end

-- constructs a network from reactors and/or heaters
function rfpower.new_network(entities)
    local network = {
        reactors = {},
        reactor_volume = 0,

        heaters = {},
        --heater_count = 0,
        heater_power = 0,

        plasma_heating = 0,
        divertor_strength = 0,
        magnetic_field_strength = 0,
        plasma_flow_speed = 20,

        fusion_rate = 0,
        energy_input = 0,
        energy_output = 0,
        total_plasma = 0.5,
        plasma_volume = 0,
        plasma_temperature = 0,
        wall_integrity = 100,

        systems = "left",
        heating = "left",
        magnetic_field = "left",
        heater_override = {},
        heater_override_slider = {},

        deuterium_input = 0,
        deuterium_removal = 0,
        deuterium_usage = 0,
        tritium_input = 0,
        tritium_removal = 0,
        tritium_usage = 0,
        helium_3_input = 0,
        helium_3_removal = 0,
        helium_3_usage = 0,
        helium_4_input = 0,
        helium_4_removal = 0,

        deuterium = 0,
        tritium = 0,
        helium_3 = 0,
        helium_4 = 0,

        lithium_stored = 0,

        recipe = nil,
        controller = nil,

        guis = {gui_ids = {}, sliders = {}, bars = {}, switches = {}, checkboxes = {}, choice_elems = {}, sprites = {}, sprite_idxs = {}},

        cached_reactivity = {}, --indexes in rfp_datasets
    }

    for k,_ in pairs(rfp_datasets) do network.cached_reactivity[k] = 5 end

    for _,v in pairs(entities) do rfpower.add_to_network(network, v) end

    return network
end
-- #endregion --

-- #region EVENT HANDLERS --

 -- #region ON BUILT --
function rfpower.copy_gui_handles(network_old, network_new)
    for elem_type, players in pairs(network_old.guis) do
        for player_id, elems in pairs(players) do
            for elem_name, elem in pairs(players) do
                if  network_new.guis[elem_type]
                and network_new.guis[elem_type][player_id]
                and network_new.guis[elem_type][player_id][elem_name] then
                    network_new.guis[elem_type][player_id][elem_name] = elem
                end
            end
        end
    end
end
script.on_event({defines.events.script_raised_built, defines.events.on_robot_built_entity, defines.events.on_built_entity}, function(event)
    try_catch(function()
        if rfpower.icf_reactors[event.created_entity.name] then
            -- #region ADD HEAT EXCHANGERS/DECS TO ICF REACTORS --
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
            -- #endregion --
        elseif event.created_entity.name:sub(1,5) == "rf-m-" then
            -- #region SPAWN EEI FOR HEATERS --
            if event.created_entity.name == "rf-m-heater" then
                event.created_entity.surface.create_entity{name="rf-heater-eei", position=event.created_entity.position, force=event.created_entity.force}
            end
            -- #endregion --

            -- #region UPDATE NETWORKS ON ENTITY PLACEMENT --
            local found = {}
            local found_len = 0
            rfpower.fcr_processed = {event.created_entity.unit_number}
            rfpower.fcr_processed_len = 1
            for _,e in pairs(event.created_entity.neighbours) do
                for _,_e in pairs(e) do
                    if _e.name:sub(1,5) == "rf-m-" then
                        --rfpower.fcr_processed_len = rfpower.fcr_processed_len + 1
                        --rfpower.fcr_processed[rfpower.fcr_processed_len] = _e.unit_number
                        if rfpower.find_connections(event.created_entity, 0) then
                            found_len = found_len+1
                            found[found_len] = rfpower.current_network
                        end
                    end
                end
            end

            --print_log(serpent.block(found))
            if found_len > 0 then
                --found another heater/reactor in pipe system, add entity to its network
                local first = found[1]
            
                if found_len > 1 then
                    for i=2,found_len do
                        local network_id = found[i]
                        for j=1,found_len do --prevent merging a network with itself
                            if found[j] == network_id and i ~= j then
                                goto continue
                            end
                        end

                        rfpower.copy_gui_handles(global.networks[network_id], global.networks[first]) --TODO TEST IN MULTIPLAYER

                        for un,r in pairs(global.networks[network_id].reactors) do
                            global.entities[un] = first
                            rfpower.add_to_network(global.networks[first], r)
                        end
                        for un,h in pairs(global.networks[network_id].heaters) do
                            global.entities[un] = first
                            rfpower.add_to_network(global.networks[first], h)

                            if global.networks[network_id].heater_override[un] == "left" then --update heater overrides
                                global.networks[first].heater_override_slider[un] = global.networks[first].plasma_heating
                                rfpower.update_heater_power(global.networks[first])

                                for _,sliders in pairs(global.networks[first].guis.sliders) do
                                    for _name,slider in pairs(sliders) do
                                        if slider.name == "rf-heater-override-slider" then
                                            slider.slider_value = global.networks[first].plasma_heating
                                            slider.parent["rf-".._name.."-value-frame"]["rf-".._name.."-value"].caption = string.sub(global.networks[first].plasma_heating.."%", 1,3)
                                        end
                                    end
                                end
                            else global.networks[first].heater_override[un] = "right" end
                        end

                        print_log("merged network #"..network_id.." to network #"..first
                            .." ("..table_size(global.networks[first].reactors).." reactors at "..global.networks[first].reactor_volume.."m^3, "
                            ..table_size(global.networks[first].heaters).." heaters at "..global.networks[first].heater_power/1e6 .. "MW ("
                            ..global.networks[first].heater_power/rfpower.const.heater_capacity*100 .."%))"
                        )
                    
                        global.networks[network_id] = nil

                        ::continue::
                    end
                end

                if event.created_entity.name == "rf-m-heater" or rfpower.reactors[event.created_entity.name] then
                    rfpower.add_to_network(global.networks[first], event.created_entity)
                    global.entities[event.created_entity.unit_number] = first
                    
                    if event.created_entity.name == "rf-m-heater" then --update override
                        global.networks[first].heater_override_slider[event.created_entity.unit_number] = global.networks[first].plasma_heating
                        rfpower.update_heater_power(global.networks[first])
                    end

                    print_log(
                        event.created_entity.name:sub(6).." added to network #"..first
                        .." ("..table_size(global.networks[first].reactors).." reactors at "..global.networks[first].reactor_volume.."m^3, "
                        ..table_size(global.networks[first].heaters).." heaters at "..global.networks[first].heater_power/1e6 .. "MW)"
                    )
                end
            elseif event.created_entity.name == "rf-m-heater" or rfpower.reactors[event.created_entity.name] then
                --nothing found in pipe system, create new network
                global.networks_len = global.networks_len + 1
                global.entities[event.created_entity.unit_number] = global.networks_len
                global.networks[global.networks_len] = rfpower.new_network{event.created_entity}
                print_log(event.created_entity.name:sub(6).." added to new network #"..global.networks_len)
                event.created_entity.active = false
            end

            --log(serpent.block{len = global.networks_len, e = global.entities, n = global.networks})
            --[[for k,v in pairs(global.networks[global.networks_len].reactors) do
                log(k..": "..v.name)
                print_log(k..": "..v.name)
            end]]

            --[[local name = "rf-m-reactor-controller"
            if event.created_entity.name == "rf-m-reactor-aneutronic" then name = name.."-aneutronic" end

            event.created_entity.surface.create_entity{name=name, position={event.created_entity.position.x, event.created_entity.position.y}, force=event.created_entity.force}]]
            -- #endregion --
        end
    end)
end)
 -- #endregion --

 -- #region ON DESTROYED --
script.on_event({
    defines.events.on_robot_mined_entity, defines.events.on_player_mined_entity,
    defines.events.script_raised_destroy, defines.events.on_entity_destroyed
}, function(event)
    try_catch(function()
        -- #region REMOVE HXS/DECS FROM ICF REACTORS --
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
        -- #endregion --
        elseif event.entity.name:sub(1,5) == "rf-m-" then
            -- #region DELETE EEI FOR HEATERS --
            if event.entity.name == "rf-m-heater" then
                local entity = event.entity.surface.find_entity("rf-heater-eei", {event.entity.position.x+0.5,event.entity.position.y+0.5})
                if entity ~= nil then entity.destroy() end
            end
            -- #endregion --

            -- #region REMOVE HEATER/REACTOR FROM + DELETE NETWORK --
            if event.entity.name == "rf-m-heater" or rfpower.reactors[event.entity.name] then
                event.entity.active = false

                local un = event.entity.unit_number
                local network_id = global.entities[un]

                global.networks[network_id][event.entity.name:sub(6).."s"][un] = nil
                global.entities[un] = nil

                if event.entity.name == "rf-m-heater" then
                    --global.networks[network_id].heater_count = global.networks[network_id].heater_count - 1
                    rfpower.update_heater_power(global.networks[network_id])
                else
                    global.networks[network_id].reactor_volume = rfpower.reactor_volume*table_size(global.networks[network_id].reactors)
                end

                print_log(event.entity.name:sub(6).." removed from network #"..network_id
                    .." ("..table_size(global.networks[network_id].reactors).." reactors at "..global.networks[network_id].reactor_volume.."m^3, "
                    ..table_size(global.networks[network_id].heaters).." heaters at "..global.networks[network_id].heater_power/1e6 .. "MW ("
                    ..global.networks[network_id].heater_power/rfpower.const.heater_capacity*100 .."%))"
                )
                --print_log(serpent.line(global.networks[network_id].heaters))
                if table_size(global.networks[network_id].reactors) == 0 and table_size(global.networks[network_id].heaters) == 0 then --delete network
                    global.networks[network_id] = nil
                    print_log("deleted network #"..network_id)
                end
            end
            -- #endregion ---
            -- #region SPLIT NETWORKS ON ENTITY DELETION --
            local found = {}
            --rfpower.fcr_processed = {event.entity.unit_number}
            --rfpower.fcr_processed_len = 1
            for _,e in pairs(event.entity.neighbours) do
                for _,_e in pairs(e) do
                    if _e.name:sub(1,5) == "rf-m-" then
                        --rfpower.fcr_processed_len = rfpower.fcr_processed_len + 1
                        --rfpower.fcr_processed[rfpower.fcr_processed_len] = _e.unit_number
                        --print_log(serpent.block{event.entity.unit_number, _e.unit_number})
                        local r = rfpower.find_connections(_e, {event.entity.unit_number, _e.unit_number}, true, found)
                        if r ~= false and r ~= 0 then table.insert(found, rfpower.fcr_output) end
                        --print_log(r)
                    end
                end
            end
            --print_log(serpent.block(found))
            if #found > 1 then
                local network_id = global.entities[found[1][1].unit_number]

                for _,n in pairs(found) do
                    global.networks_len = global.networks_len + 1
                    global.networks[global.networks_len] = rfpower.new_network(n)

                    for _,e in pairs(n) do global.entities[e.unit_number] = global.networks_len end

                    print_log("created new network #"..global.networks_len.." from #"..network_id
                        .." ("..table_size(global.networks[network_id].reactors).." reactors at "..global.networks[network_id].reactor_volume.."m^3, "
                        ..table_size(global.networks[network_id].heaters).." heaters at "..global.networks[network_id].heater_power/1e6 .. "MW ("
                        ..global.networks[network_id].heater_power/rfpower.const.heater_capacity*100 .."%))"
                    )
                end
                
                global.networks[network_id] = nil
                print_log("deleted network #"..network_id)
            end
            -- #endregion -
        end
    end)
end)
 -- #endregion --
