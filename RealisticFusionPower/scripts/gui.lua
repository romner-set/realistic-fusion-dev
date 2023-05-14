--! TODO: Find a way to somehow make padding work properly on higher/lower resolutions, currently it's slightly off
rfpower.gui_window_name = "rf-gui-window" --global constant

-- #region FUNCTIONS --
local function padding(element, height)
    local padding = element.add{type="empty-widget"}
    if height == nil then
        padding.style.vertically_stretchable = true
    else
        padding.style.height = height
    end
end
local function paddingh(element, width)
    local padding = element.add{type="empty-widget"}
    if width == nil then
        padding.style.horizontally_stretchable = true
    else
        padding.style.width = width
    end
end
local function line(element, direction)
    element.add{type="line", style="inside_shallow_frame_with_padding_line", direction=direction}
end

local function slider_progressbar(args)--{id, element, name, key, suffix, padleft, padcenter, padright, type, max_value, style, top_margin, slider_size, value_size, value, button, enabled, id_is_network_number}
    local tags, n
    if args.id_is_network_number then
        n = global.networks[args.id]
        tags = {network_number = args.id}
    else
        n = global.networks[global.entities[args.id]]
        tags = {unit_number = args.id}
    end

    args.style = args.style or "rf_reactor_control_notched_slider"--"map_generator_notched_slider_wide"
    args.slider_size = args.slider_size or 120
    args.value_size = args.value_size or 30
    args.type = args.type or "slider"
    args.value = args.value or n[args.name:gsub("-", "_")]
    args.max_value = args.max_value or 100
    args.suffix = args.suffix or ""

    if args.button then
        local bt = args.element.add{ --TODO
            type="button",
            name="rf-"..args.name.."-button",
            --groupstyle = "frame_action_button",
            caption=args.key,
            mouse_button_filter={"left"},
            tags=tags
        }--; bt.style.width = 70; bt.style.font_color = {1,1,1}
        --bt.enabled = args.enabled
    else
        args.element.add{type="label", name="rf-"..args.name.."-label", caption=args.key}
    end

    if args.padleft ~= nil then
        if args.padleft == -1 then paddingh(args.element)
        else paddingh(args.element, args.padleft) end
    end

    tags.suffix=args.suffix

    local slider = args.element.add{type=args.type, name="rf-"..args.name, style=args.style, value=args.value, tags=tags, maximum_value=args.max_value}
        slider.style.width = args.slider_size
        slider.style.top_margin = args.top_margin
    if args.type ~= "slider" then
        slider.style.height = 10
        slider.style.bar_width = 10
        if args.style == "statistics_progressbar" then
            slider.style.color = {0, 0.8, 1}
        end
    end

    if args.padcenter ~= nil then
        if args.padcenter == -1 then paddingh(args.element)
        else paddingh(args.element, args.padcenter) end
    end

    if args.value_size ~= 0 then
        local value_frame = args.element.add{type="frame", name="rf-"..args.name.."-value-frame", style="slot_button_deep_frame"}

        if args.enabled ~= nil then slider.enabled = args.enabled else
            if n.systems == "left"
            or (args.name == "plasma-heating" and n.heating == "left")
            or (args.name == "magnetic-field-strength" and n.magnetic_field == "left") then
                slider.enabled = false
                args.value = "OFF"
            end
        end
        local value = value_frame.add{type="label", name="rf-"..args.name.."-value", caption=(args.value..args.suffix):sub(1,3), tags=tags}
            value.style.width = args.value_size
            value.style.horizontal_align = "center"
    end

    if args.padright ~= nil then
        if args.padright == -1 then paddingh(args.element)
        else paddingh(args.element, args.padright) end
    end

    return slider
end

