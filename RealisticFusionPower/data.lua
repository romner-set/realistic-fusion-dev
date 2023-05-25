-- #region COMPATIBILITY PATCHES --
for k,_ in pairs(mods) do pcall(require, "compatibility-patches."..k..".pre-data") end
-- #endregion --

-- #region INIT PROTOTYPES --
require("prototypes.gui")
require("prototypes.items")
require("prototypes.entities")
require("prototypes.fluids")
require("prototypes.categories")
require("prototypes.recipes.items")
require("prototypes.recipes.recipes")
require("prototypes.shortcuts")
--TODO require("prototypes.technology.technology")
--TODO require("prototypes.technology.fusion-efficiency")
-- #endregion --

-- #region COMPATIBILITY PATCHES --
for k,_ in pairs(mods) do pcall(require, "compatibility-patches."..k..".data") end
-- #endregion --
