--[[local files = {
		"Public/5eSpells/Stats/Generated/Data/Passives_5eSpells.txt",
		"Public/5eSpells/Stats/Generated/Data/Spells_1stLevel.txt",
		"Public/5eSpells/Stats/Generated/Data/Spells_2ndLevel.txt",
		"Public/5eSpells/Stats/Generated/Data/Spells_3rdLevel.txt",
		"Public/5eSpells/Stats/Generated/Data/Spells_4thLevel.txt",
		"Public/5eSpells/Stats/Generated/Data/Spells_5thLevel.txt",
		"Public/5eSpells/Stats/Generated/Data/Spells_Effects.txt",
		"Public/5eSpells/Stats/Generated/Data/Statuses_1stLevel.txt",
		"Public/5eSpells/Stats/Generated/Data/Statuses_2ndLevel.txt",
		"Public/5eSpells/Stats/Generated/Data/Statuses_3rdLevel.txt",
		"Public/5eSpells/Stats/Generated/Data/Statuses_4thLevel.txt",
		"Public/5eSpells/Stats/Generated/Data/Statuses_5thLevel.txt"
}

local function ResetStats()
        Ext.Stats.LoadStatsFile("Public/5eSpells/Stats/Generated/Data/Spells_2ndLevel.txt", false)
		Ext.Stats.LoadStatsFile("Public/5eSpells/Stats/Generated/Data/Character_5eSpells.txt", false)
        Ext.Stats.LoadStatsFile("Public/5eSpells/Stats/Generated/Data/Statuses_2ndLevelSpells.txt", false)
end

Ext.Events.ResetCompleted:Subscribe(ResetStats)--]]

function DelayedCall(delayInMs, func)
    local startTime = Ext.Utils.MonotonicTime()
    local handlerId;
    handlerId = Ext.Events.Tick:Subscribe(function()
        local endTime = Ext.Utils.MonotonicTime()
        if (endTime - startTime > delayInMs) then
            Ext.Events.Tick:Unsubscribe(handlerId)
            func()
        end
    end) 
end

local function GetEntityStatus(entity, statusId)
    if entity.ServerCharacter ~= nil then
        return entity.ServerCharacter:GetStatus(statusId)
    elseif entity.ServerItem ~= nil then
        for _, esvStatus in pairs(entity.ServerItem.StatusManager.Statuses) do
            if esvStatus.StatusId == statusId then
                return esvStatus
            end
        end
    end
end