local function window(player, size, caption, flow_direction, id, suffix, no_manual, scrollable, no_id_in_title, id_is_network_number)
    local tags,n

    if id ~= nil then
        if id_is_network_number then
            n = global.networks[id]
            tags = {network_number = id}
        else
            n = global.networks[global.entities[id]]
            tags = {unit_number = id}
        end

        n.guis.gui_ids[player.index] = (n.guis.gui_ids[player.index] or 0) + 1
        for _,v in pairs{"sliders", "bars", "switches", "choice_elems", "sprites", "checkboxes"} do
            n.guis[v][player.index] = n.guis[v][player.index] or {}
            n.guis[v][player.index][n.guis.gui_ids[player.index]] = {}
        end
        n.guis.sprite_idxs[player.index] = n.guis.sprite_idxs[player.index] or {}
        n.guis.sprite_idxs[player.index][n.guis.gui_ids[player.index]] = 1
        tags.gui_id=n.guis.gui_ids[player.index]
    end

    local window = player.gui.screen.add{type="frame", name=rfpower.gui_window_name..(suffix or ""), direction="vertical", tags=tags}
          window.style.size = size
          window.auto_center = true
    --network[event.player_index].window = window

    local titlebar = window.add{type="flow", name="titlebar", direction="horizontal"};
          titlebar.drag_target = window
          titlebar.add{type="label", name="title", style="frame_title", ignored_by_interaction=true, caption=caption}

    if not no_id_in_title and id ~= nil then
        titlebar.add{type="label", name="title-un", ignored_by_interaction=true, caption="#"..id}
    end

    local drag_handle = titlebar.add{type="empty-widget", name="rf-drag-handle", style="draggable_space_header", ignored_by_interaction=true}
          drag_handle.style.height = 24
          drag_handle.style.horizontally_stretchable = true
          drag_handle.style.right_margin = 4

    if not no_manual then
        local manual = titlebar.add{ --TODO
            type="button",
            name="rf-manual-button",
            style = "frame_action_button",
            caption="Manual",
            mouse_button_filter={"left"},
            tags=tags
        }; manual.style.width = 70; manual.style.font_color = {1,1,1}
    end

    titlebar.add{
        type = "sprite-button",
        name = "rf-close-button",
        style = "frame_action_button",
        sprite = "utility/close_white",
        hovered_sprite = "utility/close_black",
        clicked_sprite = "utility/close_black",
        tooltip = "Close window",
        tags=tags,
        mouse_button_filter={"left"}
    }

    local ret
    if n ~= nil then ret = n.guis.gui_ids[player.index] end
    if scrollable then
        local ret_args = {type="scroll-pane", style="inner_frame_scroll_pane"}
        if flow_direction == "horizontal" then
            ret_args.vertical_scroll_policy   = "never"
            ret_args.horizontal_scroll_policy = "always"
        else
            ret_args.vertical_scroll_policy   = "always"
            ret_args.horizontal_scroll_policy = "never"
        end
        return window,window.add(ret_args),ret
    else
        local content = window.add{type="frame", name="content", direction="vertical", style="inside_shallow_frame_with_padding"}
              content.style.vertically_stretchable = "on"
        return window,content.add{type="flow", direction=flow_direction or "horizontal"},ret
    end
end
-- #endregion --

-- #region MAIN FUNCTIONS --

-- EVENT HANDLERS
-- General GUI
script.on_event(defines.events.on_gui_opened, function(event)
    try_catch(function()
        if event.gui_type == defines.gui_type.entity then
            if event.entity.name == "rf-m-reactor" then
                rfpower.reactor_gui(event.player_index, global.entities[event.entity.unit_number])
            elseif event.entity.name == "rf-m-heater" then
                rfpower.heater_gui(event.player_index, event.entity.unit_number)
            end
        end
    end)
end)
-- Control shortcut
script.on_event(defines.events.on_lua_shortcut, function(event) --TODO test in MP
    if event.prototype_name == "rf-reactor-control" then
        try_catch(function()
            rfpower.shortcut_gui(event)
        end)
    end
end)

