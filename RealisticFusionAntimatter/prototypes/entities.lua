data:extend{
    -- Explosion for when antimatter is piped in non-magnetic pipes --
    {
      type = "projectile",
      name = "rf-antimatter-pipe-explosion-projectile",
      flags = {"not-on-map"},
      collision_box = {{-0.3, -1.1}, {0.3, 1.1}},
      acceleration = 0,
      piercing_damage = 100,
      action =
      {
        type = "direct",
        action_delivery =
        {
          type = "instant",
          target_effects =
          {
            {
              type = "damage",
              damage = {amount = 180, type = "physical"}
            },
            {
              type = "create-entity",
              entity_name = "explosion"
            }
          }
        }
      },
      final_action =
      {
        type = "direct",
        action_delivery =
        {
          type = "instant",
          target_effects =
          {
            {
              type = "create-entity",
              entity_name = "big-explosion"
            },
            {
              type = "nested-result",
              action =
              {
                type = "area",
                radius = 4,
                action_delivery =
                {
                  type = "instant",
                  target_effects =
                  {
                    {
                      type = "damage",
                      damage = {amount = 300, type = "explosion"}
                    },
                    {
                      type = "create-entity",
                      entity_name = "explosion"
                    }
                  }
                }
              }
            },
            {
              type = "create-entity",
              entity_name = "medium-scorchmark-tintable",
              check_buildability = true
            },
            {
            type = "invoke-tile-trigger",
            repeat_count = 1
            },
            {
            type = "destroy-decoratives",
            from_render_layer = "decorative",
            to_render_layer = "object",
            include_soft_decoratives = true, -- soft decoratives are decoratives with grows_through_rail_path = true
            include_decals = false,
            invoke_decorative_trigger = true,
            decoratives_with_trigger_only = false, -- if true, destroys only decoratives that have trigger_effect set
            radius = 2 -- large radius for demostrative purposes
            }
          }
        }
      },
      animation =
      {
        filename = "__base__/graphics/entity/bullet/bullet.png",
        draw_as_glow = true,
        frame_count = 1,
        width = 3,
        height = 50,
        priority = "high"
      }
    },
    -- Particle ac/decelerator --
    {
        name = "rf-particle-accelerator",
        type = "assembling-machine",
        order = "h[antimatter-power]-b[particle-accelerator]",
        icon = "__RealisticFusionAntimatter__/graphics/particle-accelerator/accelerator-icon.png",
        icon_size = 64,
        max_health = 5000,
        repair_sound = {filename = "__base__/sound/manual-repair-simple.ogg"},
        mined_sound = {filename = "__base__/sound/deconstruct-bricks.ogg",volume = 0.8},
        vehicle_impact_sound = rfcore.sounds.generic_impact,
        open_sound = rfcore.sounds.machine_open,
        close_sound = rfcore.sounds.machine_close,
        tile_width = 15, tile_height = 15,
        flags = {"placeable-neutral", "placeable-player", "player-creation", "not-flammable", "not-upgradable"},
        minable = {mining_time = 10, result= "rf-particle-accelerator"},
        crafting_categories = {"rf-particle-acceleration"},
        crafting_speed = 1,
        collision_box = {{-7.25, -7.25}, {7.25, 7.25}},
        selection_box = {{-7.5, -7.5}, {7.5, 7.5}},
        fluid_boxes = {
            {
                production_type = "input",
                pipe_covers = pipecoverspictures(),
                base_area = 10,
                base_level = -1,
                pipe_connections = {{type="input", position = {-2, 8}}}
            },
            {
                production_type = "input",
                pipe_covers = pipecoverspictures(),
                base_area = 10,
                base_level = -1,
                pipe_connections = {{type="input", position = {2, 8}}}
            },
            {
                production_type = "output",
                pipe_covers = pipecoverspictures(),
                base_area = 10,
                base_level = 1,
                pipe_connections = {{type="output", position = {0, -8}}}
            },
            off_when_no_fluid_recipe = false
        },
        animation =
        {
            layers =
            {
                {
                    filename = "__RealisticFusionAntimatter__/graphics/particle-accelerator/accelerator.png",
                    size = 1100,
                    frame_count = 1,
                    shift = {1.01, 0},
                    scale = 0.5
                },
                {
                    filename = "__RealisticFusionAntimatter__/graphics/particle-accelerator/shadow.png",
                    priority = "high",
                    size = 1100,
                    shift = {1.01, 0},
                    frame_count = 1,
                    draw_as_shadow = true,
                    scale = 0.5
                }
            }
        },
        working_sound = {
            sound = {
                filename = "__RealisticFusionAntimatter__/sounds/particle-accelerator.ogg",
                allow_random_repeat = true
            },
            fade_in_ticks = 30,
            fade_out_ticks = 10
        },
        working_visualisations = {{animation = {
            filename = "__RealisticFusionAntimatter__/graphics/particle-accelerator/accelerator-animation.png",
            line_length = 6,
            width = 626,
            height = 688,
            frame_count = 12,
            animation_speed = 0.75,
            scale = 0.5,
            shift = {2.18, -2.358}
        }}},
        energy_usage = "9.95GW",
        energy_source = {
            type = "electric",
            usage_priority = "secondary-input",
            drain = "50MW"
        },
        result_inventory_size = 0,
        source_inventory_size = 0,
        se_allow_in_space = true
    },
    {
        name = "rf-particle-decelerator",
        type = "assembling-machine",
        order = "h[antimatter-power]-b[particle-decelerator]",
        icon = "__RealisticFusionAntimatter__/graphics/particle-accelerator/decelerator-icon.png",
        icon_size = 128,
        max_health = 3000,
        repair_sound = {filename = "__base__/sound/manual-repair-simple.ogg"},
        mined_sound = {filename = "__base__/sound/deconstruct-bricks.ogg",volume = 0.8},
        vehicle_impact_sound = rfcore.sounds.generic_impact,
        open_sound = rfcore.sounds.machine_open,
        close_sound = rfcore.sounds.machine_close,
        tile_width = 7, tile_height = 7,
        flags = {"placeable-neutral", "placeable-player", "player-creation", "not-flammable", "not-upgradable"},
        minable = {mining_time = 5, result= "rf-particle-decelerator"},
        crafting_categories = {"rf-particle-deceleration"},
        crafting_speed = 1,
        collision_box = {{-3.25, -3.25}, {3.25, 3.25}},
        selection_box = {{-3.5, -3.5}, {3.5, 3.5}},
        fluid_boxes = {
            {
                production_type = "input",
                pipe_covers = pipecoverspictures(),
                base_area = 10,
                base_level = -1,
                pipe_connections = {{type="input", position = {0, 4}}}
            },
            {
                production_type = "output",
                pipe_covers = pipecoverspictures(),
                base_area = 10,
                base_level = 1,
                pipe_connections = {{type="output", position = {0, -4}}}
            },
            off_when_no_fluid_recipe = false
        },
        working_sound = {
            sound = {
                filename = "__RealisticFusionAntimatter__/sounds/particle-accelerator.ogg",
                allow_random_repeat = true
            },
            fade_in_ticks = 30,
            fade_out_ticks = 10
        },
        animation =
        {
            layers =
            {
                {
                    filename = "__RealisticFusionAntimatter__/graphics/particle-accelerator/decelerator.png",
                    size = 550,
                    frame_count = 1,
                    shift = {0.505, 0},
                    scale = 0.5
                },
                {
                    filename = "__RealisticFusionAntimatter__/graphics/particle-accelerator/shadow.png",
                    priority = "high",
                    size = 1100,
                    shift = {0.505, 0},
                    frame_count = 1,
                    draw_as_shadow = true,
                    scale = 0.25
                }
            }
        },
        working_visualisations = {{animation = {
            filename = "__RealisticFusionAntimatter__/graphics/particle-accelerator/decelerator-animation.png",
            line_length = 6,
            width = 313,
            height = 344,
            frame_count = 12,
            animation_speed = 0.75,
            scale = 0.5,
            shift = {1.01, -1},
        }}},
        energy_usage = "7.45GW",
        energy_source = {
            type = "electric",
            usage_priority = "secondary-input",
            drain = "50MW"
        },
        result_inventory_size = 0,
        source_inventory_size = 0,
        se_allow_in_space = true
    },

    -- Antimatter processor --
    {
        name = "rf-antimatter-processor",
        type = "assembling-machine",
        order = "h[antimatter-power]-a[antimatter-processor]",
        icon = "__RealisticFusionAntimatter__/graphics/icons/antimatter-processor.png",
        icon_size = 64,
        max_health = 500,
        repair_sound = {filename = "__base__/sound/manual-repair-simple.ogg"},
        mined_sound = {filename = "__base__/sound/deconstruct-bricks.ogg",volume = 0.8},
        vehicle_impact_sound = rfcore.sounds.generic_impact,
        open_sound = rfcore.sounds.machine_open,
        close_sound = rfcore.sounds.machine_close,
        tile_width = 3, tile_height = 3,
        flags = {"placeable-neutral", "placeable-player", "player-creation", "not-flammable", "not-upgradable"},
        minable = {mining_time = 0.5, result= "rf-antimatter-processor"},
        crafting_categories = {"rf-antimatter-processing"},
        crafting_speed = 1,
        collision_box = {{-1.25, -1.25}, {1.25, 1.25}},
        selection_box = {{-1.5, -1.5}, {1.5, 1.5}},
        localised_description = {"rf.antimatter-processor", "rf-antiprotons", "rf-positrons", "rf-antihydrogen"},
        fluid_boxes = {
            {
                production_type = "input",
                pipe_covers = pipecoverspictures(),
                base_area = 10,
                base_level = -1,
                pipe_connections = {{type="input", position = {1, 2}}}
            },
            {
                production_type = "input",
                pipe_covers = pipecoverspictures(),
                base_area = 10,
                base_level = -1,
                pipe_connections = {{type="input", position = {-1, 2}}}
            },
            {
                production_type = "output",
                pipe_covers = pipecoverspictures(),
                base_area = 10,
                base_level = 1,
                pipe_connections = {{type="output", position = {1, -2}}}
            },
            {
                production_type = "output",
                pipe_covers = pipecoverspictures(),
                base_area = 10,
                base_level = 1,
                pipe_connections = {{type="output", position = {-1, -2}}}
            },
            off_when_no_fluid_recipe = false
        },
        animation =
        {
            layers =
            {
                {
                    filename = "__RealisticFusionAntimatter__/graphics/entities/antimatter-processor.png",
                    size = 160,
                    frame_count = 1,
                    --scale = 0.6
                },
                {
                    filename = "__RealisticFusionAntimatter__/graphics/entities/shadows/antimatter-processor.png",
                    size = 160,
                    frame_count = 1,
                    draw_as_shadow = true,
                    --scale = 0.6
                }
            }
        },
        working_visualisations = {{animation = {
            filename = "__RealisticFusionAntimatter__/graphics/entities/antimatter-processor.png",
            size = 160,
            --scale = 0.6,
            line_length = 5,
            frame_count = 25,
            animation_speed = 0.75
        }}},
        energy_usage = "49.95MW",
        energy_source = {
            type = "electric",
            usage_priority = "secondary-input",
            drain = "50kW"
        },
        result_inventory_size = 0,
        source_inventory_size = 0,
        se_allow_in_space = true
    },

    -- Matter-antimatter reactor --
    {
        name = "rf-antimatter-reactor",
        type = "burner-generator",
        order = "h[antimatter-power]-c[antimatter-reactor]",
        icon = "__RealisticFusionAntimatter__/graphics/icons/antimatter-reactor.png",
        icon_size = 64,
        max_health = 10000,
        repair_sound = {filename = "__base__/sound/manual-repair-simple.ogg"},
        mined_sound = {filename = "__base__/sound/deconstruct-bricks.ogg",volume = 0.8},
        vehicle_impact_sound = rfcore.sounds.generic_impact,
        open_sound = rfcore.sounds.machine_open,
        close_sound = rfcore.sounds.machine_close,
        tile_width = 20, tile_height = 18,
        flags = {"placeable-neutral", "placeable-player", "player-creation", "not-flammable", "not-upgradable", "not-rotatable"},
        minable = {mining_time = 0.5, result= "rf-antimatter-reactor"},
        crafting_categories = {"rf-matter-antimatter-annihilations"},
        crafting_speed = 1,
        collision_box = {{-9.75, -7.75}, {9.75, 9.75}},
        selection_box = {{-10, -8}, {10, 10}},
        fluid_boxes = {
            {
                production_type = "input",
                pipe_covers = pipecoverspictures(),
                base_area = 10,
                base_level = -1,
                pipe_connections = {{type="input", position = {-4.5, 0}}}
            },
            {
                production_type = "input",
                pipe_covers = pipecoverspictures(),
                base_area = 10,
                base_level = -1,
                pipe_connections = {{type="input", position = {4.5, 0}}}
            },
            {
                production_type = "input",
                pipe_covers = pipecoverspictures(),
                base_area = 10000,
                base_level = -1,
                pipe_connections = {{type="input", position = {0, -4.5}}}
            },
            {
                production_type = "output",
                pipe_covers = pipecoverspictures(),
                base_area = 10000,
                base_level = 1,
                pipe_connections = {{type="output", position = {0, 4.5}}}
            },
            off_when_no_fluid_recipe = false
        },
        idle_animation = {layers = {
            {
                filename = "__RealisticFusionAntimatter__/graphics/entities/antimatter-reactor.png",
                width = 2048,
                height =  1365,
                frame_count = 9, --it's really only 1 frame, but "Idle animation must have the same frame count as animation."
                frame_sequence = {1,1,1,1,1,1,1,1,1}, --repeat 1st frame (other frames are blank to save space)
                line_length = 3,
                animation_speed = 0.4,
                scale = 0.5,
                shift = {0, 0.4},
            },
            {
                filename = "__RealisticFusionAntimatter__/graphics/entities/shadows/antimatter-reactor.png",
                width = 2048,
                height =  1365,
                frame_count = 9,
                line_length = 3,
                draw_as_shadow = true,
                animation_speed = 0.4,
                scale = 0.5,
                shift = {0, 0.4}
            }
        }},
        animation = {layers = {
            {
                filename = "__RealisticFusionAntimatter__/graphics/entities/antimatter-reactor-powered.png",
                width = 2048,
                height =  1365,
                frame_count = 9,
                line_length = 3,
                animation_speed = 0.4,
                scale = 0.5,
                shift = {0, 0.4},
            },
            {
                filename = "__RealisticFusionAntimatter__/graphics/entities/shadows/antimatter-reactor.png",
                width = 2048,
                height =  1365,
                frame_count = 9,
                line_length = 3,
                draw_as_shadow = true,
                animation_speed = 0.4,
                scale = 0.5,
                shift = {0, 0.4}
            }
        }},
        min_perceived_performance = 1,
        working_sound = {
            sound = {
                filename = "__RealisticFusionAntimatter__/sounds/antimatter-reactor-running.ogg",
            },
            activate_sound = {
                filename = "__RealisticFusionAntimatter__/sounds/antimatter-reactor-startup.ogg",
            },
            deactivate_sound = {
                filename = "__RealisticFusionAntimatter__/sounds/antimatter-reactor-shutdown.ogg",
            },
            max_sounds_per_type = 3,
        },
        max_power_output = "1.5TW", --UNLIMITED POWAAAH
        energy_source = {
            type = "electrical",
            usage_priority = "secondary-output"
        },
        burner = {
            type = "burner",
            fuel_inventory_size = 1,
            burnt_inventory_size = 1,
            fuel_category = "rf-matter-antimatter"
        },
        se_allow_in_space = true
    },
}