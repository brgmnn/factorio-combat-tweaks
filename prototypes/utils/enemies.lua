local sounds = require("__base__.prototypes.entity.sounds")
local hit_effects = require("__base__.prototypes.entity.hit-effects")
local data_util = require("__flib__.data-util")
local animations = require("spawner-animation")
local spitter_projectiles = require("spitter-projectiles")

local sizes = {
  "larva",
  "pupae",
  "worker",
  "grunt",
  "soldier",
  "elite",
  "champion",
  "overlord",
  "titan",
  "leviathan"
}

local vanilla_sizes = {
  "small",
  "small",
  "medium",
  "medium",
  "big",
  "big",
  "behemoth",
  "behemoth",
  "behemoth",
  "behemoth"
}

local biter_attributes = {
  range = { 0.5, 0.5, 0.75, 0.75, 1.0, 1.0, 1.25, 1.50, 1.75, 2.0 },
  radius = { 0.5, 0.65, 0.75, 0.85, 0.95, 1.1, 1.2, 1.3, 1.4, 1.5 },
  cooldown = { 40, 41, 42, 44, 46, 48, 50, 52, 55, 57 },
  damage = { 16, 35, 65, 85, 115, 145, 175, 205, 235, 265 },
  healing_per_tick = { 0.01, 0.01, 0.015, 0.02, 0.05, 0.075, 0.1, 0.12, 0.14, 0.16 },

  physical_decrease = { 0, 0, 4, 5, 6, 8, 11, 13, 16, 17 },
  physical_percent = { 0, 0, 0, 10, 12, 12, 14, 16, 18, 20 },
  explosion_decrease = { 0, 0, 0, 0, 0, 10, 12, 14, 16, 20 },
  explosion_percent = { 0, 0, 0, 10, 12, 13, 15, 16, 17, 20 },

  distance_per_frame = { 0.08, 0.10, 0.125, 0.15, 0.18, 0.195, 0.2, 0.2, 0.2, 0.2 },
  movement_speed = { 0.2, 0.19, 0.185, 0.18, 0.175, 0.17, 0.17, 0.17, 0.17, 0.17 },

  max_health = { 15, 75, 150, 250, 1000, 2000, 3500, 7500, 15000, 30000 },
  pollution_to_join_attack = { 10, 40, 80, 120, 200, 300, 450, 550, 650, 750 },
  spawning_time_modifer = { 1, 1, 1, 2, 3, 7, 10, 10, 12, 12 },

  scale = { 0.25, 0.40, 0.60, 0.8, 0.9, 1, 1.2, 1.4, 1.6, 1.8 },
  corpse_icon_scale = { 0.5, 0.8, 0.857, 1.143, 0.9, 1, 1.2, 1.4, 1.6, 1.8 },

  collision_box = {
    { { -0.1, -0.1 }, { 0.1, 0.1 } },
    { { -0.2, -0.2 }, { 0.2, 0.2 } },
    { { -0.28, -0.28 }, { 0.28, 0.28 } },
    { { -0.32, -0.32 }, { 0.32, 0.32 } },
    { { -0.35, -0.35 }, { 0.35, 0.35 } },
    { { -0.4, -0.4 }, { 0.4, 0.4 } },
    { { -0.4, -0.4 }, { 0.4, 0.4 } },
    { { -0.45, -0.45 }, { 0.45, 0.45 } },
    { { -0.6, -0.6 }, { 0.6, 0.53 } },
    { { -0.8, -0.8 }, { 0.8, 0.6 } }
  },
  selection_box = {
    { { -0.2, -0.35 }, { 0.2, 0.2 } },
    { { -0.4, -0.7 }, { 0.4, 0.4 } },
    { { -0.5, -1.3 }, { 0.6, 0.25 } },
    { { -0.6, -1.4 }, { 0.6, 0.25 } },
    { { -0.7, -1.5 }, { 0.7, 0.3 } },
    { { -1.5, -2.0 }, { 1.5, 0.7 } },
    { { -2.1, -3.1 }, { 2.0, 0.5 } },
    { { -2.3, -3.4 }, { 2.3, 0.8 } },
    { { -2.6, -3.8 }, { 2.6, 1.2 } },
    { { -2.8, -4.0 }, { 2.8, 1.3 } }
  },

  attack_sound = {
    sounds.biter_roars(0.25),
    sounds.biter_roars(0.35),
    sounds.biter_roars_mid(0.60),
    sounds.biter_roars_mid(0.73),
    sounds.biter_roars_big(0.37),
    sounds.biter_roars_big(0.44),
    sounds.biter_roars_big(0.50),
    sounds.biter_roars_behemoth(0.65),
    sounds.biter_roars_behemoth(0.75),
    sounds.biter_roars_behemoth(0.85)
  }
}