---------------- #region SHORTCUT GUI ----------------
function rfpower.shortcut_gui(event)
    for _,v in pairs(game.players[event.player_index].gui.screen.children_names) do
        if v == rfpower.gui_window_name.."-shortcut-gui" then return end
    end

    local size = {330, 440}
    local scrollable = true
    local tsh = global.networks_len
    if tsh<15 then
        if tsh == 0 then
            size[2] = 100
        else
            size[2] = 75+tsh*32
        end
        scrollable = false
    end

    local w,content_flow,gui_id = window(
        game.get_player(event.player_index), size, "Network overview", "vertical",
        nil, "-network-list", true, scrollable, nil, true);

    if tsh == 0 then
        local label = content_flow.add{type="label", caption="No RF networks found"}
        label.style.font = "default-large-semibold"
        label.style.font_color = {1,1,1}
        label.style.left_padding = 65
    else for k,n in pairs(global.networks) do
        local enabled = table_size(n.reactors) > 0;
        local caption; local padding
        if enabled then caption="Open"; padding=120 else caption="No reactors"; padding=90 end

        local line_flow = content_flow.add{type="flow", direction="horizontal"}
        line_flow.add{type="label", caption="Network"}

        local kcaption
        if k < 10 then kcaption = "#0"..k else kcaption = "#"..k end
        local klabel = line_flow.add{type="label", caption=kcaption}
              klabel.style.font = "default-small"
              klabel.style.font_color = {0.75,0.75,0.75}
              klabel.style.top_padding = 2

        paddingh(line_flow, padding)


        local bt = line_flow.add{
            type="button",
            name="rf-network-open-button",
            --groupstyle = "frame_action_button",
            caption=caption, enabled=enabled,
            mouse_button_filter={"left"},
            tags={network_number=k}
        }; bt.style.width = 180-padding
    end end

    --paddingh(content_flow)
end
---------------- #endregion ----------------