--[[local invisStatuses = {
  INVISIBLE = "INVISIBLE_SEEN",
  INVISIBLE_MAGEHAND = "INVISIBLE_MAGEHAND_SEEN",
  INVISIBILITY = "INVISIBILITY_SEEN",
  ONE_WITH_SHADOWS = "ONE_WITH_SHADOWS_SEEN",
  POTION_OF_INVISIBILITY = "POTION_OF_INVISIBILITY_SEEN",
  CLOAK_OF_SHADOWS = "CLOAK_OF_SHADOWS_SEEN",
  CLOAK_OF_SHADOWS_MONK = "CLOAK_OF_SHADOWS_MONK_SEEN",
  UMBRAL_CLOAK = "UMBRAL_CLOAK_SEEN",
  GREATER_INVISIBILITY = "GREATER_INVISIBILITY_SEEN",
  SHADOWBLEND = "SHADOWBLEND_SEEN",
  INVISIBILITY_SHADARKAI_GLOOMWEAVER = "INVISIBILITY_SHADARKAI_GLOOMWEAVER_SEEN",
  HIDE_IN_PLAIN_SIGHT = "HIDE_IN_PLAIN_SIGHT_SEEN",
  MISTY_ESCAPE_INVISIBLE = "MISTY_ESCAPE_INVISIBLE_SEEN",
  INVISIBILITY_PANTHER = "INVISIBILITY_PANTHER_SEEN",
  SHROUD_SELF = "SHROUD_SELF_SEEN",
  SUPREME_SNEAK = "SUPREME_SNEAK_SEEN",
  LOW_POLTERGEIST_INVISIBLE = "LOW_POLTERGEIST_INVISIBLE_SEEN"
}

-- Mind Spike Invisibility Source
Ext.Osiris.RegisterListener("StatusApplied", 4, "after", function (character, status, causee, _)
	if Osi.HasActiveStatusWithGroup(character, "SG_Invisible") == 1 then
		Osi.SetVarObject(character,"MindSpikeSource",causee)
    end
end)

-- Mind Spike Setup
Ext.Osiris.RegisterListener("GainedControl", 1, "before", function (character)
	if Osi.HasActiveStatus(character,"MIND_SPIKE_OWNER") == 1 then
		Osi.ApplyStatus(character,"MIND_SPIKE_AURA",6.0,1)
	elseif Osi.HasActiveStatus(character,"MIND_SPIKE_OWNER") == 0 then
		Osi.RemoveStatus(character,"MIND_SPIKE_REMOVAL")
		Osi.RemoveStatus(character,"MIND_SPIKE_TECHNICAL")
    end
end)

-- Mind Spike Application
Ext.Osiris.RegisterListener("StatusApplied", 4, "after", function (character, status, _, _)
	local source = Osi.GetVarObject(character,"MindSpikeSource")
	if status == "MIND_SPIKE_REMOVAL" then
		for invis, seeninvis in pairs(invisStatuses) do
			if Osi.HasActiveStatus(character,invis) == 1 then
				local turns = Osi.GetStatusTurns(character,invis)
				Osi.ApplyStatus(character,seeninvis,turns*6,1,character)
			end
		end
    end
end)

-- Mind Spike Removal
Ext.Osiris.RegisterListener("StatusRemoved", 4, "after", function (character, status, _, _)
	local source = Osi.GetVarObject(character,"MindSpikeSource")
	if status == "MIND_SPIKE_REMOVAL" then
		for invis, seeninvis in pairs(invisStatuses) do
			if Osi.HasActiveStatus(character,seeninvis) == 1 then
				local turns = Osi.GetStatusTurns(character,seeninvis)
				Osi.ApplyStatus(character,invis,turns*6,1,character)
			end
		end
    end
end)--]]

-- Catnap Short Resting
Ext.Osiris.RegisterListener("StatusApplied", 4, "after", function (character, status, causee, _)
	if status == "CATNAP" then
		local catnapper = Ext.Entity.Get(character)
		catnapper:CreateComponent("ShortRest")
    end
end)

---@param diceAmount integer
---@param faces integer
---@param minDieValue? integer
---@param maxDieValue? integer
---@return integer
function RollDice(diceAmount, faces, minDieValue, maxDieValue)
    local total = 0
    local min = math.min(minDieValue or 1, faces)
    local max = math.min(maxDieValue or faces, faces)
    for i = 1, diceAmount do
        total = total + Ext.Utils.Random(min, max)
    end
    return total
end

--[[ Weapon Equipping
Ext.Osiris.RegisterListener("TemplateAddedTo", 4, "after", function (item, object2, character, addtype)
	if Osi.HasSpell(character,"Shout_ShadowBlade") == 1 and item == "UNI_HUM_ShadowBlade_66d6cbd5-c231-4fc4-a3b7-80f781b579f7" then
	local mainwep = Osi.GetEquippedItem(character, "Melee Main Weapon")
	local mainweapon = Osi.GetTemplate(mainwep)
		if mainweapon ~= "UNI_HUM_ShadowBlade_66d6cbd5-c231-4fc4-a3b7-80f781b579f7" then
			Osi.Unequip(character,mainwep)
			DelayedCall(100, function ()
				Osi.Equip(character,mainwep)
			end)
		end
	end
end)--]]

function S5E_IsNullUUID(uuid)
	return (uuid == nil) or uuid:find('00000000[-]0000[-]0000[-]0000[-]000000000000$')
end

function S5E_ShareInitiative(owner, summon)
	if (Debug) then
		print("S5E_ShareInitiative: " .. owner .. ", " .. summon)
	end
	
	local ownerCombat = Osi.CombatGetGuidFor(owner)
	local summonCombat = Osi.CombatGetGuidFor(summon)
	
	if not ownerCombat or ownerCombat ~= summonCombat then
		return
	end

	local ownerEntity = Ext.Entity.Get(owner)
	local summonEntity = Ext.Entity.Get(summon)
	local ownerRoll = ownerEntity.CombatParticipant.InitiativeRoll
	local summonRoll = summonEntity.CombatParticipant.InitiativeRoll
	
	if ownerRoll ~= summonRoll then
		print("Adjusting initiative roll from " .. summonRoll .. " to " .. ownerRoll .. " for " .. summon)
		summonEntity.CombatParticipant.InitiativeRoll = ownerRoll
		summonEntity:Replicate("CombatParticipant")
	end
