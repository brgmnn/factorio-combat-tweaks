data:extend({
  -- Enemies
  {
    type = "bool-setting",
    name = "combat-tweaks--use-enemies",
    setting_type = "startup",
    default_value = false,
    order = "0",
    per_user = false
  },
  {
    type = "bool-setting",
    name = "combat-tweaks--new-enemy-map-colors",
    setting_type = "startup",
    default_value = false,
    order = "0",
    per_user = false
  },
  {
    type = "bool-setting",
    name = "combat-tweaks--small-collision-boxes",
    setting_type = "startup",
    default_value = false,
    order = "0",
    per_user = false
  },

  -- Technology research
  {
    type = "bool-setting",
    name = "combat-tweaks--enable-artillery-range-linear-scaling",
    setting_type = "startup",
    default_value = false,
    order = "1",
    per_user = false
  },

  -- Turrets
  {
    type = "double-setting",
    name = "combat-tweaks--laser-turret-damage-modifier",
    setting_type = "startup",
    default_value = 1.0,
    minimum_value = 0.1,
    maximum_value = 100.0,
    order = "3",
    per_user = false
  },

  -- Cannons
  {
    type = "int-setting",
    name = "combat-tweaks--min-cannon-turret-range",
    setting_type = "startup",
    default_value = 5,
    minimum_value = 5,
    maximum_value = 150,
    order = "6",
    per_user = false
  },
  {
    type = "int-setting",
    name = "combat-tweaks--cannon-shell-range",
    setting_type = "startup",
    default_value = 34,
    minimum_value = 10,
    maximum_value = 150,
    order = "6",
    per_user = false
  },

  -- Deadly trains
  {
    type = "bool-setting",
    name = "combat-tweaks--deadly-trains",
    setting_type = "startup",
    default_value = false,
    order = "9",
    per_user = false
  },

  -- Safe building toggles
  {
    type = "bool-setting",
    name = "combat-tweaks--safe-buildings--big-electric-pole",
    setting_type = "runtime-global",
    default_value = false,
    order = "c[modifier]-d[safe]",
    per_user = false
  },
  {
    type = "bool-setting",
    name = "combat-tweaks--safe-buildings--rails",
    setting_type = "runtime-global",
    default_value = false,
    order = "c[modifier]-c[safe]",
    per_user = false
  },
  {
    type = "bool-setting",
    name = "combat-tweaks--safe-buildings--rail-signals",
    setting_type = "runtime-global",
    default_value = false,
    order = "c[modifier]-e[safe]",
    per_user = false
  },
  {
    type = "bool-setting",
    name = "combat-tweaks--safe-buildings--train-stop",
    setting_type = "runtime-global",
    default_value = false,
    order = "c[modifier]-g[safe]",
    per_user = false
  },
  {
    type = "bool-setting",
    name = "combat-tweaks--safe-buildings--small-lamp",
    setting_type = "runtime-global",
    default_value = false,
    order = "c[modifier]-h[safe]",
    per_user = false
  },

  -- Unkillable toggles
  {
    type = "bool-setting",
    name = "combat-tweaks--unkillable-construction-robot",
    setting_type = "startup",
    default_value = false,
    order = "10",
    per_user = false
  },
  {
    type = "bool-setting",
    name = "combat-tweaks--unkillable-logistic-robot",
    setting_type = "startup",
    default_value = false,
    order = "10",
    per_user = false
  },
  {
    type = "bool-setting",
    name = "combat-tweaks--unkillable-land-mine",
    setting_type = "startup",
    default_value = false,
    order = "100",
    per_user = false
  },
  {
    type = "bool-setting",
    name = "combat-tweaks--unkillable-locomotive",
    setting_type = "startup",
    default_value = false,
    order = "11",
    per_user = false
  },
  {
    type = "bool-setting",
    name = "combat-tweaks--unkillable-artillery-wagon",
    setting_type = "startup",
    default_value = false,
    order = "12",
    per_user = false
  },
  {
    type = "bool-setting",
    name = "combat-tweaks--unkillable-cargo-wagon",
    setting_type = "startup",
    default_value = false,
    order = "12",
    per_user = false
  },
  {
    type = "bool-setting",
    name = "combat-tweaks--unkillable-fluid-wagon",
    setting_type = "startup",
    default_value = false,
    order = "12",
    per_user = false
  }
})