local spitter_attributes = {
  max_health = { 10, 50, 200, 350, 1250, 2250, 3250, 6500, 12500, 25000 },
  healing_per_tick = { 0.01, 0.01, 0.015, 0.02, 0.05, 0.075, 0.1, 0.12, 0.14, 0.16 },
  movement_speed = { 0.185, 0.18, 0.18, 0.17, 0.17, 0.16, 0.16, 0.15, 0.15, 0.14 },
  distance_per_frame = { 0.04, 0.045, 0.050, 0.055, 0.060, 0.065, 0.067, 0.069, 0.071, 0.073 },
  pollution_to_join_attack = { 10, 40, 80, 120, 200, 300, 450, 550, 650, 750 },
  range = { 11, 11, 11, 12, 12, 12, 13, 13, 14, 14 },
  cooldown = { 100, 100, 97, 97, 95, 95, 93, 93, 90, 90 },
  warmup = { 30, 29, 28, 27, 26, 25, 24, 23, 22, 21 },

  radius = { 1.2, 1.3, 1.4, 1.5, 1.6, 1.7, 1.8, 1.9, 2.0, 2.5 },
  sticker_duration = { 600, 610, 620, 630, 640, 650, 660, 670, 680, 690 },
  damage_per_tick = { 0.1, 0.2, 0.3, 0.4, 0.5, 0.6, 0.7, 0.8, 0.9, 1 },
  sticker_damage_per_tick = { 0.025, 0.05, 0.075, 0.1, 0.125, 0.15, 0.175, 0.2, 0.225, 0.25 },
  sticker_movement_modifier = { 0.97, 0.96, 0.95, 0.94, 0.93, 0.92, 0.91, 0.90, 0.89, 0.88 },
  damage = { 4, 7.5, 11.25, 15, 22.5, 27.5, 32.5, 37.5, 42.5, 47.5 },
  particle_vertical_acceleration = { 0.01, 0.01, 0.02, 0.02, 0.03, 0.03, 0.04, 0.04, 0.05, 0.05 },
  particle_hoizontal_speed = { 0.6, 0.6, 0.7, 0.7, 0.8, 0.8, 0.9, 0.9, 1, 1 },
  particle_hoizontal_speed_deviation = {
    0.0025,
    0.0025,
    0.0024,
    0.0024,
    0.0023,
    0.0023,
    0.0022,
    0.0022,
    0.0021,
    0.0021
  },
  scale = { 0.25, 0.40, 0.60, 0.8, 0.9, 1, 1.2, 1.4, 1.6, 1.8 },

  physical_decrease = { 0, 0, 0, 0, 2, 4, 6, 8, 10, 12 },
  physical_percent = { 0, 0, 0, 10, 12, 12, 14, 14, 15, 15 },
  explosion_percent = { 0, 0, 10, 10, 20, 20, 30, 30, 40, 40 },
  spawning_time_modifer = { 1, 1, 1, 2, 2, 5, 8, 8, 10, 10 },

  collision_box = {
    { { -0.1, -0.1 }, { 0.1, 0.1 } },
    { { -0.2, -0.2 }, { 0.2, 0.2 } },
    { { -0.28, -0.28 }, { 0.28, 0.28 } },
    { { -0.32, -0.32 }, { 0.32, 0.32 } },
    { { -0.35, -0.35 }, { 0.35, 0.35 } },
    { { -0.4, -0.4 }, { 0.4, 0.4 } },
    { { -0.4, -0.4 }, { 0.4, 0.4 } },
    { { -0.45, -0.45 }, { 0.45, 0.45 } },
    { { -0.6, -0.6 }, { 0.6, 0.53 } },
    { { -0.8, -0.8 }, { 0.8, 0.6 } }
  },
  selection_box = {
    { { -0.2, -0.35 }, { 0.2, 0.2 } },
    { { -0.4, -0.7 }, { 0.4, 0.4 } },
    { { -0.5, -1.3 }, { 0.6, 0.25 } },
    { { -0.6, -1.4 }, { 0.6, 0.25 } },
    { { -0.7, -1.5 }, { 0.7, 0.3 } },
    { { -1.5, -2.0 }, { 1.5, 0.7 } },
    { { -2.1, -3.1 }, { 2.0, 0.5 } },
    { { -2.3, -3.4 }, { 2.3, 0.8 } },
    { { -2.6, -3.8 }, { 2.6, 1.2 } },
    { { -2.8, -4.0 }, { 2.8, 1.3 } }
  },

  roarvolume = { 0.4, 0.4, 0.5, 0.5, 0.6, 0.6, 0.7, 0.7, 0.8, 0.8 },
  attack_parameters_fn = {
    spitter_attack_parameters,
    spitter_attack_parameters,
    spitter_mid_attack_parameters,
    spitter_mid_attack_parameters,
    spitter_big_attack_parameters,
    spitter_big_attack_parameters,
    spitter_behemoth_attack_parameters,
    spitter_behemoth_attack_parameters,
    spitter_behemoth_attack_parameters,
    spitter_behemoth_attack_parameters
  }
}

