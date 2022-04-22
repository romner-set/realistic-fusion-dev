if settings.startup["rf-antimatter"].value then
	for _, v in pairs(game.surfaces) do
        for _, _v in pairs(v.find_entities_filtered{name = "rf-antimatter-reactor"}) do
            _v.mine()
        end
    end
end