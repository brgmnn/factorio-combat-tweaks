local data_util = require("__flib__.data-util");
local animations = require("prototypes.utils.spawner-animation")
local create_autoplacer = require("prototypes.utils.enemy-autoplace")
local enemies = require("prototypes.utils.enemies")

local tint1 = { r = 1, g = 1, b = 1, a = 1 }
local tint2 = { r = 1, g = 1, b = 1, a = 0.3 }
local map_color = { r = 1, g = 1, b = 1 }
local attributes = { "fast-spawning" }

-- Use the same autoplacer for this faction
-- TODO: make density configurable
local autoplacer = create_autoplacer { name = "common-biter", seed = 1234, density = 1 / 8 }

-- --- Biters ---
for i, size in pairs(enemies.sizes) do
  enemies.build_biter {
    variant = "common",
    attributes = attributes,
    map_color = map_color,
    size = size,
    tier = i,
    tint1 = tint1,
    tint2 = tint2
  }
end

-- --- Spitters ---
for i, size in pairs(enemies.sizes) do
  enemies.build_spitter {
    variant = "common",
    attributes = attributes,
    map_color = map_color,
    size = size,
    tier = i,
    tint1 = tint1,
    tint2 = tint2
  }
end

-- --- Worms ---
for i, size in pairs(enemies.sizes) do
  enemies.build_worm {
    variant = "common",
    attributes = attributes,
    autoplacer = autoplacer,
    map_color = map_color,
    size = size,
    tier = i,
    tint1 = tint1,
    tint2 = tint2
  }
end

-- --- Spawners ---
-- Biter spawner
enemies.build_biter_spawner {
  variant = "common",
  attributes = attributes,
  autoplacer = autoplacer,
  map_color = map_color,
  tint = tint1
}

-- Spitter spawner
enemies.build_spitter_spawner {
  variant = "common",
  attributes = attributes,
  autoplacer = autoplacer,
  map_color = map_color,
  tint = tint1
}
