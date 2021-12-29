-- require("__base__.prototypes.entity.spitter-animations")
local math3d = require "math3d"

local function attack_parameters(data)
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
        {
          type = "area",
          radius = data.radius,
          action_delivery = {
            type = "instant",
            target_effects = { { type = "damage", damage = { amount = data.damage, type = "acid" } } }
          }
        },
        {
          type = "direct",
          action_delivery = {
            type = "stream",
            stream = data.acid_stream_name,
          }
        }
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

return { acid_stream = acid_stream, attack_parameters = attack_parameters }
