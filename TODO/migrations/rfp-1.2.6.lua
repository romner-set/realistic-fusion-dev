if game.active_mods["Flow Control"] then
	for _, v in pairs(game.forces) do
		if v.technologies["rf-plasma-handling"] and v.technologies["rf-plasma-handling"].researched then
			v.recipes["rf-pipe-elbow"].enabled = true
			v.recipes["rf-pipe-junction"].enabled = true
			v.recipes["rf-pipe-straight"].enabled = true
		end
	end
end