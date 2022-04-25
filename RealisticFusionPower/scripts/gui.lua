--! TODO: Find a way to somehow make padding work properly on higher/lower resolutions, currently it's slightly off
rfpower.gui_name = "rf-fusion-reactor-control" --global constant

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

local function slider_progressbar(unit_number, element, name, k, suffix, padleft, padcenter, padright, t, max_value, style, top_margin, slider_size, value_size)
    style = style or "rf_reactor_control_notched_slider"--"map_generator_notched_slider_wide"
    slider_size = slider_size or 120
    value_size = value_size or 30
    t = t or "slider"
    local v = global.reactors[unit_number][name:gsub("-", "_")]
    max_value = max_value or 100
    suffix = suffix or ""

    element.add{type="label", name=name.."-label", caption=k}

    if padleft ~= nil then
        if padleft == -1 then paddingh(element)
        else paddingh(element, padleft) end
    end

    local slider = element.add{type=t, name="rf-"..name, style=style, value=v, tags={unit_number=unit_number, suffix=suffix}, maximum_value=max_value}
        slider.style.width = slider_size
        slider.style.top_margin = top_margin
    if t ~= "slider" then
        slider.style.height = 10
        slider.style.bar_width = 10
        if style == "statistics_progressbar" then
            slider.style.color = {0, 0.8, 1}
        end
    end

    if padcenter ~= nil then
        if padcenter == -1 then paddingh(element)
        else paddingh(element, padcenter) end
    end

    if value_size ~= 0 then
        local value_frame = element.add{type="frame", name="rf-"..name.."-value-frame", style="slot_button_deep_frame"}
        if global.reactors[unit_number].systems == "left" then slider.enabled = false; v = "OFF" end
        local value = value_frame.add{type="label", name="rf-"..name.."-value", caption=(v..suffix):sub(1,3), tags={unit_number=unit_number, suffix=suffix}}
            value.style.width = value_size
            value.style.horizontal_align = "center"
    end

    if padright ~= nil then
        if padright == -1 then paddingh(element)
        else paddingh(element, padright) end
    end

    return slider
end
-- #endregion --

-- #region MAIN FUNCTION --