end

local function S5E_Mislead_EnteredCombat(object, combatGuid)

	local caster = ""
	local byTagTable = ""
	local casterUuid = ""
	local doubleUuid = ""
	local casterUuid = ""
	
	if not S5E_IsNullUUID(object) and Osi.IsPartyMember(object, 0) == 1 and Osi.HasActiveStatus(object, "MISLEAD_TECHNICAL") == 1 then 
		local caster = Ext.Entity.Get(object)
		
		if caster.SummonContainer ~= nil and caster.SummonContainer.ByTag ~= nil then 
			local byTagTable = caster.SummonContainer.ByTag
			
			for key, entityList in pairs(byTagTable) do
				if key == "'MisleadStack'" then
					for i,entity in ipairs(entityList) do
						
						local doubleUuid = Ext.Entity.HandleToUuid(entity)
						local casterUuid = string.sub(object, -36)
						
						S5E_ShareInitiative(casterUuid, doubleUuid)
					end
				end
			end
		end
		
	elseif not S5E_IsNullUUID(object) then
		if Osi.IsSummon(object) == 1 and Osi.HasActiveStatus(object, "MISLEAD_ILLUSION") == 1 then
		
			local casterUuid = Osi.CharacterGetOwner(object)
			local doubleUuid = string.sub(object, -36)	

			S5E_ShareInitiative(casterUuid, doubleUuid)	
		end
	end
end	

Ext.Osiris.RegisterListener("EnteredCombat", 2, "after", S5E_Mislead_EnteredCombat)