local spitterAttributeNumeric = {
  range = { 11, 11, 11, 12, 12, 12, 13, 13, 14, 14 },
  radius = { 1.2, 1.3, 1.4, 1.5, 1.6, 1.7, 1.8, 1.9, 2.0, 2.5 },
  cooldown = { 100, 100, 97, 97, 95, 95, 93, 93, 90, 90 },
  warmup = { 30, 29, 28, 27, 26, 25, 24, 23, 22, 21 },
  stickerDuration = { 600, 610, 620, 630, 640, 650, 660, 670, 680, 690 },
  damagePerTick = { 0.1, 0.2, 0.3, 0.4, 0.5, 0.6, 0.7, 0.8, 0.9, 1 },
  stickerDamagePerTick = { 0.025, 0.05, 0.075, 0.1, 0.125, 0.15, 0.175, 0.2, 0.225, 0.25 },
  stickerMovementModifier = { 0.97, 0.96, 0.95, 0.94, 0.93, 0.92, 0.91, 0.90, 0.89, 0.88 },
  damage = { 4, 7.5, 11.25, 15, 22.5, 27.5, 32.5, 37.5, 42.5, 47.5 },
  particleVerticalAcceleration = { 0.01, 0.01, 0.02, 0.02, 0.03, 0.03, 0.04, 0.04, 0.05, 0.05 },
  particleHoizontalSpeed = { 0.6, 0.6, 0.7, 0.7, 0.8, 0.8, 0.9, 0.9, 1, 1 },
  particleHoizontalSpeedDeviation = {
    0.0025,
    0.0025,
    0.0024,
    0.0024,
    0.0023,
    0.0023,
    0.0022,
    0.0022,
    0.0021,
    0.0021
  },
  scale = { 0.25, 0.40, 0.60, 0.8, 0.9, 1, 1.2, 1.4, 1.6, 1.8 },
  healing = { 0.01, 0.01, 0.015, 0.02, 0.05, 0.075, 0.1, 0.12, 0.14, 0.16 },
  physicalDecrease = { 0, 0, 0, 0, 2, 4, 6, 8, 10, 12 },
  physicalPercent = { 0, 0, 0, 10, 12, 12, 14, 14, 15, 15 },
  explosionPercent = { 0, 0, 10, 10, 20, 20, 30, 30, 40, 40 },
  distancePerFrame = { 0.04, 0.045, 0.050, 0.055, 0.060, 0.065, 0.067, 0.069, 0.071, 0.073 },
  movement = { 0.185, 0.18, 0.18, 0.17, 0.17, 0.16, 0.16, 0.15, 0.15, 0.14 },
  health = { 10, 50, 200, 350, 1250, 2250, 3250, 6500, 12500, 25000 },
  pollutionToAttack = { 10, 40, 80, 120, 200, 300, 450, 550, 650, 750 },
  spawningTimeModifer = { 1, 1, 1, 2, 2, 5, 8, 8, 10, 10 }
}

