-- #region SPRITES --
--each used more than once
local gas_mixer = {
    {layers = {
        {filename = "__RealisticFusionCore__/graphics/entities/light-isotope-processor-0.png", size = 320, scale = 0.5},
        {filename = "__RealisticFusionCore__/graphics/entities/shadows/light-isotope-processor-0.png", size = 320, scale = 0.5, draw_as_shadow = true}
    }},
    {layers = {
        {filename = "__RealisticFusionCore__/graphics/entities/light-isotope-processor-1.png", size = 320, scale = 0.5},
        {filename = "__RealisticFusionCore__/graphics/entities/shadows/light-isotope-processor-1.png", size = 320, scale = 0.5, draw_as_shadow = true}
    }},
    {filename = "__RealisticFusionCore__/graphics/entities/light-isotope-processor-0-powered.png", size = 320, scale = 0.5},
    {filename = "__RealisticFusionCore__/graphics/entities/light-isotope-processor-1-powered.png", size = 320, scale = 0.5}
}
local electrolyser = {
    {layers = {
        {filename = "__RealisticFusionCore__/graphics/entities/electrolyser-0.png", size = 160, shift = {0, -0.25}},
        {filename = "__RealisticFusionCore__/graphics/entities/shadows/electrolyser-0.png", size = 160, draw_as_shadow = true, shift = {0, -0.25}}
    }},
    {layers = {
        {filename = "__RealisticFusionCore__/graphics/entities/electrolyser-1.png", size = 160},
        {filename = "__RealisticFusionCore__/graphics/entities/shadows/electrolyser-1.png", size = 160, draw_as_shadow = true}
    }},
}

local thermal_ep = {
    base = {
        filename = "__RealisticFusionCore__/graphics/entities/thermal-evaporation-plant.png",
        size = 512,
        scale = 0.5,
        shift = {0.7, -1.5},
    },
    vertical = {
        filename = "__RealisticFusionCore__/graphics/entities/thermal-evaporation-plant-pipes-vertical.png",
        size = 512,
        scale = 0.5,
        shift = {0.7, -1.5},
    },
    horizontal = {
        filename = "__RealisticFusionCore__/graphics/entities/thermal-evaporation-plant-pipes-horizontal.png",
        size = 512,
        scale = 0.5,
        shift = {0.7, -1.5},
    },
    shadow = {
        filename = "__RealisticFusionCore__/graphics/entities/shadows/thermal-evaporation-plant.png",
        size = 512,
        scale = 0.5,
        shift = {0.7, -1.5},
        draw_as_shadow = true
    }
}
-- #endregion --

