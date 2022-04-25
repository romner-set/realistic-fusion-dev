-- #region INIT SETTINGS --
data:extend{
    {
        type = "int-setting",
        name = "rf-gui-color-variations",
        setting_type = "startup",
        default_value = 3,
        order = "a"
    },
    {
        type = "bool-setting",
        name = "rf-hc-stuff",
        setting_type = "startup",
        default_value = true,
        order = "b"
    },
    {
        type = "string-setting",
        name = "rf-hc-priority",
        setting_type = "startup",
        default_value = "secondary",
        allowed_values = {"primary", "secondary"},
        order = "c"
    },
}
-- #endregion --

-- COMPATIBILITY PATCHES --
for k,_ in pairs(mods) do pcall(require, "compatibility-patches."..k..".settings") end