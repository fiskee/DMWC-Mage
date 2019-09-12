local DMW = DMW
local Mage = DMW.Rotations.MAGE
local Rotation = DMW.Helpers.Rotation
local Setting = DMW.Helpers.Rotation.Setting
local Player, Buff, Debuff, Spell, Target, Talent, Item, GCD, CDs, HUD, Enemy20Y, Enemy20YC, Enemy30Y, Enemy30YC
local WandTime = GetTime()
local PetAttackTime = GetTime()

local function Locals()
    Player = DMW.Player
    Buff = Player.Buffs
    Debuff = Player.Debuffs
    Spell = Player.Spells
    Talent = Player.Talents
    Item = Player.Items
    Target = Player.Target or false
    HUD = DMW.Settings.profile.HUD
    CDs = Player:CDs()
    Enemy20Y, Enemy20YC = Player:GetEnemies(20)
    Enemy30Y, Enemy30YC = Player:GetEnemies(30)
end

local function Wand()
    if not Player.Moving and not DMW.Helpers.Queue.Spell and not IsAutoRepeatSpell(Spell.Shoot.SpellName) and (DMW.Time - WandTime) > 0.7 and (Target.Distance > 1 or not Setting("Auto Attack In Melee")) and
    (Spell.Frostbolt:CD() > 2 or (not Setting("Frostbolt") or Player.PowerPct <= Setting("Frostbolt Mana") or Target.TTD < Spell.Frostbolt:CastTime()))
    and Spell.Shoot:Cast(Target) then
        WandTime = DMW.Time
        return true
    end
end

local function Defensive()
    if Setting("Healthstone") and Player.HP < Setting("Healthstone HP") and (Item.MajorHealthstone:Use(Player) or Item.GreaterHealthstone:Use(Player) or Item.Healthstone:Use(Player) or Item.LesserHealthstone:Use(Player) or Item.MinorHealthstone:Use(Player)) then
        return true
    end
end

local function AutoBuff()
    if Buff.ArcaneIntellect:Remain() < 300 and Spell.ArcaneIntellect:Cast(Player) then
        return true
    end
    if Buff.FrostArmor:Remain() < 300 and Spell.FrostArmor:Cast(Player) then
        return true
    end
end

function Mage.Rotation()
    Locals()
    if Setting("Auto Target Quest Units") then
        if Player:AutoTargetQuest(30, true) then
            return true
        end
    end
    if Player.Combat and Setting("Auto Target") then
        if Player:AutoTarget(30, true) then
            return true
        end
    end
    if not Player.Combat then
        if Setting("Auto Buff") and AutoBuff() then
            return true
        end
    end

    if Target and Target.ValidEnemy and Target.Distance < 40 then
        if Defensive() then
            return true
        end
        if not Player.Moving and Setting("Polymorph Bonus Mobs") and Debuff.Polymorph:Count() == 0 and (not Spell.Polymorph:LastCast() or (DMW.Player.LastCast[1].SuccessTime and (DMW.Time - DMW.Player.LastCast[1].SuccessTime) > 0.7)) then
            if Enemy20YC > 1 and not Player.InGroup then
                local CreatureType
                for i, Unit in ipairs(Enemy20Y) do
                    if i > 1 then
                        CreatureType = Unit.CreatureType
                        if Unit.TTD > 3 and (CreatureType == "Humanoid" or CreatureType == "Beast") and not Unit:IsBoss() and Spell.Polymorph:Cast(Unit) then
                            return true
                        end
                    end
                end
            end
        end
        if (not DMW.Player.Equipment[18] or (Target.Distance <= 1 and Setting("Auto Attack In Melee"))) and not IsCurrentSpell(Spell.Attack.SpellID) then
            StartAttack()
        end
        if Setting("Frostbolt") and Target.Facing and not Player.Moving and Player.PowerPct >= Setting("Frostbolt Mana") and (Target.TTD > Spell.Frostbolt:CastTime() or (Target.Distance > 5 and not DMW.Player.Equipment[18])) and Spell.Frostbolt:Cast(Target) then
            return true
        end
        if DMW.Player.Equipment[18] and Target.Facing and Wand() then
            return true
        end
    end
end
