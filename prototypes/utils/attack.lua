function acid_stream(data)
  return {
    type = "stream",
    name = data.name,
    flags = { "not-on-map" },
    particle_buffer_size = 90,
    particle_spawn_interval = data.particle_spawn_interval,
    particle_spawn_timeout = data.particle_spawn_timeout,
    particle_vertical_acceleration = 0.005 * 0.60 * 1.5, -- x
    particle_horizontal_speed = 0.2 * 0.75 * 1.5 * 1.5, -- x
    particle_horizontal_speed_deviation = 0.005 * 0.70,
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
          target_effects = {
            { type = "create-sticker", sticker = data.sticker_name },
            { type = "damage", damage = { amount = 1, type = "acid" } }
          }
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

return { acid_stream = acid_stream }
