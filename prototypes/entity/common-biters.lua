local data_util = require("__flib__.data-util");
local create_autoplacer = require("prototypes.utils.enemy-autoplace")
local enemies = require("prototypes.utils.enemies")

local tint1 = { r = 1, g = 1, b = 1, a = 1 }
local tint2 = { r = 1, g = 1, b = 1, a = 0.3 }
local map_color = { r = 1, g = 1, b = 1 }

-- Use the same autoplacer for this faction
local autoplacer = create_autoplacer { name = "common-biter", seed = 1234 }

local biters = {}

for i, size in pairs(enemies.sizes) do
  enemies.build_biter {
    variant = "common",
    size = size,
    tier = i,
    tint1 = tint1,
    tint2 = tint2,
    map_color = map_color
  }
end

-- Biter spawner
local biter_spawner = data_util.copy_prototype(data.raw["unit-spawner"]["biter-spawner"])

biter_spawner.name = "common-biter-spawner"
biter_spawner.animations = {
  spawner_idle_animation(0, tint1),
  spawner_idle_animation(1, tint1),
  spawner_idle_animation(2, tint1),
  spawner_idle_animation(3, tint1)
}

biter_spawner.autoplace = autoplacer.enemy_spawner_autoplace(0)
biter_spawner.enemy_map_color = map_color
biter_spawner.result_units = enemies.build_result_units { variant = "common", unit = "biter" }

-- Spitter spawner
local spitter_spawner = data_util.copy_prototype(data.raw["unit-spawner"]["spitter-spawner"])

spitter_spawner.name = "common-spitter-spawner"
spitter_spawner.animations = {
  spawner_idle_animation(0, tint1),
  spawner_idle_animation(1, tint1),
  spawner_idle_animation(2, tint1),
  spawner_idle_animation(3, tint1)
}

spitter_spawner.autoplace = autoplacer.enemy_spawner_autoplace(0)
spitter_spawner.enemy_map_color = map_color

-- Insert to data table
data:extend({ biter_spawner, spitter_spawner })
