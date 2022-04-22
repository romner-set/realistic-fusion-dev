-- Compatibility patches --
for k,_ in pairs(mods) do pcall(require, "compatibility-patches."..k..".settings-updates") end