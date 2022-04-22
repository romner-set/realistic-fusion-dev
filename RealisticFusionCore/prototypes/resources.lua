rfcore.resource_autoplace.initialize_patch_set("rf-brine", false)

data:extend{
    {
		type = "autoplace-control",
		name = "rf-brine",
		localised_name = {"", "[entity=rf-brine] ", {"entity-name.rf-brine"}},
		richness = true,
		order = "b-z",
		category = "resource"
    },
    {
		type = "resource",
		name = "rf-brine",
		icon = "__RealisticFusionCore__/graphics/entities/brine-resource.png",
		icon_size = 120,
		flags = {"placeable-neutral"},
		category = "basic-fluid",
		subgroup = "raw-resource",
		order="a-b-z",
		infinite = true,
		highlight = true,
		minimum = 1000000,
		normal = 5000000,
		infinite_depletion_amount = 50,
		resource_patch_search_radius = 12,
		tree_removal_probability = 0.7,
		tree_removal_max_distance = 32 * 32,
		minable = {
			mining_time = 1,
			results = {
				{
					type = "fluid",
					name = "rf-brine",
					amount_min = 100,
					amount_max = 100,
					probability = 1
				}
			}
		},
		walking_sound = rfcore.sounds.oil,
		collision_box = {{-1.4, -1.4}, {1.4, 1.4}},
		selection_box = {{-0.5, -0.5}, {0.5, 0.5}},
		autoplace = rfcore.resource_autoplace.resource_autoplace_settings{
			name = "rf-brine",
			order = "c", -- Other resources are "b"; oil won't get placed if something else is already there.
			base_density = 11,
			base_spots_per_km2 = 1.8,
			random_probability = 1/48,
			random_spot_size_minimum = 1,
			random_spot_size_maximum = 1, -- don't randomize spot size
			additional_richness = 5000000, -- this increases the total everywhere, so base_density needs to be decreased to compensate
			has_starting_area_placement = false,
			regular_rq_factor_multiplier = 1
		},
		stage_counts = {0},
		stages = {
			sheet = {
				filename = "__RealisticFusionCore__/graphics/entities/brine-resource.png",
				priority = "extra-high",
				width = 148,
				height = 120,
				frame_count = 4,
				variation_count = 1,
				shift = util.by_pixel(0, -2),
				scale = 0.5
			}
		},
		map_color = {150,150,150,255},--{169,150,100,128},
		map_grid = false
    }
}