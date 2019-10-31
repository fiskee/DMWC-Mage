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
    UI.AddToggle("Auto Buff", "Auto buff with Arcane Intellect and Frost Armor/Mage Armor and Gem", true, true)
    UI.AddToggle("Auto Target", "Auto target units when in combat and target dead/missing", false)
    UI.AddToggle("Auto Target Quest Units", nil, false)
	UI.AddToggle("Auto Face", nil, false)
	UI.AddToggle("Pull Anything", nil, false)
	UI.AddRange("Auto Pull Min Health", "Amount of Health in % before pulling with AutoTarget", 0, 100, 1, 25)
    UI.AddRange("Auto Pull Min Mana", "Amount of Mana in % before pulling with AutoTarget", 0, 100, 1, 25)
	
	
    UI.AddHeader("Defensive")
	UI.AddToggle("Ice Barrier", "Frost Barrier", true)
	UI.AddToggle("Ice Barrier OOC", "Frost Barrier out of combat", true)
	UI.AddToggle("Frost Nova", "Frost nova when close", true)
	UI.AddRange("Frost Nova Amount", "Will frost nova amount set or higher", 1,20,1,3)
	UI.AddToggle("Cone of Cold", "Blast Enemy with winter", true)
	UI.AddRange("Cone of Cold Units", "Minimum units hit to cast Cone of Cold", 1, 10, 1, 4)
	UI.AddToggle("Ice Armor", "Ice Armor Usage", false)
	UI.AddToggle("Mage Armor", "Mage Armor Usage", true)
	
	
    UI.AddHeader("DPS")
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
	UI.AddToggle("Arcane explosion", "Use Arcane Explosion", false)
	UI.AddRange("Arcane Explosion Mana", "Will not use below %", 0, 100, 1, 10)
	UI.AddRange("Arcane Explosion Unit", "Amount of Units in range", 0, 20, 1, 1)
	
    UI.AddHeader("Defensive")
    UI.AddToggle("Healthstone", nil, true)
    UI.AddRange("Healthstone HP", nil, 0, 100, 1, 35)
	UI.AddToggle("Mana Gem Usage", "Use Mana Gem?", false)
	UI.AddRange("Gem Mana", "What mana to use Gem at", 0, 100, 1, 25)
	UI.AddToggle("Ice Block", "Ice Block Usage", false)
	UI.AddRange("Ice Block HP", "Ice Block on % Health Points", 0, 100, 1, 25)
	


    UI.AddHeader("Utility")
    UI.AddToggle("Polly", "Auto Polymorph non target enemies when solo", false, true)
	UI.AddToggle("Luffa", "Auto use luffa trinket", true)


end
