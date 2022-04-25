-- COMPATIBILITY PATCHES --
for k,_ in pairs(mods) do pcall(require, "compatibility-patches."..k..".settings-final-fixes") end