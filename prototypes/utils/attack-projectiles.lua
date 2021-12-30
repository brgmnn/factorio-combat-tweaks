-- require("__base__.prototypes.entity.spitter-animations")
local math3d = require "math3d"

local function acid_stream(data)
  return {
    type = "stream",
    name = data.name,
    flags = { "not-on-map" },
    particle_buffer_size = 90,
    particle_spawn_interval = data.particle_spawn_interval,
    particle_spawn_timeout = data.particle_spawn_timeout,
    particle_vertical_acceleration = data.particle_vertical_acceleration,
    particle_horizontal_speed = data.particle_horizontal_speed,
    particle_horizontal_speed_deviation = data.particle_horizontal_speed_deviation,
    particle_start_alpha = 0.5,
    particle_end_alpha = 1,
    particle_alpha_per_part = 0.8,
    particle_scale_per_part = 0.8,
    particle_loop_frame_count = 15,
    particle_fade_out_duration = 2,
    particle_loop_exit_threshold = 0.25,
    special_neutral_target_damage = { amount = 1, type = "acid" },
    working_sound = {
      sound = { { filename = "__base__/sound/fight/projectile-acid-burn-loop.ogg", volume = 0.4 } }
    },
    initial_action = {
      {
        type = "direct",
        action_delivery = {
          type = "instant",
          target_effects = {
            {
              type = "play-sound",
              sound = {
                { filename = "__base__/sound/creatures/projectile-acid-burn-1.ogg", volume = 0.65 },
                { filename = "__base__/sound/creatures/projectile-acid-burn-2.ogg", volume = 0.65 },
                {
                  filename = "__base__/sound/creatures/projectile-acid-burn-long-1.ogg",
                  volume = 0.6
                },
                {
                  filename = "__base__/sound/creatures/projectile-acid-burn-long-2.ogg",
                  volume = 0.6
                }
              }
            },
            {
              type = "create-fire",
              entity_name = data.splash_fire_name,
              tile_collision_mask = { "water-tile" },
              show_in_tooltip = true
            },
            {
              type = "create-entity",
              entity_name = "water-splash",
              tile_collision_mask = { "ground-tile" }
            }
          }
        }
      },
      {
        type = "area",
        radius = data.spit_radius,
        force = "enemy",
        ignore_collision_condition = true,
        action_delivery = {
          type = "instant",
          target_effects = { { type = "create-sticker", sticker = data.sticker_name } }
        }
      }
    },
    particle = {
      filename = "__base__/graphics/entity/acid-projectile/acid-projectile-head.png",
      draw_as_glow = true,
      line_length = 5,
      width = 22,
      height = 84,
      frame_count = 15,
      shift = util.mul_shift(util.by_pixel(-2, 30), data.scale),
      tint = data.tint,
      priority = "high",
      scale = data.scale,
      animation_speed = 1,
      hr_version = {
        filename = "__base__/graphics/entity/acid-projectile/hr-acid-projectile-head.png",
        draw_as_glow = true,
        line_length = 5,
        width = 42,
        height = 164,
        frame_count = 15,
        shift = util.mul_shift(util.by_pixel(-2, 31), data.scale),
        tint = data.tint,
        priority = "high",
        scale = 0.5 * data.scale,
        animation_speed = 1
      }
    },
    spine_animation = {
      filename = "__base__/graphics/entity/acid-projectile/acid-projectile-tail.png",
      draw_as_glow = true,
      line_length = 5,
      width = 66,
      height = 12,
      frame_count = 15,
      shift = util.mul_shift(util.by_pixel(0, -2), data.scale),
      tint = data.tint,
      priority = "high",
      scale = data.scale,
      animation_speed = 1,
      hr_version = {
        filename = "__base__/graphics/entity/acid-projectile/hr-acid-projectile-tail.png",
        draw_as_glow = true,
        line_length = 5,
        width = 132,
        height = 20,
        frame_count = 15,
        shift = util.mul_shift(util.by_pixel(0, -1), data.scale),
        tint = data.tint,
        priority = "high",
        scale = 0.5 * data.scale,
        animation_speed = 1
      }
    },
    shadow = {
      filename = "__base__/graphics/entity/acid-projectile/acid-projectile-shadow.png",
      line_length = 15,
      width = 22,
      height = 84,
      frame_count = 15,
      priority = "high",
      shift = util.mul_shift(util.by_pixel(-2, 30), data.scale),
      draw_as_shadow = true,
      scale = data.scale,
      animation_speed = 1,
      hr_version = {
        filename = "__base__/graphics/entity/acid-projectile/hr-acid-projectile-shadow.png",
        line_length = 15,
        width = 42,
        height = 164,
        frame_count = 15,
        shift = util.mul_shift(util.by_pixel(-2, 31), data.scale),
        draw_as_shadow = true,
        priority = "high",
        scale = 0.5 * data.scale,
        animation_speed = 1
      }
    },

    oriented_particle = true,
    shadow_scale_enabled = true
  }