script.on_event(defines.events.on_gui_opened, function(event)
    if event.gui_type == defines.gui_type.entity and event.entity.name == "rf-reactor" then
        try_catch(function()
            local player = game.get_player(event.player_index)
            if player.gui.screen[rfpower.gui_name] then player.opened = nil else
                local un = event.entity.unit_number
                -- #region INIT GLOBAL TABLE --
                global.reactors[un].guis.sliders[event.player_index] = {}
                global.reactors[un].guis.bars[event.player_index] = {}
                global.reactors[un].guis.switches[event.player_index] = {}
                global.reactors[un].guis.choice_elems[event.player_index] = {}
                global.reactors[un].guis.sprites[event.player_index] = {}
                global.reactors[un].guis.sprite_idxs[event.player_index] = 1
                -- #endregion --

                -- #region WINDOW --
                local window = player.gui.screen.add{type="frame", name=rfpower.gui_name, direction="vertical", tags={unit_number=un}}
                    window.style.size = {1080, 440}
                    window.auto_center = true
                --global.reactors[un][event.player_index].window = window

                local titlebar = window.add{type="flow", name="titlebar", direction="horizontal"}; titlebar.drag_target = window
                    titlebar.add{type="label", name="title", style="frame_title", ignored_by_interaction=true, caption="Fusion reactor control"}

                local drag_handle = titlebar.add{type="empty-widget", name="rf-drag-handle", style="draggable_space_header", ignored_by_interaction=true}
                    drag_handle.style.height = 24
                    drag_handle.style.horizontally_stretchable = true
                    drag_handle.style.right_margin = 4

                local manual = titlebar.add{ --TODO
                    type="button",
                    name="rf-manual-button",
                    style = "frame_action_button",
                    caption="Manual",
                    mouse_button_filter={"left"},
                    tags={unit_number=un}
                }; manual.style.width = 70; manual.style.font_color = {1,1,1}

                titlebar.add{
                    type = "sprite-button",
                    name = "rf-close-button",
                    style = "frame_action_button",
                    sprite = "utility/close_white",
                    hovered_sprite = "utility/close_black",
                    clicked_sprite = "utility/close_black",
                    tooltip = "Close window",
                    tags={unit_number=un},
                    mouse_button_filter={"left"}
                }

                local content = window.add{type="frame", name="content", direction="vertical", style="inside_shallow_frame_with_padding"}
                    content.style.vertically_stretchable = "on"
                local content_flow = content.add{type="flow", name="flow", direction="horizontal"}

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
                global.reactors[un].guis.sliders[event.player_index]["plasma-heating"] = slider_progressbar(
                    un, content_left_main_vars, "plasma-heating", "Plasma heating", "%", 30
                )
                padding(content_sections.left, 10)
                line(content_sections.left)
                padding(content_sections.left, 10)

                local content_left_vars = content_sections.left.add{type="table", name="table-vars", column_count=3}
                    content_left_vars.style.top_cell_padding = 3
                    content_left_vars.style.bottom_cell_padding = 3

                for _,k in pairs{--[["Plasma heating",]] "Magnetic field strength", "Plasma flow speed"} do
                    local name = k:lower():gsub(" ", "-")
                    global.reactors[un].guis.sliders[event.player_index][name] = slider_progressbar(un, content_left_vars, name, k, "%")
                end

                --content_left_vars.add{type="label", caption="Plasma flow direction"}
                --global.reactors[un].guis.switches[event.player_index]["plasma-flow-direction"] = content_left_vars.add{
                --    type="switch", name="rf-plasma-flow-direction", style = "rf_reactor_control_switch", left_label_caption="CW", right_label_caption="CCW",
                --    allow_none_state=true, switch_state=global.reactors[un].plasma_flow_direction, tags={unit_number=un}
                --}
                --if global.reactors[un].systems == "left" then global.reactors[un].guis.switches[event.player_index]["plasma-flow-direction"].enabled = false end

                --padding(content_sections.left, 10)
                --line(content_sections.left)
                --padding(content_sections.left)

                for i,v in ipairs{
                    {["Fusion rate"] = {"", 100--[[TODO]]}, ["Energy input"] = {"MW", 1000}, ["Energy output"] = {"MW", 1000}},
                    {["Total plasma"] = {"u", 100--[[TODO]]}, ["Plasma density"] = {"u/m³", 100--[[TODO]]}, ["Plasma temperature"] = {" M°C", 200}},
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
                        global.reactors[un].guis.bars[event.player_index][name] = slider_progressbar(un, table, name, k, _v[0], -1, nil, 0, "progressbar", _v[1], s, nil, w, 58)
                    end
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
                    global.reactors[un].guis.switches[event.player_index][name] = content_right_switches.add{type="switch", name="rf-"..name,
                        style = "rf_reactor_control_switch", left_label_caption="OFF", right_label_caption="ON", tags={unit_number=un}, switch_state=global.reactors[un][name:gsub("-", "_")]
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
                            local v = global.reactors[un][name:gsub("-", "_")]
                            local slider = content_right_vars.add{type="slider", name="rf-"..name, style="rf_reactor_control_notched_slider",
                                value=v, maximum_value=100, value_step=10, tags={unit_number=un}
                            }; slider.style.width = 103
                            if global.reactors[un].systems == "left" then slider.enabled = false; v = "OFF" end
                            local value_frame = content_right_vars.add{type="frame", name="rf-"..name.."-value-frame", style="slot_button_deep_frame"}
                            local value = value_frame.add{type="label", name="rf-"..name.."-value", caption=((v or "OFF").."%"):sub(1,3)}
                                value.style.width = 30
                                value.style.horizontal_align = "center"
                            global.reactors[un].guis.sliders[event.player_index][name] = slider
                        else
                            paddingh(content_right_vars, 0)
                            paddingh(content_right_vars, pad_slider)
                        end
                    end

                    padding(content_sections.right, 5)

                    local content_right_stats = content_sections.right.add{type="table", name="table-"..prefix:lower().."-stats", column_count=4}
                        content_right_stats.style.top_cell_padding = 3
                        content_right_stats.style.bottom_cell_padding = 3
                    global.reactors[un].guis.bars[event.player_index][prefix:lower()] = slider_progressbar(un, content_right_stats,
                        prefix:lower(), prefix.." in plasma", "%",
                        pad_progressbar, nil, nil, "progressbar", nil,
                        "statistics_progressbar", nil, 99, 60
                    )

                    padding(content_sections.right, 5)
                    line(content_sections.right)
                end

                gas_section("Deuterium", 0)
                --gas_section("Deuterium", 0, {0,30}, 133)
                gas_section("Tritium", 20)
                gas_section("Helium-3", 7)
                --gas_section("Helium-3", 7, {30,0}, 133)
                gas_section("Helium-4", 7, {-1,-1})

                --[[global.reactors[un].guis.bars[event.player_index]["lithium-stored"] = slider_progressbar(un, content_sections.right.add{type="flow", name="table-stats-right-lithium"},
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

                global.reactors[un].guis.choice_elems[event.player_index]["reactor-recipe"] = recipe
                global.reactors[un].guis.choice_elems[event.player_index]["controller-tech"] = controller]]
                -- #endregion --

                -- #region CENTER --
                local wall_integrity = content_sections.center.add{type="flow", name="table-stats-right-wall-integrity"}
                paddingh(wall_integrity)
                --global.reactors[un].guis.bars[event.player_index]["wall-integrity"] = slider_progressbar(un, wall_integrity,
                --    "wall-integrity", "Wall integrity", nil, nil, nil, "progressbar",
                --    "electric_satisfaction_progressbar",5, 82, 0
                --)
                local slider = wall_integrity.add{type="progressbar", name="rf-wall-integrity", style="electric_satisfaction_progressbar",
                    value=global.reactors[un].wall_integrity,tags={unit_number=un}, maximum_value=100, caption="INTERNAL REACTOR WALL INTEGRITY"
                };
                    slider.style.width = 400;
                    slider.style.height = 18
                    --slider.style.top_margin = 5
                    slider.style.bar_width = 18
                    slider.style.horizontal_align = "center"
                    slider.style.font = "default-small-semibold"
                global.reactors[un].guis.bars[event.player_index]["wall-integrity"] = slider
                paddingh(wall_integrity)

                global.reactors[un].guis.sprites[event.player_index] = content_sections.center.add{type="sprite", name="rf-reactor-sprite", tags={unit_number=un},
                    --sprite = "rf-gui-plasma-sprite-1"
                }; global.reactors[un].guis.sprites[event.player_index].style.left_padding = 10
                -- #endregion --

                player.opened = window
            end
        end)
    end
end)
-- #endregion --