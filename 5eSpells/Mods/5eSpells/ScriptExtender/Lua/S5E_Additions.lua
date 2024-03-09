local files = {
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
        Ext.Stats.LoadStatsFile("Public/5eSpells/Stats/Generated/Data/Statuses_2ndLevelSpells.txt", false)
end

Ext.Events.ResetCompleted:Subscribe(ResetStats)--]]

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

-- Chaos Bolt Self
Ext.Osiris.RegisterListener("UsingSpell", 5, "before", function (caster, spell, _, _, _)
	local number = Random(8)
	if	(spell == "Target_ChaosBolt" or spell == "Target_ChaosBolt_2" or spell == "Target_ChaosBolt_3" or spell == "Target_ChaosBolt_4" or spell == "Target_ChaosBolt_5" or spell == "Target_ChaosBolt_6" or spell == "Target_ChaosBolt_7" or spell == "Target_ChaosBolt_8" or spell == "Target_ChaosBolt_9") and number == 0 and Osi.HasActiveStatus(caster,"CHAOS_BOLT_ACID") == 0 and Osi.HasActiveStatus(caster,"CHAOS_BOLT_COLD") == 0 and Osi.HasActiveStatus(caster,"CHAOS_BOLT_FIRE") == 0 and Osi.HasActiveStatus(caster,"CHAOS_BOLT_FORCE") == 0 and Osi.HasActiveStatus(caster,"CHAOS_BOLT_LIGHTNING") == 0 and Osi.HasActiveStatus(caster,"CHAOS_BOLT_POISON") == 0 and Osi.HasActiveStatus(caster,"CHAOS_BOLT_PSYCHIC") == 0 and Osi.HasActiveStatus(caster,"CHAOS_BOLT_THUNDER") == 0 then
		Osi.ApplyStatus(caster, "CHAOS_BOLT_ACID",6.0,1,caster)
		Osi.SetVarInteger(caster,"RandomNumber",number)
	elseif	(spell == "Target_ChaosBolt" or spell == "Target_ChaosBolt_2" or spell == "Target_ChaosBolt_3" or spell == "Target_ChaosBolt_4" or spell == "Target_ChaosBolt_5" or spell == "Target_ChaosBolt_6" or spell == "Target_ChaosBolt_7" or spell == "Target_ChaosBolt_8" or spell == "Target_ChaosBolt_9") and number == 1 and Osi.HasActiveStatus(caster,"CHAOS_BOLT_ACID") == 0 and Osi.HasActiveStatus(caster,"CHAOS_BOLT_COLD") == 0 and Osi.HasActiveStatus(caster,"CHAOS_BOLT_FIRE") == 0 and Osi.HasActiveStatus(caster,"CHAOS_BOLT_FORCE") == 0 and Osi.HasActiveStatus(caster,"CHAOS_BOLT_LIGHTNING") == 0 and Osi.HasActiveStatus(caster,"CHAOS_BOLT_POISON") == 0 and Osi.HasActiveStatus(caster,"CHAOS_BOLT_PSYCHIC") == 0 and Osi.HasActiveStatus(caster,"CHAOS_BOLT_THUNDER") == 0 then
		Osi.ApplyStatus(caster, "CHAOS_BOLT_COLD",6.0,1,caster)
		Osi.SetVarInteger(caster,"RandomNumber",number)
	elseif	(spell == "Target_ChaosBolt" or spell == "Target_ChaosBolt_2" or spell == "Target_ChaosBolt_3" or spell == "Target_ChaosBolt_4" or spell == "Target_ChaosBolt_5" or spell == "Target_ChaosBolt_6" or spell == "Target_ChaosBolt_7" or spell == "Target_ChaosBolt_8" or spell == "Target_ChaosBolt_9") and number == 2 and Osi.HasActiveStatus(caster,"CHAOS_BOLT_ACID") == 0 and Osi.HasActiveStatus(caster,"CHAOS_BOLT_COLD") == 0 and Osi.HasActiveStatus(caster,"CHAOS_BOLT_FIRE") == 0 and Osi.HasActiveStatus(caster,"CHAOS_BOLT_FORCE") == 0 and Osi.HasActiveStatus(caster,"CHAOS_BOLT_LIGHTNING") == 0 and Osi.HasActiveStatus(caster,"CHAOS_BOLT_POISON") == 0 and Osi.HasActiveStatus(caster,"CHAOS_BOLT_PSYCHIC") == 0 and Osi.HasActiveStatus(caster,"CHAOS_BOLT_THUNDER") == 0 then
		Osi.ApplyStatus(caster, "CHAOS_BOLT_FIRE",6.0,1,caster)
		Osi.SetVarInteger(caster,"RandomNumber",number)
	elseif	(spell == "Target_ChaosBolt" or spell == "Target_ChaosBolt_2" or spell == "Target_ChaosBolt_3" or spell == "Target_ChaosBolt_4" or spell == "Target_ChaosBolt_5" or spell == "Target_ChaosBolt_6" or spell == "Target_ChaosBolt_7" or spell == "Target_ChaosBolt_8" or spell == "Target_ChaosBolt_9") and number == 3 and Osi.HasActiveStatus(caster,"CHAOS_BOLT_ACID") == 0 and Osi.HasActiveStatus(caster,"CHAOS_BOLT_COLD") == 0 and Osi.HasActiveStatus(caster,"CHAOS_BOLT_FIRE") == 0 and Osi.HasActiveStatus(caster,"CHAOS_BOLT_FORCE") == 0 and Osi.HasActiveStatus(caster,"CHAOS_BOLT_LIGHTNING") == 0 and Osi.HasActiveStatus(caster,"CHAOS_BOLT_POISON") == 0 and Osi.HasActiveStatus(caster,"CHAOS_BOLT_PSYCHIC") == 0 and Osi.HasActiveStatus(caster,"CHAOS_BOLT_THUNDER") == 0 then
		Osi.ApplyStatus(caster, "CHAOS_BOLT_FORCE",6.0,1,caster)
		Osi.SetVarInteger(caster,"RandomNumber",number)
	elseif	(spell == "Target_ChaosBolt" or spell == "Target_ChaosBolt_2" or spell == "Target_ChaosBolt_3" or spell == "Target_ChaosBolt_4" or spell == "Target_ChaosBolt_5" or spell == "Target_ChaosBolt_6" or spell == "Target_ChaosBolt_7" or spell == "Target_ChaosBolt_8" or spell == "Target_ChaosBolt_9") and number == 4 and Osi.HasActiveStatus(caster,"CHAOS_BOLT_ACID") == 0 and Osi.HasActiveStatus(caster,"CHAOS_BOLT_COLD") == 0 and Osi.HasActiveStatus(caster,"CHAOS_BOLT_FIRE") == 0 and Osi.HasActiveStatus(caster,"CHAOS_BOLT_FORCE") == 0 and Osi.HasActiveStatus(caster,"CHAOS_BOLT_LIGHTNING") == 0 and Osi.HasActiveStatus(caster,"CHAOS_BOLT_POISON") == 0 and Osi.HasActiveStatus(caster,"CHAOS_BOLT_PSYCHIC") == 0 and Osi.HasActiveStatus(caster,"CHAOS_BOLT_THUNDER") == 0 then
		Osi.ApplyStatus(caster, "CHAOS_BOLT_LIGHTNING",6.0,1,caster)
		Osi.SetVarInteger(caster,"RandomNumber",number)
	elseif	(spell == "Target_ChaosBolt" or spell == "Target_ChaosBolt_2" or spell == "Target_ChaosBolt_3" or spell == "Target_ChaosBolt_4" or spell == "Target_ChaosBolt_5" or spell == "Target_ChaosBolt_6" or spell == "Target_ChaosBolt_7" or spell == "Target_ChaosBolt_8" or spell == "Target_ChaosBolt_9") and number == 5 and Osi.HasActiveStatus(caster,"CHAOS_BOLT_ACID") == 0 and Osi.HasActiveStatus(caster,"CHAOS_BOLT_COLD") == 0 and Osi.HasActiveStatus(caster,"CHAOS_BOLT_FIRE") == 0 and Osi.HasActiveStatus(caster,"CHAOS_BOLT_FORCE") == 0 and Osi.HasActiveStatus(caster,"CHAOS_BOLT_LIGHTNING") == 0 and Osi.HasActiveStatus(caster,"CHAOS_BOLT_POISON") == 0 and Osi.HasActiveStatus(caster,"CHAOS_BOLT_PSYCHIC") == 0 and Osi.HasActiveStatus(caster,"CHAOS_BOLT_THUNDER") == 0 then
		Osi.ApplyStatus(caster, "CHAOS_BOLT_POISON",6.0,1,caster)
		Osi.SetVarInteger(caster,"RandomNumber",number)
	elseif	(spell == "Target_ChaosBolt" or spell == "Target_ChaosBolt_2" or spell == "Target_ChaosBolt_3" or spell == "Target_ChaosBolt_4" or spell == "Target_ChaosBolt_5" or spell == "Target_ChaosBolt_6" or spell == "Target_ChaosBolt_7" or spell == "Target_ChaosBolt_8" or spell == "Target_ChaosBolt_9") and number == 6 and Osi.HasActiveStatus(caster,"CHAOS_BOLT_ACID") == 0 and Osi.HasActiveStatus(caster,"CHAOS_BOLT_COLD") == 0 and Osi.HasActiveStatus(caster,"CHAOS_BOLT_FIRE") == 0 and Osi.HasActiveStatus(caster,"CHAOS_BOLT_FORCE") == 0 and Osi.HasActiveStatus(caster,"CHAOS_BOLT_LIGHTNING") == 0 and Osi.HasActiveStatus(caster,"CHAOS_BOLT_POISON") == 0 and Osi.HasActiveStatus(caster,"CHAOS_BOLT_PSYCHIC") == 0 and Osi.HasActiveStatus(caster,"CHAOS_BOLT_THUNDER") == 0 then
		Osi.ApplyStatus(caster, "CHAOS_BOLT_PSYCHIC",6.0,1,caster)
		Osi.SetVarInteger(caster,"RandomNumber",number)
	elseif	(spell == "Target_ChaosBolt" or spell == "Target_ChaosBolt_2" or spell == "Target_ChaosBolt_3" or spell == "Target_ChaosBolt_4" or spell == "Target_ChaosBolt_5" or spell == "Target_ChaosBolt_6" or spell == "Target_ChaosBolt_7" or spell == "Target_ChaosBolt_8" or spell == "Target_ChaosBolt_9") and number == 7 and Osi.HasActiveStatus(caster,"CHAOS_BOLT_ACID") == 0 and Osi.HasActiveStatus(caster,"CHAOS_BOLT_COLD") == 0 and Osi.HasActiveStatus(caster,"CHAOS_BOLT_FIRE") == 0 and Osi.HasActiveStatus(caster,"CHAOS_BOLT_FORCE") == 0 and Osi.HasActiveStatus(caster,"CHAOS_BOLT_LIGHTNING") == 0 and Osi.HasActiveStatus(caster,"CHAOS_BOLT_POISON") == 0 and Osi.HasActiveStatus(caster,"CHAOS_BOLT_PSYCHIC") == 0 and Osi.HasActiveStatus(caster,"CHAOS_BOLT_THUNDER") == 0 then
		Osi.ApplyStatus(caster, "CHAOS_BOLT_THUNDER",6.0,1,caster)
		Osi.SetVarInteger(caster,"RandomNumber",number)
	elseif	(spell == "Target_ChaosBolt" or spell == "Target_ChaosBolt_2" or spell == "Target_ChaosBolt_3" or spell == "Target_ChaosBolt_4" or spell == "Target_ChaosBolt_5" or spell == "Target_ChaosBolt_6" or spell == "Target_ChaosBolt_7" or spell == "Target_ChaosBolt_8" or spell == "Target_ChaosBolt_9") and number == 0 and (HasActiveStatus(caster,"CHAOS_BOLT_ACID") == 1 or Osi.HasActiveStatus(caster,"CHAOS_BOLT_COLD") == 1 or Osi.HasActiveStatus(caster,"CHAOS_BOLT_FIRE") == 1 or Osi.HasActiveStatus(caster,"CHAOS_BOLT_FORCE") == 1 or Osi.HasActiveStatus(caster,"CHAOS_BOLT_LIGHTNING") == 1 or Osi.HasActiveStatus(caster,"CHAOS_BOLT_POISON") == 1 or Osi.HasActiveStatus(caster,"CHAOS_BOLT_PSYCHIC") == 1 or Osi.HasActiveStatus(caster,"CHAOS_BOLT_THUNDER") == 1) then
		Osi.RemoveStatus(caster,"CHAOS_BOLT_ACID")
		Osi.RemoveStatus(caster,"CHAOS_BOLT_COLD")
		Osi.RemoveStatus(caster,"CHAOS_BOLT_FIRE")
		Osi.RemoveStatus(caster,"CHAOS_BOLT_FORCE")
		Osi.RemoveStatus(caster,"CHAOS_BOLT_LIGHTNING")
		Osi.RemoveStatus(caster,"CHAOS_BOLT_POISON")
		Osi.RemoveStatus(caster,"CHAOS_BOLT_PSYCHIC")
		Osi.RemoveStatus(caster,"CHAOS_BOLT_THUNDER")
		Osi.ApplyStatus(caster, "CHAOS_BOLT_ACID",6.0,1,caster)
		Osi.SetVarInteger(caster,"RandomNumber",number)
	elseif	(spell == "Target_ChaosBolt" or spell == "Target_ChaosBolt_2" or spell == "Target_ChaosBolt_3" or spell == "Target_ChaosBolt_4" or spell == "Target_ChaosBolt_5" or spell == "Target_ChaosBolt_6" or spell == "Target_ChaosBolt_7" or spell == "Target_ChaosBolt_8" or spell == "Target_ChaosBolt_9") and number == 1 and (HasActiveStatus(caster,"CHAOS_BOLT_ACID") == 1 or Osi.HasActiveStatus(caster,"CHAOS_BOLT_COLD") == 1 or Osi.HasActiveStatus(caster,"CHAOS_BOLT_FIRE") == 1 or Osi.HasActiveStatus(caster,"CHAOS_BOLT_FORCE") == 1 or Osi.HasActiveStatus(caster,"CHAOS_BOLT_LIGHTNING") == 1 or Osi.HasActiveStatus(caster,"CHAOS_BOLT_POISON") == 1 or Osi.HasActiveStatus(caster,"CHAOS_BOLT_PSYCHIC") == 1 or Osi.HasActiveStatus(caster,"CHAOS_BOLT_THUNDER") == 1) then
		Osi.RemoveStatus(caster,"CHAOS_BOLT_ACID")
		Osi.RemoveStatus(caster,"CHAOS_BOLT_COLD")
		Osi.RemoveStatus(caster,"CHAOS_BOLT_FIRE")
		Osi.RemoveStatus(caster,"CHAOS_BOLT_FORCE")
		Osi.RemoveStatus(caster,"CHAOS_BOLT_LIGHTNING")
		Osi.RemoveStatus(caster,"CHAOS_BOLT_POISON")
		Osi.RemoveStatus(caster,"CHAOS_BOLT_PSYCHIC")
		Osi.RemoveStatus(caster,"CHAOS_BOLT_THUNDER")
		Osi.ApplyStatus(caster, "CHAOS_BOLT_COLD",6.0,1,caster)
		Osi.SetVarInteger(caster,"RandomNumber",number)
	elseif	(spell == "Target_ChaosBolt" or spell == "Target_ChaosBolt_2" or spell == "Target_ChaosBolt_3" or spell == "Target_ChaosBolt_4" or spell == "Target_ChaosBolt_5" or spell == "Target_ChaosBolt_6" or spell == "Target_ChaosBolt_7" or spell == "Target_ChaosBolt_8" or spell == "Target_ChaosBolt_9") and number == 2 and (HasActiveStatus(caster,"CHAOS_BOLT_ACID") == 1 or Osi.HasActiveStatus(caster,"CHAOS_BOLT_COLD") == 1 or Osi.HasActiveStatus(caster,"CHAOS_BOLT_FIRE") == 1 or Osi.HasActiveStatus(caster,"CHAOS_BOLT_FORCE") == 1 or Osi.HasActiveStatus(caster,"CHAOS_BOLT_LIGHTNING") == 1 or Osi.HasActiveStatus(caster,"CHAOS_BOLT_POISON") == 1 or Osi.HasActiveStatus(caster,"CHAOS_BOLT_PSYCHIC") == 1 or Osi.HasActiveStatus(caster,"CHAOS_BOLT_THUNDER") == 1) then
		Osi.RemoveStatus(caster,"CHAOS_BOLT_ACID")
		Osi.RemoveStatus(caster,"CHAOS_BOLT_COLD")
		Osi.RemoveStatus(caster,"CHAOS_BOLT_FIRE")
		Osi.RemoveStatus(caster,"CHAOS_BOLT_FORCE")
		Osi.RemoveStatus(caster,"CHAOS_BOLT_LIGHTNING")
		Osi.RemoveStatus(caster,"CHAOS_BOLT_POISON")
		Osi.RemoveStatus(caster,"CHAOS_BOLT_PSYCHIC")
		Osi.RemoveStatus(caster,"CHAOS_BOLT_THUNDER")
		Osi.ApplyStatus(caster, "CHAOS_BOLT_FIRE",6.0,1,caster)
		Osi.SetVarInteger(caster,"RandomNumber",number)
	elseif	(spell == "Target_ChaosBolt" or spell == "Target_ChaosBolt_2" or spell == "Target_ChaosBolt_3" or spell == "Target_ChaosBolt_4" or spell == "Target_ChaosBolt_5" or spell == "Target_ChaosBolt_6" or spell == "Target_ChaosBolt_7" or spell == "Target_ChaosBolt_8" or spell == "Target_ChaosBolt_9") and number == 3 and (HasActiveStatus(caster,"CHAOS_BOLT_ACID") == 1 or Osi.HasActiveStatus(caster,"CHAOS_BOLT_COLD") == 1 or Osi.HasActiveStatus(caster,"CHAOS_BOLT_FIRE") == 1 or Osi.HasActiveStatus(caster,"CHAOS_BOLT_FORCE") == 1 or Osi.HasActiveStatus(caster,"CHAOS_BOLT_LIGHTNING") == 1 or Osi.HasActiveStatus(caster,"CHAOS_BOLT_POISON") == 1 or Osi.HasActiveStatus(caster,"CHAOS_BOLT_PSYCHIC") == 1 or Osi.HasActiveStatus(caster,"CHAOS_BOLT_THUNDER") == 1) then
		Osi.RemoveStatus(caster,"CHAOS_BOLT_ACID")
		Osi.RemoveStatus(caster,"CHAOS_BOLT_COLD")
		Osi.RemoveStatus(caster,"CHAOS_BOLT_FIRE")
		Osi.RemoveStatus(caster,"CHAOS_BOLT_FORCE")
		Osi.RemoveStatus(caster,"CHAOS_BOLT_LIGHTNING")
		Osi.RemoveStatus(caster,"CHAOS_BOLT_POISON")
		Osi.RemoveStatus(caster,"CHAOS_BOLT_PSYCHIC")
		Osi.RemoveStatus(caster,"CHAOS_BOLT_THUNDER")
		Osi.ApplyStatus(caster, "CHAOS_BOLT_FORCE",6.0,1,caster)
		Osi.SetVarInteger(caster,"RandomNumber",number)
	elseif	(spell == "Target_ChaosBolt" or spell == "Target_ChaosBolt_2" or spell == "Target_ChaosBolt_3" or spell == "Target_ChaosBolt_4" or spell == "Target_ChaosBolt_5" or spell == "Target_ChaosBolt_6" or spell == "Target_ChaosBolt_7" or spell == "Target_ChaosBolt_8" or spell == "Target_ChaosBolt_9") and number == 4 and (HasActiveStatus(caster,"CHAOS_BOLT_ACID") == 1 or Osi.HasActiveStatus(caster,"CHAOS_BOLT_COLD") == 1 or Osi.HasActiveStatus(caster,"CHAOS_BOLT_FIRE") == 1 or Osi.HasActiveStatus(caster,"CHAOS_BOLT_FORCE") == 1 or Osi.HasActiveStatus(caster,"CHAOS_BOLT_LIGHTNING") == 1 or Osi.HasActiveStatus(caster,"CHAOS_BOLT_POISON") == 1 or Osi.HasActiveStatus(caster,"CHAOS_BOLT_PSYCHIC") == 1 or Osi.HasActiveStatus(caster,"CHAOS_BOLT_THUNDER") == 1) then
		Osi.RemoveStatus(caster,"CHAOS_BOLT_ACID")
		Osi.RemoveStatus(caster,"CHAOS_BOLT_COLD")
		Osi.RemoveStatus(caster,"CHAOS_BOLT_FIRE")
		Osi.RemoveStatus(caster,"CHAOS_BOLT_FORCE")
		Osi.RemoveStatus(caster,"CHAOS_BOLT_LIGHTNING")
		Osi.RemoveStatus(caster,"CHAOS_BOLT_POISON")
		Osi.RemoveStatus(caster,"CHAOS_BOLT_PSYCHIC")
		Osi.RemoveStatus(caster,"CHAOS_BOLT_THUNDER")
		Osi.ApplyStatus(caster, "CHAOS_BOLT_LIGHTNING",6.0,1,caster)
		Osi.SetVarInteger(caster,"RandomNumber",number)
	elseif	(spell == "Target_ChaosBolt" or spell == "Target_ChaosBolt_2" or spell == "Target_ChaosBolt_3" or spell == "Target_ChaosBolt_4" or spell == "Target_ChaosBolt_5" or spell == "Target_ChaosBolt_6" or spell == "Target_ChaosBolt_7" or spell == "Target_ChaosBolt_8" or spell == "Target_ChaosBolt_9") and number == 5 and (HasActiveStatus(caster,"CHAOS_BOLT_ACID") == 1 or Osi.HasActiveStatus(caster,"CHAOS_BOLT_COLD") == 1 or Osi.HasActiveStatus(caster,"CHAOS_BOLT_FIRE") == 1 or Osi.HasActiveStatus(caster,"CHAOS_BOLT_FORCE") == 1 or Osi.HasActiveStatus(caster,"CHAOS_BOLT_LIGHTNING") == 1 or Osi.HasActiveStatus(caster,"CHAOS_BOLT_POISON") == 1 or Osi.HasActiveStatus(caster,"CHAOS_BOLT_PSYCHIC") == 1 or Osi.HasActiveStatus(caster,"CHAOS_BOLT_THUNDER") == 1) then
		Osi.RemoveStatus(caster,"CHAOS_BOLT_ACID")
		Osi.RemoveStatus(caster,"CHAOS_BOLT_COLD")
		Osi.RemoveStatus(caster,"CHAOS_BOLT_FIRE")
		Osi.RemoveStatus(caster,"CHAOS_BOLT_FORCE")
		Osi.RemoveStatus(caster,"CHAOS_BOLT_LIGHTNING")
		Osi.RemoveStatus(caster,"CHAOS_BOLT_POISON")
		Osi.RemoveStatus(caster,"CHAOS_BOLT_PSYCHIC")
		Osi.RemoveStatus(caster,"CHAOS_BOLT_THUNDER")
		Osi.ApplyStatus(caster, "CHAOS_BOLT_POISON",6.0,1,caster)
		Osi.SetVarInteger(caster,"RandomNumber",number)
	elseif	(spell == "Target_ChaosBolt" or spell == "Target_ChaosBolt_2" or spell == "Target_ChaosBolt_3" or spell == "Target_ChaosBolt_4" or spell == "Target_ChaosBolt_5" or spell == "Target_ChaosBolt_6" or spell == "Target_ChaosBolt_7" or spell == "Target_ChaosBolt_8" or spell == "Target_ChaosBolt_9") and number == 6 and (HasActiveStatus(caster,"CHAOS_BOLT_ACID") == 1 or Osi.HasActiveStatus(caster,"CHAOS_BOLT_COLD") == 1 or Osi.HasActiveStatus(caster,"CHAOS_BOLT_FIRE") == 1 or Osi.HasActiveStatus(caster,"CHAOS_BOLT_FORCE") == 1 or Osi.HasActiveStatus(caster,"CHAOS_BOLT_LIGHTNING") == 1 or Osi.HasActiveStatus(caster,"CHAOS_BOLT_POISON") == 1 or Osi.HasActiveStatus(caster,"CHAOS_BOLT_PSYCHIC") == 1 or Osi.HasActiveStatus(caster,"CHAOS_BOLT_THUNDER") == 1) then
		Osi.RemoveStatus(caster,"CHAOS_BOLT_ACID")
		Osi.RemoveStatus(caster,"CHAOS_BOLT_COLD")
		Osi.RemoveStatus(caster,"CHAOS_BOLT_FIRE")
		Osi.RemoveStatus(caster,"CHAOS_BOLT_FORCE")
		Osi.RemoveStatus(caster,"CHAOS_BOLT_LIGHTNING")
		Osi.RemoveStatus(caster,"CHAOS_BOLT_POISON")
		Osi.RemoveStatus(caster,"CHAOS_BOLT_PSYCHIC")
		Osi.RemoveStatus(caster,"CHAOS_BOLT_THUNDER")
		Osi.ApplyStatus(caster, "CHAOS_BOLT_PSYCHIC",6.0,1,caster)
		Osi.SetVarInteger(caster,"RandomNumber",number)
	elseif	(spell == "Target_ChaosBolt" or spell == "Target_ChaosBolt_2" or spell == "Target_ChaosBolt_3" or spell == "Target_ChaosBolt_4" or spell == "Target_ChaosBolt_5" or spell == "Target_ChaosBolt_6" or spell == "Target_ChaosBolt_7" or spell == "Target_ChaosBolt_8" or spell == "Target_ChaosBolt_9") and number == 7 and (HasActiveStatus(caster,"CHAOS_BOLT_ACID") == 1 or Osi.HasActiveStatus(caster,"CHAOS_BOLT_COLD") == 1 or Osi.HasActiveStatus(caster,"CHAOS_BOLT_FIRE") == 1 or Osi.HasActiveStatus(caster,"CHAOS_BOLT_FORCE") == 1 or Osi.HasActiveStatus(caster,"CHAOS_BOLT_LIGHTNING") == 1 or Osi.HasActiveStatus(caster,"CHAOS_BOLT_POISON") == 1 or Osi.HasActiveStatus(caster,"CHAOS_BOLT_PSYCHIC") == 1 or Osi.HasActiveStatus(caster,"CHAOS_BOLT_THUNDER") == 1) then
		Osi.RemoveStatus(caster,"CHAOS_BOLT_ACID")
		Osi.RemoveStatus(caster,"CHAOS_BOLT_COLD")
		Osi.RemoveStatus(caster,"CHAOS_BOLT_FIRE")
		Osi.RemoveStatus(caster,"CHAOS_BOLT_FORCE")
		Osi.RemoveStatus(caster,"CHAOS_BOLT_LIGHTNING")
		Osi.RemoveStatus(caster,"CHAOS_BOLT_POISON")
		Osi.RemoveStatus(caster,"CHAOS_BOLT_PSYCHIC")
		Osi.RemoveStatus(caster,"CHAOS_BOLT_THUNDER")
		Osi.ApplyStatus(caster, "CHAOS_BOLT_THUNDER",6.0,1,caster)
		Osi.SetVarInteger(caster,"RandomNumber",number)
    end
end)

