local function update_gui(event, value)
    local name = event.element.name:sub(4)
    local n = global.networks[global.entities[event.element.tags.unit_number]]

    -- #region GIGANTIC UGLY IF-BLOCK FOR UPDATING STUFF AFTER FLIPPING SWITCHES WHICH I CAN'T BE BOTHERED TO REPLACE (--TODO?--) --
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
                    if not (slider.name == "rf-magnetic-field-strength" and n.magnetic_field == "left")
                    and not (slider.name == "rf-plasma-heating" and n.heating == "left") then
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
                        slider.slider_value = 0
                        slider.enabled = false
                        slider.parent["rf-".._name.."-value-frame"]["rf-".._name.."-value"].caption = "OFF"
                    end
                end
            end
        end
    end
    -- #endregion --

    -- #region UPDATE ELEMENT --
    n[name:gsub("-", "_")] = event.element[value]

    for idx, v in pairs(n.guis.sliders) do
        if idx ~= event.player_index then
            v[name][value] = event.element[value]
        end
        if value == "slider_value" then v[name].parent[event.element.name.."-value-frame"][event.element.name.."-value"].caption = (event.element.slider_value.."%"):sub(1,3) end
    end
    -- #endregion --
end

-- #region EVENT HANDLERS --
script.on_event(defines.events.on_gui_click, function(event)
    try_catch(function()
        local n = global.networks[global.entities[event.element.tags.unit_number]]
        if event.element and event.element.name == "rf-close-button" then
            n.guis.sliders[event.player_index] = nil
            n.guis.switches[event.player_index] = nil
            game.get_player(event.player_index).gui.screen[rfpower.gui_name].destroy() --DESTROY sounds a bit aggressive for just closing a GUI...
        end
    end)
end)

script.on_event(defines.events.on_gui_value_changed, function(event) --TODO test in MP
    try_catch(function()
        if event.element.name:sub(1,3) == "rf-" then update_gui(event, "slider_value") end
    end)
end)

script.on_event(defines.events.on_gui_switch_state_changed, function(event) --TODO test in MP
    try_catch(function()
        if event.element.name:sub(1,3) == "rf-" then update_gui(event, "switch_state") end
    end)
end)

script.on_event(defines.events.on_gui_elem_changed, function(event) --TODO test in MP
    try_catch(function()
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
    end)
end)
-- #endregion --

-- #region PLASMA ANIMATION FUNCTION --

return function(reactor, unit_number, tick) --runs on_tick, per reactor
    for player_index, sprite in pairs(reactor.guis.sprites) do
        if sprite and sprite.valid and global.networks[unit_number].systems == "right" then
            local fs = global.networks[unit_number].plasma_flow_speed

            -- #region SPEED CONTROL --
            if fs == 0 then fs = global.networks[unit_number].guis.sprite_idxs[player_index]
            elseif fs >= 99 then fs = global.networks[unit_number].guis.sprite_idxs[player_index]%27+3
            elseif fs >= 95 and tick%2==0 then fs = global.networks[unit_number].guis.sprite_idxs[player_index]%27+3
            elseif fs >= 85 then fs = global.networks[unit_number].guis.sprite_idxs[player_index]%28+2
            elseif fs >= 75 and tick%2==0 then fs = global.networks[unit_number].guis.sprite_idxs[player_index]%28+2
            elseif fs >= 50 then fs = global.networks[unit_number].guis.sprite_idxs[player_index]%29+1
            else
                if (fs >= 25 and tick%2==0)
                or (fs >= 17 and tick%3==0)
                or (fs >= 12 and tick%4==0)
                or (fs >= 10 and tick%5==0)
                or (fs >=  8 and tick%6==0)
                or (fs >=  7 and tick%7==0)
                or (fs >=  6 and tick%8==0)
                or (fs >=  5 and tick%10==0)
                or (fs >=  4 and tick%12==0)
                or (fs >=  3 and tick%17==0)
                or (fs >=  2 and tick%25==0)
                or (fs >=  1 and tick%50==0)
                then fs = global.networks[unit_number].guis.sprite_idxs[player_index]%29+1
                else fs = global.networks[unit_number].guis.sprite_idxs[player_index] end
            end
            -- #endregion --

            -- #region BLOOM CONTROL --
            local ph = global.networks[unit_number].plasma_temperature
            if ph < 35 then ph = "min"
            elseif ph < 75 then ph = "med-min"
            elseif ph < 120 then ph = "med"
            elseif ph < 170 then ph = "max-med"
            else ph = "max"
            end
            -- #endregion --

            -- #region SWITCH CURRENT FRAME --
            sprite.sprite = "rf-gui-plasma-neutronic-"..ph.."-"..fs--..(tick%10+1)
            --log(sprite.sprite)
            global.networks[unit_number].guis.sprite_idxs[player_index] = fs
            -- #endregion --
        end
    end
end
-- #endregion --