local spawn_probability = {
  { { 0.00, 1 }, { 0.650, 0.0 } },
  { { 0.30, 0 }, { 0.350, 0.5 }, { 0.800, 0.0 } },
  { { 0.40, 0 }, { 0.450, 0.5 }, { 0.900, 0.0 } },
  { { 0.50, 0 }, { 0.550, 0.5 }, { 0.900, 0.0 } },
  { { 0.60, 0 }, { 0.650, 0.5 }, { 0.950, 0.0 } },
  { { 0.70, 0 }, { 0.750, 0.5 }, { 0.975, 0.0 } },
  { { 0.80, 0 }, { 0.825, 0.5 }, { 0.975, 0.0 } },
  { { 0.85, 0 }, { 0.875, 0.5 }, { 0.975, 0.0 } },
  { { 0.90, 0 }, { 0.925, 0.5 }, { 0.975, 0.0 } },
  { { 0.93, 0 }, { 1.000, 1.0 } }
}

-- Applies unit attributes
local function apply_unit_attributes(unit, attributes)
  attributes = attributes or {}

  for i, attribute in pairs(attributes) do
    if attribute == "slow-movement" then

    elseif attribute == "fast-movement" then
      unit.movement_speed = unit.movement_speed * 1.5
      unit.distance_per_frame = unit.distance_per_frame * 1.5
    elseif attribute == "fastest-movement" then
      unit.movement_speed = unit.movement_speed * 2
      unit.distance_per_frame = unit.distance_per_frame * 2
    end
  end
end

-- Applies spawner attributes
local function apply_spawner_attributes(spawner, attributes)
  attributes = attributes or {}

  for i, attribute in pairs(attributes) do
    -- Allows faster spawning of units from spawner. We also increase the spawn radius to allow
    -- more units to spawn
    if attribute == "fast-spawning" then
      spawner.spawning_radius = spawner.spawning_radius * 1.5

      for i, value in pairs(spawner.spawning_cooldown) do
        spawner.spawning_cooldown[i] = value / 2
      end
    end
  end
end

local function build_biter(attributes)
  local tier = attributes.tier
  local scale = biter_attributes.scale[tier]
  local name = attributes.variant .. "-" .. attributes.size .. "-biter"
  local tint1 = attributes.tint1
  local tint2 = attributes.tint2 or tint1

  local biter = data_util.copy_prototype(data.raw["unit"][vanilla_sizes[tier] .. "-biter"])

  biter.name = name
  biter.enemy_map_color = attributes.map_color

  -- Set fixed attributes from lookup table
  for _, attr in pairs {
    "max_health",
    "healing_per_tick",
    "movement_speed",
    "distance_per_frame",
    "pollution_to_join_attack",
    "collision_box",
    "selection_box"
  } do
    biter[attr] = biter_attributes[attr][tier];
  end
  -- TODO: water_reflection

  biter.run_animation = biterrunanimation(scale, tint1, tint2)
  biter.corpse = name .. "-corpse"

  biter.attack_parameters = {
    type = "projectile",
    range = biter_attributes.range[tier],
    cooldown = biter_attributes.cooldown[tier],
    cooldown_deviation = 0.15,
    ammo_type = make_unit_melee_ammo_type(biter_attributes.damage[tier]),
    sound = biter_attributes.attack_sound[tier],
    animation = biterattackanimation(scale, tint1, tint2),
    range_mode = "bounding-box-to-bounding-box"
  }

  apply_unit_attributes(biter, attributes.attributes)

  data:extend({
    biter,

    add_biter_die_animation(scale, tint1, tint2, {
      type = "corpse",
      name = name .. "-corpse",
      icons = {
        {
          -- There is no behemoth biter corse icon
          icon = "__base__/graphics/icons/" ..
              (vanilla_sizes[tier] == "behemoth" and "big" or vanilla_sizes[tier]) ..
              "-biter-corpse.png",
          icon_size = 64,
          scale = biter_attributes.corpse_icon_scale[tier],
          icon_mipmaps = 4
        }
      },
      selectable_in_game = false,
      selection_box = { { -1, -1 }, { 1, 1 } },
      subgroup = "corpses",
      order = "c[corpse]-a[biter]-c[" .. attributes.size .. "]",
      flags = { "placeable-neutral", "placeable-off-grid", "building-direction-8-way", "not-on-map" }
    })
  })

  return biter
end