-- Chaos Bolt Target
Ext.Osiris.RegisterListener("UsingSpellOnTarget", 6, "before", function (caster, target, spell, _, _, _)
	local ran = Random(8)
	if	(spell == "Target_ChaosBolt" or spell == "Target_ChaosBolt_2" or spell == "Target_ChaosBolt_3" or spell == "Target_ChaosBolt_4" or spell == "Target_ChaosBolt_5" or spell == "Target_ChaosBolt_6" or spell == "Target_ChaosBolt_7" or spell == "Target_ChaosBolt_8" or spell == "Target_ChaosBolt_9") and ran == 0 and Osi.HasActiveStatus(target,"CHAOS_BOLT_ACID") == 0 and Osi.HasActiveStatus(target,"CHAOS_BOLT_COLD") == 0 and Osi.HasActiveStatus(target,"CHAOS_BOLT_FIRE") == 0 and Osi.HasActiveStatus(target,"CHAOS_BOLT_FORCE") == 0 and Osi.HasActiveStatus(target,"CHAOS_BOLT_LIGHTNING") == 0 and Osi.HasActiveStatus(target,"CHAOS_BOLT_POISON") == 0 and Osi.HasActiveStatus(target,"CHAOS_BOLT_PSYCHIC") == 0 and Osi.HasActiveStatus(target,"CHAOS_BOLT_THUNDER") == 0 then
		Osi.ApplyStatus(target, "CHAOS_BOLT_ACID",6.0,1,caster)
		Osi.SetVarInteger(caster,"RandomNumbe2r",ran)
	elseif	(spell == "Target_ChaosBolt" or spell == "Target_ChaosBolt_2" or spell == "Target_ChaosBolt_3" or spell == "Target_ChaosBolt_4" or spell == "Target_ChaosBolt_5" or spell == "Target_ChaosBolt_6" or spell == "Target_ChaosBolt_7" or spell == "Target_ChaosBolt_8" or spell == "Target_ChaosBolt_9") and ran == 1 and Osi.HasActiveStatus(target,"CHAOS_BOLT_ACID") == 0 and Osi.HasActiveStatus(target,"CHAOS_BOLT_COLD") == 0 and Osi.HasActiveStatus(target,"CHAOS_BOLT_FIRE") == 0 and Osi.HasActiveStatus(target,"CHAOS_BOLT_FORCE") == 0 and Osi.HasActiveStatus(target,"CHAOS_BOLT_LIGHTNING") == 0 and Osi.HasActiveStatus(target,"CHAOS_BOLT_POISON") == 0 and Osi.HasActiveStatus(target,"CHAOS_BOLT_PSYCHIC") == 0 and Osi.HasActiveStatus(target,"CHAOS_BOLT_THUNDER") == 0 then
		Osi.ApplyStatus(target, "CHAOS_BOLT_COLD",6.0,1,caster)
		Osi.SetVarInteger(caster,"RandomNumbe2r",ran)
	elseif	(spell == "Target_ChaosBolt" or spell == "Target_ChaosBolt_2" or spell == "Target_ChaosBolt_3" or spell == "Target_ChaosBolt_4" or spell == "Target_ChaosBolt_5" or spell == "Target_ChaosBolt_6" or spell == "Target_ChaosBolt_7" or spell == "Target_ChaosBolt_8" or spell == "Target_ChaosBolt_9") and ran == 2 and Osi.HasActiveStatus(target,"CHAOS_BOLT_ACID") == 0 and Osi.HasActiveStatus(target,"CHAOS_BOLT_COLD") == 0 and Osi.HasActiveStatus(target,"CHAOS_BOLT_FIRE") == 0 and Osi.HasActiveStatus(target,"CHAOS_BOLT_FORCE") == 0 and Osi.HasActiveStatus(target,"CHAOS_BOLT_LIGHTNING") == 0 and Osi.HasActiveStatus(target,"CHAOS_BOLT_POISON") == 0 and Osi.HasActiveStatus(target,"CHAOS_BOLT_PSYCHIC") == 0 and Osi.HasActiveStatus(target,"CHAOS_BOLT_THUNDER") == 0 then
		Osi.ApplyStatus(target, "CHAOS_BOLT_FIRE",6.0,1,caster)
		Osi.SetVarInteger(caster,"RandomNumbe2r",ran)
	elseif	(spell == "Target_ChaosBolt" or spell == "Target_ChaosBolt_2" or spell == "Target_ChaosBolt_3" or spell == "Target_ChaosBolt_4" or spell == "Target_ChaosBolt_5" or spell == "Target_ChaosBolt_6" or spell == "Target_ChaosBolt_7" or spell == "Target_ChaosBolt_8" or spell == "Target_ChaosBolt_9") and ran == 3 and Osi.HasActiveStatus(target,"CHAOS_BOLT_ACID") == 0 and Osi.HasActiveStatus(target,"CHAOS_BOLT_COLD") == 0 and Osi.HasActiveStatus(target,"CHAOS_BOLT_FIRE") == 0 and Osi.HasActiveStatus(target,"CHAOS_BOLT_FORCE") == 0 and Osi.HasActiveStatus(target,"CHAOS_BOLT_LIGHTNING") == 0 and Osi.HasActiveStatus(target,"CHAOS_BOLT_POISON") == 0 and Osi.HasActiveStatus(target,"CHAOS_BOLT_PSYCHIC") == 0 and Osi.HasActiveStatus(target,"CHAOS_BOLT_THUNDER") == 0 then
		Osi.ApplyStatus(target, "CHAOS_BOLT_FORCE",6.0,1,caster)
		Osi.SetVarInteger(caster,"RandomNumbe2r",ran)
	elseif	(spell == "Target_ChaosBolt" or spell == "Target_ChaosBolt_2" or spell == "Target_ChaosBolt_3" or spell == "Target_ChaosBolt_4" or spell == "Target_ChaosBolt_5" or spell == "Target_ChaosBolt_6" or spell == "Target_ChaosBolt_7" or spell == "Target_ChaosBolt_8" or spell == "Target_ChaosBolt_9") and ran == 4 and Osi.HasActiveStatus(target,"CHAOS_BOLT_ACID") == 0 and Osi.HasActiveStatus(target,"CHAOS_BOLT_COLD") == 0 and Osi.HasActiveStatus(target,"CHAOS_BOLT_FIRE") == 0 and Osi.HasActiveStatus(target,"CHAOS_BOLT_FORCE") == 0 and Osi.HasActiveStatus(target,"CHAOS_BOLT_LIGHTNING") == 0 and Osi.HasActiveStatus(target,"CHAOS_BOLT_POISON") == 0 and Osi.HasActiveStatus(target,"CHAOS_BOLT_PSYCHIC") == 0 and Osi.HasActiveStatus(target,"CHAOS_BOLT_THUNDER") == 0 then
		Osi.ApplyStatus(target, "CHAOS_BOLT_LIGHTNING",6.0,1,caster)
		Osi.SetVarInteger(caster,"RandomNumbe2r",ran)
	elseif	(spell == "Target_ChaosBolt" or spell == "Target_ChaosBolt_2" or spell == "Target_ChaosBolt_3" or spell == "Target_ChaosBolt_4" or spell == "Target_ChaosBolt_5" or spell == "Target_ChaosBolt_6" or spell == "Target_ChaosBolt_7" or spell == "Target_ChaosBolt_8" or spell == "Target_ChaosBolt_9") and ran == 5 and Osi.HasActiveStatus(target,"CHAOS_BOLT_ACID") == 0 and Osi.HasActiveStatus(target,"CHAOS_BOLT_COLD") == 0 and Osi.HasActiveStatus(target,"CHAOS_BOLT_FIRE") == 0 and Osi.HasActiveStatus(target,"CHAOS_BOLT_FORCE") == 0 and Osi.HasActiveStatus(target,"CHAOS_BOLT_LIGHTNING") == 0 and Osi.HasActiveStatus(target,"CHAOS_BOLT_POISON") == 0 and Osi.HasActiveStatus(target,"CHAOS_BOLT_PSYCHIC") == 0 and Osi.HasActiveStatus(target,"CHAOS_BOLT_THUNDER") == 0 then
		Osi.ApplyStatus(target, "CHAOS_BOLT_POISON",6.0,1,caster)
		Osi.SetVarInteger(caster,"RandomNumbe2r",ran)
	elseif	(spell == "Target_ChaosBolt" or spell == "Target_ChaosBolt_2" or spell == "Target_ChaosBolt_3" or spell == "Target_ChaosBolt_4" or spell == "Target_ChaosBolt_5" or spell == "Target_ChaosBolt_6" or spell == "Target_ChaosBolt_7" or spell == "Target_ChaosBolt_8" or spell == "Target_ChaosBolt_9") and ran == 6 and Osi.HasActiveStatus(target,"CHAOS_BOLT_ACID") == 0 and Osi.HasActiveStatus(target,"CHAOS_BOLT_COLD") == 0 and Osi.HasActiveStatus(target,"CHAOS_BOLT_FIRE") == 0 and Osi.HasActiveStatus(target,"CHAOS_BOLT_FORCE") == 0 and Osi.HasActiveStatus(target,"CHAOS_BOLT_LIGHTNING") == 0 and Osi.HasActiveStatus(target,"CHAOS_BOLT_POISON") == 0 and Osi.HasActiveStatus(target,"CHAOS_BOLT_PSYCHIC") == 0 and Osi.HasActiveStatus(target,"CHAOS_BOLT_THUNDER") == 0 then
		Osi.ApplyStatus(target, "CHAOS_BOLT_PSYCHIC",6.0,1,caster)
		Osi.SetVarInteger(caster,"RandomNumbe2r",ran)
	elseif	(spell == "Target_ChaosBolt" or spell == "Target_ChaosBolt_2" or spell == "Target_ChaosBolt_3" or spell == "Target_ChaosBolt_4" or spell == "Target_ChaosBolt_5" or spell == "Target_ChaosBolt_6" or spell == "Target_ChaosBolt_7" or spell == "Target_ChaosBolt_8" or spell == "Target_ChaosBolt_9") and ran == 7 and Osi.HasActiveStatus(target,"CHAOS_BOLT_ACID") == 0 and Osi.HasActiveStatus(target,"CHAOS_BOLT_COLD") == 0 and Osi.HasActiveStatus(target,"CHAOS_BOLT_FIRE") == 0 and Osi.HasActiveStatus(target,"CHAOS_BOLT_FORCE") == 0 and Osi.HasActiveStatus(target,"CHAOS_BOLT_LIGHTNING") == 0 and Osi.HasActiveStatus(target,"CHAOS_BOLT_POISON") == 0 and Osi.HasActiveStatus(target,"CHAOS_BOLT_PSYCHIC") == 0 and Osi.HasActiveStatus(target,"CHAOS_BOLT_THUNDER") == 0 then
		Osi.ApplyStatus(target, "CHAOS_BOLT_THUNDER",6.0,1,caster)
		Osi.SetVarInteger(caster,"RandomNumbe2r",ran)
	elseif	(spell == "Target_ChaosBolt" or spell == "Target_ChaosBolt_2" or spell == "Target_ChaosBolt_3" or spell == "Target_ChaosBolt_4" or spell == "Target_ChaosBolt_5" or spell == "Target_ChaosBolt_6" or spell == "Target_ChaosBolt_7" or spell == "Target_ChaosBolt_8" or spell == "Target_ChaosBolt_9") and ran == 0 and (HasActiveStatus(target,"CHAOS_BOLT_ACID") == 1 and Osi.HasActiveStatus(target,"CHAOS_BOLT_COLD") == 1 and Osi.HasActiveStatus(target,"CHAOS_BOLT_FIRE") == 1 or Osi.HasActiveStatus(target,"CHAOS_BOLT_FORCE") == 1 or Osi.HasActiveStatus(target,"CHAOS_BOLT_LIGHTNING") == 1 or Osi.HasActiveStatus(target,"CHAOS_BOLT_POISON") == 1 or Osi.HasActiveStatus(target,"CHAOS_BOLT_PSYCHIC") == 1 or Osi.HasActiveStatus(target,"CHAOS_BOLT_THUNDER") == 1) then
		Osi.RemoveStatus(target,"CHAOS_BOLT_ACID")
		Osi.RemoveStatus(target,"CHAOS_BOLT_COLD")
		Osi.RemoveStatus(target,"CHAOS_BOLT_FIRE")
		Osi.RemoveStatus(target,"CHAOS_BOLT_FORCE")
		Osi.RemoveStatus(target,"CHAOS_BOLT_LIGHTNING")
		Osi.RemoveStatus(target,"CHAOS_BOLT_POISON")
		Osi.RemoveStatus(target,"CHAOS_BOLT_PSYCHIC")
		Osi.RemoveStatus(target,"CHAOS_BOLT_THUNDER")
		Osi.ApplyStatus(target, "CHAOS_BOLT_ACID",6.0,1,caster)
		Osi.SetVarInteger(caster,"RandomNumbe2r",ran)
	elseif	(spell == "Target_ChaosBolt" or spell == "Target_ChaosBolt_2" or spell == "Target_ChaosBolt_3" or spell == "Target_ChaosBolt_4" or spell == "Target_ChaosBolt_5" or spell == "Target_ChaosBolt_6" or spell == "Target_ChaosBolt_7" or spell == "Target_ChaosBolt_8" or spell == "Target_ChaosBolt_9") and ran == 1 and (HasActiveStatus(target,"CHAOS_BOLT_ACID") == 1 and Osi.HasActiveStatus(target,"CHAOS_BOLT_COLD") == 1 and Osi.HasActiveStatus(target,"CHAOS_BOLT_FIRE") == 1 or Osi.HasActiveStatus(target,"CHAOS_BOLT_FORCE") == 1 or Osi.HasActiveStatus(target,"CHAOS_BOLT_LIGHTNING") == 1 or Osi.HasActiveStatus(target,"CHAOS_BOLT_POISON") == 1 or Osi.HasActiveStatus(target,"CHAOS_BOLT_PSYCHIC") == 1 or Osi.HasActiveStatus(target,"CHAOS_BOLT_THUNDER") == 1) then
		Osi.RemoveStatus(target,"CHAOS_BOLT_ACID")
		Osi.RemoveStatus(target,"CHAOS_BOLT_COLD")
		Osi.RemoveStatus(target,"CHAOS_BOLT_FIRE")
		Osi.RemoveStatus(target,"CHAOS_BOLT_FORCE")
		Osi.RemoveStatus(target,"CHAOS_BOLT_LIGHTNING")
		Osi.RemoveStatus(target,"CHAOS_BOLT_POISON")
		Osi.RemoveStatus(target,"CHAOS_BOLT_PSYCHIC")
		Osi.RemoveStatus(target,"CHAOS_BOLT_THUNDER")
		Osi.ApplyStatus(target, "CHAOS_BOLT_COLD",6.0,1,caster)
		Osi.SetVarInteger(caster,"RandomNumbe2r",ran)
	elseif	(spell == "Target_ChaosBolt" or spell == "Target_ChaosBolt_2" or spell == "Target_ChaosBolt_3" or spell == "Target_ChaosBolt_4" or spell == "Target_ChaosBolt_5" or spell == "Target_ChaosBolt_6" or spell == "Target_ChaosBolt_7" or spell == "Target_ChaosBolt_8" or spell == "Target_ChaosBolt_9") and ran == 2 and (HasActiveStatus(target,"CHAOS_BOLT_ACID") == 1 and Osi.HasActiveStatus(target,"CHAOS_BOLT_COLD") == 1 and Osi.HasActiveStatus(target,"CHAOS_BOLT_FIRE") == 1 or Osi.HasActiveStatus(target,"CHAOS_BOLT_FORCE") == 1 or Osi.HasActiveStatus(target,"CHAOS_BOLT_LIGHTNING") == 1 or Osi.HasActiveStatus(target,"CHAOS_BOLT_POISON") == 1 or Osi.HasActiveStatus(target,"CHAOS_BOLT_PSYCHIC") == 1 or Osi.HasActiveStatus(target,"CHAOS_BOLT_THUNDER") == 1) then
		Osi.RemoveStatus(target,"CHAOS_BOLT_ACID")
		Osi.RemoveStatus(target,"CHAOS_BOLT_COLD")
		Osi.RemoveStatus(target,"CHAOS_BOLT_FIRE")
		Osi.RemoveStatus(target,"CHAOS_BOLT_FORCE")
		Osi.RemoveStatus(target,"CHAOS_BOLT_LIGHTNING")
		Osi.RemoveStatus(target,"CHAOS_BOLT_POISON")
		Osi.RemoveStatus(target,"CHAOS_BOLT_PSYCHIC")
		Osi.RemoveStatus(target,"CHAOS_BOLT_THUNDER")
		Osi.ApplyStatus(target, "CHAOS_BOLT_FIRE",6.0,1,caster)
		Osi.SetVarInteger(caster,"RandomNumbe2r",ran)
	elseif	(spell == "Target_ChaosBolt" or spell == "Target_ChaosBolt_2" or spell == "Target_ChaosBolt_3" or spell == "Target_ChaosBolt_4" or spell == "Target_ChaosBolt_5" or spell == "Target_ChaosBolt_6" or spell == "Target_ChaosBolt_7" or spell == "Target_ChaosBolt_8" or spell == "Target_ChaosBolt_9") and ran == 3 and (HasActiveStatus(target,"CHAOS_BOLT_ACID") == 1 and Osi.HasActiveStatus(target,"CHAOS_BOLT_COLD") == 1 and Osi.HasActiveStatus(target,"CHAOS_BOLT_FIRE") == 1 or Osi.HasActiveStatus(target,"CHAOS_BOLT_FORCE") == 1 or Osi.HasActiveStatus(target,"CHAOS_BOLT_LIGHTNING") == 1 or Osi.HasActiveStatus(target,"CHAOS_BOLT_POISON") == 1 or Osi.HasActiveStatus(target,"CHAOS_BOLT_PSYCHIC") == 1 or Osi.HasActiveStatus(target,"CHAOS_BOLT_THUNDER") == 1) then
		Osi.RemoveStatus(target,"CHAOS_BOLT_ACID")
		Osi.RemoveStatus(target,"CHAOS_BOLT_COLD")
		Osi.RemoveStatus(target,"CHAOS_BOLT_FIRE")
		Osi.RemoveStatus(target,"CHAOS_BOLT_FORCE")
		Osi.RemoveStatus(target,"CHAOS_BOLT_LIGHTNING")
		Osi.RemoveStatus(target,"CHAOS_BOLT_POISON")
		Osi.RemoveStatus(target,"CHAOS_BOLT_PSYCHIC")
		Osi.RemoveStatus(target,"CHAOS_BOLT_THUNDER")
		Osi.ApplyStatus(target, "CHAOS_BOLT_FORCE",6.0,1,caster)
		Osi.SetVarInteger(caster,"RandomNumbe2r",ran)
	elseif	(spell == "Target_ChaosBolt" or spell == "Target_ChaosBolt_2" or spell == "Target_ChaosBolt_3" or spell == "Target_ChaosBolt_4" or spell == "Target_ChaosBolt_5" or spell == "Target_ChaosBolt_6" or spell == "Target_ChaosBolt_7" or spell == "Target_ChaosBolt_8" or spell == "Target_ChaosBolt_9") and ran == 4 and (HasActiveStatus(target,"CHAOS_BOLT_ACID") == 1 and Osi.HasActiveStatus(target,"CHAOS_BOLT_COLD") == 1 and Osi.HasActiveStatus(target,"CHAOS_BOLT_FIRE") == 1 or Osi.HasActiveStatus(target,"CHAOS_BOLT_FORCE") == 1 or Osi.HasActiveStatus(target,"CHAOS_BOLT_LIGHTNING") == 1 or Osi.HasActiveStatus(target,"CHAOS_BOLT_POISON") == 1 or Osi.HasActiveStatus(target,"CHAOS_BOLT_PSYCHIC") == 1 or Osi.HasActiveStatus(target,"CHAOS_BOLT_THUNDER") == 1) then
		Osi.RemoveStatus(target,"CHAOS_BOLT_ACID")
		Osi.RemoveStatus(target,"CHAOS_BOLT_COLD")
		Osi.RemoveStatus(target,"CHAOS_BOLT_FIRE")
		Osi.RemoveStatus(target,"CHAOS_BOLT_FORCE")
		Osi.RemoveStatus(target,"CHAOS_BOLT_LIGHTNING")
		Osi.RemoveStatus(target,"CHAOS_BOLT_POISON")
		Osi.RemoveStatus(target,"CHAOS_BOLT_PSYCHIC")
		Osi.RemoveStatus(target,"CHAOS_BOLT_THUNDER")
		Osi.ApplyStatus(target, "CHAOS_BOLT_LIGHTNING",6.0,1,caster)
		Osi.SetVarInteger(caster,"RandomNumbe2r",ran)
	elseif	(spell == "Target_ChaosBolt" or spell == "Target_ChaosBolt_2" or spell == "Target_ChaosBolt_3" or spell == "Target_ChaosBolt_4" or spell == "Target_ChaosBolt_5" or spell == "Target_ChaosBolt_6" or spell == "Target_ChaosBolt_7" or spell == "Target_ChaosBolt_8" or spell == "Target_ChaosBolt_9") and ran == 5 and (HasActiveStatus(target,"CHAOS_BOLT_ACID") == 1 and Osi.HasActiveStatus(target,"CHAOS_BOLT_COLD") == 1 and Osi.HasActiveStatus(target,"CHAOS_BOLT_FIRE") == 1 or Osi.HasActiveStatus(target,"CHAOS_BOLT_FORCE") == 1 or Osi.HasActiveStatus(target,"CHAOS_BOLT_LIGHTNING") == 1 or Osi.HasActiveStatus(target,"CHAOS_BOLT_POISON") == 1 or Osi.HasActiveStatus(target,"CHAOS_BOLT_PSYCHIC") == 1 or Osi.HasActiveStatus(target,"CHAOS_BOLT_THUNDER") == 1) then
		Osi.RemoveStatus(target,"CHAOS_BOLT_ACID")
		Osi.RemoveStatus(target,"CHAOS_BOLT_COLD")
		Osi.RemoveStatus(target,"CHAOS_BOLT_FIRE")
		Osi.RemoveStatus(target,"CHAOS_BOLT_FORCE")
		Osi.RemoveStatus(target,"CHAOS_BOLT_LIGHTNING")
		Osi.RemoveStatus(target,"CHAOS_BOLT_POISON")
		Osi.RemoveStatus(target,"CHAOS_BOLT_PSYCHIC")
		Osi.RemoveStatus(target,"CHAOS_BOLT_THUNDER")
		Osi.ApplyStatus(target, "CHAOS_BOLT_POISON",6.0,1,caster)
		Osi.SetVarInteger(caster,"RandomNumbe2r",ran)
	elseif	(spell == "Target_ChaosBolt" or spell == "Target_ChaosBolt_2" or spell == "Target_ChaosBolt_3" or spell == "Target_ChaosBolt_4" or spell == "Target_ChaosBolt_5" or spell == "Target_ChaosBolt_6" or spell == "Target_ChaosBolt_7" or spell == "Target_ChaosBolt_8" or spell == "Target_ChaosBolt_9") and ran == 6 and (HasActiveStatus(target,"CHAOS_BOLT_ACID") == 1 and Osi.HasActiveStatus(target,"CHAOS_BOLT_COLD") == 1 and Osi.HasActiveStatus(target,"CHAOS_BOLT_FIRE") == 1 or Osi.HasActiveStatus(target,"CHAOS_BOLT_FORCE") == 1 or Osi.HasActiveStatus(target,"CHAOS_BOLT_LIGHTNING") == 1 or Osi.HasActiveStatus(target,"CHAOS_BOLT_POISON") == 1 or Osi.HasActiveStatus(target,"CHAOS_BOLT_PSYCHIC") == 1 or Osi.HasActiveStatus(target,"CHAOS_BOLT_THUNDER") == 1) then
		Osi.RemoveStatus(target,"CHAOS_BOLT_ACID")
		Osi.RemoveStatus(target,"CHAOS_BOLT_COLD")
		Osi.RemoveStatus(target,"CHAOS_BOLT_FIRE")
		Osi.RemoveStatus(target,"CHAOS_BOLT_FORCE")
		Osi.RemoveStatus(target,"CHAOS_BOLT_LIGHTNING")
		Osi.RemoveStatus(target,"CHAOS_BOLT_POISON")
		Osi.RemoveStatus(target,"CHAOS_BOLT_PSYCHIC")
		Osi.RemoveStatus(target,"CHAOS_BOLT_THUNDER")
		Osi.ApplyStatus(target, "CHAOS_BOLT_PSYCHIC",6.0,1,caster)
		Osi.SetVarInteger(caster,"RandomNumbe2r",ran)
	elseif	(spell == "Target_ChaosBolt" or spell == "Target_ChaosBolt_2" or spell == "Target_ChaosBolt_3" or spell == "Target_ChaosBolt_4" or spell == "Target_ChaosBolt_5" or spell == "Target_ChaosBolt_6" or spell == "Target_ChaosBolt_7" or spell == "Target_ChaosBolt_8" or spell == "Target_ChaosBolt_9") and ran == 7 and (HasActiveStatus(target,"CHAOS_BOLT_ACID") == 1 and Osi.HasActiveStatus(target,"CHAOS_BOLT_COLD") == 1 and Osi.HasActiveStatus(target,"CHAOS_BOLT_FIRE") == 1 or Osi.HasActiveStatus(target,"CHAOS_BOLT_FORCE") == 1 or Osi.HasActiveStatus(target,"CHAOS_BOLT_LIGHTNING") == 1 or Osi.HasActiveStatus(target,"CHAOS_BOLT_POISON") == 1 or Osi.HasActiveStatus(target,"CHAOS_BOLT_PSYCHIC") == 1 or Osi.HasActiveStatus(target,"CHAOS_BOLT_THUNDER") == 1) then
		Osi.RemoveStatus(target,"CHAOS_BOLT_ACID")
		Osi.RemoveStatus(target,"CHAOS_BOLT_COLD")
		Osi.RemoveStatus(target,"CHAOS_BOLT_FIRE")
		Osi.RemoveStatus(target,"CHAOS_BOLT_FORCE")
		Osi.RemoveStatus(target,"CHAOS_BOLT_LIGHTNING")
		Osi.RemoveStatus(target,"CHAOS_BOLT_POISON")
		Osi.RemoveStatus(target,"CHAOS_BOLT_PSYCHIC")
		Osi.RemoveStatus(target,"CHAOS_BOLT_THUNDER")
		Osi.ApplyStatus(target, "CHAOS_BOLT_THUNDER",6.0,1,caster)
		Osi.SetVarInteger(caster,"RandomNumbe2r",ran)
    end
end)