---------------- #region REACTOR GUI ----------------
function rfpower.reactor_gui(player_index, network_number)
    local player = game.get_player(player_index)
    if player.gui.screen[rfpower.gui_window_name.."-reactor-"..network_number] then player.opened = nil else
        local network = global.networks[network_number]

        -- #region WINDOW --
        local w,content_flow,gui_id = window(player, {1080, 490}, "Fusion reactor control", nil, network_number, "-reactor-"..network_number, nil,nil,nil, true);

        local content_sections = {}
        for i,k in ipairs{"left", "center", "right"} do
            local style = "invisible_frame"
            if i == 2 then style = "deep_frame_in_shallow_frame" end
            local w = 300
            if i==2 then w = 420 end
            content_sections[k] = content_flow.add{type="frame", name=k, style=style, direction="vertical"}
                content_sections[k].style.width = w
                content_sections[k].style.vertically_stretchable = true
        end
        -- #endregion --

        -- #region LEFT SIDE --
        local content_left_main_vars = content_sections.left.add{type="table", name="table-main-vars", column_count=4};
            content_left_main_vars.style.top_cell_padding = 3
            content_left_main_vars.style.bottom_cell_padding = 3
        network.guis.sliders[player_index][gui_id]["plasma-heating"] = slider_progressbar{
            id=network_number, element=content_left_main_vars, name="plasma-heating", key="Plasma heating", suffix="%", padleft=10, button=true, id_is_network_number=true
        }
        padding(content_sections.left, 10)
        line(content_sections.left)
        padding(content_sections.left, 10)

        local content_left_vars = content_sections.left.add{type="table", name="table-vars", column_count=3}
            content_left_vars.style.top_cell_padding = 3
            content_left_vars.style.bottom_cell_padding = 3

        for _,k in pairs{--[["Plasma heating",]] "Magnetic field strength", "Plasma flow speed"} do
            local name = k:lower():gsub(" ", "-")
            network.guis.sliders[player_index][gui_id][name] = slider_progressbar{id=network_number, element=content_left_vars, name=name, key=k, suffix="%", id_is_network_number=true}
        end

        for i,v in ipairs{
            {["Energy input"] = {"MW", 1000}, ["Energy output"] = {"MW", 1000}},
            {["Total plasma"] = {"u", 100--[[TODO]]}, ["Plasma volume"] = {"m³", 100--[[TODO]]}, ["Plasma temperature"] = {" M°C", 200}},
            --{"Reactor wall integrity"},
            --{"Tritium breeding rate"},
        } do
            local w = 100; if i == 1 then w = 140 end
            local s = "statistics_progressbar";
            --if i == 3 then s = "electric_satisfaction_progressbar" end
            --elseif i == 2 then s = "heat_progressbar" end

            padding(content_sections.left, 10)
            line(content_sections.left)
            padding(content_sections.left, 10)
            local table = content_sections.left.add{type="table", name="table-stats-"..i, column_count=5}
                table.style.top_cell_padding = 3
                table.style.bottom_cell_padding = 3
            for k,_v in pairs(v) do
                if k:sub(1,6) == "Energy" then s = "electric_statistics_progressbar" end
                local name = k:lower():gsub(" ", "-")
                network.guis.bars[player_index][gui_id][name] = slider_progressbar{
                    id=network_number, element=table, name=name, key=k,
                    suffix=_v[0], padleft=-1, padright=0, type="progressbar",
                    max_value=_v[1], style=s, slider_size=w, value_size=58,
                    id_is_network_number=true
                }
            end
        end

        padding(content_sections.left, 10)
        line(content_sections.left)
        padding(content_sections.left, 10)

        local content_left_usage = content_sections.left.add{type="table", name="table-usage", column_count=5};
            content_left_usage.style.top_cell_padding = 3
            content_left_usage.style.bottom_cell_padding = 3

        for i,v in ipairs{"Deuterium", "Tritium", "Helium-3"} do
            network.guis.bars[player_index][gui_id][v:lower().."-usage"] = slider_progressbar{
                id=network_number, element=content_left_usage, name=v:lower().."-usage", key=v.." usage/s",
                suffix="u", padleft=-1, padright=0, type="progressbar", value=network[v:lower().."_usage"],
                max_value=1, style="statistics_progressbar", slider_size=100, value_size=58,
                id_is_network_number=true
            }
        end
        -- #endregion --

        -- #region RIGHT SIDE --
        content_sections.right.style.left_padding = 10

        local content_right_switches = content_sections.right.add{type="table", name="table-switches", column_count=3}
            content_right_switches.style.left_cell_padding = 6
            content_right_switches.style.right_cell_padding = 6
            --content_right_secondary_switches.style.left_padding = 20
        local switches = {"     Systems", "Magnetic field", "       Heating"}
        for _,k in ipairs(switches) do content_right_switches.add{type="label", caption=k} end
        for _,k in ipairs(switches) do
            local name = k:gsub("%s%s+", ""):lower():gsub(" ", "-")
            network.guis.switches[player_index][gui_id][name] = content_right_switches.add{type="switch", name="rf-"..name,
                style = "rf_reactor_control_switch", left_label_caption="OFF", right_label_caption="ON", tags={network_number=network_number}, switch_state=network[name:gsub("-", "_")]
            }
        end

        padding(content_sections.right, 5)
        line(content_sections.right)

        local function gas_section(prefix, pad_progressbar, pad, pad_slider)
            local vars = {}
            if pad == nil then
                pad = {}
                for i=1, #prefix do pad[i]=0 end
            end
            if pad[1] ~= -1 then if pad[1] == 0 then vars[1] = prefix.." input" else vars[1] = (" "):rep(pad[1]) end end
            if pad[2] ~= -1 then if pad[2] == 0 then vars[2] = prefix.." removal" else vars[2] = "" end end

            if table_size(vars) > 1 then
                padding(content_sections.right, 5)

                local content_right_var_labels = content_sections.right.add{type="flow", name="table-"..prefix:lower().."-var-labels"}
                    content_right_var_labels.style.horizontal_spacing = 45
                    content_right_var_labels.style.left_padding = 32
                for _,k in ipairs(vars) do content_right_var_labels.add{type="label", caption=k} end

                padding(content_sections.right, 5)
            end

            local content_right_vars = content_sections.right.add{type="flow", name=prefix:lower().."-vars"}
            for i,k in ipairs(vars) do
                paddingh(content_right_vars, 5 - (i%2)*5)
                if pad[i] == 0 then
                    local name = k:lower():gsub(" ", "-")
                    local v = network[name:gsub("-", "_")]
                    local slider = content_right_vars.add{type="slider", name="rf-"..name, style="rf_reactor_control_notched_slider",
                        value=v, maximum_value=100, value_step=10, tags={network_number=network_number}
                    }; slider.style.width = 103
                    if network.systems == "left" then slider.enabled = false; v = "OFF" end
                    local value_frame = content_right_vars.add{type="frame", name="rf-"..name.."-value-frame", style="slot_button_deep_frame"}
                    local value = value_frame.add{type="label", name="rf-"..name.."-value", caption=((v or "OFF").."%"):sub(1,3)}
                        value.style.width = 30
                        value.style.horizontal_align = "center"
                    network.guis.sliders[player_index][gui_id][name] = slider
                else
                    paddingh(content_right_vars, 0)
                    paddingh(content_right_vars, pad_slider)
                end
            end

            padding(content_sections.right, 5)

            local content_right_stats = content_sections.right.add{type="table", name="table-"..prefix:lower().."-stats", column_count=4}
                content_right_stats.style.top_cell_padding = 3
                content_right_stats.style.bottom_cell_padding = 3
            network.guis.bars[player_index][gui_id][prefix:lower()] = slider_progressbar{
                id=network_number, element=content_right_stats,
                name=prefix:lower(), key=prefix.." in plasma", suffix="%",
                padleft=pad_progressbar, type="progressbar",
                style="statistics_progressbar", slider_size=99,
                value_size=60, id_is_network_number=true
            }

            padding(content_sections.right, 5)
            line(content_sections.right)
        end

        gas_section("Deuterium", 0)
        --gas_section("Deuterium", 0, {0,30}, 133)
        gas_section("Tritium", 20)
        gas_section("Helium-3", 7)
        --gas_section("Helium-3", 7, {30,0}, 133)
        gas_section("Helium-4", 7)

        --[[network.guis.bars[event.player_index][gui_id]["lithium-stored"] = slider_progressbar(un, content_sections.right.add{type="flow", name="table-stats-right-lithium"},
            "lithium-stored", "Lithium stored in reactor", "u",
            1, nil, nil, "progressbar", nil,
            "statistics_progressbar", 5, 78, 58
        )

        padding(content_sections.right)
        line(content_sections.right)

        local type_label_flow = content_sections.right.add{type="flow"}
        local type_flow = content_sections.right.add{type="flow"}
        
        paddingh(type_label_flow)
        local label = type_label_flow.add{type="label", caption="Fusion type"}; label.style.font = "default-large"
        paddingh(type_label_flow)
        local label = type_label_flow.add{type="label", caption="Controller type"}; label.style.font = "default-large"
        paddingh(type_label_flow)

        paddingh(type_flow, 32)
        local recipe = type_flow.add{type="choose-elem-button", name="reactor-recipe", elem_type="recipe", tags={unit_number=un}, elem_filters={
            {filter = "has-ingredient-fluid", elem_filters = {
                {filter = "name", name = "rf-deuterium-plasma"},
                {filter = "name", name = "rf-d-t-plasma"},
            }}
        }}
        recipe.style.size = 64

        paddingh(type_flow, 64)
        local controller = type_flow.add{type="choose-elem-button", name="controller-tech", elem_type="recipe", tags={unit_number=un}, elem_filters={
            {filter = "has-ingredient-fluid", elem_filters = {
                {filter = "name", name = "rf-deuterium-plasma"},
                {filter = "name", name = "rf-d-t-plasma"},
            }}
        }}
        controller.style.size = 64

        network.guis.choice_elems[event.player_index][gui_id]["reactor-recipe"] = recipe
        network.guis.choice_elems[event.player_index][gui_id]["controller-tech"] = controller]]
        -- #endregion --

        -- #region CENTER --
        local wall_integrity = content_sections.center.add{type="flow", name="table-stats-right-wall-integrity"}
        paddingh(wall_integrity)
        --network.guis.bars[event.player_index][gui_id]["wall-integrity"] = slider_progressbar(un, wall_integrity,
        --    "wall-integrity", "Wall integrity", nil, nil, nil, "progressbar",
        --    "electric_satisfaction_progressbar",5, 82, 0
        --)
        local slider = wall_integrity.add{type="progressbar", name="rf-wall-integrity", style="electric_satisfaction_progressbar",
            value=network.wall_integrity,tags={network_number=network_number}, maximum_value=100, caption="INTERNAL REACTOR WALL INTEGRITY"
        };
            slider.style.width = 400;
            slider.style.height = 18
            --slider.style.top_margin = 5
            slider.style.bar_width = 18
            slider.style.horizontal_align = "center"
            slider.style.font = "default-small-semibold"
        network.guis.bars[player_index][gui_id]["wall-integrity"] = slider
        paddingh(wall_integrity)

        network.guis.sprites[player_index][gui_id] = content_sections.center.add{
            type="sprite",
            name="rf-m-reactor-sprite",
            resize_to_sprite=false,
            tags={network_number=network_number},
            --sprite = "rf-gui-plasma-sprite-1"
        };
        network.guis.sprites[player_index][gui_id].style.left_padding = 10
        network.guis.sprites[player_index][gui_id].style.width = 400
        network.guis.sprites[player_index][gui_id].style.height = 343
        -- #endregion --

        player.opened = w
    end
