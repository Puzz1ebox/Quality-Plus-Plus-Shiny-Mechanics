if mods["Quality-Plus-Plus"] then
    require("__Quality-Plus-Plus__.prototypes.quality")
end

local shiny_qualities = {
	"uncommonShiny",
	"rareShiny",
	"epicShiny",
	"legendaryShiny",
}


local shiny_std_defs = {
	uncommonShiny = {
		type = "quality",
		name = "uncommon-shiny",
		hidden = true,
		level = 21,
		order = "b-1",
		color = {65.9, 87.5, 0, 255},
		next = "uncommon",
		next_probability = 0.999,
		subgroup = "qualities",
		icon = "__Quality-Plus-Plus-Shiny-Mechanics__/graphics/icons/quality-uncommon-shiny.png",
		mining_drill_resource_drain_multiplier = 0.01, -- Special Shiny Property
	},
	rareShiny = {
		type = "quality",
		name = "rare-shiny",
		hidden = true,
		level = 21,
		order = "c-1",
		color = {0, 66.7, 54.9, 255},
		next = "rare",
		next_probability = 0.999,
		subgroup = "qualities",
		icon = "__Quality-Plus-Plus-Shiny-Mechanics__/graphics/icons/quality-rare-shiny.png",
		accumulator_capacity_multiplier = 1000, -- Special Shiny Property
	},
	epicShiny = {
		type = "quality",
		name = "epic-shiny",
		hidden = true,
		level = 21,
		order = "d-1",
		color = {100, 0, 47.8, 255},
		next = "epic",
		next_probability = 0.999,
		subgroup = "qualities",
		icon = "__Quality-Plus-Plus-Shiny-Mechanics__/graphics/icons/quality-epic-shiny.png",
		electric_pole_supply_area_distance_bonus = 50, -- Special Shiny Property
		electric_pole_wire_reach_bonus = 50, -- Special Shiny Property
	},
	legendaryShiny = {
		type = "quality",
		name = "legendary-shiny",
		hidden = true,
		level = 21,
		order = "e-1",
		color = {50.6, 65.9, 100, 255},
		next = "legendary",
		next_probability = 0.999,
		subgroup = "qualities",
		icon = "__Quality-Plus-Plus-Shiny-Mechanics__/graphics/icons/quality-legendary-shiny.png",
		inserter_speed_multiplier = 1 + 0.6 * 20, -- Special Shiny Property
	},
}

if mods["Quality-Plus-Plus"] then

	local mod_qualities = {"mythical","masterwork","wondrous","artifactual"}

	local mod_shiny_qualities = {
		"mythicalShiny",
		"masterworkShiny",
		"wondrousShiny",
		"artifactualShiny",
	}

	local shiny_mod_defs = {
		mythicalShiny = {
			type = "quality",
			name = "mythical-shiny",
			hidden = true,
			level = 21,
			order = "f-1",
			color = {98.8, 75.7, 100, 255},
			next_probability = 0.999,
			subgroup = "qualities",
			icon = "__Quality-Plus-Plus-Shiny-Mechanics__/graphics/icons/quality-mythical-shiny.png",
			tool_durability_multiplier = 1000, -- Special Shiny Property
		},
		masterworkShiny = {
			type = "quality",
			name = "masterwork-shiny",
			hidden = true,
			level = 21,
			order = "g-1",
			color = {63.9, 44.3, 100, 255},
			next_probability = 0.999,
			subgroup = "qualities",
			icon = "__Quality-Plus-Plus-Shiny-Mechanics__/graphics/icons/quality-masterwork-shiny.png",
			logistic_cell_charging_energy_multiplier = 20, -- Special Shiny Property
		},
		wondrousShiny = {
			type = "quality",
			name = "wondrous-shiny",
			hidden = true,
			level = 21,
			order = "h-1",
			color = {32.9, 67.1, 34.5, 255},
			next_probability = 0.999,
			subgroup = "qualities",
			icon = "__Quality-Plus-Plus-Shiny-Mechanics__/graphics/icons/quality-wondrous-shiny.png",
			crafting_machine_energy_usage_multiplier = 0.01, -- Special Shiny Property
		},
		artifactualShiny = {
			type = "quality",
			name = "artifactual-shiny",
			hidden = true,
			level = 21,
			order = "i-1",
			color = {71.4, 85.5, 70.2, 255},
			next_probability = 0.999,
			subgroup = "qualities",
			icon = "__Quality-Plus-Plus-Shiny-Mechanics__/graphics/icons/quality-artifactual-shiny.png",
			equipment_grid_width_bonus = 30, -- Special Shiny Property
			equipment_grid_height_bonus = 30, -- Special Shiny Property
		},
	}

	-- Mapping from "mythical-shiny" to "mythicalShiny"
	local shiny_key_map = {
		["mythical-shiny"] = "mythicalShiny",
		["masterwork-shiny"] = "masterworkShiny",
		["wondrous-shiny"] = "wondrousShiny",
		["artifactual-shiny"] = "artifactualShiny",
	}

	local enabled = {}
	for _, q in ipairs(mod_qualities) do
		if settings.startup["sep-multiplier-header-m-"..q].value then
			table.insert(enabled, q.."-shiny")
		end
	end

	for _, q in ipairs(mod_shiny_qualities) do
		local def_shiny = table.deepcopy(shiny_mod_defs[q])
		data:extend{ def_shiny }
	end

	for idx, q in ipairs(enabled) do
		local shiny_key = shiny_key_map[q]
		local def_shiny = shiny_key and table.deepcopy(shiny_mod_defs[shiny_key]) or nil
		local def = data.raw.quality[q:gsub("-shiny", "")]
		local next_q = enabled[idx+1]
		if def_shiny and def then
			-- Always set .next for def_shiny
			def_shiny.next = def.name
			-- UNCOMMENT FOR TESTING ONLY: def_shiny.hidden = false
			-- Only set .next for def if there is a next_q
			if next_q then
				def.next = next_q
			end
			data:extend{ def_shiny }
		end
	end

	local first_q = enabled[1]
	if first_q and data.raw.quality["legendary"] then
		local legendary = data.raw.quality["legendary"]
		legendary.next = first_q
	end
end

-- If you are using the mod, you definitely want this.

for _, q in ipairs(shiny_qualities) do
	local def_shiny = table.deepcopy(shiny_std_defs[q])
	-- UNCOMMENT FOR TESTING ONLY: def_shiny.hidden = false
	data:extend{ def_shiny }
end