-- Chaos Bolt Leap
Ext.Osiris.RegisterListener("UsingSpellOnTarget", 6, "before", function (caster, target, spell, _, _, _)
	local number = GetVarInteger(caster, "RandomNumber")
	local number2 = Random(8)
	if	number == number2 then
		Osi.ApplyStatus(target,"CHAOS_BOLT_ADDITIONAL",6.0,1,caster)
		local number3 = Random(8)
		if	(spell == "Target_ChaosBolt" or spell == "Target_ChaosBolt_2" or spell == "Target_ChaosBolt_3" or spell == "Target_ChaosBolt_4" or spell == "Target_ChaosBolt_5" or spell == "Target_ChaosBolt_6" or spell == "Target_ChaosBolt_7" or spell == "Target_ChaosBolt_8" or spell == "Target_ChaosBolt_9") and number3 == 0 then
			Osi.ApplyStatus(target, "CHAOS_BOLT_ACID_SECOND",6.0,1,caster)
		elseif	(spell == "Target_ChaosBolt" or spell == "Target_ChaosBolt_2" or spell == "Target_ChaosBolt_3" or spell == "Target_ChaosBolt_4" or spell == "Target_ChaosBolt_5" or spell == "Target_ChaosBolt_6" or spell == "Target_ChaosBolt_7" or spell == "Target_ChaosBolt_8" or spell == "Target_ChaosBolt_9") and number3 == 1 then
			Osi.ApplyStatus(target, "CHAOS_BOLT_COLD_SECOND",6.0,1,caster)
		elseif	(spell == "Target_ChaosBolt" or spell == "Target_ChaosBolt_2" or spell == "Target_ChaosBolt_3" or spell == "Target_ChaosBolt_4" or spell == "Target_ChaosBolt_5" or spell == "Target_ChaosBolt_6" or spell == "Target_ChaosBolt_7" or spell == "Target_ChaosBolt_8" or spell == "Target_ChaosBolt_9") and number3 == 2 then
			Osi.ApplyStatus(target, "CHAOS_BOLT_FIRE_SECOND",6.0,1,caster)
		elseif	(spell == "Target_ChaosBolt" or spell == "Target_ChaosBolt_2" or spell == "Target_ChaosBolt_3" or spell == "Target_ChaosBolt_4" or spell == "Target_ChaosBolt_5" or spell == "Target_ChaosBolt_6" or spell == "Target_ChaosBolt_7" or spell == "Target_ChaosBolt_8" or spell == "Target_ChaosBolt_9") and number3 == 3 then
			Osi.ApplyStatus(target, "CHAOS_BOLT_FORCE_SECOND",6.0,1,caster)
		elseif	(spell == "Target_ChaosBolt" or spell == "Target_ChaosBolt_2" or spell == "Target_ChaosBolt_3" or spell == "Target_ChaosBolt_4" or spell == "Target_ChaosBolt_5" or spell == "Target_ChaosBolt_6" or spell == "Target_ChaosBolt_7" or spell == "Target_ChaosBolt_8" or spell == "Target_ChaosBolt_9") and number3 == 4 then
			Osi.ApplyStatus(target, "CHAOS_BOLT_LIGHTNING_SECOND",6.0,1,caster)
		elseif	(spell == "Target_ChaosBolt" or spell == "Target_ChaosBolt_2" or spell == "Target_ChaosBolt_3" or spell == "Target_ChaosBolt_4" or spell == "Target_ChaosBolt_5" or spell == "Target_ChaosBolt_6" or spell == "Target_ChaosBolt_7" or spell == "Target_ChaosBolt_8" or spell == "Target_ChaosBolt_9") and number3 == 5 then
			Osi.ApplyStatus(target, "CHAOS_BOLT_POISON_SECOND",6.0,1,caster)
		elseif	(spell == "Target_ChaosBolt" or spell == "Target_ChaosBolt_2" or spell == "Target_ChaosBolt_3" or spell == "Target_ChaosBolt_4" or spell == "Target_ChaosBolt_5" or spell == "Target_ChaosBolt_6" or spell == "Target_ChaosBolt_7" or spell == "Target_ChaosBolt_8" or spell == "Target_ChaosBolt_9") and number3 == 6 then
			Osi.ApplyStatus(target, "CHAOS_BOLT_PSYCHIC_SECOND",6.0,1,caster)
		elseif	(spell == "Target_ChaosBolt" or spell == "Target_ChaosBolt_2" or spell == "Target_ChaosBolt_3" or spell == "Target_ChaosBolt_4" or spell == "Target_ChaosBolt_5" or spell == "Target_ChaosBolt_6" or spell == "Target_ChaosBolt_7" or spell == "Target_ChaosBolt_8" or spell == "Target_ChaosBolt_9") and number3 == 7 then
			Osi.ApplyStatus(target, "CHAOS_BOLT_THUNDER_SECOND",6.0,1,caster)
		end
    end
end)

