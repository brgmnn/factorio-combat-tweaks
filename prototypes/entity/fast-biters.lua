local data_util = require("__flib__.data-util");
local create_autoplacer = require("prototypes.utils.enemy-autoplace")

local nest_tint = { r = 0.1, g = 0.1, b = 1.0, a = 1 }
local map_color = { r = 0.1, g = 0.1, b = 1.0 }

local fast_biter_spawner = data_util.copy_prototype(data.raw["unit-spawner"]["biter-spawner"]);

fast_biter_spawner.name = "fast-biter-spawner";
fast_biter_spawner.animations = {
  spawner_idle_animation(0, nest_tint), spawner_idle_animation(1, nest_tint),
  spawner_idle_animation(2, nest_tint), spawner_idle_animation(3, nest_tint)
}

local autoplacer = create_autoplacer { name = "fast-biter", seed = 1235 };
fast_biter_spawner.autoplace = autoplacer.enemy_spawner_autoplace(0)
fast_biter_spawner.enemy_map_color = map_color;

data:extend({ fast_biter_spawner })
