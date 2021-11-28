-- Unkillable entities
for _, category in pairs{ "land-mine", "locomotive", "artillery-wagon", "cargo-wagon", "fluid-wagon" } do
  for _, vehicle in pairs(data.raw[category]) do
    if (settings.startup["combat-tweaks--unkillable-"..category].value) then
      vehicle.resistances = {}
        for damageType, _ in pairs(data.raw["damage-type"]) do
          vehicle.resistances[damageType] = {
            type = damageType,
            percent = 100
          }
        end
    end
  end
end


-- Laser turrets
local laser_turret_damage_modifier = settings.startup["combat-tweaks--laser-turret-damage-modifier"].value
data.raw["electric-turret"]["laser-turret"].attack_parameters.damage_modifier = laser_turret_damage_modifier

-- -- Modify laser shooting speed
-- for _, effect in pairs(data.raw.technology["laser-shooting-speed-7"].effects) do
--   if effect.type == "gun-speed" then
--     effect.modifier = 10.0
--   end
-- end


-- Modify artillery shell range research
if settings.startup["combat-tweaks--enable-artillery-range-linear-scaling"].value == true then
  local formula = "2000+(L-1)*500"

  data.raw.technology["artillery-shell-range-1"].unit.count_formula = formula
  data.raw.technology["artillery-shell-speed-1"].unit.count_formula = formula

  -- for _, effect in pairs(artillery_range_tech.effects) do
  --   if effect.type == "artillery-range" then
  --     effect.modifier = 10.0
  --   end
  -- end
end
