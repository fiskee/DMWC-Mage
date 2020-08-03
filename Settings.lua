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
    UI.AddTab("General")
    UI.AddToggle("Auto Buff", "Auto buff with Arcane Intellect and Frost Armor", true, true)
    UI.AddToggle("Auto Target", "Auto target units when in combat and target dead/missing", false)
    UI.AddToggle("Auto Target Quest Units", nil, false)
    UI.AddToggle("Frost Nova", "Frost nova when close", true)
    UI.AddToggle("Ice Barrier", "Frost Barrier", true)
	UI.AddToggle("Cone of Cold", "Blast Enemy with winter", true)
	UI.AddRange("Cone of Cold Units", "Minimum units hit to cast Cone of Cold", 1, 10, 1, 4)
    UI.AddTab("DPS")
    UI.AddToggle("Auto Attack In Melee", "Will use normal attack over wand if target is in melee range", false, true)
    UI.AddToggle("Frostbolt", nil, true)
    UI.AddRange("Frostbolt Mana", "Minimum mana pct to cast Frostbolt", 0, 100, 1, 35)
    UI.AddToggle("Fireball", nil, true)
    UI.AddRange("Fireball Mana", "Minimum mana pct to cast Fireball", 0, 100, 1, 35)
    UI.AddToggle("Fire Blast", nil, false)
    UI.AddRange("Fire Blast Mana", "Minimum mana pct to cast Fire Blast", 0, 100, 1, 60)
    UI.AddToggle("Blizzard", nil, false, true)
    UI.AddRange("Blizzard Mana", "Minimum mana pct to cast Blizzard", 0, 100, 1, 20)
    UI.AddRange("Blizzard Units", "Minimum units hit to cast Blizzard", 1, 10, 1, 4)
    UI.AddTab("Defensive")
    UI.AddToggle("Healthstone", nil, true)
    UI.AddRange("Healthstone HP", nil, 0, 100, 1, 35)
    UI.AddTab("Utility")
    UI.AddToggle("Polymorph Bonus Mobs", "Auto Polymorph non target enemies when solo", false, true)
end