end

local function acid_splash_fire(data)
  return {
    type = "fire",
    name = data.name,
    localised_name = { "entity-name.acid-splash" },
    flags = { "placeable-off-grid", "not-on-map" },
    damage_per_tick = { amount = 0 / 60, type = "acid" },
    maximum_damage_multiplier = 3,
    damage_multiplier_increase_per_added_fuel = 1,
    damage_multiplier_decrease_per_tick = 0.005,

    -- spawn_entity = "fire-flame-on-tree",
    uses_alternative_behavior = true,
    limit_overlapping_particles = true,
    initial_render_layer = "object",
    render_layer = "lower-object-above-shadow",
    secondary_render_layer = "higher-object-above",
    secondary_picture_fade_out_start = 30,
    secondary_picture_fade_out_duration = 60,

    spread_delay = 300,
    spread_delay_deviation = 180,
    maximum_spread_count = 100,

    particle_alpha = 0.6,
    particle_alpha_blend_duration = 60 * 5,
    -- flame_alpha = 0.35,
    -- flame_alpha_deviation = 0.05,

    emissions_per_second = 0,

    add_fuel_cooldown = 10,
    fade_in_duration = 1,
    fade_out_duration = 30,

    initial_lifetime = 60 * 32, -- 120,
    lifetime_increase_by = 0,
    lifetime_increase_cooldown = 4,
    maximum_lifetime = 1800,
    delay_between_initial_flames = 10,
    initial_flame_count = 1,
    burnt_patch_lifetime = 0,

    on_damage_tick_effect = {
      type = "direct",
      force = "enemy",
      ignore_collision_condition = true,
      trigger_target_mask = { "ground-unit" },
      filter_enabled = true,
      action_delivery = {
        type = "instant",
        target_effects = {
          { type = "create-sticker", sticker = data.sticker_name, show_in_tooltip = true },
          {
            type = "damage",
            damage = { amount = data.splash_damage_per_tick, type = "acid" },
            apply_damage_to_trees = false
          }
        }
      }
    },

    pictures = {
      {
        layers = {
          {
            filename = "__base__/graphics/entity/acid-splash/acid-splash-1.png",
            draw_as_glow = true,
            line_length = 8,
            direction_count = 1,
            width = 106,
            height = 116,
            frame_count = 26,
            shift = util.mul_shift(util.by_pixel(-12, -10), data.scale),
            tint = data.tint,
            scale = data.scale,
            hr_version = {
              filename = "__base__/graphics/entity/acid-splash/hr-acid-splash-1.png",
              draw_as_glow = true,
              line_length = 8,
              direction_count = 1,
              width = 210,
              height = 224,
              frame_count = 26,
              shift = util.mul_shift(util.by_pixel(-12, -8), data.scale),
              tint = data.tint,
              scale = 0.5 * data.scale
            }
          },
          {
            filename = "__base__/graphics/entity/acid-splash/acid-splash-1-shadow.png",
            line_length = 8,
            direction_count = 1,
            width = 134,
            height = 98,
            frame_count = 26,
            shift = util.mul_shift(util.by_pixel(2, 0), data.scale),
            draw_as_shadow = true,
            scale = data.scale,
            hr_version = {
              filename = "__base__/graphics/entity/acid-splash/hr-acid-splash-1-shadow.png",
              line_length = 8,
              direction_count = 1,
              width = 266,
              height = 188,
              frame_count = 26,
              shift = util.mul_shift(util.by_pixel(2, 2), data.scale),
              draw_as_shadow = true,
              scale = 0.5 * data.scale
            }
          }
        }
      },
      {
        layers = {
          {
            filename = "__base__/graphics/entity/acid-splash/acid-splash-2.png",
            draw_as_glow = true,
            line_length = 8,
            direction_count = 1,
            width = 88,
            height = 76,
            frame_count = 29,
            shift = util.mul_shift(util.by_pixel(-10, -18), data.scale),
            tint = data.tint,
            scale = data.scale,
            hr_version = {
              filename = "__base__/graphics/entity/acid-splash/hr-acid-splash-2.png",
              draw_as_glow = true,
              line_length = 8,
              direction_count = 1,
              width = 174,
              height = 150,
              frame_count = 29,
              shift = util.mul_shift(util.by_pixel(-9, -17), data.scale),
              tint = data.tint,
              scale = 0.5 * data.scale
            }
          },
          {
            filename = "__base__/graphics/entity/acid-splash/acid-splash-2-shadow.png",
            line_length = 8,
            direction_count = 1,
            width = 120,
            height = 136,
            frame_count = 29,
            shift = util.mul_shift(util.by_pixel(6, 28), data.scale),
            draw_as_shadow = true,
            scale = data.scale,
            hr_version = {
              filename = "__base__/graphics/entity/acid-splash/hr-acid-splash-2-shadow.png",
              line_length = 8,
              direction_count = 1,
              width = 238,
              height = 266,
              frame_count = 29,
              shift = util.mul_shift(util.by_pixel(6, 29), data.scale),
              draw_as_shadow = true,
              scale = 0.5 * data.scale
            }
          }
        }
      },
      {
        layers = {
          {
            filename = "__base__/graphics/entity/acid-splash/acid-splash-3.png",
            draw_as_glow = true,
            line_length = 8,
            direction_count = 1,
            width = 118,
            height = 104,
            frame_count = 29,
            shift = util.mul_shift(util.by_pixel(22, -16), data.scale),
            tint = data.tint,
            scale = data.scale,
            hr_version = {
              filename = "__base__/graphics/entity/acid-splash/hr-acid-splash-3.png",
              draw_as_glow = true,
              line_length = 8,
              direction_count = 1,
              width = 236,
              height = 208,
              frame_count = 29,
              shift = util.mul_shift(util.by_pixel(22, -16), data.scale),
              tint = data.tint,
              scale = 0.5 * data.scale
            }
          },
          {
            filename = "__base__/graphics/entity/acid-splash/acid-splash-3-shadow.png",
            line_length = 8,
            direction_count = 1,
            width = 110,
            height = 70,
            frame_count = 29,
            shift = util.mul_shift(util.by_pixel(16, 2), data.scale),
            draw_as_shadow = true,
            scale = data.scale,
            hr_version = {
              filename = "__base__/graphics/entity/acid-splash/hr-acid-splash-3-shadow.png",
              line_length = 8,
              direction_count = 1,
              width = 214,
              height = 140,
              frame_count = 29,
              shift = util.mul_shift(util.by_pixel(17, 2), data.scale),
              draw_as_shadow = true,
              scale = 0.5 * data.scale
            }
          }
        }
      },
      {
        layers = {
          {
            filename = "__base__/graphics/entity/acid-splash/acid-splash-4.png",
            draw_as_glow = true,
            line_length = 8,
            direction_count = 1,
            width = 128,
            height = 80,
            frame_count = 24,
            shift = util.mul_shift(util.by_pixel(16, -20), data.scale),
            tint = data.tint,
            scale = data.scale,
            hr_version = {
              filename = "__base__/graphics/entity/acid-splash/hr-acid-splash-4.png",
              draw_as_glow = true,
              line_length = 8,
              direction_count = 1,
              width = 252,
              height = 154,
              frame_count = 24,
              shift = util.mul_shift(util.by_pixel(17, -19), data.scale),
              tint = data.tint,
              scale = 0.5 * data.scale
            }
          },
          {
            filename = "__base__/graphics/entity/acid-splash/acid-splash-4-shadow.png",
            line_length = 8,
            direction_count = 1,
            width = 124,
            height = 80,
            frame_count = 24,
            shift = util.mul_shift(util.by_pixel(18, -16), data.scale),
            draw_as_shadow = true,
            scale = data.scale,
            hr_version = {
              filename = "__base__/graphics/entity/acid-splash/hr-acid-splash-4-shadow.png",
              line_length = 8,
              direction_count = 1,
              width = 248,
              height = 160,
              frame_count = 24,
              shift = util.mul_shift(util.by_pixel(18, -16), data.scale),
              draw_as_shadow = true,
              scale = 0.5 * data.scale
            }
          }
        }
      }
    },

    secondary_pictures = {
      {
        layers = {
          {
            filename = "__base__/graphics/entity/acid-splash/acid-splash-1.png",
            draw_as_glow = true,
            line_length = 8,
            direction_count = 1,
            width = 106,
            height = 116,
            frame_count = 26,
            shift = util.mul_shift(util.by_pixel(-12, -10), data.ground_patch_scale),
            tint = util.multiply_color(data.tint, data.patch_tint_multiplier),
            scale = data.ground_patch_scale,
            hr_version = {
              filename = "__base__/graphics/entity/acid-splash/hr-acid-splash-1.png",
              draw_as_glow = true,
              line_length = 8,
              direction_count = 1,
              width = 210,
              height = 224,
              frame_count = 26,
              shift = util.mul_shift(util.by_pixel(-12, -8), data.ground_patch_scale),
              tint = util.multiply_color(data.tint, data.patch_tint_multiplier),
              scale = 0.5 * data.ground_patch_scale
            }
          },
          {
            filename = "__base__/graphics/entity/acid-splash/acid-splash-1-shadow.png",
            line_length = 8,
            direction_count = 1,
            width = 134,
            height = 98,
            frame_count = 26,
            shift = util.mul_shift(util.by_pixel(2, 0), data.ground_patch_scale),
            draw_as_shadow = true,
            scale = data.ground_patch_scale,
            hr_version = {
              filename = "__base__/graphics/entity/acid-splash/hr-acid-splash-1-shadow.png",
              line_length = 8,
              direction_count = 1,
              width = 266,
              height = 188,
              frame_count = 26,
              shift = util.mul_shift(util.by_pixel(2, 2), data.ground_patch_scale),
              draw_as_shadow = true,
              scale = 0.5 * data.ground_patch_scale
            }
          }
        }
      },
      {
        layers = {
          {
            filename = "__base__/graphics/entity/acid-splash/acid-splash-2.png",
            draw_as_glow = true,
            line_length = 8,
            direction_count = 1,
            width = 88,
            height = 76,
            frame_count = 29,
            shift = util.mul_shift(util.by_pixel(-10, -18), data.ground_patch_scale),
            tint = util.multiply_color(data.tint, data.patch_tint_multiplier),
            scale = data.ground_patch_scale,
            hr_version = {
              filename = "__base__/graphics/entity/acid-splash/hr-acid-splash-2.png",
              draw_as_glow = true,
              line_length = 8,
              direction_count = 1,
              width = 174,
              height = 150,
              frame_count = 29,
              shift = util.mul_shift(util.by_pixel(-9, -17), data.ground_patch_scale),
              tint = util.multiply_color(data.tint, data.patch_tint_multiplier),
              scale = 0.5 * data.ground_patch_scale
            }
          },
          {
            filename = "__base__/graphics/entity/acid-splash/acid-splash-2-shadow.png",
            line_length = 8,
            direction_count = 1,
            width = 120,
            height = 136,
            frame_count = 29,
            shift = util.mul_shift(util.by_pixel(6, 28), data.ground_patch_scale),
            draw_as_shadow = true,
            scale = data.ground_patch_scale,
            hr_version = {
              filename = "__base__/graphics/entity/acid-splash/hr-acid-splash-2-shadow.png",
              line_length = 8,
              direction_count = 1,
              width = 238,
              height = 266,
              frame_count = 29,
              shift = util.mul_shift(util.by_pixel(6, 29), data.ground_patch_scale),
              draw_as_shadow = true,
              scale = 0.5 * data.ground_patch_scale
            }
          }
        }
      },
      {
        layers = {
          {
            filename = "__base__/graphics/entity/acid-splash/acid-splash-3.png",
            draw_as_glow = true,
            line_length = 8,
            direction_count = 1,
            width = 118,
            height = 104,
            frame_count = 29,
            shift = util.mul_shift(util.by_pixel(22, -16), data.ground_patch_scale),
            tint = util.multiply_color(data.tint, data.patch_tint_multiplier),
            scale = data.ground_patch_scale,
            hr_version = {
              filename = "__base__/graphics/entity/acid-splash/hr-acid-splash-3.png",
              draw_as_glow = true,
              line_length = 8,
              direction_count = 1,
              width = 236,
              height = 208,
              frame_count = 29,
              shift = util.mul_shift(util.by_pixel(22, -16), data.ground_patch_scale),
              tint = util.multiply_color(data.tint, data.patch_tint_multiplier),
              scale = 0.5 * data.ground_patch_scale
            }
          },
          {
            filename = "__base__/graphics/entity/acid-splash/acid-splash-3-shadow.png",
            line_length = 8,
            direction_count = 1,
            width = 110,
            height = 70,
            frame_count = 29,
            shift = util.mul_shift(util.by_pixel(16, 2), data.ground_patch_scale),
            draw_as_shadow = true,
            scale = data.ground_patch_scale,
            hr_version = {
              filename = "__base__/graphics/entity/acid-splash/hr-acid-splash-3-shadow.png",
              line_length = 8,
              direction_count = 1,
              width = 214,
              height = 140,
              frame_count = 29,
              shift = util.mul_shift(util.by_pixel(17, 2), data.ground_patch_scale),
              draw_as_shadow = true,
              scale = 0.5 * data.ground_patch_scale
            }
          }
        }
      },
      {
        layers = {
          {
            filename = "__base__/graphics/entity/acid-splash/acid-splash-4.png",
            draw_as_glow = true,
            line_length = 8,
            direction_count = 1,
            width = 128,
            height = 80,
            frame_count = 24,
            shift = util.mul_shift(util.by_pixel(16, -20), data.ground_patch_scale),
            tint = util.multiply_color(data.tint, data.patch_tint_multiplier),
            scale = data.ground_patch_scale,
            hr_version = {
              filename = "__base__/graphics/entity/acid-splash/hr-acid-splash-4.png",
              draw_as_glow = true,
              line_length = 8,
              direction_count = 1,
              width = 252,
              height = 154,
              frame_count = 24,
              shift = util.mul_shift(util.by_pixel(17, -19), data.ground_patch_scale),
              tint = util.multiply_color(data.tint, data.patch_tint_multiplier),
              scale = 0.5 * data.ground_patch_scale
            }
          },
          {
            filename = "__base__/graphics/entity/acid-splash/acid-splash-4-shadow.png",
            line_length = 8,
            direction_count = 1,
            width = 124,
            height = 80,
            frame_count = 24,
            shift = util.mul_shift(util.by_pixel(18, -16), data.ground_patch_scale),
            draw_as_shadow = true,
            scale = data.ground_patch_scale,
            hr_version = {
              filename = "__base__/graphics/entity/acid-splash/hr-acid-splash-4-shadow.png",
              line_length = 8,
              direction_count = 1,
              width = 248,
              height = 160,
              frame_count = 24,
              shift = util.mul_shift(util.by_pixel(18, -16), data.ground_patch_scale),
              draw_as_shadow = true,
              scale = 0.5 * data.ground_patch_scale
            }
          }
        }
      }
    }
  }