-- #region DATA --
data:extend{
    -- #region MAGNETIC PIPES AND PUMP --
    {
        type = "pipe",
        name = "rf-m-magnetic-pipe",
        icon = "__base__/graphics/icons/pipe.png", --TODO
        icon_size = 64, icon_mipmaps = 4,
        flags = {"placeable-neutral", "player-creation"},
        minable = {mining_time = 0.1, result = "rf-m-magnetic-pipe"},
        max_health = 500,
        corpse = "pipe-remnants", --TODO
        dying_explosion = "pipe-explosion",
        resistances = {
            {
                type = "fire",
                percent = 100
            },
            {
                type = "impact",
                percent = 40
            },
            {
                type = "explosion",
                percent = 20
            }
        },
        fast_replaceable_group = "pipe",
        collision_box = {{-0.29, -0.29}, {0.29, 0.29}},
        selection_box = {{-0.5, -0.5}, {0.5, 0.5}},
        damaged_trigger_effect = rfcore.hit_effects.entity(),
        fluid_box = {
            base_area = 1,
            pipe_connections = {
                { position = {0, -1} },
                { position = {1, 0} },
                { position = {0, 1} },
                { position = {-1, 0} }
            }
        },
        vehicle_impact_sound = rfcore.sounds.generic_impact,
        pictures = rfcore.magnetic_pipe_pictures(),
        working_sound = {
            sound = rfcore.sounds.pipe,
            match_volume_to_activity = true,
            audible_distance_modifier = 0.3,
            fade_in_ticks = 4,
            fade_out_ticks = 60
        },
        open_sound = rfcore.sounds.machine_open,
        close_sound = rfcore.sounds.machine_close,

        horizontal_window_bounding_box = {{0, 0}, {0, 0}},
        vertical_window_bounding_box = {{0, 0}, {0, 0}},
        se_allow_in_space = true
    },

    {
        type = "pipe-to-ground",
        name = "rf-m-magnetic-pipe-to-ground",
        icon = "__base__/graphics/icons/pipe-to-ground.png", --TODO
        icon_size = 64, icon_mipmaps = 4,
        flags = {"placeable-neutral", "player-creation"},
        minable = {mining_time = 0.1, result = "rf-m-magnetic-pipe-to-ground"},
        max_health = 150,
        corpse = "pipe-to-ground-remnants", --TODO
        dying_explosion = "pipe-to-ground-explosion",
        resistances = {
            {
                type = "fire",
                percent = 100
            },
            {
                type = "impact",
                percent = 40
            },
            {
                type = "explosion",
                percent = 20
            }
        },
        fast_replaceable_group = "pipe",
        collision_box = {{-0.29, -0.29}, {0.29, 0.2}},
        selection_box = {{-0.5, -0.5}, {0.5, 0.5}},
        damaged_trigger_effect = rfcore.hit_effects.entity(),
        fluid_box = {
            base_area = 1,
            pipe_covers = rfcore.magnetic_pipe_covers_pictures(),
            pipe_connections = {
                {position = {0, -1}},
                {
                    position = {0, 1},
                    max_underground_distance = 10
                }
            }
        },
        vehicle_impact_sound = rfcore.sounds.generic_impact,
        working_sound = {
            sound = rfcore.sounds.pipe,
            match_volume_to_activity = true,
            audible_distance_modifier = 0.3,
            fade_in_ticks = 4,
            fade_out_ticks = 60
        },
        open_sound = rfcore.sounds.machine_open,
        close_sound = rfcore.sounds.machine_close,
        pictures = rfcore.magnetic_pipe_to_ground_pictures()
    },

    {
        type = "pump",
        name = "rf-m-magnetic-pump",
        icon = "__base__/graphics/icons/pump.png", --TODO
        icon_size = 64, icon_mipmaps = 4,
        flags = {"placeable-neutral", "player-creation"},
        minable = {mining_time = 0.2, result = "rf-m-magnetic-pump"},
        max_health = 180,
        fast_replaceable_group = "pipe",
        corpse = "pump-remnants", --TODO
        dying_explosion = "pump-explosion",
        collision_box = {{-0.29, -0.9}, {0.29, 0.9}},
        selection_box = {{-0.5, -1}, {0.5, 1}},
        working_sound = {
            sound = {
                filename = "__base__/sound/pump.ogg",
                volume = 0.3
            },
            audible_distance_modifier = 0.5,
            max_sounds_per_type = 2
        },
        damaged_trigger_effect = rfcore.hit_effects.entity(),
        resistances = {
            {
                type = "fire",
                percent = 100
            },
            {
                type = "impact",
                percent = 40
            },
            {
                type = "explosion",
                percent = 20
            }
        },
        fluid_box = {
            base_area = 1,
            height = 4,
            pipe_covers = rfcore.magnetic_pipe_covers_pictures(),
            pipe_connections =
            {
                {position = {0, -1.5}, type="output"},
                {position = {0, 1.5}, type="input"}
            }
        },
        energy_source = {
            type = "electric",
            usage_priority = "secondary-input",
            drain = "100kW"
        },
        energy_usage = "900kW",
        pumping_speed = 200,
        vehicle_impact_sound = rfcore.sounds.generic_impact,
        open_sound = rfcore.sounds.machine_open,
        close_sound = rfcore.sounds.machine_close,
        animations = rfcore.magnetic_pump_pictures(),

        circuit_wire_connection_points = circuit_connector_definitions["pump"].points,
        circuit_connector_sprites = circuit_connector_definitions["pump"].sprites,
        circuit_wire_max_distance = default_circuit_wire_max_distance
    },
    -- #endregion --

    -- PLASMA HEATER --
    {
        type = "assembling-machine",
        name = "rf-m-heater",
        icon = "__RealisticFusionCore__/graphics/icons/heater.png",
        icon_size = 64,
        max_health = 1000,
        repair_sound = {filename = "__base__/sound/manual-repair-simple.ogg"},
        mined_sound = {filename = "__base__/sound/deconstruct-bricks.ogg",volume = 0.8},
        vehicle_impact_sound = rfcore.sounds.generic_impact,
        open_sound = rfcore.sounds.machine_open,
        close_sound = rfcore.sounds.machine_close,
        tile_width = 9, tile_height = 9,
        collision_box = {{-4.25, -4.25}, {4.25, 4.25}},
        selection_box = {{-4.5, -4.5}, {4.5, 4.5}},
        flags = {"not-rotatable", "placeable-neutral", "placeable-player", "player-creation", "not-flammable", "not-upgradable"},
        minable = {mining_time = 1.5, result= "rf-m-heater"},
        crafting_categories = {"rf-heating"},
        crafting_speed = 1,
        scale_entity_info_icon = true,
        energy_source = {
            type = "electric",
            usage_priority = "primary-input",
            input_flow_limit = "1TW",
            drain = "0W"
        },
        fluid_boxes = {
            {
                base_area = 1,
                height = 2,
                base_level = 1,
                pipe_connections = {
                    {type = "output", position = {5, 4}},
                    {type = "output", position = {4, 5}},
                    {type = "output", position = {3, 5}}
                },
                production_type = "output"
            },
            {
                base_area = 1,
                height = 2,
                base_level = -1,
                pipe_covers = {
                    filename = "__RealisticFusionCore__/graphics/entities/heater-pipe-cover.png",
                    size = 64,
                    scale = 1.1,
                    shift = util.by_pixel(-1, 1)
                },
                pipe_connections = {
                    {type = "input-output", position = {-5, 3}},
                    {type = "input-output", position = {-5, 2}},
                },
                production_type = "input"
            },
            {
                base_area = 1,
                height = 2,
                base_level = -1,
                pipe_covers = {
                    filename = "__RealisticFusionCore__/graphics/entities/heater-pipe-cover.png",
                    size = 64,
                    scale = 1.1,
                    shift = util.by_pixel(-1, 1)
                },
                pipe_connections = {{type = "input-output", position = {-5, 0}}},
                production_type = "input"
            }
        },
        energy_usage = "400MW",
        idle_animation = {layers = {
            {
                filename = "__RealisticFusionCore__/graphics/entities/heater.png",
                size = {328, 320},
                scale = 1.1,
                shift = util.by_pixel(27, 1),
            },
            {
                filename = "__RealisticFusionCore__/graphics/entities/shadows/heater.png",
                size = {328, 320},
                scale = 1.1,
                shift = util.by_pixel(27, 1),
                draw_as_shadow = true
            }
        }},
        always_draw_idle_animation = true,
        result_inventory_size = 0,
        source_inventory_size = 0,
        se_allow_in_space = true
    },

    -- GAS MIXER --
    {
        name = "rf-light-isotope-processor",
        type = "assembling-machine",
        icon = "__RealisticFusionCore__/graphics/icons/light-isotope-processor.png",
        icon_size = 64,
        max_health = 500,
        repair_sound = {filename = "__base__/sound/manual-repair-simple.ogg"},
        mined_sound = {filename = "__base__/sound/deconstruct-bricks.ogg",volume = 0.8},
        vehicle_impact_sound = rfcore.sounds.generic_impact,
        open_sound = rfcore.sounds.machine_open,
        close_sound = rfcore.sounds.machine_close,
        tile_width = 3, tile_height = 3,
        flags = {"placeable-neutral", "placeable-player", "player-creation", "not-flammable", "not-upgradable"},
        minable = {mining_time = 0.5, result= "rf-light-isotope-processor"},
        crafting_categories = {"rf-light-isotope-processing"},
        crafting_speed = 1,
        collision_box = {{-1.25, -1.25}, {1.25, 1.25}},
        selection_box = {{-1.5, -1.5}, {1.5, 1.5}},
        fluid_boxes = {
            {
                base_area = 10,
                base_level = 1,
                pipe_connections = {
                    {type = "output", position = {-1, -2}},
                    {type = "output", position = {1, -2}}
                },
                production_type = "output"
            },
            {
                base_area = 10,
                base_level = -1,
                pipe_connections = {{type = "input-output", position = {1, 2}}},
                production_type = "input"
            },
            {
                base_area = 10,
                base_level = -1,
                pipe_connections = {
                    {type = "input-output", position = {-1, 2}},
                },
                production_type = "input"
            }
        },
        always_draw_idle_animation = true,
        idle_animation = {north = gas_mixer[1], west = gas_mixer[2], south = gas_mixer[1], east = gas_mixer[2]},
        working_visualisations = {{
            north_animation = gas_mixer[3],
            west_animation = gas_mixer[4],
            south_animation = gas_mixer[3],
            east_animation = gas_mixer[4]
        }},
        energy_usage = "200kW",
        energy_source = {
            type = "electric",
            usage_priority = "secondary-input",
            drain = "10kW"
        },
        se_allow_in_space = true
    },

    -- ELECTOLYSER --
    {
        type = "assembling-machine",
        name = "rf-electrolyser",
        icon = "__RealisticFusionCore__/graphics/icons/electrolyser.png",
        localised_description = {"rf.electrolyser", "rf-heavy-water", "rf-deuterium"},
        icon_size = 32,
        max_health = 600,
        repair_sound = {filename = "__base__/sound/manual-repair-simple.ogg"},
        mined_sound = {filename = "__base__/sound/deconstruct-bricks.ogg",volume = 0.8},
        vehicle_impact_sound = rfcore.sounds.generic_impact,
        open_sound = rfcore.sounds.machine_open,
        close_sound = rfcore.sounds.machine_close,
        tile_width = 15, tile_height = 15,
        flags = {"placeable-neutral", "placeable-player", "player-creation", "not-flammable", "not-upgradable"},
        minable = {mining_time = 0.5, result= "rf-electrolyser"},
        crafting_categories = {"rf-electrolysis"},
        crafting_speed = 1,
        collision_box = {{-1.25, -1.25}, {1.25, 1.25}},
        selection_box = {{-1.5, -1.5}, {1.5, 1.5}},
        fluid_boxes = {
            {
                base_area = 10,
                base_level = 1,
                pipe_covers = pipecoverspictures(),
                pipe_connections = {
                    {type = "output", position = {-1, -2}}
                },
                production_type = "output"
            },
            {
                base_area = 10,
                base_level = 1,
                pipe_covers = pipecoverspictures(),
                pipe_connections = {
                    {type = "output", position = {1, -2}}
                },
                production_type = "output"
            },
            {
                base_area = 10,
                base_level = -1,
                pipe_covers = pipecoverspictures(),
                pipe_connections = {
                    {type = "input-output", position = {-1, 2}},
                    {type = "input-output", position = {1, 2}}
                },
                production_type = "input"
            }
        },
        always_draw_idle_animation = true,
        idle_animation = {north = electrolyser[1], west = electrolyser[2], south = electrolyser[1], east = electrolyser[2]},
        working_visualisations = {{
            north_animation = electrolyser[1],
            west_animation = electrolyser[2],
            south_animation = electrolyser[1],
            east_animation = electrolyser[2]
        }},
        energy_usage = "1990kW",
        energy_source = {
            type = "electric",
            usage_priority = "secondary-input",
            drain = "10kW"
        },
        source_inventory_size = 0,
        result_inventory_size = 0,
        se_allow_in_space = true
    },

    -- DISCHARGE PUMP --
    {
        type = "assembling-machine",
        name = "rf-discharge-pump",
        icons = {{icon = "__base__/graphics/icons/offshore-pump.png", tint = {0,0.5,1}}},
        icon_size = 64, icon_mipmaps = 4,
        flags = {"placeable-neutral", "player-creation", "filter-directions"},
        collision_mask = { "ground-tile", "object-layer" },
        center_collision_mask = { "water-tile", "object-layer", "player-layer" },
        fluid_box_tile_collision_test = { "ground-tile" },
        adjacent_tile_collision_test = { "water-tile" },
        adjacent_tile_collision_mask = { "ground-tile" },
        adjacent_tile_collision_box = { { -1, -2 }, { 1, -1 } },
        minable = {mining_time = 0.1, result = "rf-discharge-pump"},
        localised_description = {"rf.discharge-pump", "rf-depleted-water"},
        max_health = 150,
        corpse = "offshore-pump-remnants",
        dying_explosion = "offshore-pump-explosion",
        fluid = "water",
        resistances =
        {
            {
            type = "fire",
            percent = 70
            },
            {
            type = "impact",
            percent = 30
            }
        },
        collision_box = {{-0.6, -1.05}, {0.6, 0.3}},
        selection_box = {{-0.6, -1.49}, {0.6, 0.49}},
        energy_usage = "1W",
        energy_source = {type = "void"},
        crafting_speed = 1,
        crafting_categories = {"rf-water-discharging"},
        fixed_recipe = "rf-depleted-water-discharging",
        fluid_boxes = {
            {
                base_area = 5,
                base_level = -9,
                height = 10,
                pipe_covers = pipecoverspictures(),
                production_type = "input",
                filter = "rf-depleted-water",
                pipe_connections = {
                    {
                        position = {0, 1},
                        type = "input"
                    }
                }
            },
            {
                base_area = 1,
                base_level = 1,
                height = 1,
                production_type = "output",
                pipe_connections = {
                    {
                        position = {0, -2},
                        type = "output"
                    }
                }
            }
        },
        tile_width = 1,
        tile_height = 1,
        vehicle_impact_sound = rfcore.sounds.generic_impact,
        open_sound = rfcore.sounds.machine_open,
        close_sound = rfcore.sounds.machine_close,
        working_sound =
        {
            sound =
            {
            {
                filename = "__base__/sound/offshore-pump.ogg",
                volume = 0.5
            }
            },
            match_volume_to_activity = true,
            audible_distance_modifier = 0.7,
            max_sounds_per_type = 3,
            fade_in_ticks = 4,
            fade_out_ticks = 20,
        },
        animation =
        {
            north =
            {
                layers =
                {
                    {
                        filename = "__base__/graphics/entity/offshore-pump/offshore-pump_North.png",
                        priority = "high",
                        line_length = 8,
                        frame_count = 32,
                        animation_speed = 0.25,
                        width = 48,
                        height = 84,
                        shift = util.by_pixel(-2, -16),
                        tint = {0,0.5,1},
                        hr_version =
                        {
                            filename = "__base__/graphics/entity/offshore-pump/hr-offshore-pump_North.png",
                            priority = "high",
                            line_length = 8,
                            frame_count = 32,
                            animation_speed = 0.25,
                            width = 90,
                            height = 162,
                            shift = util.by_pixel(-1, -15),
                            scale = 0.5,
                            tint = {0,0.5,1}
                        }
                    },
                    {
                        filename = "__base__/graphics/entity/offshore-pump/offshore-pump_North-shadow.png",
                        priority = "high",
                        line_length = 8,
                        frame_count = 32,
                        animation_speed = 0.25,
                        width = 78,
                        height = 70,
                        shift = util.by_pixel(12, -8),
                        draw_as_shadow = true,
                        hr_version =
                        {
                        filename = "__base__/graphics/entity/offshore-pump/hr-offshore-pump_North-shadow.png",
                        priority = "high",
                        line_length = 8,
                        frame_count = 32,
                        animation_speed = 0.25,
                        width = 150,
                        height = 134,
                        shift = util.by_pixel(13, -7),
                        draw_as_shadow = true,
                        scale = 0.5
                        }
                    }
                }
            },
            east =
            {
                layers =
                {
                    {
                        filename = "__base__/graphics/entity/offshore-pump/offshore-pump_East.png",
                        priority = "high",
                        line_length = 8,
                        frame_count = 32,
                        animation_speed = 0.25,
                        width = 64,
                        height = 52,
                        shift = util.by_pixel(14, -2),
                        tint = {0,0.5,1},
                        hr_version =
                        {
                            filename = "__base__/graphics/entity/offshore-pump/hr-offshore-pump_East.png",
                            priority = "high",
                            line_length = 8,
                            frame_count = 32,
                            animation_speed = 0.25,
                            width = 124,
                            height = 102,
                            shift = util.by_pixel(15, -2),
                            scale = 0.5,
                            tint = {0,0.5,1}
                        }
                    },
                    {
                        filename = "__base__/graphics/entity/offshore-pump/offshore-pump_East-shadow.png",
                        priority = "high",
                        line_length = 8,
                        frame_count = 32,
                        animation_speed = 0.25,
                        width = 88,
                        height = 34,
                        shift = util.by_pixel(28, 8),
                        draw_as_shadow = true,
                        hr_version =
                        {
                            filename = "__base__/graphics/entity/offshore-pump/hr-offshore-pump_East-shadow.png",
                            priority = "high",
                            line_length = 8,
                            frame_count = 32,
                            animation_speed = 0.25,
                            width = 180,
                            height = 66,
                            shift = util.by_pixel(27, 8),
                            draw_as_shadow = true,
                            scale = 0.5
                        }
                    }
                }
            },
            south =
            {
                layers =
                {
                    {
                        filename = "__base__/graphics/entity/offshore-pump/offshore-pump_South.png",
                        priority = "high",
                        line_length = 8,
                        frame_count = 32,
                        animation_speed = 0.25,
                        width = 48,
                        height = 96,
                        shift = util.by_pixel(-2, 0),
                        tint = {0,0.5,1},
                        hr_version =
                        {
                            filename = "__base__/graphics/entity/offshore-pump/hr-offshore-pump_South.png",
                            priority = "high",
                            line_length = 8,
                            frame_count = 32,
                            animation_speed = 0.25,
                            width = 92,
                            height = 192,
                            shift = util.by_pixel(-1, 0),
                            scale = 0.5,
                            tint = {0,0.5,1}
                        }
                    },
                    {
                        filename = "__base__/graphics/entity/offshore-pump/offshore-pump_South-shadow.png",
                        priority = "high",
                        line_length = 8,
                        frame_count = 32,
                        animation_speed = 0.25,
                        width = 80,
                        height = 66,
                        shift = util.by_pixel(16, 22),
                        draw_as_shadow = true,
                        hr_version =
                        {
                        filename = "__base__/graphics/entity/offshore-pump/hr-offshore-pump_South-shadow.png",
                        priority = "high",
                        line_length = 8,
                        frame_count = 32,
                        animation_speed = 0.25,
                        width = 164,
                        height = 128,
                        shift = util.by_pixel(15, 23),
                        draw_as_shadow = true,
                        scale = 0.5
                        }
                    }
                }
            },
            west =
            {
                layers =
                {
                    {
                        filename = "__base__/graphics/entity/offshore-pump/offshore-pump_West.png",
                        priority = "high",
                        line_length = 8,
                        frame_count = 32,
                        animation_speed = 0.25,
                        width = 64,
                        height = 52,
                        shift = util.by_pixel(-16, -2),
                        tint = {0,0.5,1},
                        hr_version =
                        {
                            filename = "__base__/graphics/entity/offshore-pump/hr-offshore-pump_West.png",
                            priority = "high",
                            line_length = 8,
                            frame_count = 32,
                            animation_speed = 0.25,
                            width = 124,
                            height = 102,
                            shift = util.by_pixel(-15, -2),
                            scale = 0.5,
                            tint = {0,0.5,1}
                        }
                    },
                    {
                        filename = "__base__/graphics/entity/offshore-pump/offshore-pump_West-shadow.png",
                        priority = "high",
                        line_length = 8,
                        frame_count = 32,
                        animation_speed = 0.25,
                        width = 88,
                        height = 34,
                        shift = util.by_pixel(-4, 8),
                        draw_as_shadow = true,
                        hr_version =
                        {
                            filename = "__base__/graphics/entity/offshore-pump/hr-offshore-pump_West-shadow.png",
                            priority = "high",
                            line_length = 8,
                            frame_count = 32,
                            animation_speed = 0.25,
                            width = 172,
                            height = 66,
                            shift = util.by_pixel(-3, 8),
                            draw_as_shadow = true,
                            scale = 0.5
                        }
                    }
                }
            }
        },
        water_reflection = {
            pictures = {
                filename = "__base__/graphics/entity/offshore-pump/offshore-pump-reflection.png",
                priority = "extra-high",
                width = 132,
                height = 156,
                shift = util.by_pixel(0, 19),
                variation_count = 4,
                scale = 1,
            },
            rotate = false,
            orientation_to_variation = true
        },
        se_allow_in_space = true
    },

    -- THERMAL EVAPORATION PLANT --
    {
        type = "assembling-machine",
        name = "rf-thermal-evaporation-plant",
        icon = "__RealisticFusionCore__/graphics/icons/thermal-evaporation-plant.png",
        icon_size = 64, icon_mipmaps = 4,
        flags = {"placeable-neutral","player-creation"},
        minable = {mining_time = 0.2, result = "rf-thermal-evaporation-plant"},
        max_health = 350,
        corpse = "oil-refinery-remnants",
        dying_explosion = "oil-refinery-explosion",
        collision_box = {{-2.4, -2.4}, {2.4, 2.4}},
        selection_box = {{-2.5, -2.5}, {2.5, 2.5}},
        damaged_trigger_effect = rfcore.hit_effects.entity(),
        drawing_box = {{-2.5, -2.8}, {2.5, 2.5}},
        module_specification = {
            module_slots = 3
        },
        fixed_recipe = "rf-thermal-evaporation",
        scale_entity_info_icon = true,
        allowed_effects = {"consumption", "speed", "productivity", "pollution"},
        crafting_categories = {"rf-thermal-evaporation"},
        crafting_speed = 1,
        energy_source =
        {
          type = "electric",
          usage_priority = "secondary-input",
          emissions_per_minute = 6
        },
        energy_usage = "420kW", --TODO?

        idle_animation = {
            north = {layers = {thermal_ep.base, thermal_ep.vertical, thermal_ep.shadow}},
            west  = {layers = {thermal_ep.base, thermal_ep.horizontal, thermal_ep.shadow}},
            south = {layers = {thermal_ep.base, thermal_ep.vertical, thermal_ep.shadow}},
            east  = {layers = {thermal_ep.base, thermal_ep.horizontal, thermal_ep.shadow}},
        },
        always_draw_idle_animation = true,

        vehicle_impact_sound = rfcore.sounds.generic_impact,
        open_sound = rfcore.sounds.machine_open,
        close_sound = rfcore.sounds.machine_close,
        working_sound = {
          sound = {
            filename = "__base__/sound/oil-refinery.ogg" --TODO?
          },
          --idle_sound = { filename = "__base__/sound/idle1.ogg", volume = 0.3 },
          fade_in_ticks = 4,
          fade_out_ticks = 20
        },
        fluid_boxes = {
          {
            production_type = "input",
            pipe_covers = pipecoverspictures(),
            base_area = 10,
            base_level = -1,
            pipe_connections = {{ type="input", position = {0, 3} }}
          },
          {
            production_type = "output",
            pipe_covers = pipecoverspictures(),
            base_level = 1,
            pipe_connections = {{ position = {0, -3} }}
          },
        },
    },
}
-- #endregion --