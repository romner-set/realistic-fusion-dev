local sheet = "__RealisticFusionPower__/graphics/gui/reactor-gui.png"

-- #region BUTTONS & SLIDERS & STUFF --
local bar = {
    base = {filename = sheet, position = {0, 0}, corner_size = 8},
    shadow = {
        position = {200, 128},
        corner_size = 8,
        tint = {0,0.08,0.1,0.4},
        scale = 0.5,
        draw_type = "outer"
    }
}

local notched_slider = table.deepcopy(data.raw["gui-style"].default.notched_slider)
    notched_slider.full_bar = bar
    notched_slider.button.hovered_graphical_set = {
        base = {filename = sheet, position = {17, 0}, size = {24, 35}},
        glow = {
            center = {position = {96, 184}, size = {40, 48}},
            top_outer_border_shift = -2,
            left_outer_border_shift = -4,
            right_outer_border_shift = 4,
            bottom_outer_border_shift = 4,
            tint = {106, 177, 225},
            draw_type = "outer"
        }
    }
    notched_slider.button.clicked_graphical_set.base = {filename = sheet, position = {41, 0}, size = {24, 35}}

local slider = table.deepcopy(data.raw["gui-style"].default.slider)
    slider.full_bar = bar
    slider.button.hovered_graphical_set = {
        base = {filename = sheet, position = {0, 95}, size = {40, 24}},
        glow = {
            center = {position = {96, 184}, size = {40, 48}},
            top_outer_border_shift = -2,
            left_outer_border_shift = -4,
            right_outer_border_shift = 4,
            bottom_outer_border_shift = 4,
            tint = {106, 177, 225},
            draw_type = "outer"
        }
    }
    slider.button.clicked_graphical_set.base = {filename = sheet, position = {40, 95}, size = {40, 24}}

local switch = table.deepcopy(data.raw["gui-style"].default.switch)
    switch.active_label.font_color = {100, 190, 241}
    switch.inactive_label.hovered_font_color = {192, 230, 255}
    switch.hover_background = {filename = sheet, position = {0, 35}, size = {64, 32}}
    switch.button.hovered_graphical_set = {filename = sheet, position = {0, 66}, size = 28}
    switch.button.clicked_graphical_set = {filename = sheet, position = {28, 66}, size = 28}

data.raw["gui-style"].default.rf_reactor_control_notched_slider = notched_slider
data.raw["gui-style"].default.rf_reactor_control_slider = slider
data.raw["gui-style"].default.rf_reactor_control_switch = switch
-- #endregion --

-- #region PLASMA ANIMATION --
local sprites = {}
for _,prefix in ipairs{"a",""} do
    for _,k in ipairs{"max", "med", "min"} do
        for i=1,29 do
            local n = 400*(i-1)
            table.insert(sprites, {
                type = "sprite",
                name = "rf-gui-plasma-"..prefix.."neutronic-"..k.."-"..i,
                filename = "__RealisticFusionPower__/graphics/gui/plasma-"..prefix.."neutronic/"..k..".png",
                size = {400,343}, --tint = {0.82,0.82,0.82}, --apparently this is just the -soft in additive-soft
                blend_mode = "additive-soft",
                position = {n%2000, 343*math.floor(n/2000)} --pos in spritesheet
            })
        end
    end
    for _,k in ipairs{"max-med", "med-min"} do
        for i=1,29 do
            local n = 400*(i-1)
            table.insert(sprites, {
                type = "sprite",
                name = "rf-gui-plasma-"..prefix.."neutronic-"..k.."-"..i,
                filename = "__RealisticFusionPower__/graphics/gui/plasma-"..prefix.."neutronic/"..k:sub(1,3)..".png",
                size = {400,343}, tint = {0.9,0.9,0.9},
                blend_mode = "additive-soft",
                position = {n%2000, 343*math.floor(n/2000)}
            })
        end
    end
end
data:extend(sprites)
-- #endregion --