local function build_spitter(attributes)
  local tier = attributes.tier
  local scale = biter_attributes.scale[tier]
  local vanilla_size = vanilla_sizes[tier]
  local name = attributes.variant .. "-" .. attributes.size .. "-spitter"
  local tint1 = attributes.tint1
  local tint2 = attributes.tint2 or tint1

  local spitter = data_util.copy_prototype(data.raw["unit"][vanilla_sizes[tier] .. "-spitter"])

  spitter.name = name
  spitter.enemy_map_color = attributes.map_color

  -- Set fixed attributes from lookup table
  for _, attr in pairs {
    "max_health",
    "healing_per_tick",
    "movement_speed",
    "distance_per_frame",
    "pollution_to_join_attack",
    "collision_box",
    "selection_box"
  } do
    spitter[attr] = spitter_attributes[attr][tier];
  end

  spitter.run_animation = spitterrunanimation(scale, tint1, tint2)
  spitter.corpse = name .. "-corpse"
  -- TODO: water_reflection

  spitter.attack_parameters = spitter_projectiles.attack_parameters {
    acid_stream_name = "acid-stream-" .. name,
    range = spitter_attributes.range[tier],
    min_attack_distance = 10,
    cooldown = spitter_attributes.cooldown[tier],
    cooldown_deviation = 0.15,
    damage_modifier = damage_modifier_spitter_behemoth,
    warmup = spitter_attributes.warmup[tier],
    scale = scale,
    tint1 = tint1,
    tint2 = tint2,
    roarvolume = spitter_attributes.roarvolume[tier],
    range_mode = "bounding-box-to-bounding-box"
  }

  -- warmup = { 30, 29, 28, 27, 26, 25, 24, 23, 22, 21 },
  -- sticker_duration = { 600, 610, 620, 630, 640, 650, 660, 670, 680, 690 },
  -- damage_per_tick = { 0.1, 0.2, 0.3, 0.4, 0.5, 0.6, 0.7, 0.8, 0.9, 1 },
  -- sticker_damage_per_tick = { 0.025, 0.05, 0.075, 0.1, 0.125, 0.15, 0.175, 0.2, 0.225, 0.25 },
  -- sticker_movement_modifier = { 0.97, 0.96, 0.95, 0.94, 0.93, 0.92, 0.91, 0.90, 0.89, 0.88 },
  -- damage = { 4, 7.5, 11.25, 15, 22.5, 27.5, 32.5, 37.5, 42.5, 47.5 },
  -- particle_vertical_acceleration = { 0.01, 0.01, 0.02, 0.02, 0.03, 0.03, 0.04, 0.04, 0.05, 0.05 },
  -- particle_hoizontal_speed = { 0.6, 0.6, 0.7, 0.7, 0.8, 0.8, 0.9, 0.9, 1, 1 },
  -- particle_hoizontal_speed_deviation = {
  --   0.0025,
  --   0.0025,
  --   0.0024,
  --   0.0024,
  --   0.0023,
  --   0.0023,
  --   0.0022,
  --   0.0022,
  --   0.0021,
  --   0.0021
  -- },
  -- scale = { 0.25, 0.40, 0.60, 0.8, 0.9, 1, 1.2, 1.4, 1.6, 1.8 },

  apply_unit_attributes(spitter, attributes.attributes)

  data:extend({
    spitter,

    -- Attacks
    acid_stream {
      name = "acid-stream-" .. name,
      scale = scale * 1.1,
      tint = tint2,
      corpse_name = "acid-splash-spitter-" .. vanilla_size,
      spit_radius = spitter_attributes.radius[tier],
      particle_spawn_interval = 1,
      particle_spawn_timeout = 6,
      splash_fire_name = "acid-splash-fire-" .. name,
      sticker_name = "acid-sticker-" .. name
    },
    acid_splash_fire({
      name = "acid-splash-fire-" .. name,
      scale = scale,
      tint = tint2,
      ground_patch_scale = scale * ground_patch_scale_modifier,
      patch_tint_multiplier = patch_opacity,
      splash_damage_per_tick = spitter_attributes.sticker_damage_per_tick[tier],
      sticker_name = "acid-sticker-" .. name
    }),
    acid_sticker({
      name = "acid-sticker-" .. name,
      tint = sticker_tint_small,
      slow_player_movement = 0.6 * spitter_attributes.sticker_movement_modifier[tier],
      slow_vehicle_speed = 0.6 * spitter_attributes.sticker_movement_modifier[tier],
      slow_vehicle_friction = 1.5,
      slow_seconds = 2
    }),

    -- Death animations
    add_spitter_die_animation(scale, tint1, tint2, {
      type = "corpse",
      name = name .. "-corpse",
      icon = "__base__/graphics/icons/big-biter-corpse.png", -- This seems to be correct in the factorio source
      icon_size = 64,
      icon_mipmaps = 4,
      selectable_in_game = false,
      selection_box = { { -1, -1 }, { 1, 1 } },
      subgroup = "corpses",
      order = "c[corpse]-b[spitter]-a[" .. attributes.size .. "]",
      flags = { "placeable-neutral", "placeable-off-grid", "building-direction-8-way", "not-on-map" }
    })
  })

  return spitter