-- Gold Tracking
Ext.Osiris.RegisterListener("GoldChanged", 2, "after", function (_, _)
	local party = Osi.DB_Players:Get(nil)
	for _,p in pairs(party) do
		local amt = Osi.PartyGetGold(p[1])
		if amt > 24 and amt ~= nil and Osi.HasActiveStatus(p[1],"CEREMONY_GOLD_COST") == 0 then
			Osi.ApplyStatus(p[1],"CEREMONY_GOLD_COST",-1.0,1,p[1])
		elseif amt < 25 and amt ~= nil and Osi.HasActiveStatus(p[1],"CEREMONY_GOLD_COST") == 1 then
			Osi.RemoveStatus(p[1],"CEREMONY_GOLD_COST")
		end
    end
end)

-- Gold Tracking 2
Ext.Osiris.RegisterListener("LevelGameplayStarted", 2, "after", function(level, _)
    if level ~= "SYS_CC_I" then
		local party = Osi.DB_Players:Get(nil)
		for _,p in pairs(party) do
			local amt = Osi.PartyGetGold(p[1])
			if amt > 24 and amt ~= nil and Osi.HasActiveStatus(p[1],"CEREMONY_GOLD_COST") == 0 then
				Osi.ApplyStatus(p[1],"CEREMONY_GOLD_COST",-1.0,1,p[1])
			elseif amt < 25 and amt ~= nil and Osi.HasActiveStatus(p[1],"CEREMONY_GOLD_COST") == 1 then
				Osi.RemoveStatus(p[1],"CEREMONY_GOLD_COST")
			end
		end
    end
end)