end

local function acid_sticker(data)
  return {
    type = "sticker",
    name = data.name,
    flags = { "not-on-map" },
    animation = {
      filename = "__base__/graphics/entity/acid-sticker/acid-sticker.png",
      draw_as_glow = true,
      priority = "extra-high",
      line_length = 5,
      width = 16,
      height = 18,
      frame_count = 50,
      animation_speed = 0.5,
      tint = data.tint or { r = 0.714, g = 0.669, b = 0.291, a = 0.745 }, -- #b6aa4abe
      shift = util.by_pixel(2, 0),
      hr_version = {
        filename = "__base__/graphics/entity/acid-sticker/hr-acid-sticker.png",
        draw_as_glow = true,
        line_length = 5,
        width = 30,
        height = 34,
        frame_count = 50,
        animation_speed = 0.5,
        tint = data.tint or { r = 0.714, g = 0.669, b = 0.291, a = 0.745 }, -- #b6aa4abe
        shift = util.by_pixel(1.5, 0),
        scale = 0.5
      }
    },
    damage_per_tick = { amount = data.damage_per_tick, type = "acid" },
    duration_in_ticks = data.slow_seconds or 600,
    target_movement_modifier_from = data.slow_player_movement,
    target_movement_modifier_to = 1,
    vehicle_speed_modifier_from = data.slow_vehicle_speed,
    vehicle_speed_modifier_to = 1,
    vehicle_friction_modifier_from = data.slow_vehicle_friction,
    vehicle_friction_modifier_to = 1
  }
