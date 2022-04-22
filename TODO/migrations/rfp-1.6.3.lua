for _, v in pairs(game.forces) do
    if v.technologies["rf-d-t-fusion"] and v.technologies["rf-d-t-fusion"].researched and v.recipes["rf-thermonuclear-fuel"] then v.recipes["rf-thermonuclear-fuel"].enabled = true end
    if v.technologies["rf-d-he3-fusion"] and v.technologies["rf-d-he3-fusion"].researched and v.recipes["rf-fusion-fuel"] then v.recipes["rf-fusion-fuel"].enabled = true end
    if v.technologies["rf-antimatter-processing"] and v.technologies["rf-antimatter-processing"].researched and v.recipes["rf-antimatter-fuel"] then v.recipes["rf-antimatter-fuel"].enabled = true end
end