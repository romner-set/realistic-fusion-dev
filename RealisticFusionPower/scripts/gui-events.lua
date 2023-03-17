function rfpower.update_heater_power(network)
    network.heater_power = 0
    for un,heater in pairs(network.heaters) do
        network.heater_power = network.heater_power + (network.heater_override_slider[un] or network.plasma_heating)
    end
    network.heater_power = network.heater_power*rfpower.const.heater_capacity/100
end

function rfpower.update_gui(event, value)
    local name = event.element.name:sub(4)
    --game.print(name.." "..name:sub(1,30).." "..name:sub(32))
    local un = event.element.tags.unit_number
    local n = global.networks[global.entities[un]]

    -- #region GIGANTIC UGLY IF-BLOCKS FOR UPDATING STUFF AFTER FLIPPING SWITCHES WHICH I CAN'T BE BOTHERED TO REPLACE
    --TODO? hopefully? I'm sincerely sorry to anyone who might have to maintain this in the future (aka myself) if I don't replace it
    if name == "systems" then
        if event.element[value] == "right" then
            for idx, bars in pairs(n.guis.bars) do
                for gui_id, _bars in pairs(bars) do
                    for _name,bar in pairs(_bars) do
                        if _name ~= "wall-integrity" then
                            bar.enabled = true
                            --bar.value = n[_name:gsub("-", "_")]
                            bar.parent["rf-".._name.."-value-frame"]["rf-".._name.."-value"].caption = (math.floor(bar.value*100)..bar.tags.suffix):sub(1,3)
                        end
                    end
                end
            end
            for idx, sliders in pairs(n.guis.sliders) do
                for gui_id, _sliders in pairs(sliders) do
                    for _name,slider in pairs(_sliders) do
                        if not (
                            (_name == "magnetic-field-strength" and n.magnetic_field == "left") or
                            (_name == "plasma-heating" and n.heating == "left")                 or
                            (_name == "heater-override-slider" and n.heater_override[slider.tags.unit_number] == "left")
                        ) then
                            slider.enabled = true
                            slider.parent["rf-".._name.."-value-frame"]["rf-".._name.."-value"].caption = (slider.slider_value.."%"):sub(1,3)
                        end
                    end
                end
            end
            
            if n.heating == "right" then
                local state = event.element[value] == "right"
                for _,override in pairs(n.heater_override) do
                    for k,v in pairs{switches = {"switch_state", override}, checkboxes = {"state", override=="right"}} do
                        for _,stuff in pairs(n.guis[k]) do
                            for _,_stuff in pairs(stuff) do
                                for _,thing in pairs(_stuff) do
                                    if thing.name == "rf-heater-override" then
                                        thing[v[1]] = v[2]
                                        thing.enabled = state
                                    end
                                end
                            end
                        end
                    end
                end
            end
        else
            for idx, bars in pairs(n.guis.bars) do
                for gui_id, _bars in pairs(bars) do
                    for _name,bar in pairs(_bars) do
                        if _name ~= "wall-integrity" then
                            bar.value = 0
                            bar.enabled = false
                            bar.parent["rf-".._name.."-value-frame"]["rf-".._name.."-value"].caption = "OFF"
                        end
                    end
                end
            end
            for idx, sliders in pairs(n.guis.sliders) do
                for gui_id, _sliders in pairs(sliders) do
                    for _name,slider in pairs(_sliders) do
                        slider.enabled = false
                        slider.parent["rf-".._name.."-value-frame"]["rf-".._name.."-value"].caption = "OFF"
                    end
                end
            end
            for _,sprites in pairs(n.guis.sprites) do
                for _,sprite in pairs(sprites) do sprite.sprite = nil end
            end
            
            if n.heating == "right" then
                local state = event.element[value] == "right"
                for _,override in pairs(n.heater_override) do
                    for k,v in pairs{switches = {"switch_state", override}, checkboxes = {"state", override=="right"}} do
                        for _,stuff in pairs(n.guis[k]) do
                            for _,_stuff in pairs(stuff) do
                                for _,thing in pairs(_stuff) do
                                    if thing.name == "rf-heater-override" then
                                        thing[v[1]] = v[2]
                                        thing.enabled = state
                                    end
                                end
                            end
                        end
                    end
                end
            end
        end
    elseif name == "magnetic-field" then
        if event.element[value] == "right" then
            if n.systems == "right" then
                for idx, sliders in pairs(n.guis.sliders) do
                    for gui_id, _sliders in pairs(sliders) do
                        if _sliders["magnetic-field-strength"] then
                            local slider = _sliders["magnetic-field-strength"]
                            slider.enabled = true
                            slider.parent["rf-magnetic-field-strength-value-frame"]["rf-magnetic-field-strength-value"].caption = (slider.slider_value.."%"):sub(1,3)
                        end
                    end
                end
            end
        else
            for idx, sliders in pairs(n.guis.sliders) do
                for gui_id, _sliders in pairs(sliders) do
                    if _sliders["magnetic-field-strength"] then
                        local slider = _sliders["magnetic-field-strength"]
                        n.magnetic_field_strength = 0
                        slider.slider_value = 0
                        slider.enabled = false
                        slider.parent["rf-magnetic-field-strength-value-frame"]["rf-magnetic-field-strength-value"].caption = "OFF"
                    end
                end
            end
        end
    elseif name == "heating" then
        if n.systems == "right" then
            local state = event.element[value] == "right"

            for idx, sliders in pairs(n.guis.sliders) do
                for gui_id, _sliders in pairs(sliders) do
                    for _name,slider in pairs(_sliders) do
                        if slider.name == "rf-heater-override-slider" then
                            if state then
                                slider.slider_value = 0
                                slider.parent["rf-".._name.."-value-frame"]["rf-".._name.."-value"].caption = string.sub(slider.slider_value.."%", 1,3)
                            else
                                n.heater_override_slider[slider.tags.unit_number] = 0
                                slider.slider_value = 0
                                slider.enabled = false
                                slider.parent["rf-".._name.."-value-frame"]["rf-".._name.."-value"].caption = "OFF"
                            end
                        elseif slider.name == "rf-plasma-heating" then
                            if state then
                                --slider.slider_value = n.plasma_heating
                                slider.enabled = true
                                slider.parent["rf-plasma-heating-value-frame"]["rf-plasma-heating-value"].caption = (slider.slider_value.."%"):sub(1,3)
                            else
                                n.plasma_heating = 0
                                slider.slider_value = 0
                                slider.enabled = false
                                slider.parent["rf-plasma-heating-value-frame"]["rf-plasma-heating-value"].caption = "OFF"
                            end
                        end
                    end
                end
            end

            for _,override in pairs(n.heater_override) do
                for k,v in pairs{switches = {"switch_state", "left"}, checkboxes = {"state", false}} do
                    for _,stuff in pairs(n.guis[k]) do
                        for _,_stuff in pairs(stuff) do
                            for _,thing in pairs(_stuff) do
                                if thing.name == "rf-heater-override" then
                                    thing[v[1]] = v[2]
                                    thing.enabled = state
                                end
                            end
                        end
                    end
                end
            end
        end
    end

    if name == "heater-override" then
        if n.systems == "right" and n.heating == "right" then
            if n.heater_override[un] == "left" then
                n.heater_override[un] = "right"
            else
                n.heater_override[un] = "left"
                n.heater_override_slider[un] = n.plasma_heating
            end
            
            for _,sliders in pairs(n.guis.sliders) do
                for _,_sliders in pairs(sliders) do
                    for _name,slider in pairs(_sliders) do
                        if slider.name == "rf-heater-override-slider" then
                            local state = event.element.switch_state == "right"
                            slider.enabled = state
                            if state then slider.slider_value = n.heater_override_slider[un] else slider.slider_value = n.plasma_heating end
                            slider.parent["rf-".._name.."-value-frame"]["rf-".._name.."-value"].caption = string.sub(slider.slider_value.."%", 1,3)
                        end
                    end
                end
            end

            for k,v in pairs{switches = {"switch_state", n.heater_override[un]}, checkboxes = {"state", n.heater_override[un] == "right"}} do
                for _,stuff in pairs(n.guis[k]) do
                    for _,_stuff in pairs(stuff) do
                        for _,thing in pairs(_stuff) do
                            if thing.name == "rf-heater-override" then thing[v[1]] = v[2] end
                        end
                    end
                end
            end
        end
    elseif name == "heater-override-slider" then
        n.heater_override_slider[un] = event.element[value]
    else n[name:gsub("-", "_")] = event.element[value] end
    -- #endregion --

    -- #region UPDATE ELEMENT --
    for idx, v in pairs(n.guis.sliders) do
        for _, _v in pairs(v) do
            if _v[name] then
                _v[name][value] = event.element[value]
                if value == "slider_value" then _v[name].parent[event.element.name.."-value-frame"][event.element.name.."-value"].caption = (event.element.slider_value.."%"):sub(1,3) end
            end
        end
    end

    if name == "plasma-heating" or value == "switch_state" then
        for h_un,v in pairs(n.heater_override) do
            if v == "left" then n.heater_override_slider[h_un] = n.plasma_heating end
        end
        for _,sliders in pairs(n.guis.sliders) do
            for _,_sliders in pairs(sliders) do
                for _name,slider in pairs(_sliders) do
                    if n.heater_override[slider.tags.unit_number] == "left" and slider.name == "rf-heater-override-slider" then
                        slider.slider_value = n.plasma_heating
                        slider.parent["rf-".._name.."-value-frame"]["rf-".._name.."-value"].caption = string.sub(n.plasma_heating.."%", 1,3)
                    end
                end
            end
        end
    end
    -- #endregion --

    if name:find("heat") then
        rfpower.update_heater_power(n)
    end
