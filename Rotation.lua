local DMW = DMW
local Mage = DMW.Rotations.MAGE
local Rotation = DMW.Helpers.Rotation
local Setting = DMW.Helpers.Rotation.Setting
local Player, Buff, Debuff, Spell, Target, Talent, Item, GCD, CDs, HUD, Enemy20Y, Enemy20YC, Enemy30Y, Enemy30YC, Enemy10Y, Enemy10YC
local WandTime = GetTime()
local ItemUsage = GetTime()

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
	Enemy13Y, Enemy13YC = Player:GetEnemies(13)
	Enemy10Y, Enemy10YC = Player:GetEnemies(10)
end

local function CreateManaAgent()
    if Spell.ConjureManaRuby:Known() then
        if not Spell.ConjureManaRuby:LastCast() and not Item.ManaRuby:InBag() and Spell.ConjureManaRuby:Cast(Player) then
            return true
        end
    elseif Spell.ConjureManaCitrine:Known() then
        if not Spell.ConjureManaCitrine:LastCast() and not Item.ManaCitrine:InBag() and Spell.ConjureManaCitrine:Cast(Player) then
            return true
        end
    elseif Spell.ConjureManaJade:Known() then
        if not Spell.ConjureManaJade:LastCast() and not Item.ManaJade:InBag() and Spell.ConjureManaJade:Cast(Player) then
            return true
        end
    elseif Spell.ConjureManaAgate:Known() then
        if not Spell.ConjureManaAgate:LastCast() and not Item.ManaAgate:InBag() and Spell.ConjureManaAgate:Cast(Player) then
            return true
        end
    end
end

local function Wand()
    if not Player.Moving and not DMW.Helpers.Queue.Spell and not IsAutoRepeatSpell(Spell.Shoot.SpellName) and (DMW.Time - WandTime) > 0.7 and (Target.Distance > 1 or not Setting("Auto Attack In Melee")) and
    (Spell.Frostbolt:CD() > 2 or (((not Setting("Frostbolt") or Player.PowerPct <= Setting("Frostbolt Mana") or Target.TTD < Spell.Frostbolt:CastTime())) and
    (not Setting("Fireball") or Player.PowerPct <= Setting("Fireball Mana") or Target.TTD < Spell.Fireball:CastTime()) and
    (not Setting("Fire Blast") or Player.PowerPct <= Setting("Fire Blast Mana"))))
    and Spell.Shoot:Cast(Target) then
        WandTime = DMW.Time
        return true
    end
end

local function Defensive()
    if Setting("Ice Block") and Spell.IceBlock:IsReady() and Player.HP < Setting("Ice Block HP") and Player.Combat and Spell.IceBlock:Cast(Player) then
	    return true
	end
    if Setting("Ice Barrier") and Buff.IceBarrier:Remain() < 3 and Spell.IceBarrier:Cast(Player) then
	    return true
	end
    if Setting("Healthstone") and Player.HP < Setting("Healthstone HP") and (Item.MajorHealthstone:Use(Player) or Item.GreaterHealthstone:Use(Player) or Item.Healthstone:Use(Player) or Item.LesserHealthstone:Use(Player) or Item.MinorHealthstone:Use(Player)) then
        return true
    end
	if Setting("Frost Nova") and Player.Moving and #Player:GetEnemies(13) >= Setting("Frost Nova Amount") and Spell.FrostNova:Cast(Player) then
		return true
	end
	if Setting("Cone of Cold") and Target.Facing and Target.Distance < 8 and select(2, Target:GetEnemies(8, 2)) >= Setting("Cone of Cold Units") and Spell.ConeOfCold:Cast(Player) then
	  return true
	end
    if Setting("Mana Gem Usage") and Player.PowerPct < Setting("Gem Mana") and (DMW.Time - ItemUsage) > 0.2 and (Item.ManaRuby:Use(Player) or Item.ManaCitrine:Use(Player) or Item.ManaJade:Use(Player) or Item.ManaAgate:Use(Player)) then
        ItemUsage = DMW.Time
        return true
    end 
	if Setting("Luffa") and Item.Luffa:Equipped() and (DMW.Time - ItemUsage) > 0.2 and Player:Dispel(Item.Luffa) and Item.Luffa:Use(Player) then
        ItemUsage = DMW.Time
        return true
    end
