---- HC Exchanger and Turbine ----
if settings.startup["rf-hc-stuff"].value then
    local hc_hx = util.table.deepcopy(data.raw.boiler["heat-exchanger"])
    hc_hx.name = "rf-hc-exchanger"
    hc_hx.energy_consumption = "100MW"
    hc_hx.minable.result = "rf-hc-exchanger"
    hc_hx.order = ""
    rfcore.tintPictures(hc_hx.structure.north.layers, {r = 1, g = 0.5, b = 0, a = 1})
    rfcore.tintPictures(hc_hx.structure.west.layers, {r = 1, g = 0.5, b = 0, a = 1})
    rfcore.tintPictures(hc_hx.structure.south.layers, {r = 1, g = 0.5, b = 0, a = 1})
    rfcore.tintPictures(hc_hx.structure.east.layers, {r = 1, g = 0.5, b = 0, a = 1})
    rfcore.tintPictures(rfcore.mapMany(hc_hx.fluid_box.pipe_covers, function (p) return p.layers; end), {r = 1, g = 0.5, b = 0, a = 1})
    rfcore.tintPictures(rfcore.mapMany(hc_hx.output_fluid_box.pipe_covers, function (p) return p.layers; end), {r = 1, g = 0.5, b = 0, a = 1})
    hc_hx.se_allow_in_space = true

    local hc_t = util.table.deepcopy(data.raw.generator["steam-turbine"])
    hc_t.name = "rf-hc-turbine"
    hc_t.fluid_usage_per_tick = 10
    hc_t.minable.result = "rf-hc-turbine"
    hc_t.order = ""
    rfcore.tintPictures(hc_t.horizontal_animation.layers, {r = 1, g = 0.5, b = 0, a = 1})
    rfcore.tintPictures(hc_t.vertical_animation.layers, {r = 1, g = 0.5, b = 0, a = 1})
    hc_t.energy_source.usage_priority = settings.startup["rf-hc-priority"].value .. "-output"
    hc_t.se_allow_in_space = true

    data:extend{hc_hx, hc_t}
end