end

-- Helper function to construct the results unit object that describes what units a spawner will
-- spawn.
local function build_result_units(params)
  local result_units = {}

  for i, size in pairs(sizes) do
    result_units[i] = { params.variant .. "-" .. size .. "-" .. params.unit, spawn_probability[i] }
  end

  return result_units
end

-- Builds a spawner that spawns biters
local function build_biter_spawner(attributes)
  local variant = attributes.variant
  local tint = attributes.tint

  local biter_spawner = data_util.copy_prototype(data.raw["unit-spawner"]["biter-spawner"])

  biter_spawner.name = variant .. "-biter-spawner"
  biter_spawner.corpse = variant .. "-biter-spawner-corpse"
  biter_spawner.animations = {
    animations.spawner_idle_animation(0, tint),
    animations.spawner_idle_animation(1, tint),
    animations.spawner_idle_animation(2, tint),
    animations.spawner_idle_animation(3, tint)
  }

  biter_spawner.autoplace = attributes.autoplacer.enemy_spawner_autoplace(0)
  biter_spawner.enemy_map_color = attributes.map_color
  biter_spawner.result_units = build_result_units { variant = variant, unit = "biter" }

  local biter_spawner_corpse = data_util.copy_prototype(data.raw["corpse"]["biter-spawner-corpse"])

  biter_spawner_corpse.name = variant .. "-biter-spawner-corpse"
  biter_spawner_corpse.animations = {
    animations.spawner_die_animation(0, tint),
    animations.spawner_die_animation(1, tint),
    animations.spawner_die_animation(2, tint),
    animations.spawner_die_animation(3, tint)
  }

  apply_spawner_attributes(biter_spawner, attributes.attributes)

  data:extend({ biter_spawner, biter_spawner_corpse })

  return biter_spawner
end

-- Builds a spawner that spawns spitters
local function build_spitter_spawner(attributes)
  local variant = attributes.variant
  local tint = attributes.tint

  local spitter_spawner = data_util.copy_prototype(data.raw["unit-spawner"]["spitter-spawner"])

  spitter_spawner.name = variant .. "-spitter-spawner"
  spitter_spawner.corpse = variant .. "-spitter-spawner-corpse"
  spitter_spawner.animations = {
    animations.spawner_idle_animation(0, tint),
    animations.spawner_idle_animation(1, tint),
    animations.spawner_idle_animation(2, tint),
    animations.spawner_idle_animation(3, tint)
  }

  spitter_spawner.autoplace = attributes.autoplacer.enemy_spawner_autoplace(0)
  spitter_spawner.enemy_map_color = attributes.map_color
  spitter_spawner.result_units = build_result_units { variant = variant, unit = "spitter" }

  local spitter_spawner_corpse = data_util.copy_prototype(
                                     data.raw["corpse"]["spitter-spawner-corpse"])

  spitter_spawner_corpse.name = variant .. "-spitter-spawner-corpse"
  spitter_spawner_corpse.animations = {
    animations.spawner_die_animation(0, tint),
    animations.spawner_die_animation(1, tint),
    animations.spawner_die_animation(2, tint),
    animations.spawner_die_animation(3, tint)
  }

  apply_spawner_attributes(spitter_spawner, attributes.attributes)

  data:extend({ spitter_spawner, spitter_spawner_corpse })

  return spitter_spawner
end

return {
  sizes = sizes,
  spawn_probability = spawn_probability,
  biter_attributes = biter_attributes,
  build_biter = build_biter,
  build_spitter = build_spitter,
  build_biter_spawner = build_biter_spawner,
  build_spitter_spawner = build_spitter_spawner,
  build_result_units = build_result_units
}