end

-- #region EVENT HANDLERS --
script.on_event(defines.events.on_gui_click, function(event)
    try_catch(function()
        if event.element.name:sub(1,3) == "rf-" and event.element then
            local n = global.networks[global.entities[event.element.tags.unit_number]]
            if event.element.name == "rf-plasma-heating-button" then
                rfpower.heater_list_gui(n, event.player_index, event.element.tags.unit_number) --defined in ./gui.lua
            elseif event.element.name == "rf-close-button" then
                local gui_id = event.element.parent.parent.tags.gui_id
                for _,v in pairs{"sliders", "bars", "switches", "choice_elems", "sprites", "sprite_idxs", "checkboxes"} do
                    n.guis[v][event.player_index][gui_id] = nil
                end
                event.element.parent.parent.destroy() --DESTROY sounds a bit aggressive for just closing a GUI...
            end
        end
    end)
end)
script.on_event(defines.events.on_gui_checked_state_changed, function(event)
    try_catch(function()
        if event.element.name:sub(1,3) == "rf-" and event.element then
            local un = event.element.tags.unit_number
            local n = global.networks[global.entities[un]]

            if n.systems == "right" and n.heating == "right" then
                if event.element.state == true then
                    n.heater_override[un] = "right"
                else
                    n.heater_override[un] = "left"
                    n.heater_override_slider[un] = n.plasma_heating
                end

                for _,sliders in pairs(n.guis.sliders) do
                    for _,_sliders in pairs(sliders) do
                        for _name,slider in pairs(_sliders) do
                            if slider.name == "rf-heater-override-slider" then
                                slider.enabled = event.element.state
                                if not event.element.state then slider.slider_value = n.plasma_heating end
                                slider.parent["rf-".._name.."-value-frame"]["rf-".._name.."-value"].caption = string.sub(slider.slider_value.."%", 1,3)
                            end
                        end
                    end
                end

                for k,v in pairs{switches = {"switch_state", n.heater_override[un]}, checkboxes = {"state", n.heater_override[un] == "right"}} do
                    for _,stuff in pairs(n.guis[k]) do
                        for _,_stuff in pairs(stuff) do
                            for _,thing in pairs(_stuff) do
                                if thing.name == "rf-heater-override" then thing[v[1]] = v[2] end
                            end
                        end
                    end
                end
            end
        end
    end)
end)

script.on_event(defines.events.on_gui_value_changed, function(event) --TODO test in MP
    try_catch(function()
        if event.element.name:sub(1,3) == "rf-" then
            rfpower.update_gui(event, "slider_value")
        end
    end)
end)

script.on_event(defines.events.on_gui_switch_state_changed, function(event) --TODO test in MP
    try_catch(function()
        if event.element.name:sub(1,3) == "rf-" then rfpower.update_gui(event, "switch_state") end
    end)
end)

script.on_event(defines.events.on_gui_elem_changed, function(event) --TODO test in MP
    try_catch(function()
        if event.element.name:sub(1,3) == "rf-" then
            local v = nil
            local n = global.networks[global.entities[event.element.tags.unit_number]]
            if event.element.elem_value then v = event.element.elem_value:sub(11, 13):upper() end
            n[event.element.name] = v

            if event.element.name == "reactor-recipe" then
                local b = event.element.elem_value ~= nil

                for idx, switches in pairs(n.guis.switches) do
                    for gui_id, _switches in pairs(switches) do
                        for _name,switch in pairs(_switches) do
                            switch.enabled = b
                        end
                    end
                end
            end
        end
    end)
end)
-- #endregion --