end
---------------- #endregion ----------------


---------------- #region HEATER GUI ----------------
function rfpower.heater_gui(player_index, unit_number)
    local player = game.get_player(player_index)
    if player.gui.screen[rfpower.gui_window_name.."-heater-"..unit_number] then player.opened = nil else
        local network = global.networks[global.entities[unit_number]]

        -- WINDOW --
        local w,content_flow,gui_id = window(player, {350, 130}, "Plasma heater control", "vertical", unit_number, "-heater-"..unit_number);

        -- #region OVERRIDE SWITCH --
        local switch_flow = content_flow.add{type="flow", name="rf-heater-override-flow", direction="horizontal"}
        switch_flow.add{type="label", name="rf-heater-override-label", caption="Override reactor controls?"}
        paddingh(switch_flow)

        local enabled = (network.systems == "right" and network.heating == "right")
        local state = "left"
        if enabled and network.heater_override[unit_number] == "right" then state="right" end

        network.heater_override[unit_number] = network.heater_override[unit_number] or 0
        network.guis.switches[player_index][gui_id]["heater-override-"..unit_number] = switch_flow.add{type="switch", name="rf-heater-override-"..unit_number,
            style = "rf_reactor_control_switch", left_label_caption="OFF", right_label_caption="ON",
            tags={unit_number=unit_number}, switch_state=state, enabled=enabled
        }
        -- #endregion --

        padding(content_flow, 5)

        -- #region OVERRIDE SLIDER --
        local slider_flow = content_flow.add{type="flow", name="rf-heater-override-slider-flow", direction="horizontal"}

        network.heater_override_slider[unit_number] = network.heater_override_slider[unit_number] or 0
        network.guis.sliders[player_index][gui_id]["heater-override-slider-"..unit_number] = slider_progressbar{
            id=unit_number, element=slider_flow, name="heater-override-slider-"..unit_number, key="Plasma heating", suffix="%",
            padleft=-1, value=network.heater_override_slider[unit_number], enabled=(state == "right")
        }
        -- #endregion --

        player.opened = w
    end
