require("__Quality-Plus-Plus-Shiny-Mechanics__.prototypes.quality")

local shiny_qualities_tier_one = {
  "uncommon-shiny",
  "rare-shiny",
}

local shiny_qualities_tier_two = {
  "epic-shiny",
}

local shiny_qualities_tier_three = {
  "legendary-shiny",
}

local shiny_qualities_tier_four = {
  "mythical-shiny",
  "masterwork-shiny",
  "wondrous-shiny",
  "artifactual-shiny"
}

local unlock_effects_tier_one = {}
for _, q in ipairs(shiny_qualities_tier_one) do
  table.insert(unlock_effects_tier_one, { type = "unlock-quality", quality = q })
end

local quality_module = data.raw.technology["quality-module"]
if quality_module then
  quality_module.effects = quality_module.effects or {}
  for _, eff in ipairs(unlock_effects_tier_one) do
    -- sanity-check
    if eff.type == "unlock-quality" then
      table.insert(quality_module.effects, eff)
    else
      log("Skipping invalid effect: ".. serpent.line(eff))
    end
  end
end

local unlock_effects_tier_two = {}
for _, q in ipairs(shiny_qualities_tier_two) do
  table.insert(unlock_effects_tier_two, { type = "unlock-quality", quality = q })
end

local epic_tech = data.raw.technology["epic-quality"]
if epic_tech then
  epic_tech.effects = epic_tech.effects or {}
  for _, eff in ipairs(unlock_effects_tier_two) do
    -- sanity-check
    if eff.type == "unlock-quality" then
      table.insert(epic_tech.effects, eff)
    else
      log("Skipping invalid effect: ".. serpent.line(eff))
    end
  end
end

local unlock_effects_tier_three = {}
for _, q in ipairs(shiny_qualities_tier_three) do
  table.insert(unlock_effects_tier_three, { type = "unlock-quality", quality = q })
end

local legendary_tech = data.raw.technology["legendary-quality"]
if legendary_tech then
  legendary_tech.effects = legendary_tech.effects or {}
  for _, eff in ipairs(unlock_effects_tier_three) do
    -- sanity-check
    if eff.type == "unlock-quality" then
      table.insert(legendary_tech.effects, eff)
    else
      log("Skipping invalid effect: ".. serpent.line(eff))
    end
  end
end

if mods["Quality-Plus-Plus"] then

  local mod_qualities = {"mythical","masterwork","wondrous","artifactual"}

  local enabled = {}
  for _, q in ipairs(mod_qualities) do
    if settings.startup["sep-multiplier-header-m-"..q].value then
      table.insert(enabled, q.."-shiny")
    end
  end

  local unlock_effects_tier_four = {}
  for _, q in ipairs(enabled) do
    table.insert(unlock_effects_tier_four, { type = "unlock-quality", quality = q })
  end

  local legendary_tech = data.raw.technology["legendary-quality"]
  if legendary_tech then
    legendary_tech.effects = legendary_tech.effects or {}
    for _, eff in ipairs(unlock_effects_tier_four) do
      -- sanity-check
      if eff.type == "unlock-quality" then
        table.insert(legendary_tech.effects, eff)
      else
        log("Skipping invalid effect: ".. serpent.line(eff))
      end
    end
  end

end