-- Gold Tracking 3
Ext.Osiris.RegisterListener("LeveledUp", 1, "after", function (_)
	local party = Osi.DB_Players:Get(nil)
	for _,p in pairs(party) do
		local amt = Osi.PartyGetGold(p[1])
		if amt > 24 and amt ~= nil and Osi.HasActiveStatus(p[1],"CEREMONY_GOLD_COST") == 0 then
			Osi.ApplyStatus(p[1],"CEREMONY_GOLD_COST",-1.0,1,p[1])
		elseif amt < 25 and amt ~= nil and Osi.HasActiveStatus(p[1],"CEREMONY_GOLD_COST") == 1 then
			Osi.RemoveStatus(p[1],"CEREMONY_GOLD_COST")
		end
    end
end)

-- Gold Removal
Ext.Osiris.RegisterListener("UsingSpell", 5, "after", function (caster, spell, _, _, _)
	if spell == "Target_Ceremony_BlessWater" or spell == "Target_Ceremony_ComingOfAge" or spell == "Target_Ceremony_Dedication" or spell == "Target_Ceremony_BlessWater_2" or spell == "Target_Ceremony_ComingOfAge_2" or spell == "Target_Ceremony_Dedication_2" or spell == "Target_Ceremony_BlessWater_3" or spell == "Target_Ceremony_ComingOfAge_3" or spell == "Target_Ceremony_Dedication_3" or spell == "Target_Ceremony_BlessWater_4" or spell == "Target_Ceremony_ComingOfAge_4" or spell == "Target_Ceremony_Dedication_4" or spell == "Target_Ceremony_BlessWater_5" or spell == "Target_Ceremony_ComingOfAge_5" or spell == "Target_Ceremony_Dedication_5" or spell == "Target_Ceremony_BlessWater_6" or spell == "Target_Ceremony_ComingOfAge_6" or spell == "Target_Ceremony_Dedication_6" or spell == "Target_Ceremony_BlessWater_7" or spell == "Target_Ceremony_ComingOfAge_7" or spell == "Target_Ceremony_Dedication_7" or spell == "Target_Ceremony_BlessWater_8" or spell == "Target_Ceremony_ComingOfAge_8" or spell == "Target_Ceremony_Dedication_8" or spell == "Target_Ceremony_BlessWater_9" or spell == "Target_Ceremony_ComingOfAge_9" or spell == "Target_Ceremony_Dedication_9" then
		Osi.PartyAddGold(caster, -25)
		Osi.ApplyStatus(caster,"GOLD_COST_PROC",6.0,0)
    end
end)