end
---------------- #endregion ----------------

---------------- #region HEATING LIST GUI IN REACTOR ----------------

function rfpower.heater_list_gui(network, player_index, network_number)
    local player = game.get_player(player_index)
    if player.gui.screen[rfpower.gui_window_name.."-heater-list-"..network_number] then return end

    for _,v in pairs(game.players[player_index].gui.screen.children_names) do
        if v == rfpower.gui_window_name.."-heater-list" then return end
    end

    local size = {330, 440}
    local scrollable = true
    local tsh = table_size(network.heaters)
    if tsh<15 then
        if tsh == 0 then
            size[2] = 100
        else
            size[2] = 75+tsh*26
        end
        scrollable = false
    end

    local w,content_flow,gui_id = window(
        player, size, "Heater overview", "vertical",
        network_number, "-heater-list-"..network_number, true, scrollable,
        nil, true
    );

    if tsh == 0 then
        local label = content_flow.add{type="label", caption="No heaters in network"}
        label.style.font = "default-large-semibold"
        label.style.font_color = {1,1,1}
        label.style.left_padding = 65
    else for un,e in pairs(network.heaters) do
        local heater_flow = content_flow.add{type="flow", direction="horizontal"}
        heater_flow.add{type="label", caption="Heater"}

        local unlabel = heater_flow.add{type="label", caption="#"..un}
              unlabel.style.font = "default-small"
              unlabel.style.font_color = {0.75,0.75,0.75}
              unlabel.style.top_padding = 2

        network.heater_override_slider[un] = network.heater_override_slider[un] or 0

        paddingh(heater_flow, 15)

        local enabled = (network.systems == "right" and network.heating == "right")
        local state = (enabled and network.heater_override[un] == "right")

        local checkbox = heater_flow.add{type="checkbox", name="rf-heater-override-"..un, state=state, tooltip="Override reactor setting?", tags={unit_number=un}, enabled=enabled}
              checkbox.style.top_margin = 4
              checkbox.style.horizontal_align = "right"
        network.guis.checkboxes[player_index][gui_id]["rf-heater-override-"..un] = checkbox

        network.heater_override_slider[un] = network.heater_override_slider[un] or 0
        network.guis.sliders[player_index][gui_id]["heater-override-slider-"..un] = slider_progressbar{
            id=un, element=heater_flow, name="heater-override-slider-"..un, suffix="%",
            padleft=-1,value=network.heater_override_slider[un], enabled=state
        }
    end end

    --paddingh(content_flow)
