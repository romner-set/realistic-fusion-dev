-- #region REGISTER REACTOR FUNCTION --

local function register_new_reactor(unit_number, entity)
    global.reactors[unit_number] = {
        entity = entity,

        plasma_heating = 0,
        divertor_strength = 0,
        magnetic_field_strength = 0,
        plasma_flow_speed = 20, --TODO 0

        fusion_rate = 0, --? calculated
        energy_input = 0,
        energy_output = 0,
        total_plasma = 0.5,
        plasma_density = 0.5,
        plasma_temperature = 0,
        wall_integrity = 100,

        systems = "left", --TODO "left"
        heating = "left", --TODO "left"
        magnetic_field = "left", --TODO "left"

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

        guis = {sliders = {}, bars = {}, switches = {}, choice_elems = {}, sprites = {}, sprite_idxs = {}}
    }
end
-- #endregion --

-- #region EVENT HANDLERS --

-- #region ON REACTOR BUILT --
script.on_event({defines.events.script_raised_built, defines.events.on_robot_built_entity, defines.events.on_built_entity}, function(event)
    try_catch(function()
        if rfpower.reactors[event.created_entity.name] then --TODO
            register_new_reactor(event.created_entity.unit_number, event.created_entity.prototype)
            event.created_entity.active = false
            --[[local name = "rf-reactor-controller"
            if event.created_entity.name == "rf-reactor-aneutronic" then name = name.."-aneutronic" end

            event.created_entity.surface.create_entity{name=name, position={event.created_entity.position.x, event.created_entity.position.y}, force=event.created_entity.force}]]
        elseif rfpower.icf_reactors[event.created_entity.name] then
            local x,y = event.created_entity.position.x, event.created_entity.position.y

            --[[
            local name = "rf-reactor-controller-icf"
            if event.created_entity.name == "rf-reactor-icf-aneutronic" then name = name.."-aneutronic" end
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
                local entity = event.entity.surface.find_entity("rf-reactor-icf"..k, {event.entity.position.x + v[1], event.entity.position.y + v[2]})
                if entity ~= nil then entity.destroy() end
            end
        elseif rfpower.icf_offsets_aneutronic[event.entity.name] then
            for k,v in pairs(rfpower.icf_offsets_aneutronic[event.entity.name]) do
                local entity = event.entity.surface.find_entity("rf-reactor-icf-aneutronic"..k, {event.entity.position.x + v[1], event.entity.position.y + v[2]})
                if entity ~= nil then entity.destroy() end
            end
        end
    end)
end)
-- #endregion --