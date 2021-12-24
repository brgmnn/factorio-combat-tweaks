local data_util = require("__flib__.data-util");
local animations = require("prototypes.utils.spawner-animation")
local create_autoplacer = require("prototypes.utils.enemy-autoplace")
local enemies = require("prototypes.utils.enemies")

local tint1 = { r = 1, g = 1, b = 1, a = 1 }
local tint2 = { r = 1, g = 1, b = 1, a = 0.3 }
local map_color = { r = 1, g = 1, b = 1 }

-- Use the same autoplacer for this faction
local autoplacer = create_autoplacer { name = "common-biter", seed = 1234 }

-- Biters
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

-- Spitters
for i, size in pairs(enemies.sizes) do
  enemies.build_spitter {
    variant = "common",
    size = size,
    tier = i,
    tint1 = tint1,
    tint2 = tint2,
    map_color = map_color
  }
end

-- Biter spawner
enemies.build_biter_spawner {
  autoplacer = autoplacer,
  map_color = map_color,
  tint = tint1,
  variant = "common",
}

-- Spitter spawner
enemies.build_spitter_spawner {
  autoplacer = autoplacer,
  map_color = map_color,
  tint = tint1,
  variant = "common"
}
