local data_util = require("__flib__.data-util");
local animations = require("prototypes.utils.spawner-animation")
local create_autoplacer = require("prototypes.utils.enemy-autoplace")
local enemies = require("prototypes.utils.enemies")

local tint1 = { r = 1, g = 1, b = 1, a = 1 }
local tint2 = { r = 1, g = 0.38, b = 0.24, a = 0.3 }
local map_color = { r = 1, g = 0.38, b = 0.24 }
local attributes = { "fastest-movement" }

-- Use the same autoplacer for this faction
local autoplacer = create_autoplacer { name = "fast-biter", seed = 456 }

-- --- Biters ---
for i, size in pairs(enemies.sizes) do
  enemies.build_biter {
    variant = "fast",
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
    variant = "fast",
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
    variant = "fast",
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
  variant = "fast",
  attributes = attributes,
  autoplacer = autoplacer,
  map_color = map_color,
  tint = tint1
}

-- Spitter spawner
enemies.build_spitter_spawner {
  variant = "fast",
  attributes = attributes,
  autoplacer = autoplacer,
  map_color = map_color,
  tint = tint1
}