-- Gold Check after Removal
Ext.Osiris.RegisterListener("StatusApplied", 4, "after", function (_, status, _, _)
	local party = Osi.DB_Players:Get(nil)
	if status == "GOLD_COST_PROC" then
		for _,p in pairs(party) do
			local amt = Osi.PartyGetGold(p[1])
			if amt > 24 and amt ~= nil and Osi.HasActiveStatus(p[1],"CEREMONY_GOLD_COST") == 0 then
				Osi.ApplyStatus(p[1],"CEREMONY_GOLD_COST",-1.0,1,p[1])
			elseif amt < 25 and amt ~= nil and Osi.HasActiveStatus(p[1],"CEREMONY_GOLD_COST") == 1 then
				Osi.RemoveStatus(p[1],"CEREMONY_GOLD_COST")
			end
		end
    end
end)

-- Ceremony Bless Water Part 1
Ext.Osiris.RegisterListener("TemplateAddedTo", 4, "after", function (template, _, character, _)
	if	(template == "CONS_Drink_Water_A_640302a8-d841-44d6-996d-2addda644306" or template == "CONS_Drink_Water_A_Wicker_00253e1b-375c-4ef4-8808-974cab615ff7" or template == "CONS_Drink_Water_Bottle_A_d8fff9cf-05b9-4aeb-b5b4-0f6bb98b7f2c" or template == "CONS_Drink_Water_B_Wicker_e8e427ac-9078-4471-85f2-4b8bbc3e00b5" or template == "CONS_Drink_Water_Bottle_B_6f5abf98-cca0-43a7-a064-10c17643bb72" or template == "CONS_Drink_Water_B_94f1d6d2-8a70-4ab9-a8cf-376dd0bc294a" or template == "CONS_Drink_Water_Jug_A_cb2e851f-8a75-4899-b705-0f079e8e55bc") and Osi.HasActiveStatus(character,"CEREMONY_BLESSED_WATER_TECHNICAL") == 0 then
		Osi.ApplyStatus(character, "CEREMONY_BLESSED_WATER_TECHNICAL", -1.0, 1, character)
    end
end)

-- Ceremony Bless Water Part 2
Ext.Osiris.RegisterListener("TemplateRemovedFrom", 3, "after", function (_, _, character)
	local item = GetItemByTemplateInInventory("640302a8-d841-44d6-996d-2addda644306", character)
	local item2 = GetItemByTemplateInInventory("00253e1b-375c-4ef4-8808-974cab615ff7", character)
	local item3 = GetItemByTemplateInInventory("d8fff9cf-05b9-4aeb-b5b4-0f6bb98b7f2c", character)
	local item4 = GetItemByTemplateInInventory("e8e427ac-9078-4471-85f2-4b8bbc3e00b5",character)
	local item5 = GetItemByTemplateInInventory("6f5abf98-cca0-43a7-a064-10c17643bb72",character)
	local item6 = GetItemByTemplateInInventory("94f1d6d2-8a70-4ab9-a8cf-376dd0bc294a",character)
	local item7 = GetItemByTemplateInInventory("cb2e851f-8a75-4899-b705-0f079e8e55bc",character)
	if	Osi.HasActiveStatus(character,"CEREMONY_BLESSED_WATER_TECHNICAL") == 1 and not (item or item2 or item3 or item4 or item5 or item6 or item7) then
		Osi.RemoveStatus(character, "CEREMONY_BLESSED_WATER_TECHNICAL")
    end
end)

-- Ceremony
Ext.Osiris.RegisterListener("StatusApplied", 4, "after", function (character, status, _, _)
	local item = GetItemByTemplateInInventory("640302a8-d841-44d6-996d-2addda644306", character)
	local item2 = GetItemByTemplateInInventory("00253e1b-375c-4ef4-8808-974cab615ff7", character)
	local item3 = GetItemByTemplateInInventory("d8fff9cf-05b9-4aeb-b5b4-0f6bb98b7f2c", character)
	local item4 = GetItemByTemplateInInventory("e8e427ac-9078-4471-85f2-4b8bbc3e00b5",character)
	local item5 = GetItemByTemplateInInventory("6f5abf98-cca0-43a7-a064-10c17643bb72",character)
	local item6 = GetItemByTemplateInInventory("94f1d6d2-8a70-4ab9-a8cf-376dd0bc294a",character)
	local item7 = GetItemByTemplateInInventory("cb2e851f-8a75-4899-b705-0f079e8e55bc",character)
	if	status == "CEREMONY_BLESSED_WATER" and item then
		Osi.TemplateAddTo("edabfdca-3371-405f-8358-850718a61fdb", character, 1, 1)
		Osi.TemplateRemoveFromUser("640302a8-d841-44d6-996d-2addda644306", character, 1)
	elseif	status == "CEREMONY_BLESSED_WATER" and item2 then
		Osi.TemplateAddTo("edabfdca-3371-405f-8358-850718a61fdb", character, 1, 1)
		Osi.TemplateRemoveFromUser("00253e1b-375c-4ef4-8808-974cab615ff7", character, 1)
	elseif	status == "CEREMONY_BLESSED_WATER" and item3 then
		Osi.TemplateAddTo("edabfdca-3371-405f-8358-850718a61fdb", character, 1, 1)
		Osi.TemplateRemoveFromUser("d8fff9cf-05b9-4aeb-b5b4-0f6bb98b7f2c", character, 1)
	elseif	status == "CEREMONY_BLESSED_WATER" and item4 then
		Osi.TemplateAddTo("edabfdca-3371-405f-8358-850718a61fdb", character, 1, 1)
		Osi.TemplateRemoveFromUser("e8e427ac-9078-4471-85f2-4b8bbc3e00b5", character, 1)
	elseif	status == "CEREMONY_BLESSED_WATER" and item5 then
		Osi.TemplateAddTo("edabfdca-3371-405f-8358-850718a61fdb", character, 1, 1)
		Osi.TemplateRemoveFromUser("6f5abf98-cca0-43a7-a064-10c17643bb72", character, 1)
	elseif	status == "CEREMONY_BLESSED_WATER" and item6 then
		Osi.TemplateAddTo("edabfdca-3371-405f-8358-850718a61fdb", character, 1, 1)
		Osi.TemplateRemoveFromUser("94f1d6d2-8a70-4ab9-a8cf-376dd0bc294a", character, 1)
	elseif	status == "CEREMONY_BLESSED_WATER" and item7 then
		Osi.TemplateAddTo("edabfdca-3371-405f-8358-850718a61fdb", character, 1, 1)
		Osi.TemplateRemoveFromUser("cb2e851f-8a75-4899-b705-0f079e8e55bc", character, 1)
	elseif	status == "CEREMONY_BLESSED_WATER" and not item1 and not item2 and not item3 and not item4 and not item5 and not item6 and not item7 then
		Osi.ApplyStatus(character, "CEREMONY_BLESSED_WATER_NONE", 6.0, 1, character)
    end
end)

-- Nathair's Mischief Owner
Ext.Osiris.RegisterListener("StatusApplied", 4, "after", function (item, status, causee, _)
	if	status == "NATHAIRS_MISCHIEF" or status == "NATHAIRS_MISCHIEF_MOVE" then
		Osi.SetVarObject(causee,"NathairsMischiefOwner",item)
	end

	if status == "NATHAIRS_MISCHIEF_PROC" then
		local nmitem = Osi.GetVarObject(causee, "NathairsMischiefOwner")
		Osi.ApplyStatus(nmitem,"NATHAIRS_MISCHIEF_EFFECT",6.0,1,causee)
    end
end)

-- Nathair's Mischief
Ext.Osiris.RegisterListener("StatusApplied", 4, "after", function (item, status, causee, _)
	if	status == "NATHAIRS_MISCHIEF_EFFECT" then
		local number = Random(4)
--		local num = IntegerToString(number)
--		Osi.ShowNotification(causee,num)
		if	number == 0 then
			Osi.CreateExplosion(item,"Projectile_NathairsMischief_Charmed", -1, causee)
		elseif	number == 1 then
			Osi.CreateExplosion(item,"Projectile_NathairsMischief_Blinded", -1, causee)
		elseif	number == 2 then
			Osi.CreateExplosion(item,"Projectile_NathairsMischief_Incapacitated", -1, causee)
		elseif	number == 3 then
			Osi.CreateExplosion(item,"Projectile_NathairsMischief_DifficultTerrain", -1, causee)
		end
    end
end)

-- Life Transference Setup
Ext.Osiris.RegisterListener("StartedPreviewingSpell", 4, "before", function (caster, spell, _, _)
	if spell == "Target_LifeTransference" or spell == "Target_LifeTransference_3" or spell == "Target_LifeTransference_4" or spell == "Target_LifeTransference_5" or spell == "Target_LifeTransference_6" or spell == "Target_LifeTransference_7" or spell == "Target_LifeTransference_8" or spell == "Target_LifeTransference_9" then
		local hp = GetHitpoints(caster)
--		local num = IntegerToString(hp)
--		Osi.ShowNotification(caster,num)
		Osi.SetVarInteger(caster,"BeforeHP",hp)
    end
end)

-- Life Transference Heal
Ext.Osiris.RegisterListener("StatusApplied", 4, "after", function (character, status, causee, _)
	if status == "LIFE_TRANSFERENCE" then
		local previoushp = GetVarInteger(causee, "BeforeHP")
		local currenthp = GetHitpoints(causee)
		local hp = 0
		hp = previoushp - currenthp
		hp = hp * 2
		local ltstatus = "LIFE_TRANSFERENCE_HP_" .. hp
		Osi.ApplyStatus(character, ltstatus, 0.0, 0)
	end
end)

-- Thunder Step
Ext.Osiris.RegisterListener("UsingSpell", 5, "before", function (caster, spell, _, _, _)
	local x, y, z = GetPosition(caster)
	if spell == "Teleportation_ThunderStep" or spell == "Teleportation_ThunderStep_4" or spell == "Teleportation_ThunderStep_5" or spell == "Teleportation_ThunderStep_6" or spell == "Teleportation_ThunderStep_7" or spell == "Teleportation_ThunderStep_8" or spell == "Teleportation_ThunderStep_9" then
		Osi.SetVarFloat(caster,"X",x)
		Osi.SetVarFloat(caster,"Y",y)
		Osi.SetVarFloat(caster,"Z",z)
	end
end)

