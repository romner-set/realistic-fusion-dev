return {
	magnetic_pipe_pictures = function()
		local pictures = {
			horizontal_window_background = rfcore.empty_sprite,
			vertical_window_background = rfcore.empty_sprite,
			fluid_background = rfcore.empty_sprite,
			low_temperature_flow = rfcore.empty_sprite,
			middle_temperature_flow = rfcore.empty_sprite,
			high_temperature_flow = rfcore.empty_sprite,
			gas_flow = rfcore.empty_sprite,
		}

		for _,k in ipairs{
			"straight_vertical_single", "straight_vertical", "straight_vertical_window", "straight_horizontal_window", "straight_horizontal",
			"corner_up_right", "corner_up_left", "corner_down_right", "corner_down_left",
			"t_up", "t_down", "t_right", "t_left",
			"cross",
			"ending_up", "ending_down", "ending_right", "ending_left"
		} do
			local filename = k:gsub("_window", ""):gsub("_", "-")..".png"
			local size = 64
			if k == "straight_vertical_single" then size = 80 end
		
			pictures[k] = {
				filename = "__RealisticFusionCore__/graphics/entities/magnetic-pipe/pipe-"..filename,
				priority = "extra-high",
				size = size,
				hr_version = {
					filename = "__RealisticFusionCore__/graphics/entities/magnetic-pipe/hr-pipe-"..filename,
					priority = "extra-high",
					size = size*2,
					scale = 0.5
				}
			}
		end

		return pictures
	end,

	magnetic_pipe_to_ground_pictures = function()
		local pictures = {}
		for _,k in ipairs{"up", "down", "left", "right"} do
			pictures[k] = {
				filename = "__RealisticFusionCore__/graphics/entities/magnetic-pipe/pipe-to-ground-"..k..".png",
				priority = "high",
				width = 64,
				height = 64, --, shift = {0.10, -0.04}
				hr_version = {
					filename = "__RealisticFusionCore__/graphics/entities/magnetic-pipe/hr-pipe-to-ground-"..k..".png",
					priority = "extra-high",
					width = 128,
					height = 128,
					scale = 0.5
				}
			}
		end
		return pictures
	end,

	magnetic_pipe_covers_pictures = function()
		local pictures = {}
		for _,k in ipairs{"north", "south", "west", "east"} do
			pictures[k] = {
				layers = {
					{
						filename = "__RealisticFusionCore__/graphics/entities/magnetic-pipe/pipe-cover-"..k..".png",
						priority = "extra-high",
						width = 64,
						height = 64,
						hr_version = {
							filename = "__RealisticFusionCore__/graphics/entities/magnetic-pipe/hr-pipe-cover-"..k..".png",
							priority = "extra-high",
							width = 128,
							height = 128,
							scale = 0.5
						}
					},
					{
						filename = "__base__/graphics/entity/pipe-covers/pipe-cover-"..k.."-shadow.png",
						priority = "extra-high",
						width = 64,
						height = 64,
						draw_as_shadow = true,
						hr_version = {
							filename = "__base__/graphics/entity/pipe-covers/hr-pipe-cover-"..k.."-shadow.png",
							priority = "extra-high",
							width = 128,
							height = 128,
							scale = 0.5,
							draw_as_shadow = true
						}
					}
				}
			}
		end
		return pictures
	end,

	magnetic_pump_pictures = function ()
		local pictures = {}

		for k,v in pairs{
			north = {
				size = {53, 79}, shift = util.by_pixel(8.000, 7.500),
				hr = {size = {103, 164}, shift = util.by_pixel(8, 3.5)}
			},
			south = {
				size = {62, 87}, shift = util.by_pixel(13.5, 0.5),
				hr = {size = {114, 160}, shift = util.by_pixel(12.5, -8)}
			},
			west = {
				size = {69, 51}, shift = util.by_pixel(0.5, -0.5),
				hr = {size = {131, 111}, shift = util.by_pixel(-0.25, 1.25)}
			},
			east = {
				size = {66, 60}, shift = util.by_pixel(0, 4),
				hr = {size = {130, 109}, shift = util.by_pixel(-0.5, 1.75)}
			},
		} do
			pictures[k] = {
				filename = "__RealisticFusionCore__/graphics/entities/magnetic-pipe/pump/pump-"..k..".png",
				size = v.size,
				line_length =8,
				frame_count =32,
				animation_speed = 0.5,
				shift = v.shift,
				hr_version = {
					filename = "__RealisticFusionCore__/graphics/entities/magnetic-pipe/pump/hr-pump-"..k..".png",
					size = v.hr.size,
					scale = 0.5,
					line_length =8,
					frame_count =32,
					animation_speed = 0.5,
					shift = v.hr.shift
				}
			}
		end

		return pictures
	end,
}