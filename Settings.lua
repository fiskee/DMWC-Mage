local DMW = DMW
DMW.Rotations.MAGE = {}
local Mage = DMW.Rotations.MAGE
local UI = DMW.UI

function Mage.Settings()
    -- UI.HUD.Options = {
    --     [1] = {
    --         Test = {
    --             [1] = {Text = "HUD Test |cFF00FF00On", Tooltip = ""},
    --             [2] = {Text = "HUD Test |cFFFFFF00Sort Of On", Tooltip = ""},
    --             [3] = {Text = "HUD Test |cffff0000Disabled", Tooltip = ""}
    --         }
    --     }
    -- }
    UI.AddHeader("General")
    UI.AddToggle("Auto Buff", "Auto buff with Arcane Intellect and Frost Armor", true, true)
    UI.AddToggle("Auto Target", "Auto target units when in combat and target dead/missing", false)
    UI.AddToggle("Auto Target Quest Units", nil, false)
    UI.AddHeader("DPS")
    UI.AddToggle("Auto Attack In Melee", "Will use normal attack over wand if target is in melee range", false, true)
    UI.AddToggle("Frostbolt", nil, true)
    UI.AddRange("Frostbolt Mana", "Minimum mana pct to cast Frostbolt", 0, 100, 1, 35)
    UI.AddToggle("Fireball", nil, true)
    UI.AddRange("Fireball Mana", "Minimum mana pct to cast Fireball", 0, 100, 1, 35)
    UI.AddToggle("Fire Blast", nil, false)
    UI.AddRange("Fire Blast Mana", "Minimum mana pct to cast Fire Blast", 0, 100, 1, 60)
    UI.AddHeader("Defensive")
    UI.AddToggle("Healthstone", nil, true)
    UI.AddRange("Healthstone HP", nil, 0, 100, 1, 35)
    UI.AddHeader("Utility")
    UI.AddToggle("Polymorph Bonus Mobs", "Auto Polymorph non target enemies when solo", false, true)
end