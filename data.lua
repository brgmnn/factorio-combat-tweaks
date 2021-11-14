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
