local event = require("__flib__.event")

local build_events = {
  defines.events.on_built_entity,
  defines.events.on_robot_built_entity,
  defines.events.script_raised_built,
  defines.events.script_raised_revive
}

local safe_buildings_filter = {}

-- Safe buildings. Set all buildings marked as safe to be indestructible when they are built.
for _, name in pairs { "big-electric-pole", "small-lamp", "train-stop" } do
  if (settings.global["combat-tweaks--safe-buildings--" .. name].value) then
    safe_buildings_filter[#safe_buildings_filter + 1] = { filter = "name", name = name }
  end
end

-- Safe rails, special case as there are multiple items here
if (settings.global["combat-tweaks--safe-buildings--rails"].value) then
  safe_buildings_filter[#safe_buildings_filter + 1] = { filter = "name", name = "curved-rail" }
  safe_buildings_filter[#safe_buildings_filter + 1] = { filter = "name", name = "straight-rail" }
end

-- Safe signals, special case to cover both regular and chain signals
if (settings.global["combat-tweaks--safe-buildings--rail-signals"].value) then
  safe_buildings_filter[#safe_buildings_filter + 1] = { filter = "name", name = "rail-signal" }
  safe_buildings_filter[#safe_buildings_filter + 1] =
      { filter = "name", name = "rail-chain-signal" }
end

if #safe_buildings_filter > 0 then
  event.register(build_events, function(event)
    local entity = event.created_entity or event.entity
    entity.destructible = false

    game.print("lamp or pole built!")
  end, safe_buildings_filter)
end
