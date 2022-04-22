for _, v in pairs(game.forces) do
    if v.technologies["rf-antimatter-processing"] and v.technologies["rf-antimatter-processing"].researched and v.recipes["rf-matter-antimatter-fuel-cell-empty"] then v.recipes["rf-matter-antimatter-fuel-cell-empty"].enabled = true end
end