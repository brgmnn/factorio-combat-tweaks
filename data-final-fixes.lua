local shell_range = settings.startup["combat-tweaks--cannon-shell-range"].value
local min_cannon_turret_range = settings.startup["combat-tweaks--min-cannon-turret-range"].value

-- Disable regular enemies
data.raw["noise-expression"]["enemy-base-radius"]["expression"] = {
  type = "literal-number",
  literal_value = 0
};

-- Vanilla cannon shells
for _, shell in pairs {
  "cannon-shell",
  "explosive-cannon-shell",
  "uranium-cannon-shell",
  "explosive-uranium-cannon-shell"
} do
  data.raw.ammo[shell].ammo_type.action.action_delivery.max_range = shell_range
end

-- Vanilla vehicles
data.raw.gun["tank-cannon"].attack_parameters.range = shell_range

-- Rampant Arsenal
if mods["RampantArsenal"] then
  for _, shell in pairs { "bio-cannon-shell", "he-cannon-shell", "incendiary-cannon-shell" } do
    ammo = data.raw.ammo[shell .. "-ammo-rampant-arsenal"]

    for _, action in pairs(ammo.ammo_type.action) do
      if action.action_delivery.type == "projectile" then
        action.action_delivery.max_range = shell_range
      end
    end
  end
end

-- K2 Turrets
if mods["K2_Turrets"] then
  data.raw["ammo-turret"]["kr-railgun-turret"].attack_parameters.range = shell_range
  data.raw["ammo-turret"]["kr-railgun-turret"].attack_parameters.min_range = min_cannon_turret_range
end