-- Thunder Step Explosion
Ext.Osiris.RegisterListener("CastSpell", 5, "after", function (caster, spell, _, _, _)
	local x = GetVarFloat(caster,"X")
	local y = GetVarFloat(caster,"Y")
	local z = GetVarFloat(caster,"Z")
	if spell == "Teleportation_ThunderStep" then
		Osi.CreateExplosionAtPosition(x, y, z, "Projectile_ThunderStep_Explosion", -1, caster)
	elseif spell == "Teleportation_ThunderStep_4" then
		Osi.CreateExplosionAtPosition(x, y, z, "Projectile_ThunderStep_4_Explosion", -1, caster)
	elseif spell == "Teleportation_ThunderStep_5" then
		Osi.CreateExplosionAtPosition(x, y, z, "Projectile_ThunderStep_5_Explosion", -1, caster)
	elseif spell == "Teleportation_ThunderStep_6" then
		Osi.CreateExplosionAtPosition(x, y, z, "Projectile_ThunderStep_6_Explosion", -1, caster)
	elseif spell == "Teleportation_ThunderStep_7" then
		Osi.CreateExplosionAtPosition(x, y, z, "Projectile_ThunderStep_7_Explosion", -1, caster)
	elseif spell == "Teleportation_ThunderStep_8" then
		Osi.CreateExplosionAtPosition(x, y, z, "Projectile_ThunderStep_8_Explosion", -1, caster)
	elseif spell == "Teleportation_ThunderStep_9" then
		Osi.CreateExplosionAtPosition(x, y, z, "Projectile_ThunderStep_9_Explosion", -1, caster)
	end
end)

-- Kinetic Jaunt
Ext.Osiris.RegisterListener("GainedControl", 1, "after", function(character)
	if	Osi.HasActiveStatus(character,"KINETIC_JAUNT") == 1 then
		Osi.ApplyStatus(character,"KINETIC_JAUNT_AURA",6.0,0,character)
	elseif	Osi.HasActiveStatus(character,"KINETIC_JAUNT_WALKTHROUGH") == 1 then
		Osi.RemoveStatus(character,"KINETIC_JAUNT_WALKTHROUGH")
	end
end)

local dragonsBreathStatuses = {
  "DRAGONS_BREATH_FIRE",
  "DRAGONS_BREATH_COLD",
  "DRAGONS_BREATH_ACID",
  "DRAGONS_BREATH_LIGHTNING",
  "DRAGONS_BREATH_POISON",
  "DRAGONS_BREATH_FIRE_3",
  "DRAGONS_BREATH_COLD_3",
  "DRAGONS_BREATH_ACID_3",
  "DRAGONS_BREATH_LIGHTNING_3",
  "DRAGONS_BREATH_POISON_3",
  "DRAGONS_BREATH_FIRE_4",
  "DRAGONS_BREATH_COLD_4",
  "DRAGONS_BREATH_ACID_4",
  "DRAGONS_BREATH_LIGHTNING_4",
  "DRAGONS_BREATH_POISON_4",
  "DRAGONS_BREATH_FIRE_5",
  "DRAGONS_BREATH_COLD_5",
  "DRAGONS_BREATH_ACID_5",
  "DRAGONS_BREATH_LIGHTNING_5",
  "DRAGONS_BREATH_POISON_5",
  "DRAGONS_BREATH_FIRE_6",
  "DRAGONS_BREATH_COLD_6",
  "DRAGONS_BREATH_ACID_6",
  "DRAGONS_BREATH_LIGHTNING_6",
  "DRAGONS_BREATH_POISON_6",
  "DRAGONS_BREATH_FIRE_7",
  "DRAGONS_BREATH_COLD_7",
  "DRAGONS_BREATH_ACID_7",
  "DRAGONS_BREATH_LIGHTNING_7",
  "DRAGONS_BREATH_POISON_7",
  "DRAGONS_BREATH_FIRE_8",
  "DRAGONS_BREATH_COLD_8",
  "DRAGONS_BREATH_ACID_8",
  "DRAGONS_BREATH_LIGHTNING_8",
  "DRAGONS_BREATH_POISON_8",
  "DRAGONS_BREATH_FIRE_9",
  "DRAGONS_BREATH_COLD_9",
  "DRAGONS_BREATH_ACID_9",
  "DRAGONS_BREATH_LIGHTNING_9",
  "DRAGONS_BREATH_POISON_9"
}

local dragonsBreathSpells = {
  Zone_DragonsBreath_Fire = "Target_DragonsBreath_Fire",
  Zone_DragonsBreath_Cold = "Target_DragonsBreath_Cold",
  Zone_DragonsBreath_Lightning = "Target_DragonsBreath_Lightning",
  Zone_DragonsBreath_Poison = "Target_DragonsBreath_Poison",
  Zone_DragonsBreath_Acid = "Target_DragonsBreath_Acid",
  Zone_DragonsBreath_Fire_3 = "Target_DragonsBreath_Fire_3",
  Zone_DragonsBreath_Cold_3 = "Target_DragonsBreath_Cold_3",
  Zone_DragonsBreath_Lightning_3 = "Target_DragonsBreath_Lightning_3",
  Zone_DragonsBreath_Poison_3 = "Target_DragonsBreath_Poison_3",
  Zone_DragonsBreath_Acid_3 = "Target_DragonsBreath_Acid_3",
  Zone_DragonsBreath_Fire_4 = "Target_DragonsBreath_Fire_4",
  Zone_DragonsBreath_Cold_4 = "Target_DragonsBreath_Cold_4",
  Zone_DragonsBreath_Lightning_4 = "Target_DragonsBreath_Lightning_4",
  Zone_DragonsBreath_Poison_4 = "Target_DragonsBreath_Poison_4",
  Zone_DragonsBreath_Acid_4 = "Target_DragonsBreath_Acid_4",
  Zone_DragonsBreath_Fire_5 = "Target_DragonsBreath_Fire_5",
  Zone_DragonsBreath_Cold_5 = "Target_DragonsBreath_Cold_5",
  Zone_DragonsBreath_Lightning_5 = "Target_DragonsBreath_Lightning_5",
  Zone_DragonsBreath_Poison_5 = "Target_DragonsBreath_Poison_5",
  Zone_DragonsBreath_Acid_5 = "Target_DragonsBreath_Acid_5",
  Zone_DragonsBreath_Fire_6 = "Target_DragonsBreath_Fire_6",
  Zone_DragonsBreath_Cold_6 = "Target_DragonsBreath_Cold_6",
  Zone_DragonsBreath_Lightning_6 = "Target_DragonsBreath_Lightning_6",
  Zone_DragonsBreath_Poison_6 = "Target_DragonsBreath_Poison_6",
  Zone_DragonsBreath_Acid_6 = "Target_DragonsBreath_Acid_6",
  Zone_DragonsBreath_Fire_7 = "Target_DragonsBreath_Fire_7",
  Zone_DragonsBreath_Cold_7 = "Target_DragonsBreath_Cold_7",
  Zone_DragonsBreath_Lightning_7 = "Target_DragonsBreath_Lightning_7",
  Zone_DragonsBreath_Poison_7 = "Target_DragonsBreath_Poison_7",
  Zone_DragonsBreath_Acid_7 = "Target_DragonsBreath_Acid_7",
  Zone_DragonsBreath_Fire_8 = "Target_DragonsBreath_Fire_8",
  Zone_DragonsBreath_Cold_8 = "Target_DragonsBreath_Cold_8",
  Zone_DragonsBreath_Lightning_8 = "Target_DragonsBreath_Lightning_8",
  Zone_DragonsBreath_Poison_8 = "Target_DragonsBreath_Poison_8",
  Zone_DragonsBreath_Acid_8 = "Target_DragonsBreath_Acid_8",
  Zone_DragonsBreath_Fire_9 = "Target_DragonsBreath_Fire_9",
  Zone_DragonsBreath_Cold_9 = "Target_DragonsBreath_Cold_9",
  Zone_DragonsBreath_Lightning_9 = "Target_DragonsBreath_Lightning_9",
  Zone_DragonsBreath_Poison_9 = "Target_DragonsBreath_Poison_9",
  Zone_DragonsBreath_Acid_9 = "Target_DragonsBreath_Acid_9"
}

-- Magic Stone & Dragon's Breath
Ext.Osiris.RegisterListener("StatusApplied", 4, "after", function (character, status, causee, _)
	if string.sub(character,-36) ~= causee and status == "MAGIC_STONE" then
		Osi.SetVarObject(string.sub(character,-36),"StoreSource",causee)
	elseif string.sub(character,-36) ~= causee and status ~= "MAGIC_STONE" then
		for _, dbstatus in pairs(dragonsBreathStatuses) do
			if status == dbstatus then
        		Osi.SetVarObject(string.sub(character,-36),"StoreSource",causee)
			end
    	end
	end

	for _, dbstatus in pairs(dragonsBreathStatuses) do
		if string.sub(character,-36) == causee and status == dbstatus then
			_D("This works")
			for _, dbstatus in pairs(Ext.Entity.Get(causee).ServerCharacter.StatusManager.Statuses) do
				_D("This works")
				if dbstatus.StatusId == status and dbstatus.SpellCastingAbility == 4 then
					Osi.ApplyStatus(character,"DRAGONS_BREATH_INTELLIGENCE",60.0,1,causee)
				elseif dbstatus.StatusId == status and dbstatus.SpellCastingAbility == 5 then
					Osi.ApplyStatus(character,"DRAGONS_BREATH_WISDOM",60.0,1,causee)
				elseif dbstatus.StatusId == status and dbstatus.SpellCastingAbility == 6 then
					Osi.ApplyStatus(character,"DRAGONS_BREATH_CHARISMA",60.0,1,causee)
				end
			end
		elseif string.sub(character,-36) ~= causee and status == dbstatus then
			for _, dbstatus in pairs(Ext.Entity.Get(character).ServerCharacter.StatusManager.Statuses) do
				if dbstatus.StatusId == status and dbstatus.SpellCastingAbility == 4 then
					Osi.ApplyStatus(character,"DRAGONS_BREATH_INTELLIGENCE",60.0,1,causee)
				elseif dbstatus.StatusId == status and dbstatus.SpellCastingAbility == 5 then
					Osi.ApplyStatus(character,"DRAGONS_BREATH_WISDOM",60.0,1,causee)
				elseif dbstatus.StatusId == status and dbstatus.SpellCastingAbility == 6 then
					Osi.ApplyStatus(character,"DRAGONS_BREATH_CHARISMA",60.0,1,causee)
				end
			end
		end
	end
end)

