function rfpower.update_heater_power(network)
    network.heater_power = 0
    for un,heater in pairs(network.heaters) do
        network.heater_power = network.heater_power + (network.heater_override_slider[un] or network.plasma_heating)
    end
    network.heater_power = (network.heater_power/100)*rfpower.heater_capacity
end

function rfpower.update_gui(event, value)
    local name = event.element.name:sub(4)
    local un = event.element.tags.unit_number
    local n = global.networks[global.entities[un]]

    -- #region GIGANTIC UGLY IF-BLOCKS FOR UPDATING STUFF AFTER FLIPPING SWITCHES WHICH I CAN'T BE BOTHERED TO REPLACE (--TODO?--) --
    if name == "systems" then
        if event.element[value] == "right" then
            for idx, bars in pairs(n.guis.bars) do
                for _name,bar in pairs(bars) do
                    if _name ~= "wall-integrity" then
                        bar.enabled = true
                        --bar.value = n[_name:gsub("-", "_")]
                        bar.parent["rf-".._name.."-value-frame"]["rf-".._name.."-value"].caption = (math.floor(bar.value*100)..bar.tags.suffix):sub(1,3)
                    end
                end
            end
            for idx, sliders in pairs(n.guis.sliders) do
                for _name,slider in pairs(sliders) do
                    if not (
                        (_name == "magnetic-field-strength" and n.magnetic_field == "left") or
                        (_name == "plasma-heating" and n.heating == "left")                 or
                        _name == "heater-override"
                    ) then
                        slider.enabled = true
                        slider.parent["rf-".._name.."-value-frame"]["rf-".._name.."-value"].caption = (slider.slider_value.."%"):sub(1,3)
                    end
                end
            end
        else
            for idx, bars in pairs(n.guis.bars) do
                for _name,bar in pairs(bars) do
                    if _name ~= "wall-integrity" then
                        bar.value = 0
                        bar.enabled = false
                        bar.parent["rf-".._name.."-value-frame"]["rf-".._name.."-value"].caption = "OFF"
                    end
                end
            end
            for idx, sliders in pairs(n.guis.sliders) do
                for _name,slider in pairs(sliders) do
                    slider.enabled = false
                    slider.parent["rf-".._name.."-value-frame"]["rf-".._name.."-value"].caption = "OFF"
                end
            end
            for _,sprite in pairs(n.guis.sprites) do sprite.sprite = nil end
        end
    elseif name == "magnetic-field" then
        if event.element[value] == "right" then
            if n.systems == "right" then
                for idx, sliders in pairs(n.guis.sliders) do
                    for _name,slider in pairs(sliders) do
                        if slider.name == "rf-magnetic-field-strength" then
                            slider.enabled = true
                            slider.parent["rf-".._name.."-value-frame"]["rf-".._name.."-value"].caption = (slider.slider_value.."%"):sub(1,3)
                        end
                    end
                end
            end
        else
            for idx, sliders in pairs(n.guis.sliders) do
                for _name,slider in pairs(sliders) do
                    if slider.name == "rf-magnetic-field-strength" then
                        n[_name:gsub("-", "_")] = 0
                        slider.slider_value = 0
                        slider.enabled = false
                        slider.parent["rf-".._name.."-value-frame"]["rf-".._name.."-value"].caption = "OFF"
                    end
                end
            end
        end
    elseif name == "heating" then
        if event.element[value] == "right" then
            if n.systems == "right" then
                for idx, sliders in pairs(n.guis.sliders) do
                    for _name,slider in pairs(sliders) do
                        if slider.name == "rf-plasma-heating" then
                            slider.enabled = true
                            slider.parent["rf-".._name.."-value-frame"]["rf-".._name.."-value"].caption = (slider.slider_value.."%"):sub(1,3)
                        end
                    end
                end
            end
        else
            for idx, sliders in pairs(n.guis.sliders) do
                for _name,slider in pairs(sliders) do
                    if slider.name == "rf-plasma-heating" then
                        n[_name:gsub("-", "_")] = 0
                        slider.slider_value = n.plasma_heating
                        slider.enabled = false
                        slider.parent["rf-".._name.."-value-frame"]["rf-".._name.."-value"].caption = "OFF"
                    end
                end
            end
        end
    end

    if name == "heater-override" then
        local switch = event.element.parent.parent["rf-heater-override-slider-flow"]["rf-heater-override-slider"]
        if n.heater_override[un] == "left" then
            n.heater_override[un] = "right"

            for _,sliders in pairs(n.guis.sliders) do
                for _name,slider in pairs(sliders) do
                    if slider.name == "rf-heater-override-slider" then slider.enabled = true end
                end
            end
        else
            n.heater_override[un] = "left"
            n.heater_override_slider[un] = n.plasma_heating

            for _,sliders in pairs(n.guis.sliders) do
                for _name,slider in pairs(sliders) do
                    if slider.name == "rf-heater-override-slider" then
                        slider.enabled = false
                        slider.slider_value = n.plasma_heating
                        slider.parent["rf-".._name.."-value-frame"]["rf-".._name.."-value"].caption = string.sub(n.plasma_heating.."%", 1,3)
                    end
                end
            end
        end
    elseif name == "heater-override-slider" then
        n.heater_override_slider[un] = event.element[value]
    else
    -- #endregion --

    -- #region UPDATE ELEMENT --
        n[name:gsub("-", "_")] = event.element[value]
    end

    for idx, v in pairs(n.guis.sliders) do
        if idx ~= event.player_index then
            v[name][value] = event.element[value]
        end
        if value == "slider_value" then v[name].parent[event.element.name.."-value-frame"][event.element.name.."-value"].caption = (event.element.slider_value.."%"):sub(1,3) end
    end

    if name == "plasma-heating" or value == "switch_state" then
        for h_un,v in pairs(n.heater_override) do
            if v == "left" then n.heater_override_slider[h_un] = n.plasma_heating end
        end
        for _,sliders in pairs(n.guis.sliders) do
            for _name,slider in pairs(sliders) do
                if slider.name == "rf-heater-override-slider" and n.heater_override[slider.tags.unit_number] == "left" then
                    slider.slider_value = n.plasma_heating
                    slider.parent["rf-".._name.."-value-frame"]["rf-".._name.."-value"].caption = string.sub(n.plasma_heating.."%", 1,3)
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
        if event.element.name:sub(1,3) == "rf-" then
            local n = global.networks[global.entities[event.element.tags.unit_number]]
            if event.element and event.element.name == "rf-close-button" then
                n.guis.sliders[event.player_index] = nil
                n.guis.switches[event.player_index] = nil
                game.get_player(event.player_index).gui.screen[rfpower.reactor_gui_name].destroy() --DESTROY sounds a bit aggressive for just closing a GUI...
            end
        end
    end)
end)

script.on_event(defines.events.on_gui_value_changed, function(event) --TODO test in MP
    try_catch(function()
        if event.element.name:sub(1,3) == "rf-" then rfpower.update_gui(event, "slider_value") end
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
                    for _name,switch in pairs(switches) do
                        switch.enabled = b
                    end
                end
            end
        end
    end)
end)
-- #endregion --