data:extend{
    -- Heat exchanger --
    {
        name = "rf-heat-exchanger",
        type = "reactor",
        icon = "__RealisticFusionPower__/graphics/icons/heat-exchanger.png",
        icon_size = 64,
        max_health = 500,
        repair_sound = {filename = "__base__/sound/manual-repair-simple.ogg"},
        mined_sound = {filename = "__base__/sound/deconstruct-bricks.ogg",volume = 0.8},
        vehicle_impact_sound = rfcore.sounds.generic_impact,
        open_sound = rfcore.sounds.machine_open,
        close_sound = rfcore.sounds.machine_close,
        tile_width = 5, tile_height = 15,
        flags = {"not-rotatable", "placeable-neutral", "placeable-player", "player-creation", "not-flammable", "not-upgradable"},
        minable = {mining_time = 1, result= "rf-heat-exchanger"},
        dying_explosion = "steam-turbine-explosion",
        working_light_picture = rfcore.empty_sprite,
        neighbour_bonus = 0,
        collision_box = {{-2.25, -7.25}, {2.25, 7.25}},
        selection_box = {{-2.5, -7.5}, {2.5, 7.5}},
        picture = {
            layers = {
                {
                    filename = "__RealisticFusionPower__/graphics/entities/heat-exchanger.png",
                    size = {383, 1088},
                    shift = util.by_pixel(15, 11),
                    scale = 0.5
                },
                {
                    filename = "__RealisticFusionPower__/graphics/entities/shadows/heat-exchanger.png",
                    size = {383, 1088},
                    shift = util.by_pixel(15, 11),
                    draw_as_shadow = true,
                    scale = 0.5
                }
            }
        },
        energy_source = {
            render_no_power_icon = false,
            type = "fluid",
            burns_fluid = true,
            scale_fluid_usage = true,
            fluid_usage_per_tick = 2e3/60,
            effectivity = 0.1,
            fluid_box = {
                base_area = 1,
                base_level = -1,
                pipe_connections = {
                    {type = "input", position = {-3, 2.3}},
                    {type = "input", position = {-3, -2.2}}
                },
                production_type = "input",
                --filter = "rf-fusion-results"
                minimum_temperature = 0xDECADE, --see fluid.lua
                maximum_temperature = 0xDECADE,
            }
        },
        consumption = "2GW",
        scale_energy_usage = true,
        heat_buffer = {
            max_temperature = 1000,
            specific_heat = "10MJ",
            max_transfer = "2GW",
            connections = {
                {position = {-2, -7}, direction = 0},
                {position = {0, -7}, direction = 0},
                {position = {2, -7}, direction = 0},
                {position = {2, -7}, direction = 2},
                {position = {2, -4}, direction = 2},
                {position = {2, -1}, direction = 2},
                {position = {2, 1}, direction = 2},
                {position = {2, 4}, direction = 2},
                {position = {2, 7}, direction = 2},
                {position = {2, 7}, direction = 4},
                {position = {0, 7}, direction = 4},
                {position = {-2, 7}, direction = 4},
            }
        },
        lower_layer_picture = {
            filename = "__RealisticFusionPower__/graphics/entities/hx-pipes.png",
            width = 383,
            height = 1088,
            scale = 0.5,
            shift = util.by_pixel(15, 11)
        },
        heat_lower_layer_picture = {
            filename = "__RealisticFusionPower__/graphics/entities/hx-pipes-heat.png",
            width = 383,
            height = 1088,
            scale = 0.5,
            shift = util.by_pixel(15, 11)
        },
        se_allow_in_space = true
    },

    -- Direct energy converter --
    {
        name = "rf-direct-energy-converter",
        type = "generator",
        icon = "__RealisticFusionPower__/graphics/icons/dec.png",
        icon_size = 64,
        max_health = 500,
        repair_sound = {filename = "__base__/sound/manual-repair-simple.ogg"},
        mined_sound = {filename = "__base__/sound/deconstruct-bricks.ogg",volume = 0.8},
        vehicle_impact_sound = rfcore.sounds.generic_impact,
        open_sound = rfcore.sounds.machine_open,
        close_sound = rfcore.sounds.machine_close,
        tile_width = 5, tile_height = 15,
        flags = {"not-rotatable", "placeable-neutral", "placeable-player", "player-creation", "not-flammable", "not-upgradable"},
        minable = {mining_time = 1, result= "rf-direct-energy-converter"},
        dying_explosion = "steam-turbine-explosion",
        collision_box = {{-2.25, -7.25}, {2.25, 7.25}},
        selection_box = {{-2.5, -7.5}, {2.5, 7.5}},
        vertical_animation = {
            layers = {
                {
                    filename = "__RealisticFusionPower__/graphics/entities/dec.png",
                    size = {383, 1088},
                    shift = util.by_pixel(15, 11),
                    scale = 0.5
                },
                {
                    filename = "__RealisticFusionPower__/graphics/entities/shadows/heat-exchanger.png",
                    size = {383, 1088},
                    shift = util.by_pixel(15, 11),
                    draw_as_shadow = true,
                    scale = 0.5
                }
            }
        },
        horizontal_animation = {
            layers = {
                {
                    filename = "__RealisticFusionPower__/graphics/entities/dec.png",
                    size = {383, 1088},
                    shift = util.by_pixel(15, 11),
                    scale = 0.5
                },
                {
                    filename = "__RealisticFusionPower__/graphics/entities/shadows/heat-exchanger.png",
                    size = {383, 1088},
                    shift = util.by_pixel(15, 11),
                    draw_as_shadow = true,
                    scale = 0.5
                }
            }
        },
        fluid_box = {
            base_area = 1,
            base_level = -1,
            burns_fluid = true,
            scale_fluid_usage = true,
            pipe_connections = {
                {type = "input", position = {-3, 2.3}},
                {type = "input", position = {-3, -2.2}}
            },
            production_type = "input",
            --filter = "rf-aneutronic-fusion-results"
            minimum_temperature = 0xFACADE, --see fluid.lua
            maximum_temperature = 0xFACADE,
        },
        effectivity = 0.1,
        fluid_usage_per_tick = 20e3/60,
        maximum_temperature = 1000,
        burns_fluid = true,
        scale_fluid_usage = true,
        max_power_output = "20GW",
        energy_source = {
            render_no_power_icon = false,
            type = "electric",
            usage_priority = "secondary-output",
            output_flow_limit = "20GW"
        },
        se_allow_in_space = true
    },

    -- Neutronic reactor --
    {
        type = "assembling-machine",
        name = "rf-reactor",
        icon = "__RealisticFusionPower__/graphics/icons/reactor.png",
        icon_size = 64,
        max_health = 5000,
        repair_sound = {filename = "__base__/sound/manual-repair-simple.ogg"},
        mined_sound = {filename = "__base__/sound/deconstruct-bricks.ogg",volume = 0.8},
        vehicle_impact_sound = rfcore.sounds.generic_impact,
        open_sound = rfcore.sounds.machine_open,
        close_sound = rfcore.sounds.machine_close,
        tile_width = 15, tile_height = 15,
        flags = {"not-rotatable", "placeable-neutral", "placeable-player", "player-creation", "not-flammable", "not-upgradable"},
        minable = {mining_time = 5, result= "rf-reactor"},
        working_sound = {
            sound = {
                filename = "__RealisticFusionPower__/sounds/reactor-running.ogg",
                allow_random_repeat = true
            },
            fade_in_ticks = 30,
            fade_out_ticks = 10
        },
        crafting_categories = {"rf-fusion"},
        crafting_speed = 1,
        collision_box = {{-7.25, -7.25}, {7.25, 7.25}},
        selection_box = {{-7.5, -7.5}, {7.5, 7.5}},
        fluid_boxes = {
            {
                base_area = 1,
                base_level = 1,
                pipe_connections = {
                    {type = "output", position = {8, 2.3}},
                    {type = "output", position = {8, -2.2}}
                },
                production_type = "output",
                minimum_temperature = 0xDECADE, --see fluid.lua
                maximum_temperature = 0xDECADE,
            },
            {
                base_area = 1,
                base_level = 1,
                pipe_covers = pipecoverspictures(),
                pipe_connections = {
                    {type = "output", position = {-1, 8}},
                    {type = "output", position = {1, 8}}
                },
                production_type = "output",
                filter = "rf-tritium"--"rf-helium-3"
            },
            {
                base_level = -1,
                base_area = 1,
                pipe_covers = {
                    filename = "__RealisticFusionCore__/graphics/entities/heater-pipe-cover.png",
                    size = 64,
                    scale = 1.1,
                    shift = util.by_pixel(-1, 1)
                },
                pipe_connections = {
                    {type = "input", position = {-8, -1}},
                    {type = "input", position = {-8, 1}},
                    {type = "input", position = {-8, 3}}
                },
                production_type = "input"
            }
        },
        working_visualisations = {{animation = {
            filename = "__RealisticFusionPower__/graphics/entities/reactor-powered.png",
            size = 1088,
            shift = util.by_pixel(32, 0),
            scale = 0.5,
        }, fadeout = true}},
        always_draw_idle_animation = true,
        idle_animation = {
            layers = {
                {
                    filename = "__RealisticFusionPower__/graphics/entities/reactor.png",
                    size = 1088,
                    shift = util.by_pixel(32, 0),
                    scale = 0.5,
                },
                {
                    filename = "__RealisticFusionPower__/graphics/entities/shadows/reactor.png",
                    size = 1088,
                    shift = util.by_pixel(32, 0),
                    scale = 0.5,
                    draw_as_shadow = true
                }
            }
        },
        scale_entity_info_icon = true,
        energy_source = {
            type = "electric",
            usage_priority = "secondary-input",
            emissions_per_minute = 6
        },
        energy_usage = "25MW", --TODO?
        result_inventory_size = 0,
        source_inventory_size = 0,
        se_allow_in_space = true
    },

    -- Aneutronic reactor --
    {
        type = "assembling-machine",
        name = "rf-reactor-aneutronic",
        icon = "__RealisticFusionPower__/graphics/icons/reactor-aneutronic.png",
        icon_size = 64,
        max_health = 5000,
        repair_sound = {filename = "__base__/sound/manual-repair-simple.ogg"},
        mined_sound = {filename = "__base__/sound/deconstruct-bricks.ogg",volume = 0.8},
        vehicle_impact_sound = rfcore.sounds.generic_impact,
        open_sound = rfcore.sounds.machine_open,
        close_sound = rfcore.sounds.machine_close,
        tile_width = 15, tile_height = 15,
        flags = {"not-rotatable", "placeable-neutral", "placeable-player", "player-creation", "not-flammable", "not-upgradable"},
        minable = {mining_time = 5, result= "rf-reactor-aneutronic"},
        working_sound = {
            sound = {
                filename = "__RealisticFusionPower__/sounds/reactor-running.ogg",
                allow_random_repeat = true
            },
            fade_in_ticks = 30,
            fade_out_ticks = 10
        },
        crafting_categories = {"rf-fusion-aneutronic"},
        crafting_speed = 1,
        scale_entity_info_icon = true,
        collision_box = {{-7.25, -7.25}, {7.25, 7.25}},
        selection_box = {{-7.5, -7.5}, {7.5, 7.5}},
        fluid_boxes = {
            {
                base_area = 1,
                base_level = 1,
                pipe_connections = {
                    {type = "output", position = {8, 2.3}},
                    {type = "output", position = {8, -2.2}}
                },
                production_type = "output",
                minimum_temperature = 0xFACADE, --see fluid.lua
                maximum_temperature = 0xFACADE,
            },
            {
                base_level = -1,
                base_area = 1,
                pipe_covers = {
                    filename = "__RealisticFusionCore__/graphics/entities/heater-pipe-cover.png",
                    size = 64,
                    scale = 1.1,
                    shift = util.by_pixel(-1, 1)
                },
                pipe_connections = {
                    {type = "input", position = {-8, -1}},
                    {type = "input", position = {-8, 1}},
                    {type = "input", position = {-8, 3}}
                },
                production_type = "input"
            }
        },
        working_visualisations = {{animation = {
            filename = "__RealisticFusionPower__/graphics/entities/reactor-aneutronic-powered.png",
            size = 1088,
            shift = util.by_pixel(32, 0),
            scale = 0.5,
        }, fadeout = true}},
        always_draw_idle_animation = true,
        idle_animation = {
            layers = {
                {
                    filename = "__RealisticFusionPower__/graphics/entities/reactor-aneutronic.png",
                    size = 1088,
                    shift = util.by_pixel(32, 0),
                    scale = 0.5,
                },
                {
                    filename = "__RealisticFusionPower__/graphics/entities/shadows/reactor.png",
                    size = 1088,
                    shift = util.by_pixel(32, 0),
                    scale = 0.5,
                    draw_as_shadow = true
                }
            }
        },
        energy_source = {
            type = "electric",
            usage_priority = "secondary-input",
            emissions_per_minute = 6
        },
        energy_usage = "50MW", --TODO?
        result_inventory_size = 0,
        source_inventory_size = 0,
        se_allow_in_space = true
    },

    -- Ion Cyclotron --
    {
        name = "rf-ion-cyclotron",
        type = "assembling-machine",
        icon = "__RealisticFusionPower__/graphics/icons/ion-cyclotron.png",
        icon_size = 64,
        max_health = 2000,
        repair_sound = {filename = "__base__/sound/manual-repair-simple.ogg"},
        mined_sound = {filename = "__base__/sound/deconstruct-bricks.ogg",volume = 0.8},
        vehicle_impact_sound = rfcore.sounds.generic_impact,
        open_sound = rfcore.sounds.machine_open,
        close_sound = rfcore.sounds.machine_close,
        tile_width = 5, tile_height = 15,
        flags = {"not-rotatable", "placeable-neutral", "placeable-player", "player-creation", "not-flammable", "not-upgradable"},
        minable = {mining_time = 3, result = "rf-ion-cyclotron"},
        dying_explosion = "steam-turbine-explosion",
        collision_box = {{-2.25, -7.25}, {2.25, 7.25}},
        selection_box = {{-2.5, -7.5}, {2.5, 7.5}},
        animation = {
            layers = {
                {
                    filename = "__RealisticFusionPower__/graphics/entities/ion-cyclotron.png",
                    size = {383, 1088},
                    shift = util.by_pixel(15, 11),
                    scale = 0.5
                },
                {
                    filename = "__RealisticFusionPower__/graphics/entities/shadows/ion-cyclotron.png",
                    size = {383, 1088},
                    shift = util.by_pixel(15, 11),
                    draw_as_shadow = true,
                    scale = 0.5
                }
            }
        },
        fluid_boxes = {
            {
                base_area = 10,
                base_level = -1,
                pipe_connections = {
                    {type = "input", position = {-3, 2.3}},
                    {type = "input", position = {-3, -2.2}},
                },
                production_type = "input",
                minimum_temperature = 0xDECADE, --see fluid.lua
                maximum_temperature = 0xDECADE,
            },
            {
                base_area = 10,
                base_level = 1,
                pipe_connections = {
                    {type = "output", position = {3, 2.3}},
                    {type = "output", position = {3, -2.2}},
                },
                production_type = "output",
                minimum_temperature = 0xDECADE, --see fluid.lua
                maximum_temperature = 0xDECADE,
            },
            {
                base_area = 10,
                base_level = 1,
                pipe_covers = rfcore.magnetic_pipe_covers_pictures(), --TODO MAGNETIC
                pipe_connections = {
                    {type = "output", position = {0, 8}},
                },
                production_type = "output",
            },
        },
        crafting_speed = 1,
        crafting_categories = {"rf-ion-cyclotron"},
        scale_entity_info_icon = true,
        energy_usage = "2GW",
        energy_source = {
            render_no_power_icon = false,
            type = "electric",
            usage_priority = "secondary-input",
            input_flow_limit = "2GW" --TODO
        },
        se_allow_in_space = true
    },

    -- ICF Laser --
    {
        type = "assembling-machine",
        name = "rf-icf-laser",
        icon = "__RealisticFusionPower__/graphics/icons/laser.png",
        icon_size = 64,
        max_health = 1000,
        repair_sound = {filename = "__base__/sound/manual-repair-simple.ogg"},
        mined_sound = {filename = "__base__/sound/deconstruct-bricks.ogg",volume = 0.8},
        vehicle_impact_sound = rfcore.sounds.generic_impact,
        open_sound = rfcore.sounds.machine_open,
        close_sound = rfcore.sounds.machine_close,
        tile_width = 4, tile_height = 8,
        flags = {"placeable-neutral", "placeable-player", "player-creation", "not-flammable", "not-upgradable"},
        minable = {mining_time = 5, result = "rf-icf-laser"},
        crafting_categories = {"rf-icf-laser"},
        --fixed_recipe = "rf-icf-laser",
        energy_usage = "100MW",--TODO
        energy_source = { --TODO
            type = "electric",
            usage_priority = "secondary-input",
            input_flow_limit = "100MW"
        },
        crafting_speed = 1,
        fluid_boxes = {
            {
                base_area = 1,
                base_level = 1,
                pipe_connections = {
                    {type = "output", position = {0, 4.5}},
                },
                production_type = "output",
                minimum_temperature = 0xACCEDE, --see fluid.lua
                maximum_temperature = 0xACCEDE,
            }
        },
        collision_box = {{-1.75, -3.75}, {1.75, 3.75}},
        selection_box = {{-2, -4}, {2, 4}},
        show_recipe_icon = false,
        always_draw_idle_animation = true,
        idle_animation = {
            north = {layers = {
                {
                    filename = "__RealisticFusionPower__/graphics/entities/laser-north.png",
                    size = 512,
                    shift = {0, 0},
                    scale = 0.6,
                },
                {
                    filename = "__RealisticFusionPower__/graphics/entities/shadows/laser-north.png",
                    size = 512,
                    shift = {0, 0},
                    scale = 0.6,
                    draw_as_shadow = true
                }
            }},
            south = {layers = {
                {
                    filename = "__RealisticFusionPower__/graphics/entities/laser-south.png",
                    size = 512,
                    shift = {-0.1, -1},
                    scale = 0.6,
                },
                {
                    filename = "__RealisticFusionPower__/graphics/entities/shadows/laser-south.png",
                    size = 512,
                    shift = {-0.1, -1},
                    scale = 0.6,
                    draw_as_shadow = true
                }
            }},
            east = {layers = {
                {
                    filename = "__RealisticFusionPower__/graphics/entities/laser-east.png",
                    size = {768,512},
                    shift = {1.5,-1},
                    scale = 0.474,
                },
                {
                    filename = "__RealisticFusionPower__/graphics/entities/shadows/laser-east.png",
                    size = {768,512},
                    shift = {1.5,-0.5},
                    scale = 0.474,
                    draw_as_shadow = true
                }
            }},
            west = {layers = {
                {
                    filename = "__RealisticFusionPower__/graphics/entities/laser-west.png",
                    size = {768,512},
                    shift = {0.65,-0.5},
                    scale = 0.474,
                },
                {
                    filename = "__RealisticFusionPower__/graphics/entities/shadows/laser-west.png",
                    size = {768,512},
                    shift = {0.65,-0.5},
                    scale = 0.474,
                    draw_as_shadow = true
                }
            }}
        },
        working_visualisations = {
            {
                north_animation = {
                    filename = "__RealisticFusionPower__/graphics/entities/laser-anim-north.png",
                    size = 512,
                    shift = {0, 0},
                    scale = 0.6,
                },
                south_animation = {
                    filename = "__RealisticFusionPower__/graphics/entities/laser-anim-south.png",
                    size = 512,
                    shift = {-0.1, -1},
                    scale = 0.6,
                },
                east_animation = {
                    filename = "__RealisticFusionPower__/graphics/entities/laser-anim-east.png",
                    size = {768,512},
                    shift = {1.5,-0.5},
                    scale = 0.474,
                },
                west_animation = {
                    filename = "__RealisticFusionPower__/graphics/entities/laser-anim-west.png",
                    size = {768,512},
                    shift = {0.65,-0.5},
                    scale = 0.474,
                },
                fadeout = true
            },
        },
    },

    -- Neutronic ICF reactor --
    {
        type = "assembling-machine",
        name = "rf-reactor-icf",
        icon = "__RealisticFusionPower__/graphics/icons/reactor-icf.png",
        icon_size = 64,
        max_health = 5000,
        repair_sound = {filename = "__base__/sound/manual-repair-simple.ogg"},
        mined_sound = {filename = "__base__/sound/deconstruct-bricks.ogg",volume = 0.8},
        vehicle_impact_sound = rfcore.sounds.generic_impact,
        open_sound = rfcore.sounds.machine_open,
        close_sound = rfcore.sounds.machine_close,
        tile_width = 18, tile_height = 18,
        flags = {"not-rotatable", "placeable-neutral", "placeable-player", "player-creation", "not-flammable", "not-upgradable"},
        minable = {mining_time = 5, result= "rf-reactor-icf"},
        working_sound = {
            sound = {
                filename = "__RealisticFusionPower__/sounds/reactor-running.ogg",
                allow_random_repeat = true
            },
            fade_in_ticks = 30,
            fade_out_ticks = 10
        },
        crafting_categories = {"rf-fusion-icf"},
        crafting_speed = 1,
        collision_box = {{-8.75, -8.75}, {8.75, 8.75}},
        selection_box = {{-9, -9}, {9, 9}},
        scale_entity_info_icon = true,
        fluid_boxes = {
            {
                base_area = 1,
                base_level = 1,
                pipe_connections = {
                    {type = "output", position = {9.5, 0.5}},
                    {type = "output", position = {-9.5, 0.5}},
                    {type = "output", position = {0, 9.5}},
                    {type = "output", position = {0, -9.5}}
                },
                production_type = "output",
                minimum_temperature = 0xDECADE, --see fluid.lua
                maximum_temperature = 0xDECADE,
            },
            {
                base_area = 0.01,
                base_level = -1,
                pipe_connections = {
                    {type = "input", position = {9.5, 7}},
                    {type = "input", position = {9.5, -7}},
                    {type = "input", position = {-9.5, 7}},
                    {type = "input", position = {-9.5, -7}},
                    {type = "input", position = {7, 9.5}},
                    {type = "input", position = {7, -9.5}},
                    {type = "input", position = {-7, 9.5}},
                    {type = "input", position = {-7, -9.5}},
                },
                production_type = "input",
                minimum_temperature = 0xACCEDE, --see fluid.lua
                maximum_temperature = 0xACCEDE,
            }
        },
        working_visualisations = {
            {
                animation = {
                    filename = "__RealisticFusionPower__/graphics/entities/reactor-icf-animation.png",
                    size = 1200,
                    shift = {0,-0.55},
                    scale = 0.8,
                },
                fadeout = true
            },
        },
        always_draw_idle_animation = true,
        idle_animation = {
            layers = {
                {
                    filename = "__RealisticFusionPower__/graphics/entities/reactor-icf.png",
                    size = 1200,
                    shift = {0,-0.55},
                    scale = 0.8,
                },
                {
                    filename = "__RealisticFusionPower__/graphics/entities/shadows/reactor-icf.png",
                    size = 1200,
                    shift = {0,-0.55},
                    scale = 0.8,
                    draw_as_shadow = true
                }
            }
        },
        energy_usage = "1W",
        energy_source = {type = "void"},
        result_inventory_size = 0,
        source_inventory_size = 0,
        se_allow_in_space = true
    },
    {
        type = "reactor",
        name = "rf-reactor-icf-hx-north",
        icon = "__RealisticFusionPower__/graphics/icons/reactor-icf.png",
        icon_size = 64,
        max_health = 5000,
        repair_sound = {filename = "__base__/sound/manual-repair-simple.ogg"},
        mined_sound = {filename = "__base__/sound/deconstruct-bricks.ogg",volume = 0.8},
        vehicle_impact_sound = rfcore.sounds.generic_impact,
        open_sound = rfcore.sounds.machine_open,
        close_sound = rfcore.sounds.machine_close,
        tile_width = 6, tile_height = 4,
        flags = {"not-rotatable", "placeable-neutral", "placeable-player", "not-flammable", "not-upgradable", "not-deconstructable", "not-blueprintable"},
        minable = {mining_time = 5, result= "rf-reactor-icf"},
        collision_box = {{-2.75, -1.75}, {2.75, 1.75}},
        selection_box = {{-3, -2}, {3, 2}},
        working_light_picture = rfcore.empty_sprite,
        --neighbour_bonus = 0,
        energy_source = {
            render_no_power_icon = false,
            type = "fluid",
            burns_fluid = true,
            scale_fluid_usage = true,
            fluid_usage_per_tick = 10, --TODO
            fluid_box = {
                base_area = 0.01,
                base_level = -1,
                pipe_connections = {
                    --{type = "input", position = {0, -2.5}},
                    {type = "input", position = {0, 2.5}}
                },
                production_type = "input",
                --filter = "rf-fusion-results"
                minimum_temperature = 0xDECADE, --see fluid.lua
                maximum_temperature = 0xDECADE,
            }
        },
        consumption = "2GW", --TODO
        scale_energy_usage = true,
        heat_buffer = {
            max_temperature = 1000,
            specific_heat = "10MJ",
            max_transfer = "2GW", --TODO
            connections = {
                {position = {-2.5, -1.5}, direction = 0},
                {position = {-2.5, -1.5}, direction = 6},
                {position = {-2.5, 1.5}, direction = 4},
                {position = {-2.5, 1.5}, direction = 6},
                {position = {2.5, -1.5}, direction = 0},
                {position = {2.5, -1.5}, direction = 2},
                {position = {2.5, 1.5}, direction = 4},
                {position = {2.5, 1.5}, direction = 2},
            }
        },
        --[[lower_layer_picture = { --TODO
            filename = "__RealisticFusionPower__/graphics/entities/icf-hx-pipes-v.png",
            width = 383,
            height = 1088,
            scale = 0.5,
            shift = util.by_pixel(15, 11)
        },
        heat_lower_layer_picture = {
            filename = "__RealisticFusionPower__/graphics/entities/icf-hx-pipes-v-heat.png",
            width = 383,
            height = 1088,
            scale = 0.5,
            shift = util.by_pixel(15, 11)
        }]]
    },
    {
        type = "reactor",
        name = "rf-reactor-icf-hx-west",
        icon = "__RealisticFusionPower__/graphics/icons/reactor-icf.png",
        icon_size = 64,
        max_health = 5000,
        repair_sound = {filename = "__base__/sound/manual-repair-simple.ogg"},
        mined_sound = {filename = "__base__/sound/deconstruct-bricks.ogg",volume = 0.8},
        vehicle_impact_sound = rfcore.sounds.generic_impact,
        open_sound = rfcore.sounds.machine_open,
        close_sound = rfcore.sounds.machine_close,
        tile_width = 5, tile_height = 7,
        flags = {"not-rotatable", "placeable-neutral", "placeable-player", "not-flammable", "not-upgradable", "not-deconstructable", "not-blueprintable"},
        minable = {mining_time = 5, result= "rf-reactor-icf"},
        collision_box = {{-2.25, -3.25}, {2.25, 3.25}},
        selection_box = {{-2.5, -3.5}, {2.5, 3.5}},
        working_light_picture = rfcore.empty_sprite,
        --neighbour_bonus = 0,
        energy_source = {
            render_no_power_icon = false,
            type = "fluid",
            burns_fluid = true,
            scale_fluid_usage = true,
            fluid_usage_per_tick = 10, --TODO
            fluid_box = {
                base_area = 0.01,
                base_level = -1,
                pipe_connections = {
                    --{type = "input", position = {-3, 0}},
                    {type = "input", position = {3, 0}}
                },
                production_type = "input",
                --filter = "rf-fusion-results"
                minimum_temperature = 0xDECADE, --see fluid.lua
                maximum_temperature = 0xDECADE,
            }
        },
        consumption = "2GW", --TODO
        scale_energy_usage = true,
        heat_buffer = {
            max_temperature = 1000,
            specific_heat = "10MJ",
            max_transfer = "2GW", --TODO
            connections = {
                {position = {-2, -3}, direction = 0},
                {position = {-2, -3}, direction = 6},
                {position = {-2, 3}, direction = 4},
                {position = {-2, 3}, direction = 6},
                {position = {2, -3}, direction = 0},
                {position = {2, -3}, direction = 2},
                {position = {2, 3}, direction = 4},
                {position = {2, 3}, direction = 2},
            }
        },
        --[[lower_layer_picture = { --TODO
            filename = "__RealisticFusionPower__/graphics/entities/icf-hx-pipes-v.png",
            width = 383,
            height = 1088,
            scale = 0.5,
            shift = util.by_pixel(15, 11)
        },
        heat_lower_layer_picture = {
            filename = "__RealisticFusionPower__/graphics/entities/icf-hx-pipes-v-heat.png",
            width = 383,
            height = 1088,
            scale = 0.5,
            shift = util.by_pixel(15, 11)
        }]]
    },

    -- Aneutronic ICF reactor --
    {
        type = "assembling-machine",
        name = "rf-reactor-icf-aneutronic",
        icon = "__RealisticFusionPower__/graphics/icons/reactor-icf-aneutronic.png",
        icon_size = 64,
        max_health = 5000,
        repair_sound = {filename = "__base__/sound/manual-repair-simple.ogg"},
        mined_sound = {filename = "__base__/sound/deconstruct-bricks.ogg",volume = 0.8},
        vehicle_impact_sound = rfcore.sounds.generic_impact,
        open_sound = rfcore.sounds.machine_open,
        close_sound = rfcore.sounds.machine_close,
        tile_width = 18, tile_height = 18,
        flags = {"not-rotatable", "placeable-neutral", "placeable-player", "player-creation", "not-flammable", "not-upgradable"},
        minable = {mining_time = 5, result= "rf-reactor-icf-aneutronic"},
        working_sound = {
            sound = {
                filename = "__RealisticFusionPower__/sounds/reactor-running.ogg",
                allow_random_repeat = true
            },
            fade_in_ticks = 30,
            fade_out_ticks = 10
        },
        crafting_categories = {"rf-fusion-icf-aneutronic"},
        crafting_speed = 1,
        collision_box = {{-8.75, -8.75}, {8.75, 8.75}},
        selection_box = {{-9, -9}, {9, 9}},
        scale_entity_info_icon = true,
        fluid_boxes = {
            {
                base_area = 1,
                base_level = 1,
                pipe_connections = {
                    {type = "output", position = {9.5, 0.5}},
                    {type = "output", position = {-9.5, 0.5}},
                    {type = "output", position = {0, 9.5}},
                    {type = "output", position = {0, -9.5}}
                },
                production_type = "output",
                minimum_temperature = 0xFACADE, --see fluid.lua
                maximum_temperature = 0xFACADE,
            }
        },
        working_visualisations = {
            {
                animation = {
                    filename = "__RealisticFusionPower__/graphics/entities/reactor-icf-aneutronic.png",
                    size = 1200,
                    shift = {0,-0.55},
                    scale = 0.8,
                },
                fadeout = true
            },
            {
                animation = {
                    filename = "__RealisticFusionPower__/graphics/entities/reactor-icf-aneutronic-animation.png",
                    size = 1200,
                    shift = {0,-0.55},
                    scale = 0.8,
                },
                fadeout = true
            },
        },
        always_draw_idle_animation = true,
        idle_animation = {
            layers = {
                {
                    filename = "__RealisticFusionPower__/graphics/entities/reactor-icf-aneutronic.png",
                    size = 1200,
                    shift = {0,-0.55},
                    scale = 0.8,
                },
                {
                    filename = "__RealisticFusionPower__/graphics/entities/shadows/reactor-icf.png",
                    size = 1200,
                    shift = {0,-0.55},
                    scale = 0.8,
                    draw_as_shadow = true
                }
            }
        },
        energy_usage = "1W",
        energy_source = {type = "void"},
        result_inventory_size = 0,
        source_inventory_size = 0,
        se_allow_in_space = true
    },
    {
        type = "generator",
        name = "rf-reactor-icf-aneutronic-hx-north",
        icon = "__RealisticFusionPower__/graphics/icons/reactor-icf-aneutronic.png",
        icon_size = 64,
        max_health = 5000,
        repair_sound = {filename = "__base__/sound/manual-repair-simple.ogg"},
        mined_sound = {filename = "__base__/sound/deconstruct-bricks.ogg",volume = 0.8},
        vehicle_impact_sound = rfcore.sounds.generic_impact,
        open_sound = rfcore.sounds.machine_open,
        close_sound = rfcore.sounds.machine_close,
        tile_width = 6, tile_height = 4,
        flags = {"not-rotatable", "placeable-neutral", "placeable-player", "not-flammable", "not-upgradable", "not-deconstructable", "not-blueprintable"},
        minable = {mining_time = 5, result= "rf-reactor-icf-aneutronic"},
        collision_box = {{-2.75, -1.75}, {2.75, 1.75}},
        selection_box = {{-3, -2}, {3, 2}},
        burns_fluid = true,
        scale_fluid_usage = true,
        fluid_usage_per_tick = 10, --TODO
        vertical_animation = rfcore.empty_sprite,
        horizontal_animation = rfcore.empty_sprite,
        fluid_box = {
            base_area = 0.01,
            base_level = -1,
            pipe_connections = {
                --{type = "input", position = {0, -2.5}},
                {type = "input", position = {0, 2.5}}
            },
            production_type = "input",
            --filter = "rf-fusion-results"
            minimum_temperature = 0xFACADE, --see fluid.lua
            maximum_temperature = 0xFACADE,
        },
        max_power_output = "2GW", --TODO
        energy_source = {
            render_no_power_icon = false,
            type = "electric",
            usage_priority = "secondary-output",
            output_flow_limit = "20GW"
        },
        maximum_temperature = 1000,
        effectivity = 1,
    },
    {
        type = "generator",
        name = "rf-reactor-icf-aneutronic-hx-west",
        icon = "__RealisticFusionPower__/graphics/icons/reactor-icf-aneutronic.png",
        icon_size = 64,
        max_health = 5000,
        repair_sound = {filename = "__base__/sound/manual-repair-simple.ogg"},
        mined_sound = {filename = "__base__/sound/deconstruct-bricks.ogg",volume = 0.8},
        vehicle_impact_sound = rfcore.sounds.generic_impact,
        open_sound = rfcore.sounds.machine_open,
        close_sound = rfcore.sounds.machine_close,
        tile_width = 5, tile_height = 7,
        flags = {"not-rotatable", "placeable-neutral", "placeable-player", "not-flammable", "not-upgradable", "not-deconstructable", "not-blueprintable"},
        minable = {mining_time = 5, result= "rf-reactor-icf-aneutronic"},
        collision_box = {{-2.25, -3.25}, {2.25, 3.25}},
        selection_box = {{-2.5, -3.5}, {2.5, 3.5}},
        burns_fluid = true,
        scale_fluid_usage = true,
        fluid_usage_per_tick = 10, --TODO
        vertical_animation = rfcore.empty_sprite,
        horizontal_animation = rfcore.empty_sprite,
        fluid_box = {
            base_area = 0.01,
            base_level = -1,
            pipe_connections = {
                --{type = "input", position = {-3, 0}},
                {type = "input", position = {3, 0}}
            },
            production_type = "input",
            --filter = "rf-fusion-results"
            minimum_temperature = 0xFACADE, --see fluid.lua
            maximum_temperature = 0xFACADE,
        },
        max_power_output = "2GW", --TODO
        energy_source = {
            render_no_power_icon = false,
            type = "electric",
            usage_priority = "secondary-output",
            output_flow_limit = "20GW"
        },
        maximum_temperature = 1000,
        effectivity = 1,
    },
}