end

local function AutoBuff()
    if Buff.ArcaneIntellect:Remain() < 300 and Spell.ArcaneIntellect:Cast(Player) then
        return true
    end
    if Setting("Ice Armor") and Buff.IceArmor:Remain() < 300 and Spell.IceArmor:Cast(Player) then
        return true
    end
	if Setting("Mage Armor") and Buff.MageArmor:Remain() < 300 and Spell.MageArmor:Cast(Player) then
        return true
    end
	if Setting("Ice Barrier") and Setting("Ice Barrier OOC") and Buff.IceBarrier:Remain() < 15 and Spell.IceBarrier:Cast(Player) then
	    return true
	end
	if Setting("Mana Gem Usage") and not Player.Moving and CreateManaAgent() then
        return true
    end

end

function Mage.Rotation()
    Locals()
    if Setting("Auto Target Quest Units") and Player.HP >= Setting("Auto Pull Min Health") and Player.PowerPct >= Setting("Auto Pull Min Mana") then
        if Player:AutoTargetQuest(30, true) then
            return true
        end
    end
	if Setting("Pull Anything") and Player.HP >= Setting("Auto Pull Min Health") and Player.PowerPct >= Setting("Auto Pull Min Mana") then
		if Player:AutoTargetAny(30, false) then 
            return true
        end
    end	
    if Player.Combat and Setting("Auto Target") then
        if Player:AutoTarget(30, true) then
            return true
        end
    end
	if Player.Combat and not Player.Moving and not Buff.IceBlock:Exist(Player) and Setting("Auto Face") and Target.ValidEnemy then
		if FaceDirection (DMW.Player.Target.Pointer) then
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
        if not Player.Moving and Player.Combat and Setting("Polymorph Bonus Mobs") and Debuff.Polymorph:Count() == 0 and (not Spell.Polymorph:LastCast() or (DMW.Player.LastCast[1].SuccessTime and (DMW.Time - DMW.Player.LastCast[1].SuccessTime) > 0.7)) then
            if Enemy30YC > 1 and not Player.InGroup then
                local CreatureType
                for i, Unit in ipairs(Enemy30Y) do
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
		if Setting("Arcane explosion") and Player.PowerPct >= Setting("Arcane Explosion Mana") and #Player:GetEnemies(9) >= Setting("Arcane Explosion Unit") and Spell.ArcaneExplosion:Cast(Player) then
		    return true
		end
        if Setting("Blizzard") and Target.Facing and not Player.Moving and Target.TTD > 4 and Player.PowerPct >= Setting("Blizzard Mana") and select(2, Target:GetEnemies(8, 2)) >= Setting("Blizzard Units") and Spell.Blizzard:Cast(Target) then
            return true
        end
        if Setting("Fireball") and Target.Facing and not Player.Moving and Player.PowerPct >= Setting("Fireball Mana") and (Target.TTD > Spell.Fireball:CastTime() or (Target.Distance > 5 and not DMW.Player.Equipment[18])) and (not Setting("Frostbolt") or Player.PowerPct < Setting("Frostbolt Mana") or Debuff.Frostbolt:Remain(Target) > Spell.Fireball:CastTime() or (Spell.Frostbolt:LastCast() and UnitIsUnit(Spell.Frostbolt.LastBotTarget, Target.Pointer))) and Spell.Fireball:Cast(Target) then
            return true
        end
        if Setting("Frostbolt") and Target.Facing and not Player.Moving and Player.PowerPct >= Setting("Frostbolt Mana") and (Target.TTD > Spell.Frostbolt:CastTime() or (Target.Distance > 5 and not DMW.Player.Equipment[18])) and Spell.Frostbolt:Cast(Target) then
            return true
        end
        if Setting("Fire Blast") and Target.Facing and Player.PowerPct >= Setting("Fire Blast Mana") and Spell.FireBlast:Cast(Target) then
            return true
        end
        if DMW.Player.Equipment[18] and Target.Facing and Wand() then
            return true
        end
    end
end