--[[ -- Dispel Magic
Ext.Osiris.RegisterListener("StatusApplied", 4, "after", function (object, status, causee, _)
    if status == "DISPEL_MAGIC" and Osi.IsCharacter(object) == 1 then
        for _, esvStatus in pairs(Ext.Entity.Get(object).ServerCharacter.StatusManager.Statuses) do
            if Osi.SpellHasSpellFlag(esvStatus.SourceSpell.Prototype, "IsSpell") == 1 then
                local spell = Ext.Stats.Get(esvStatus.SourceSpell.Prototype)
                if spell.PowerLevel < 4 then
                    Osi.RemoveStatus(object,esvStatus.StatusId)
                end
            end
        end
    elseif status == "DISPEL_MAGIC" and Osi.IsItem(object) == 1 then
        for _, esvStatus in pairs(Ext.Entity.Get(object).ServerItem.StatusManager.Statuses) do
            if Osi.SpellHasSpellFlag(esvStatus.SourceSpell.Prototype, "IsSpell") == 1 then
                local spell = Ext.Stats.Get(esvStatus.SourceSpell.Prototype)
                if spell.PowerLevel < 4 then
                    Osi.RemoveStatus(object,esvStatus.StatusId)
                end
            end
        end
	elseif status == "DISPEL_MAGIC" and Osi.IsSurface(object) == 1 then
        for _, esvStatus in pairs(Ext.Entity.Get(object).ServerSurface.StatusManager.Statuses) do
            if Osi.SpellHasSpellFlag(esvStatus.SourceSpell.Prototype, "IsSpell") == 1 then
                local spell = Ext.Stats.Get(esvStatus.SourceSpell.Prototype)
                if spell.PowerLevel < 4 then
                    Osi.RemoveStatus(object,esvStatus.StatusId)
                end
            end
        end	
    end

    if status == "DISPEL_MAGIC_4" and Osi.IsCharacter(object) == 1 then
        for _, esvStatus in pairs(Ext.Entity.Get(object).ServerCharacter.StatusManager.Statuses) do
            if Osi.SpellHasSpellFlag(esvStatus.SourceSpell.Prototype, "IsSpell") == 1 then
                local spell = Ext.Stats.Get(esvStatus.SourceSpell.Prototype)
                if spell.PowerLevel < 5 then
                    Osi.RemoveStatus(object,esvStatus.StatusId)
                end
            end
        end
    elseif status == "DISPEL_MAGIC_4" and Osi.IsItem(object) == 1 then
        for _, esvStatus in pairs(Ext.Entity.Get(object).ServerItem.StatusManager.Statuses) do
            if Osi.SpellHasSpellFlag(esvStatus.SourceSpell.Prototype, "IsSpell") == 1 then
                local spell = Ext.Stats.Get(esvStatus.SourceSpell.Prototype)
                if spell.PowerLevel < 5 then
                    Osi.RemoveStatus(object,esvStatus.StatusId)
                end
            end
        end
	elseif status == "DISPEL_MAGIC_4" and Osi.IsSurface(object) == 1 then
        for _, esvStatus in pairs(Ext.Entity.Get(object).ServerSurface.StatusManager.Statuses) do
            if Osi.SpellHasSpellFlag(esvStatus.SourceSpell.Prototype, "IsSpell") == 1 then
                local spell = Ext.Stats.Get(esvStatus.SourceSpell.Prototype)
                if spell.PowerLevel < 5 then
                    Osi.RemoveStatus(object,esvStatus.StatusId)
                end
            end
        end
    end
	
	if status == "DISPEL_MAGIC_5" and Osi.IsCharacter(object) == 1 then
        for _, esvStatus in pairs(Ext.Entity.Get(object).ServerCharacter.StatusManager.Statuses) do
            if Osi.SpellHasSpellFlag(esvStatus.SourceSpell.Prototype, "IsSpell") == 1 then
                local spell = Ext.Stats.Get(esvStatus.SourceSpell.Prototype)
                if spell.PowerLevel < 6 then
                    Osi.RemoveStatus(object,esvStatus.StatusId)
                end
            end
        end
    elseif status == "DISPEL_MAGIC_5" and Osi.IsItem(object) == 1 then
        for _, esvStatus in pairs(Ext.Entity.Get(object).ServerItem.StatusManager.Statuses) do
            if Osi.SpellHasSpellFlag(esvStatus.SourceSpell.Prototype, "IsSpell") == 1 then
                local spell = Ext.Stats.Get(esvStatus.SourceSpell.Prototype)
                if spell.PowerLevel < 6 then
                    Osi.RemoveStatus(object,esvStatus.StatusId)
                end
            end
        end
	elseif status == "DISPEL_MAGIC_5" and Osi.IsSurface(object) == 1 then
        for _, esvStatus in pairs(Ext.Entity.Get(object).ServerSurface.StatusManager.Statuses) do
            if Osi.SpellHasSpellFlag(esvStatus.SourceSpell.Prototype, "IsSpell") == 1 then
                local spell = Ext.Stats.Get(esvStatus.SourceSpell.Prototype)
                if spell.PowerLevel < 6 then
                    Osi.RemoveStatus(object,esvStatus.StatusId)
                end
            end
        end	
    end
	
	if status == "DISPEL_MAGIC_6" and Osi.IsCharacter(object) == 1 then
        for _, esvStatus in pairs(Ext.Entity.Get(object).ServerCharacter.StatusManager.Statuses) do
            if Osi.SpellHasSpellFlag(esvStatus.SourceSpell.Prototype, "IsSpell") == 1 then
                local spell = Ext.Stats.Get(esvStatus.SourceSpell.Prototype)
                if spell.PowerLevel < 7 then
                    Osi.RemoveStatus(object,esvStatus.StatusId)
                end
            end
        end
    elseif status == "DISPEL_MAGIC_6" and Osi.IsItem(object) == 1 then
        for _, esvStatus in pairs(Ext.Entity.Get(object).ServerItem.StatusManager.Statuses) do
            if Osi.SpellHasSpellFlag(esvStatus.SourceSpell.Prototype, "IsSpell") == 1 then
                local spell = Ext.Stats.Get(esvStatus.SourceSpell.Prototype)
                if spell.PowerLevel < 7 then
                    Osi.RemoveStatus(object,esvStatus.StatusId)
                end
            end
        end
	elseif status == "DISPEL_MAGIC_6" and Osi.IsSurface(object) == 1 then
        for _, esvStatus in pairs(Ext.Entity.Get(object).ServerSurface.StatusManager.Statuses) do
            if Osi.SpellHasSpellFlag(esvStatus.SourceSpell.Prototype, "IsSpell") == 1 then
                local spell = Ext.Stats.Get(esvStatus.SourceSpell.Prototype)
                if spell.PowerLevel < 7 then
                    Osi.RemoveStatus(object,esvStatus.StatusId)
                end
            end
        end
    end
end)

-- Status Debug Text
Ext.Osiris.RegisterListener("StatusApplied",4, "after",function (character, status, _, _)
	if status ~= "INSURFACE" then
	local disname = Osi.GetDisplayName(character)
	local name = Osi.ResolveTranslatedString(disname)
	local str = status .. " status applied to " .. name
	end
end)

-- Status Debug Text
Ext.Osiris.RegisterListener("StatusRemoved",4, "after",function (character, status, causee, _)
	if status ~= "INSURFACE" then
	local disname = Osi.GetDisplayName(character)
	local name = Osi.ResolveTranslatedString(disname)
	local str = status .. " status removed from " .. name .. " by " .. causee
	end
end)--]]

