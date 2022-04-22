if settings.startup["rf-advanced-deuterium-extraction"].value then
	for _, v in pairs(game.forces) do
		if not game.active_mods["angelspetrochem"] and v.technologies["rf-deuterium-extraction"] and v.technologies["rf-deuterium-extraction"].researched then
			if v.recipes["rf-hydrogen-sulfide"] then v.recipes["rf-hydrogen-sulfide"].enabled = true end
		end
	end
end