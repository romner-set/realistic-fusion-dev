if settings.startup["rf-advanced-deuterium-extraction"].value then
	for _, v in pairs(game.forces) do
		if v.technologies["rf-deuterium-extraction"] and v.technologies["rf-deuterium-extraction"].researched then
			if not game.active_mods["angelspetrochem"] then
				v.recipes["angels-electric-boiler"].enabled = true
				if not game.active_mods["Krastorio2"] then v.recipes["rf-electrolyser"].enabled = true end
			end
			v.recipes["rf-water-purification"].enabled = true
			v.recipes["rf-electrolysis"].enabled = true
		end
	end
end