Ext.Osiris.RegisterListener("StartedPreviewingSpell", 4, "after", function (caster, spell, _, _)
	local source = Osi.GetVarObject(caster,"StoreSource")
	if spell == "Projectile_MagicStone" and caster ~= source then
		for _, spell in pairs(Ext.Entity.Get(source).SpellBook.Spells) do
			if spell.Id.Prototype == "Target_MagicStone" and spell.SpellCastingAbility == "Intelligence" then
				local int = Osi.GetAbility(caster,"Intelligence") - Osi.GetAbility(source,"Intelligence")
				local scastatus = "MAGIC_STONE_MODIFIER_" .. int
				if Osi.HasActiveStatus(caster,scastatus) == 0 then
					Osi.ApplyStatus(caster,scastatus,-1.0,1,source)
				end
			elseif spell.Id.Prototype == "Target_MagicStone" and spell.SpellCastingAbility == "Wisdom" then
				local wis = Osi.GetAbility(caster,"Wisdom") - Osi.GetAbility(source,"Wisdom")
				local scastatus = "MAGIC_STONE_MODIFIER_" .. wis
				if Osi.HasActiveStatus(caster,scastatus) == 0 then
					Osi.ApplyStatus(caster,scastatus,-1.0,1,source)
				end
			elseif spell.Id.Prototype == "Target_MagicStone" and spell.SpellCastingAbility == "Charisma" then
				local cha = Osi.GetAbility(caster,"Charisma") - Osi.GetAbility(source,"Charisma")
				local scastatus = "MAGIC_STONE_MODIFIER_" .. cha
				if Osi.HasActiveStatus(caster,scastatus) == 0 then
					Osi.ApplyStatus(caster,scastatus,-1.0,1,source)
				end
			end
		local pb = Ext.Entity.Get(source).Stats.ProficiencyBonus
		local pbstatus = "MAGIC_STONE_PROFICIENCY_BONUS_" .. pb
		Osi.ApplyStatus(caster,pbstatus,-1.0,1,source)
		end
	elseif (spell == "Zone_DragonsBreath_Fire" or spell == "Zone_DragonsBreath_Cold" or spell == "Zone_DragonsBreath_Lightning" or spell == "Zone_DragonsBreath_Poison" or spell == "Zone_DragonsBreath_Acid" or spell == "Zone_DragonsBreath_Fire_3" or spell == "Zone_DragonsBreath_Cold_3" or spell == "Zone_DragonsBreath_Lightning_3" or spell == "Zone_DragonsBreath_Poison_3" or spell == "Zone_DragonsBreath_Acid_3" or spell == "Zone_DragonsBreath_Fire_4" or spell == "Zone_DragonsBreath_Cold_4" or spell == "Zone_DragonsBreath_Lightning_4" or spell == "Zone_DragonsBreath_Poison_4" or spell == "Zone_DragonsBreath_Acid_4" or spell == "Zone_DragonsBreath_Fire_5" or spell == "Zone_DragonsBreath_Cold_5" or spell == "Zone_DragonsBreath_Lightning_5" or spell == "Zone_DragonsBreath_Poison_5" or spell == "Zone_DragonsBreath_Acid_5" or spell == "Zone_DragonsBreath_Fire_6" or spell == "Zone_DragonsBreath_Cold_6" or spell == "Zone_DragonsBreath_Lightning_6" or spell == "Zone_DragonsBreath_Poison_6" or spell == "Zone_DragonsBreath_Acid_6" or spell == "Zone_DragonsBreath_Fire_7" or spell == "Zone_DragonsBreath_Cold_7" or spell == "Zone_DragonsBreath_Lightning_7" or spell == "Zone_DragonsBreath_Poison_7" or spell == "Zone_DragonsBreath_Acid_7" or spell == "Zone_DragonsBreath_Fire_8" or spell == "Zone_DragonsBreath_Cold_8" or spell == "Zone_DragonsBreath_Lightning_8" or spell == "Zone_DragonsBreath_Poison_8" or spell == "Zone_DragonsBreath_Acid_8" or spell == "Zone_DragonsBreath_Fire_9" or spell == "Zone_DragonsBreath_Cold_9" or spell == "Zone_DragonsBreath_Lightning_9" or spell == "Zone_DragonsBreath_Poison_9" or spell == "Zone_DragonsBreath_Acid_9") and caster ~= source then
		for _, spell in pairs(Ext.Entity.Get(source).SpellBook.Spells) do
			for dbaction, dbspell in pairs(dragonsBreathSpells) do
				if spell.Id.Prototype == dbspell and spell.SpellCastingAbility == "Intelligence" then
					local int = Osi.GetAbility(caster,"Intelligence") - Osi.GetAbility(source,"Intelligence")
					local scastatus = "DRAGONS_BREATH_MODIFIER_" .. int
					if Osi.HasActiveStatus(caster,scastatus) == 0 and  Osi.HasActiveStatus(caster,"DRAGONS_BREATH_MODIFIER_REMOVAL") == 0 then
							Osi.ApplyStatus(caster,scastatus,-1.0,1,source)
					end
				elseif spell.Id.Prototype == dbspell and spell.SpellCastingAbility == "Wisdom" then
					local wis = Osi.GetAbility(caster,"Wisdom") - Osi.GetAbility(source,"Wisdom")
					local scastatus = "DRAGONS_BREATH_MODIFIER_" .. wis
					if Osi.HasActiveStatus(caster,scastatus) == 0 and  Osi.HasActiveStatus(caster,"DRAGONS_BREATH_MODIFIER_REMOVAL") == 0 then
							Osi.ApplyStatus(caster,scastatus,-1.0,1,source)
					end
				elseif spell.Id.Prototype == dbspell and spell.SpellCastingAbility == "Charisma" then
					local cha = Osi.GetAbility(caster,"Charisma") - Osi.GetAbility(source,"Charisma")
					local scastatus = "DRAGONS_BREATH_MODIFIER_" .. cha
					if Osi.HasActiveStatus(caster,scastatus) == 0 and  Osi.HasActiveStatus(caster,"DRAGONS_BREATH_MODIFIER_REMOVAL") == 0 then
							Osi.ApplyStatus(caster,scastatus,-1.0,1,source)
					end
				end
			end
		end
		local pb = Ext.Entity.Get(source).Stats.ProficiencyBonus
		local pbstatus = "DRAGONS_BREATH_PROFICIENCY_BONUS_" .. pb
		Osi.ApplyStatus(caster,pbstatus,-1.0,1,source)			
	elseif (spell ~= "Projectile_MagicStone" and spell ~= "Zone_DragonsBreath_Fire" and spell ~= "Zone_DragonsBreath_Cold" and spell ~= "Zone_DragonsBreath_Lightning" and spell ~= "Zone_DragonsBreath_Poison" and spell ~= "Zone_DragonsBreath_Acid" and spell ~= "Zone_DragonsBreath_Fire_3" and spell ~= "Zone_DragonsBreath_Cold_3" and spell ~= "Zone_DragonsBreath_Lightning_3" and spell ~= "Zone_DragonsBreath_Poison_3" and spell ~= "Zone_DragonsBreath_Acid_3" and spell ~= "Zone_DragonsBreath_Fire_4" and spell ~= "Zone_DragonsBreath_Cold_4" and spell ~= "Zone_DragonsBreath_Lightning_4" and spell ~= "Zone_DragonsBreath_Poison_4" and spell ~= "Zone_DragonsBreath_Acid_4" and spell ~= "Zone_DragonsBreath_Fire_5" and spell ~= "Zone_DragonsBreath_Cold_5" and spell ~= "Zone_DragonsBreath_Lightning_5" and spell ~= "Zone_DragonsBreath_Poison_5" and spell ~= "Zone_DragonsBreath_Acid_5" and spell ~= "Zone_DragonsBreath_Fire_6" and spell ~= "Zone_DragonsBreath_Cold_6" and spell ~= "Zone_DragonsBreath_Lightning_6" and spell ~= "Zone_DragonsBreath_Poison_6" and spell ~= "Zone_DragonsBreath_Acid_6" and spell ~= "Zone_DragonsBreath_Fire_7" and spell ~= "Zone_DragonsBreath_Cold_7" and spell ~= "Zone_DragonsBreath_Lightning_7" and spell ~= "Zone_DragonsBreath_Poison_7" and spell ~= "Zone_DragonsBreath_Acid_7" and spell ~= "Zone_DragonsBreath_Fire_8" and spell ~= "Zone_DragonsBreath_Cold_8" and spell ~= "Zone_DragonsBreath_Lightning_8" and spell ~= "Zone_DragonsBreath_Poison_8" and spell ~= "Zone_DragonsBreath_Acid_8" and spell ~= "Zone_DragonsBreath_Fire_9" and spell ~= "Zone_DragonsBreath_Cold_9" and spell ~= "Zone_DragonsBreath_Lightning_9" and spell ~= "Zone_DragonsBreath_Poison_9" and spell ~= "Zone_DragonsBreath_Acid_9") and caster ~= source then
		for dbaction, dbspell in pairs(dragonsBreathSpells) do
			if Osi.HasSpell(caster,"Projectile_MagicStone") == 1 or Osi.HasSpell(caster,dbaction) == 1 then
				Osi.ApplyStatus(caster,"DRAGONS_BREATH_MODIFIER_REMOVAL",0.0,1,source)
				Osi.ApplyStatus(caster,"DRAGONS_BREATH_PROFICIENCY_BONUS_REMOVAL",0.0,1,source)
				Osi.ApplyStatus(caster,"MAGIC_STONE_PROFICIENCY_BONUS_REMOVAL",0.0,1)
				Osi.ApplyStatus(caster,"MAGIC_STONE_MODIFIER_REMOVAL",0.0,1)
			end
		end
	end
end)

Ext.Osiris.RegisterListener("CastedSpell", 5, "after", function (caster, spell, _, _, _)
	if spell == "Projectile_MagicStone" then
		Osi.ApplyStatus(caster,"MAGIC_STONE_MODIFIER_REMOVAL",0.0,1)
		Osi.ApplyStatus(caster,"MAGIC_STONE_PROFICIENCY_BONUS_REMOVAL",0.0,1)
	elseif spell ~= "Projectile_MagicStone" then
		for dbaction, _ in pairs(dragonsBreathSpells) do
			for _, dbstatus in pairs(dragonsBreathStatuses) do
				if spell == dbaction and Osi.HasActiveStatus(caster,dbstatus) == 1 then
					Osi.ApplyStatus(caster,"DRAGONS_BREATH_MODIFIER_REMOVAL",0.0,1)
					Osi.ApplyStatus(caster,"DRAGONS_BREATH_PROFICIENCY_BONUS_REMOVAL",0.0,1)
				end
			end
		end
	end
end)

local invisStatuses = {
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
				Osi.ApplyStatus(character,seeninvis,turns*6,1,source)
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
				Osi.ApplyStatus(character,invis,turns*6,1,source)
			end
		end
    end
end)

-- Catnap Short Resting
Ext.Osiris.RegisterListener("StatusApplied", 4, "after", function (character, status, causee, _)
	if status == "CATNAP" then
		local catnapper = Ext.Entity.Get(character)
		catnapper:CreateComponent("ShortRest")
    end
end)

-- Heal
Ext.Osiris.RegisterListener("UsingSpellOnTarget", 6, "before", function (caster, target, spell, _, _, _)
	if (spell == "Target_Heal" or spell == "Target_GreaterRestoration" or spell == "Target_GreaterRestoration_6") and Osi.HasActiveStatus(target,"FEEBLEMIND") == 1 then
		Osi.RemoveStatus(target,"FEEBLEMIND")
    end
end)

-- Power Word Heal
Ext.Osiris.RegisterListener("UsingSpellOnTarget", 6, "before", function (caster, target, spell, _, _, _)
	if spell == "Target_PowerWordHeal" and Osi.HasActiveStatusWithGroup(target,"SG_Prone") == 1 then
		Osi.ApplyStatus(target,"POWER_WORD_HEAL_INTERRUPT",6.0,1)
	elseif spell ~= "Target_PowerWordHeal" and Osi.HasActiveStatusWithGroup(target,"SG_Prone") == 1 then
		Osi.RemoveStatus(target,"POWER_WORD_HEAL_INTERRUPT")
		Osi.RemoveStatus(target,"POWER_WORD_HEAL_TECHNICAL")
    end
end)

--[[ Boost Checking
Ext.Osiris.RegisterListener("StatusApplied", 4, "after", function (character, status, causee, _)
	if status == "SNEAKING" then
		for _, boosts in pairs(Ext.Entity.Get(causee).BoostsContainer.Boosts) do
			if boosts.Type == "ProficiencyBonus" then
				for _, b in pairs(boosts.Boosts) do
					if b.ProficiencyBonusBoost.Type == "SavingThrow" then
						_D(b.ProficiencyBonusBoost.Ability)
					end
				end
			end
		end
    end
end)--]]


--[[ Dispel Magic
Ext.Osiris.RegisterListener("StatusApplied", 4, "after", function(character, status, causee, _)
	if status == "DISPEL_MAGIC" then
		local spell = Ext.Entity.Get(character).ServerCharacter:GetStatus(statuses).SourceSpell.Prototype)

	end
end)

-- Status Debug Text
Ext.Osiris.RegisterListener("StatusApplied",4, "after",function (character, status, _, _)
	if status ~= "INSURFACE" then
	local disname = Osi.GetDisplayName(character)
	local name = Osi.ResolveTranslatedString(disname)
	local str = status .. " status applied to " .. name
	_D(str)
	end
end)

-- Status Debug Text
Ext.Osiris.RegisterListener("StatusRemoved",4, "after",function (character, status, causee, _)
	if status ~= "INSURFACE" then
	local disname = Osi.GetDisplayName(character)
	local name = Osi.ResolveTranslatedString(disname)
	local str = status .. " status removed from " .. name .. " by " .. causee
	_D(str)
	end
end)

-- Spell Casting Debug
Ext.Osiris.RegisterListener("UsingSpell",5, "before",function (caster, spell, _, _, _)
	_D(spell)
end)--]]