end

local function spitter_attack_parameters(data)
  return {
    type = "stream",
    ammo_category = "biological",
    cooldown = data.cooldown,
    cooldown_deviation = data.cooldown_deviation,
    range = data.range,
    range_mode = data.range_mode,
    min_attack_distance = data.min_attack_distance,
    -- projectile_creation_distance = 1.9,
    damage_modifier = data.damage_modifier,
    warmup = data.warmup or 30,
    projectile_creation_parameters = spitter_shoot_shiftings(data.scale,
        data.scale * scale_spitter_stream),
    use_shooter_direction = true,
    lead_target_for_projectile_speed = 0.2 * 0.75 * 1.5 * 1.5, -- this is same as particle horizontal speed of flamethrower fire stream

    ammo_type = {
      category = "biological",
      action = {
        { type = "direct", action_delivery = { type = "stream", stream = data.acid_stream_name } }
      }
    },
    cyclic_sound = {
      begin_sound = {
        { filename = "__base__/sound/creatures/spitter-spit-start-1.ogg", volume = 0.27 },
        { filename = "__base__/sound/creatures/spitter-spit-start-2.ogg", volume = 0.27 },
        { filename = "__base__/sound/creatures/spitter-spit-start-3.ogg", volume = 0.27 },
        { filename = "__base__/sound/creatures/spitter-spit-start-4.ogg", volume = 0.27 }
      },
      middle_sound = { { filename = "__base__/sound/fight/flamethrower-mid.ogg", volume = 0 } },
      end_sound = { { filename = "__base__/sound/creatures/spitter-spit-end-1.ogg", volume = 0 } }
    },
    -- sound = sounds.spitter_roars(data.roarvolume),
    animation = spitterattackanimation(data.scale, data.tint1, data.tint2)
  }
end

return {
  acid_stream = acid_stream,
  acid_splash_fire = acid_splash_fire,
  acid_sticker = acid_sticker,
  spitter_attack_parameters = spitter_attack_parameters
}
