-- Init rfcore global --
rfcore = require("prototypes.pipe-pictures") --{magnetic_pipe_pictures(), magnetic_pipe_to_ground_pictures(), magnetic_pipe_covers_pictures()}

rfcore.sm = settings.startup["rf-science-multiplier"].value/2 --TODO /2 added in 1.3.5 because science cost was too high + I'm too lazy to change all of the values manually
rfcore.sounds = require("__base__/prototypes/entity/sounds")
rfcore.hit_effects = require("__base__/prototypes/entity/hit-effects")
rfcore.resource_autoplace = require("resource-autoplace")
rfcore.empty_sprite = {filename = "__RealisticFusionCore__/graphics/empty.png", size = 1}

function rfcore.insert_to_ingredients (n, t) for _, v in ipairs(t) do table.insert(data.raw.recipe[n].ingredients, v) end end

function rfcore.tintPictures(pictures, tint)
	for _, picture in pairs(pictures) do
		picture.tint = tint
		if picture.hr_version then
			picture.hr_version.tint = tint
		end
	end
end
function rfcore.mapMany(array, f)
	local result = {}
	for _, vs in pairs(array) do
		for _, v in pairs(f(vs)) do
			table.insert(result, v)
		end
	end
	return result;
end

-- Init prototypes --
require("prototypes.items")
require("prototypes.entities")
require("prototypes.fluids")
require("prototypes.categories")
require("prototypes.recipes.items")
require("prototypes.recipes.recipes")
require("prototypes.resources")
--TODO require("prototypes.technology.technology")
--TODO require("prototypes.technology.heating-efficiency")
if not mods["angelspetrochem"] then require("electric-boiler.electric-boiler") end

-- Compatibility patches --
for k,_ in pairs(mods) do pcall(require, "compatibility-patches."..k..".data") end