-- Compatibility patches --
for k,_ in pairs(mods) do pcall(require, "compatibility-patches."..k..".pre-data") end

-- Init prototypes --
require("prototypes.items")
require("prototypes.entities")
require("prototypes.fluids")
require("prototypes.categories")
require("prototypes.recipes.items")
require("prototypes.recipes.recipes")
--TODO require("prototypes.technology.technology")
--TODO require("prototypes.technology.antimatter-efficiency")

-- Compatibility patches --
for k,_ in pairs(mods) do pcall(require, "compatibility-patches."..k..".data") end