end
---------------- #endregion ----------------
-- #endregion --

-- #region PLASMA ANIMATION FUNCTION --

return function(reactor, unit_number, tick) --runs on_tick, per reactor
    for player_index, sprites in pairs(reactor.guis.sprites) do
        for gui_id, sprite in pairs(sprites) do
            if sprite and sprite.valid and global.networks[unit_number].systems == "right" then
                local fs = global.networks[unit_number].plasma_flow_speed

                -- #region SPEED CONTROL --
                if fs == 0 then fs = global.networks[unit_number].guis.sprite_idxs[player_index][gui_id]
                elseif fs >= 99 then fs = global.networks[unit_number].guis.sprite_idxs[player_index][gui_id]%27+3
                elseif fs >= 95 and tick%2==0 then fs = global.networks[unit_number].guis.sprite_idxs[player_index][gui_id]%27+3
                elseif fs >= 85 then fs = global.networks[unit_number].guis.sprite_idxs[player_index][gui_id]%28+2
                elseif fs >= 75 and tick%2==0 then fs = global.networks[unit_number].guis.sprite_idxs[player_index][gui_id]%28+2
                elseif fs >= 50 then fs = global.networks[unit_number].guis.sprite_idxs[player_index][gui_id]%29+1
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
                    then fs = global.networks[unit_number].guis.sprite_idxs[player_index][gui_id]%29+1
                    else fs = global.networks[unit_number].guis.sprite_idxs[player_index][gui_id] end
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
                global.networks[unit_number].guis.sprite_idxs[player_index][gui_id] = fs
                -- #endregion --
            end
        end
    end
end
-- #endregion --
