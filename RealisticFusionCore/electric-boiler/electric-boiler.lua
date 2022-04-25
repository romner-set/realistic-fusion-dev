data:extend{
    -- Add an electric boiler if angels petrochem not present --
    -- All textures and code are from angels petrochem: https://mods.factorio.com/mod/angelspetrochem
    -- To (hopefully) comply with CC BY-NC-ND 4.0, all changes made are indicated in comments starting with --*
    -- #region ANGEL'S CODE --
    {
        type = "item",
        name = "angels-electric-boiler",
        icons = {
            {
                icon = "__RealisticFusionCore__/electric-boiler/icon.png" --*replaced "__angelspetrochem__/graphics/icons/electric-boiler.png" with "__RealisticFusionCore__/electric-boiler/icon.png"
            },
            --[[{ --*section commented out
            icon = "__angelsrefining__/graphics/icons/num_1.png",
            tint = angelsmods.refining.number_tint,
            scale = 0.32,
            shift = {-12, -12}
            }]]
        },
        icon_size = 32,
        subgroup = "production-machine", --*replaced boiler-building with production-machine
        order = "g[centrifuge]z[realistic-fusion]-a[deuterium]-a[boiler]", --*replaced "c[electric-boiler]-a" with "g[centrifuge]z[realistic-fusion]-a[deuterium]-a[boiler]"
        place_result = "angels-electric-boiler",
        stack_size = 10
        ,localised_name = {"rf.electric-boiler"}, localised_description = {"rf.electric-boiler-description", "rf-heavy-water", "water"}, --*added line
    },
    {
        type = "assembling-machine",
        name = "angels-electric-boiler",
        icons = {
            {
                icon = "__RealisticFusionCore__/electric-boiler/icon.png" --*replaced "__angelspetrochem__/graphics/icons/electric-boiler.png" with "__RealisticFusionCore__/electric-boiler/icon.png"
            },
            --[[{ --*section commented out
            icon = "__angelsrefining__/graphics/icons/num_1.png",
            tint = angelsmods.refining.number_tint,
            scale = 0.32,
            shift = {-12, -12}
            }]]
        },
        icon_size = 32,
        flags = {"placeable-neutral", "player-creation"},
        minable = {mining_time = 1, result = "angels-electric-boiler"},
        --fast_replaceable_group = "angels-electric-boiler", --*line commented out
        --next_upgrade = "angels-electric-boiler-2", --*line commented out
        max_health = 200,
        corpse = "small-remnants",
        collision_box = {{-1.29, -1.29}, {1.29, 1.29}},
        selection_box = {{-1.5, -1.5}, {1.5, 1.5}},
        module_specification = {
            module_slots = 0
        },
        allowed_effects = {"consumption", "speed", "pollution"},
        crafting_categories = {"rf-boiling"}, --*replaced ""petrochem-boiler"" with ""rf-boiling""
        crafting_speed = 1,
        energy_source = {
            type = "electric",
            usage_priority = "secondary-input",
            emissions_per_minute = 0.01 * 60,
            drain = "40kW"
        },
        energy_usage = "1160kW", -- with drain power this comes exactly to 1.2 MW, produces 40/s steam (at speed 1)
        animation = {
            north = {
                filename = "__RealisticFusionCore__/electric-boiler/boiler-north-on.png", --*replaced __angelspetrochem__/graphics/entity/ with __RealisticFusionCore__/
                frame_count = 1,
                width = 160,
                height = 160,
                shift = {0, 0}
            },
                east = {
                filename = "__RealisticFusionCore__/electric-boiler/boiler-east-on.png", --*replaced __angelspetrochem__/graphics/entity/ with __RealisticFusionCore__/
                frame_count = 1,
                width = 160,
                height = 160,
                shift = {0, 0}
            },
                south = {
                filename = "__RealisticFusionCore__/electric-boiler/boiler-south-on.png", --*replaced __angelspetrochem__/graphics/entity/ with __RealisticFusionCore__/
                frame_count = 1,
                width = 160,
                height = 160,
                shift = {0, 0}
            },
                west = {
                filename = "__RealisticFusionCore__/electric-boiler/boiler-west-on.png", --*replaced __angelspetrochem__/graphics/entity/ with __RealisticFusionCore__/
                frame_count = 1,
                width = 160,
                height = 160,
                shift = {0, 0}
            }
        },
        idle_animation = {
            north = {
                filename = "__RealisticFusionCore__/electric-boiler/boiler-north-off.png", --*replaced __angelspetrochem__/graphics/entity/ with __RealisticFusionCore__/
                frame_count = 1,
                width = 160,
                height = 160,
                shift = {0, 0}
            },
            east = {
                filename = "__RealisticFusionCore__/electric-boiler/boiler-east-off.png", --*replaced __angelspetrochem__/graphics/entity/ with __RealisticFusionCore__/
                frame_count = 1,
                width = 160,
                height = 160,
                shift = {0, 0}
            },
            south = {
                filename = "__RealisticFusionCore__/electric-boiler/boiler-south-off.png", --*replaced __angelspetrochem__/graphics/entity/ with __RealisticFusionCore__/
                frame_count = 1,
                width = 160,
                height = 160,
                shift = {0, 0}
            },
            west = {
                filename = "__RealisticFusionCore__/electric-boiler/boiler-west-off.png", --*replaced __angelspetrochem__/graphics/entity/ with __RealisticFusionCore__/
                frame_count = 1,
                width = 160,
                height = 160,
                shift = {0, 0}
            }
        },
        vehicle_impact_sound = {filename = "__base__/sound/car-metal-impact.ogg", volume = 0.65},
        working_sound = {
            sound = {
                filename = "__base__/sound/boiler.ogg",
                volume = 0.8
            },
            max_sounds_per_type = 3
        },
        fluid_boxes = {
            {
                production_type = "input",
                pipe_covers = pipecoverspictures(),
                height = 2,
                base_area = 1,
                base_level = -1,
                pipe_connections = {
                    {type = "input-output", position = {-2, 0}},
                    {type = "input-output", position = {2, 0}}
                }
            },
            {
                production_type = "output",
                pipe_covers = pipecoverspictures(),
                base_area = 1,
                base_level = 1,
                height = 2, --*added line
                pipe_connections = {
                    {type = "output", position = {0, -2}}
                }
            },
            {
                production_type = "output",
                pipe_covers = pipecoverspictures(),
                base_area = 1,
                base_level = 1,
                pipe_connections = {
                    {type = "output", position = {0, 2}}
                }
            }
        }
        , result_inventory_size = 0, source_inventory_size = 0, --*added line
        localised_name = {"rf.electric-boiler"}, localised_description = {"rf.electric-boiler-description", "rf-heavy-water", "water"}, --*added line
        se_allow_in_space = true, --*added line
    },
    -- #endregion --
}