local icf_hx_south = table.deepcopy(data.raw.reactor["rf-reactor-icf-hx-north"])
icf_hx_south.name = "rf-reactor-icf-hx-south"
icf_hx_south.energy_source.fluid_box.pipe_connections = {{type = "input", position = {0, -2.5}}}
local icf_hx_east = table.deepcopy(data.raw.reactor["rf-reactor-icf-hx-west"])
icf_hx_east.name = "rf-reactor-icf-hx-east"
icf_hx_east.energy_source.fluid_box.pipe_connections = {{type = "input", position = {-3, 0}}}

local aneutronic_icf_hx_south = table.deepcopy(data.raw.generator["rf-reactor-icf-aneutronic-hx-north"])
aneutronic_icf_hx_south.name = "rf-reactor-icf-aneutronic-hx-south"
aneutronic_icf_hx_south.fluid_box.pipe_connections = {{type = "input", position = {0, -2.5}}}
local aneutronic_icf_hx_east = table.deepcopy(data.raw.generator["rf-reactor-icf-aneutronic-hx-west"])
aneutronic_icf_hx_east.name = "rf-reactor-icf-aneutronic-hx-east"
aneutronic_icf_hx_east.fluid_box.pipe_connections = {{type = "input", position = {-3, 0}}}
data:extend{icf_hx_south, icf_hx_east, aneutronic_icf_hx_south, aneutronic_icf_hx_east}