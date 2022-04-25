-- #region INIT SETTINGS --
data:extend{
    {
        type = "int-setting",
        name = "rf-operations-per-tick",
        setting_type = "runtime-global",
        default_value = 16,
        minimum_value = 0,
        order = "a"
    },
    {
        type = "double-setting",
        name = "rf-science-multiplier",
        setting_type = "startup",
        default_value = 1,
        order = "a"
    },
    {
        type = "bool-setting",
        name = "rf-ddw-recycling",
        setting_type = "startup",
        default_value = true,
        order = "c"
    },
    {
        type = "double-setting",
        name = "rf-gs-process-efficiency",
        setting_type = "startup",
        maximum_value = 1,
        default_value = 1,
        minimum_value = 0,
        order = "b"
    },
    {
        type = "bool-setting",
        name = "rf-separate-category",
        setting_type = "startup",
        default_value = true,
        order = "e"
    },
}
-- #endregion --

-- COMPATIBILITY PATCHES --
for k,_ in pairs(mods) do pcall(require, "compatibility-patches."..k..".settings") end