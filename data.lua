require("prototypes.entity.common-biters")
require("prototypes.entity.fast-biters")

-- Unkillable entities
for _, category in pairs {
  "construction-robot",
  "logistic-robot",
  "land-mine",
  "locomotive",
  "artillery-wagon",
  "cargo-wagon",
  "fluid-wagon"
} do
  for _, vehicle in pairs(data.raw[category]) do
    if (settings.startup["combat-tweaks--unkillable-" .. category].value) then
      vehicle.resistances = {}

      for damageType, _ in pairs(data.raw["damage-type"]) do
        vehicle.resistances[damageType] = { type = damageType, percent = 100 }
      end
    end
  end
end

-- Laser turrets
local laser_turret_damage_modifier = settings.startup["combat-tweaks--laser-turret-damage-modifier"]
                                         .value

data.raw["electric-turret"]["laser-turret"].attack_parameters.damage_modifier =
    laser_turret_damage_modifier

-- Modify artillery shell range research
if settings.startup["combat-tweaks--enable-artillery-range-linear-scaling"].value == true then
  local formula = "2000+(L-1)*500"

  data.raw.technology["artillery-shell-range-1"].unit.count_formula = formula
  data.raw.technology["artillery-shell-speed-1"].unit.count_formula = formula
end

-- Deadly trains
if settings.startup["combat-tweaks--deadly-trains"].value == true then
  for _, category in pairs { "locomotive", "artillery-wagon", "cargo-wagon", "fluid-wagon" } do
    for _, vehicle in pairs(data.raw[category]) do
      vehicle.energy_per_hit_point = 0.000001
    end
  end
end