-- Death Modification Entered Combat
Ext.Osiris.RegisterListener("EnteredCombat", 2, "after", function (character, combatguid)
	if Osi.IsPlayer(character) == 1 and Osi.HasPassive(character,"S5E_NoInstantDeath") == 1 then
		local dead = Osi.DB_Dead:Get(nil)
		for _,d in pairs(dead) do
			if d[1] ~= nil and d[1] ~= "NULL_00000000-0000-0000-0000-000000000000" and Osi.IsAlly(d[1],character) == 1 and Osi.HasActiveStatus(d[1],"DEAD_TECHNICAL") == 1 then
				Osi.ApplyStatus(d[1],"DEAD_COMBAT_BLOCK",-1.0,1)
				Osi.SetVarString(character,"Combatant",combatguid)
			end
		end
	end
end)

-- Death Modification Left Combat
Ext.Osiris.RegisterListener("CombatEnded", 1, "after", function (combatguid)
	local dead = Osi.DB_Dead:Get(nil)
	for _,d in pairs(dead) do
		if d[1] ~= nil and d[1] ~= "NULL_00000000-0000-0000-0000-000000000000" then
			Osi.RemoveStatus(d[1],"DEAD_COMBAT_BLOCK")
		end
	end
end)

-- Death Modification Died
Ext.Osiris.RegisterListener("Died", 1, "after", function (character)
	if Osi.IsPlayer(character) == 1 and Osi.HasPassive(character,"S5E_NoInstantDeath") == 1 then
		Osi.ApplyStatus(character,"DEAD_TECHNICAL",60.0,1)
	end
end)

-- Death Modification Combat Round Start
Ext.Osiris.RegisterListener("CombatRoundStarted", 2, "after", function (combatguid, round)
	local character = Osi.CombatGetInvolvedPartyMember(combatguid, 1)
	local dead = Osi.DB_Dead:Get(nil)
	for _,d in pairs(dead) do
		if d[1] ~= nil and d[1] ~= "NULL_00000000-0000-0000-0000-000000000000" and Osi.HasActiveStatus(d[1],"DEAD_TECHNICAL") == 1 and Osi.HasActiveStatus(d[1],"GENTLE_REPOSE") == 0 then
			Osi.ApplyStatus(d[1],"DEAD_COMBAT_BLOCK",-1.0,1)
			local turns = Osi.GetStatusTurns(d[1],"DEAD_TECHNICAL")
			turns = turns - 1.0
			if turns > 0.0 then
				Osi.RemoveStatus(d[1],"DEAD_TECHNICAL")
				Osi.ApplyStatus(d[1],"DEAD_TECHNICAL",turns*6,1)
			else
				Osi.RemoveStatus(d[1],"DEAD_TECHNICAL")
				Osi.ApplyStatus(d[1],"DEAD_ONE_TIME",-1.0,1)
			end
		end
	end
end)

-- Death Modification Resurrected
Ext.Osiris.RegisterListener("Resurrected", 1, "after", function (character)
	Osi.RemoveStatus(character,"DEAD_TECHNICAL")
end)