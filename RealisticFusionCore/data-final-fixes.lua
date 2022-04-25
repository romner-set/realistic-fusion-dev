-- COMPATIBILITY PATCHES --
for k,_ in pairs(mods) do pcall(require, "compatibility-patches."..k..".data-final-fixes") end

-- #region DDW RECYCLING --
if settings.startup["rf-ddw-recycling"].value then
    local recipes = {}
    for _,recipe in pairs(data.raw.recipe) do
        if recipe.ingredients then
            for i,v in ipairs(recipe.ingredients) do
                if v.name and v.name == "water" then
                    local b = false
                    if recipe.results then
                        for _,_v in ipairs(recipe.results) do
                            if _v.name and string.find(_v.name, "water") then b = true; break end
                        end
                    elseif string.find(recipe.result, "water") then break end
                    if b then break end

                    local new_recipe = util.table.deepcopy(recipe)
                    new_recipe.ingredients[i].name = "rf-depleted-water"
                    new_recipe.name = new_recipe.name.."-rf-ddw"

                    if recipe.localised_name then new_recipe.localised_name = recipe.localised_name --why is localisation so hard
                    elseif recipe.result then new_recipe.localised_name = {"item-name."..recipe.result}
                    elseif #recipe.results == 1 then
                        if recipe.results[1].type then
                            if recipe.results[1].type == "fluid" then
                                new_recipe.localised_name = {"fluid-name."..recipe.results[1].name}
                            else
                                new_recipe.localised_name = {"item-name."..recipe.results[1].name}
                            end
                        end
                    else new_recipe.localised_name = {"recipe-name."..recipe.name}
                    end
                    if recipe.localised_description then new_recipe.localised_description = recipe.localised_description end

                    table.insert(recipes, new_recipe)
                    break
                end
            end
        else
            local new_recipe
            if recipe.normal then for i,v in ipairs(recipe.normal.ingredients) do
                if v.name and v.name == "water" then
                    local b = false
                    if recipe.normal.results then
                        for _,_v in ipairs(recipe.normal.results) do
                            if _v.name and string.find(_v.name, "water") then b = true; break end
                        end
                    elseif string.find(recipe.normal.result, "water") then break end
                    if b then break end

                    new_recipe = util.table.deepcopy(recipe)
                    new_recipe.normal.ingredients[i].name = "rf-depleted-water"
                    break
                end
            end end
            if recipe.expensive then for i,v in ipairs(recipe.expensive.ingredients) do
                if v.name and v.name == "water" then
                    local b = false
                    if recipe.expensive.results then
                        for _,_v in ipairs(recipe.expensive.results) do
                            if _v.name and string.find(_v.name, "water") then b = true; break end
                        end
                    elseif string.find(recipe.expensive.result, "water") then break end
                    if b then break end

                    new_recipe = new_recipe or util.table.deepcopy(recipe)
                    new_recipe.expensive.ingredients[i].name = "rf-depleted-water"
                    break
                end
            end end

            if new_recipe ~= nil then
                table.insert(recipes, new_recipe)
                new_recipe.name = new_recipe.name.."-rf-ddw"

                if recipe.localised_name then new_recipe.localised_name = recipe.localised_name
                elseif recipe.normal.result then new_recipe.localised_name = {"item-name."..recipe.normal.result}
                elseif recipe.expensive.result then new_recipe.localised_name = {"item-name."..recipe.expensive.result}
                elseif #recipe.normal.results == 1 then
                    if recipe.normal.results[1].type then
                        if recipe.normal.results[1].type == "fluid" then
                            new_recipe.localised_name = {"fluid-name."..recipe.normal.results[1].name}
                        else
                            new_recipe.localised_name = {"item-name."..recipe.normal.results[1].name}
                        end
                    end
                elseif #recipe.expensive.results == 1 then
                    if recipe.expensive.results[1].type then
                        if recipe.expensive.results[1].type == "fluid" then
                            new_recipe.localised_name = {"fluid-name."..recipe.expensive.results[1].name}
                        else
                            new_recipe.localised_name = {"item-name."..recipe.expensive.results[1].name}
                        end
                    end
                else new_recipe.localised_name = {"recipe-name."..recipe.name}
                end if recipe.localised_description then new_recipe.localised_description = recipe.localised_description end
            end
        end
    end

    for k,technology in pairs(data.raw.technology) do
        if technology.effects then for _,effect in ipairs(technology.effects) do
            if effect.type == "unlock-recipe" then
                for _,recipe in ipairs(recipes) do
                    if effect.recipe == string.sub(recipe.name, 1, #recipe.name-8) then
                        table.insert(data.raw.technology[k].effects, {
                            type = "unlock-recipe",
                            recipe = recipe.name
                        })
                    end
                end
            end
        end end
    end

    data:extend(recipes)
end
-- #endregion --