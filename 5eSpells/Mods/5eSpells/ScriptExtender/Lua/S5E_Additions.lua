-- Chaos Bolt Passive Trigger
Ext.Osiris.RegisterListener("EnteredTrigger", 2, "before", function (character, _)
	if	Osi.HasPassive(character,"ChaosBolt_Explosion") == 0 and Osi.IsPlayer(character) == 1 then
		Osi.AddPassive(character, "ChaosBolt")
		Osi.AddPassive(character, "ChaosBolt_2")
		Osi.AddPassive(character, "ChaosBolt_3")
		Osi.AddPassive(character, "ChaosBolt_4")
		Osi.AddPassive(character, "ChaosBolt_5")
		Osi.AddPassive(character, "ChaosBolt_6")
		Osi.AddPassive(character, "ChaosBolt_7")
		Osi.AddPassive(character, "ChaosBolt_8")
		Osi.AddPassive(character, "ChaosBolt_9")
		Osi.AddPassive(character, "ChaosBolt_Explosion")
    end
end)

-- Chaos Bolt Preview
Ext.Osiris.RegisterListener("StartedPreviewingSpell", 4, "before", function (character, spell, _, _)
	if	(spell == "Target_ChaosBolt" or spell == "Target_ChaosBolt_2" or spell == "Target_ChaosBolt_3" or spell == "Target_ChaosBolt_4" or spell == "Target_ChaosBolt_5" or spell == "Target_ChaosBolt_6" or spell == "Target_ChaosBolt_7" or spell == "Target_ChaosBolt_8" or spell == "Target_ChaosBolt_9") and Osi.HasPassive(character,"ChaosBolt_Explosion") == 0 and Osi.IsPlayer(character) == 1 then
		Osi.AddPassive(character, "ChaosBolt")
		Osi.AddPassive(character, "ChaosBolt_2")
		Osi.AddPassive(character, "ChaosBolt_3")
		Osi.AddPassive(character, "ChaosBolt_4")
		Osi.AddPassive(character, "ChaosBolt_5")
		Osi.AddPassive(character, "ChaosBolt_6")
		Osi.AddPassive(character, "ChaosBolt_7")
		Osi.AddPassive(character, "ChaosBolt_8")
		Osi.AddPassive(character, "ChaosBolt_9")
		Osi.AddPassive(character, "ChaosBolt_Explosion")
    end
end)

-- Chaos Bolt Self
Ext.Osiris.RegisterListener("UsingSpell", 5, "before", function (caster, spell, _, _, _)
	local number = Random(8)
	if	(spell == "Target_ChaosBolt" or spell == "Target_ChaosBolt_2" or spell == "Target_ChaosBolt_3" or spell == "Target_ChaosBolt_4" or spell == "Target_ChaosBolt_5" or spell == "Target_ChaosBolt_6" or spell == "Target_ChaosBolt_7" or spell == "Target_ChaosBolt_8" or spell == "Target_ChaosBolt_9") and number == 0 and HasActiveStatus(caster,"CHAOS_BOLT_ACID") == 0 and HasActiveStatus(caster,"CHAOS_BOLT_COLD") == 0 and HasActiveStatus(caster,"CHAOS_BOLT_FIRE") == 0 and HasActiveStatus(caster,"CHAOS_BOLT_FORCE") == 0 and HasActiveStatus(caster,"CHAOS_BOLT_LIGHTNING") == 0 and HasActiveStatus(caster,"CHAOS_BOLT_POISON") == 0 and HasActiveStatus(caster,"CHAOS_BOLT_PSYCHIC") == 0 and HasActiveStatus(caster,"CHAOS_BOLT_THUNDER") == 0 then
		Osi.ApplyStatus(caster, "CHAOS_BOLT_ACID",6.0,1,caster)
		Osi.SetVarInteger(caster,"RandomNumber",number)
	elseif	(spell == "Target_ChaosBolt" or spell == "Target_ChaosBolt_2" or spell == "Target_ChaosBolt_3" or spell == "Target_ChaosBolt_4" or spell == "Target_ChaosBolt_5" or spell == "Target_ChaosBolt_6" or spell == "Target_ChaosBolt_7" or spell == "Target_ChaosBolt_8" or spell == "Target_ChaosBolt_9") and number == 1 and HasActiveStatus(caster,"CHAOS_BOLT_ACID") == 0 and HasActiveStatus(caster,"CHAOS_BOLT_COLD") == 0 and HasActiveStatus(caster,"CHAOS_BOLT_FIRE") == 0 and HasActiveStatus(caster,"CHAOS_BOLT_FORCE") == 0 and HasActiveStatus(caster,"CHAOS_BOLT_LIGHTNING") == 0 and HasActiveStatus(caster,"CHAOS_BOLT_POISON") == 0 and HasActiveStatus(caster,"CHAOS_BOLT_PSYCHIC") == 0 and HasActiveStatus(caster,"CHAOS_BOLT_THUNDER") == 0 then
		Osi.ApplyStatus(caster, "CHAOS_BOLT_COLD",6.0,1,caster)
		Osi.SetVarInteger(caster,"RandomNumber",number)
	elseif	(spell == "Target_ChaosBolt" or spell == "Target_ChaosBolt_2" or spell == "Target_ChaosBolt_3" or spell == "Target_ChaosBolt_4" or spell == "Target_ChaosBolt_5" or spell == "Target_ChaosBolt_6" or spell == "Target_ChaosBolt_7" or spell == "Target_ChaosBolt_8" or spell == "Target_ChaosBolt_9") and number == 2 and HasActiveStatus(caster,"CHAOS_BOLT_ACID") == 0 and HasActiveStatus(caster,"CHAOS_BOLT_COLD") == 0 and HasActiveStatus(caster,"CHAOS_BOLT_FIRE") == 0 and HasActiveStatus(caster,"CHAOS_BOLT_FORCE") == 0 and HasActiveStatus(caster,"CHAOS_BOLT_LIGHTNING") == 0 and HasActiveStatus(caster,"CHAOS_BOLT_POISON") == 0 and HasActiveStatus(caster,"CHAOS_BOLT_PSYCHIC") == 0 and HasActiveStatus(caster,"CHAOS_BOLT_THUNDER") == 0 then
		Osi.ApplyStatus(caster, "CHAOS_BOLT_FIRE",6.0,1,caster)
		Osi.SetVarInteger(caster,"RandomNumber",number)
	elseif	(spell == "Target_ChaosBolt" or spell == "Target_ChaosBolt_2" or spell == "Target_ChaosBolt_3" or spell == "Target_ChaosBolt_4" or spell == "Target_ChaosBolt_5" or spell == "Target_ChaosBolt_6" or spell == "Target_ChaosBolt_7" or spell == "Target_ChaosBolt_8" or spell == "Target_ChaosBolt_9") and number == 3 and HasActiveStatus(caster,"CHAOS_BOLT_ACID") == 0 and HasActiveStatus(caster,"CHAOS_BOLT_COLD") == 0 and HasActiveStatus(caster,"CHAOS_BOLT_FIRE") == 0 and HasActiveStatus(caster,"CHAOS_BOLT_FORCE") == 0 and HasActiveStatus(caster,"CHAOS_BOLT_LIGHTNING") == 0 and HasActiveStatus(caster,"CHAOS_BOLT_POISON") == 0 and HasActiveStatus(caster,"CHAOS_BOLT_PSYCHIC") == 0 and HasActiveStatus(caster,"CHAOS_BOLT_THUNDER") == 0 then
		Osi.ApplyStatus(caster, "CHAOS_BOLT_FORCE",6.0,1,caster)
		Osi.SetVarInteger(caster,"RandomNumber",number)
	elseif	(spell == "Target_ChaosBolt" or spell == "Target_ChaosBolt_2" or spell == "Target_ChaosBolt_3" or spell == "Target_ChaosBolt_4" or spell == "Target_ChaosBolt_5" or spell == "Target_ChaosBolt_6" or spell == "Target_ChaosBolt_7" or spell == "Target_ChaosBolt_8" or spell == "Target_ChaosBolt_9") and number == 4 and HasActiveStatus(caster,"CHAOS_BOLT_ACID") == 0 and HasActiveStatus(caster,"CHAOS_BOLT_COLD") == 0 and HasActiveStatus(caster,"CHAOS_BOLT_FIRE") == 0 and HasActiveStatus(caster,"CHAOS_BOLT_FORCE") == 0 and HasActiveStatus(caster,"CHAOS_BOLT_LIGHTNING") == 0 and HasActiveStatus(caster,"CHAOS_BOLT_POISON") == 0 and HasActiveStatus(caster,"CHAOS_BOLT_PSYCHIC") == 0 and HasActiveStatus(caster,"CHAOS_BOLT_THUNDER") == 0 then
		Osi.ApplyStatus(caster, "CHAOS_BOLT_LIGHTNING",6.0,1,caster)
		Osi.SetVarInteger(caster,"RandomNumber",number)
	elseif	(spell == "Target_ChaosBolt" or spell == "Target_ChaosBolt_2" or spell == "Target_ChaosBolt_3" or spell == "Target_ChaosBolt_4" or spell == "Target_ChaosBolt_5" or spell == "Target_ChaosBolt_6" or spell == "Target_ChaosBolt_7" or spell == "Target_ChaosBolt_8" or spell == "Target_ChaosBolt_9") and number == 5 and HasActiveStatus(caster,"CHAOS_BOLT_ACID") == 0 and HasActiveStatus(caster,"CHAOS_BOLT_COLD") == 0 and HasActiveStatus(caster,"CHAOS_BOLT_FIRE") == 0 and HasActiveStatus(caster,"CHAOS_BOLT_FORCE") == 0 and HasActiveStatus(caster,"CHAOS_BOLT_LIGHTNING") == 0 and HasActiveStatus(caster,"CHAOS_BOLT_POISON") == 0 and HasActiveStatus(caster,"CHAOS_BOLT_PSYCHIC") == 0 and HasActiveStatus(caster,"CHAOS_BOLT_THUNDER") == 0 then
		Osi.ApplyStatus(caster, "CHAOS_BOLT_POISON",6.0,1,caster)
		Osi.SetVarInteger(caster,"RandomNumber",number)
	elseif	(spell == "Target_ChaosBolt" or spell == "Target_ChaosBolt_2" or spell == "Target_ChaosBolt_3" or spell == "Target_ChaosBolt_4" or spell == "Target_ChaosBolt_5" or spell == "Target_ChaosBolt_6" or spell == "Target_ChaosBolt_7" or spell == "Target_ChaosBolt_8" or spell == "Target_ChaosBolt_9") and number == 6 and HasActiveStatus(caster,"CHAOS_BOLT_ACID") == 0 and HasActiveStatus(caster,"CHAOS_BOLT_COLD") == 0 and HasActiveStatus(caster,"CHAOS_BOLT_FIRE") == 0 and HasActiveStatus(caster,"CHAOS_BOLT_FORCE") == 0 and HasActiveStatus(caster,"CHAOS_BOLT_LIGHTNING") == 0 and HasActiveStatus(caster,"CHAOS_BOLT_POISON") == 0 and HasActiveStatus(caster,"CHAOS_BOLT_PSYCHIC") == 0 and HasActiveStatus(caster,"CHAOS_BOLT_THUNDER") == 0 then
		Osi.ApplyStatus(caster, "CHAOS_BOLT_PSYCHIC",6.0,1,caster)
		Osi.SetVarInteger(caster,"RandomNumber",number)
	elseif	(spell == "Target_ChaosBolt" or spell == "Target_ChaosBolt_2" or spell == "Target_ChaosBolt_3" or spell == "Target_ChaosBolt_4" or spell == "Target_ChaosBolt_5" or spell == "Target_ChaosBolt_6" or spell == "Target_ChaosBolt_7" or spell == "Target_ChaosBolt_8" or spell == "Target_ChaosBolt_9") and number == 7 and HasActiveStatus(caster,"CHAOS_BOLT_ACID") == 0 and HasActiveStatus(caster,"CHAOS_BOLT_COLD") == 0 and HasActiveStatus(caster,"CHAOS_BOLT_FIRE") == 0 and HasActiveStatus(caster,"CHAOS_BOLT_FORCE") == 0 and HasActiveStatus(caster,"CHAOS_BOLT_LIGHTNING") == 0 and HasActiveStatus(caster,"CHAOS_BOLT_POISON") == 0 and HasActiveStatus(caster,"CHAOS_BOLT_PSYCHIC") == 0 and HasActiveStatus(caster,"CHAOS_BOLT_THUNDER") == 0 then
		Osi.ApplyStatus(caster, "CHAOS_BOLT_THUNDER",6.0,1,caster)
		Osi.SetVarInteger(caster,"RandomNumber",number)
	elseif	(spell == "Target_ChaosBolt" or spell == "Target_ChaosBolt_2" or spell == "Target_ChaosBolt_3" or spell == "Target_ChaosBolt_4" or spell == "Target_ChaosBolt_5" or spell == "Target_ChaosBolt_6" or spell == "Target_ChaosBolt_7" or spell == "Target_ChaosBolt_8" or spell == "Target_ChaosBolt_9") and number == 0 and (HasActiveStatus(caster,"CHAOS_BOLT_ACID") == 1 and HasActiveStatus(caster,"CHAOS_BOLT_COLD") == 1 and HasActiveStatus(caster,"CHAOS_BOLT_FIRE") == 1 or HasActiveStatus(caster,"CHAOS_BOLT_FORCE") == 1 or HasActiveStatus(caster,"CHAOS_BOLT_LIGHTNING") == 1 or HasActiveStatus(caster,"CHAOS_BOLT_POISON") == 1 or HasActiveStatus(caster,"CHAOS_BOLT_PSYCHIC") == 1 or HasActiveStatus(caster,"CHAOS_BOLT_THUNDER") == 1) then
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
	elseif	(spell == "Target_ChaosBolt" or spell == "Target_ChaosBolt_2" or spell == "Target_ChaosBolt_3" or spell == "Target_ChaosBolt_4" or spell == "Target_ChaosBolt_5" or spell == "Target_ChaosBolt_6" or spell == "Target_ChaosBolt_7" or spell == "Target_ChaosBolt_8" or spell == "Target_ChaosBolt_9") and number == 1 and (HasActiveStatus(caster,"CHAOS_BOLT_ACID") == 1 and HasActiveStatus(caster,"CHAOS_BOLT_COLD") == 1 and HasActiveStatus(caster,"CHAOS_BOLT_FIRE") == 1 or HasActiveStatus(caster,"CHAOS_BOLT_FORCE") == 1 or HasActiveStatus(caster,"CHAOS_BOLT_LIGHTNING") == 1 or HasActiveStatus(caster,"CHAOS_BOLT_POISON") == 1 or HasActiveStatus(caster,"CHAOS_BOLT_PSYCHIC") == 1 or HasActiveStatus(caster,"CHAOS_BOLT_THUNDER") == 1) then
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
	elseif	(spell == "Target_ChaosBolt" or spell == "Target_ChaosBolt_2" or spell == "Target_ChaosBolt_3" or spell == "Target_ChaosBolt_4" or spell == "Target_ChaosBolt_5" or spell == "Target_ChaosBolt_6" or spell == "Target_ChaosBolt_7" or spell == "Target_ChaosBolt_8" or spell == "Target_ChaosBolt_9") and number == 2 and (HasActiveStatus(caster,"CHAOS_BOLT_ACID") == 1 and HasActiveStatus(caster,"CHAOS_BOLT_COLD") == 1 and HasActiveStatus(caster,"CHAOS_BOLT_FIRE") == 1 or HasActiveStatus(caster,"CHAOS_BOLT_FORCE") == 1 or HasActiveStatus(caster,"CHAOS_BOLT_LIGHTNING") == 1 or HasActiveStatus(caster,"CHAOS_BOLT_POISON") == 1 or HasActiveStatus(caster,"CHAOS_BOLT_PSYCHIC") == 1 or HasActiveStatus(caster,"CHAOS_BOLT_THUNDER") == 1) then
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
	elseif	(spell == "Target_ChaosBolt" or spell == "Target_ChaosBolt_2" or spell == "Target_ChaosBolt_3" or spell == "Target_ChaosBolt_4" or spell == "Target_ChaosBolt_5" or spell == "Target_ChaosBolt_6" or spell == "Target_ChaosBolt_7" or spell == "Target_ChaosBolt_8" or spell == "Target_ChaosBolt_9") and number == 3 and (HasActiveStatus(caster,"CHAOS_BOLT_ACID") == 1 and HasActiveStatus(caster,"CHAOS_BOLT_COLD") == 1 and HasActiveStatus(caster,"CHAOS_BOLT_FIRE") == 1 or HasActiveStatus(caster,"CHAOS_BOLT_FORCE") == 1 or HasActiveStatus(caster,"CHAOS_BOLT_LIGHTNING") == 1 or HasActiveStatus(caster,"CHAOS_BOLT_POISON") == 1 or HasActiveStatus(caster,"CHAOS_BOLT_PSYCHIC") == 1 or HasActiveStatus(caster,"CHAOS_BOLT_THUNDER") == 1) then
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
	elseif	(spell == "Target_ChaosBolt" or spell == "Target_ChaosBolt_2" or spell == "Target_ChaosBolt_3" or spell == "Target_ChaosBolt_4" or spell == "Target_ChaosBolt_5" or spell == "Target_ChaosBolt_6" or spell == "Target_ChaosBolt_7" or spell == "Target_ChaosBolt_8" or spell == "Target_ChaosBolt_9") and number == 4 and (HasActiveStatus(caster,"CHAOS_BOLT_ACID") == 1 and HasActiveStatus(caster,"CHAOS_BOLT_COLD") == 1 and HasActiveStatus(caster,"CHAOS_BOLT_FIRE") == 1 or HasActiveStatus(caster,"CHAOS_BOLT_FORCE") == 1 or HasActiveStatus(caster,"CHAOS_BOLT_LIGHTNING") == 1 or HasActiveStatus(caster,"CHAOS_BOLT_POISON") == 1 or HasActiveStatus(caster,"CHAOS_BOLT_PSYCHIC") == 1 or HasActiveStatus(caster,"CHAOS_BOLT_THUNDER") == 1) then
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
	elseif	(spell == "Target_ChaosBolt" or spell == "Target_ChaosBolt_2" or spell == "Target_ChaosBolt_3" or spell == "Target_ChaosBolt_4" or spell == "Target_ChaosBolt_5" or spell == "Target_ChaosBolt_6" or spell == "Target_ChaosBolt_7" or spell == "Target_ChaosBolt_8" or spell == "Target_ChaosBolt_9") and number == 5 and (HasActiveStatus(caster,"CHAOS_BOLT_ACID") == 1 and HasActiveStatus(caster,"CHAOS_BOLT_COLD") == 1 and HasActiveStatus(caster,"CHAOS_BOLT_FIRE") == 1 or HasActiveStatus(caster,"CHAOS_BOLT_FORCE") == 1 or HasActiveStatus(caster,"CHAOS_BOLT_LIGHTNING") == 1 or HasActiveStatus(caster,"CHAOS_BOLT_POISON") == 1 or HasActiveStatus(caster,"CHAOS_BOLT_PSYCHIC") == 1 or HasActiveStatus(caster,"CHAOS_BOLT_THUNDER") == 1) then
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
	elseif	(spell == "Target_ChaosBolt" or spell == "Target_ChaosBolt_2" or spell == "Target_ChaosBolt_3" or spell == "Target_ChaosBolt_4" or spell == "Target_ChaosBolt_5" or spell == "Target_ChaosBolt_6" or spell == "Target_ChaosBolt_7" or spell == "Target_ChaosBolt_8" or spell == "Target_ChaosBolt_9") and number == 6 and (HasActiveStatus(caster,"CHAOS_BOLT_ACID") == 1 and HasActiveStatus(caster,"CHAOS_BOLT_COLD") == 1 and HasActiveStatus(caster,"CHAOS_BOLT_FIRE") == 1 or HasActiveStatus(caster,"CHAOS_BOLT_FORCE") == 1 or HasActiveStatus(caster,"CHAOS_BOLT_LIGHTNING") == 1 or HasActiveStatus(caster,"CHAOS_BOLT_POISON") == 1 or HasActiveStatus(caster,"CHAOS_BOLT_PSYCHIC") == 1 or HasActiveStatus(caster,"CHAOS_BOLT_THUNDER") == 1) then
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
	elseif	(spell == "Target_ChaosBolt" or spell == "Target_ChaosBolt_2" or spell == "Target_ChaosBolt_3" or spell == "Target_ChaosBolt_4" or spell == "Target_ChaosBolt_5" or spell == "Target_ChaosBolt_6" or spell == "Target_ChaosBolt_7" or spell == "Target_ChaosBolt_8" or spell == "Target_ChaosBolt_9") and number == 7 and (HasActiveStatus(caster,"CHAOS_BOLT_ACID") == 1 and HasActiveStatus(caster,"CHAOS_BOLT_COLD") == 1 and HasActiveStatus(caster,"CHAOS_BOLT_FIRE") == 1 or HasActiveStatus(caster,"CHAOS_BOLT_FORCE") == 1 or HasActiveStatus(caster,"CHAOS_BOLT_LIGHTNING") == 1 or HasActiveStatus(caster,"CHAOS_BOLT_POISON") == 1 or HasActiveStatus(caster,"CHAOS_BOLT_PSYCHIC") == 1 or HasActiveStatus(caster,"CHAOS_BOLT_THUNDER") == 1) then
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
	if	(spell == "Target_ChaosBolt" or spell == "Target_ChaosBolt_2" or spell == "Target_ChaosBolt_3" or spell == "Target_ChaosBolt_4" or spell == "Target_ChaosBolt_5" or spell == "Target_ChaosBolt_6" or spell == "Target_ChaosBolt_7" or spell == "Target_ChaosBolt_8" or spell == "Target_ChaosBolt_9") and ran == 0 and HasActiveStatus(target,"CHAOS_BOLT_ACID") == 0 and HasActiveStatus(target,"CHAOS_BOLT_COLD") == 0 and HasActiveStatus(target,"CHAOS_BOLT_FIRE") == 0 and HasActiveStatus(target,"CHAOS_BOLT_FORCE") == 0 and HasActiveStatus(target,"CHAOS_BOLT_LIGHTNING") == 0 and HasActiveStatus(target,"CHAOS_BOLT_POISON") == 0 and HasActiveStatus(target,"CHAOS_BOLT_PSYCHIC") == 0 and HasActiveStatus(target,"CHAOS_BOLT_THUNDER") == 0 then
		Osi.ApplyStatus(target, "CHAOS_BOLT_ACID",6.0,1,caster)
		Osi.SetVarInteger(caster,"RandomNumbe2r",ran)
	elseif	(spell == "Target_ChaosBolt" or spell == "Target_ChaosBolt_2" or spell == "Target_ChaosBolt_3" or spell == "Target_ChaosBolt_4" or spell == "Target_ChaosBolt_5" or spell == "Target_ChaosBolt_6" or spell == "Target_ChaosBolt_7" or spell == "Target_ChaosBolt_8" or spell == "Target_ChaosBolt_9") and ran == 1 and HasActiveStatus(target,"CHAOS_BOLT_ACID") == 0 and HasActiveStatus(target,"CHAOS_BOLT_COLD") == 0 and HasActiveStatus(target,"CHAOS_BOLT_FIRE") == 0 and HasActiveStatus(target,"CHAOS_BOLT_FORCE") == 0 and HasActiveStatus(target,"CHAOS_BOLT_LIGHTNING") == 0 and HasActiveStatus(target,"CHAOS_BOLT_POISON") == 0 and HasActiveStatus(target,"CHAOS_BOLT_PSYCHIC") == 0 and HasActiveStatus(target,"CHAOS_BOLT_THUNDER") == 0 then
		Osi.ApplyStatus(target, "CHAOS_BOLT_COLD",6.0,1,caster)
		Osi.SetVarInteger(caster,"RandomNumbe2r",ran)
	elseif	(spell == "Target_ChaosBolt" or spell == "Target_ChaosBolt_2" or spell == "Target_ChaosBolt_3" or spell == "Target_ChaosBolt_4" or spell == "Target_ChaosBolt_5" or spell == "Target_ChaosBolt_6" or spell == "Target_ChaosBolt_7" or spell == "Target_ChaosBolt_8" or spell == "Target_ChaosBolt_9") and ran == 2 and HasActiveStatus(target,"CHAOS_BOLT_ACID") == 0 and HasActiveStatus(target,"CHAOS_BOLT_COLD") == 0 and HasActiveStatus(target,"CHAOS_BOLT_FIRE") == 0 and HasActiveStatus(target,"CHAOS_BOLT_FORCE") == 0 and HasActiveStatus(target,"CHAOS_BOLT_LIGHTNING") == 0 and HasActiveStatus(target,"CHAOS_BOLT_POISON") == 0 and HasActiveStatus(target,"CHAOS_BOLT_PSYCHIC") == 0 and HasActiveStatus(target,"CHAOS_BOLT_THUNDER") == 0 then
		Osi.ApplyStatus(target, "CHAOS_BOLT_FIRE",6.0,1,caster)
		Osi.SetVarInteger(caster,"RandomNumbe2r",ran)
	elseif	(spell == "Target_ChaosBolt" or spell == "Target_ChaosBolt_2" or spell == "Target_ChaosBolt_3" or spell == "Target_ChaosBolt_4" or spell == "Target_ChaosBolt_5" or spell == "Target_ChaosBolt_6" or spell == "Target_ChaosBolt_7" or spell == "Target_ChaosBolt_8" or spell == "Target_ChaosBolt_9") and ran == 3 and HasActiveStatus(target,"CHAOS_BOLT_ACID") == 0 and HasActiveStatus(target,"CHAOS_BOLT_COLD") == 0 and HasActiveStatus(target,"CHAOS_BOLT_FIRE") == 0 and HasActiveStatus(target,"CHAOS_BOLT_FORCE") == 0 and HasActiveStatus(target,"CHAOS_BOLT_LIGHTNING") == 0 and HasActiveStatus(target,"CHAOS_BOLT_POISON") == 0 and HasActiveStatus(target,"CHAOS_BOLT_PSYCHIC") == 0 and HasActiveStatus(target,"CHAOS_BOLT_THUNDER") == 0 then
		Osi.ApplyStatus(target, "CHAOS_BOLT_FORCE",6.0,1,caster)
		Osi.SetVarInteger(caster,"RandomNumbe2r",ran)
	elseif	(spell == "Target_ChaosBolt" or spell == "Target_ChaosBolt_2" or spell == "Target_ChaosBolt_3" or spell == "Target_ChaosBolt_4" or spell == "Target_ChaosBolt_5" or spell == "Target_ChaosBolt_6" or spell == "Target_ChaosBolt_7" or spell == "Target_ChaosBolt_8" or spell == "Target_ChaosBolt_9") and ran == 4 and HasActiveStatus(target,"CHAOS_BOLT_ACID") == 0 and HasActiveStatus(target,"CHAOS_BOLT_COLD") == 0 and HasActiveStatus(target,"CHAOS_BOLT_FIRE") == 0 and HasActiveStatus(target,"CHAOS_BOLT_FORCE") == 0 and HasActiveStatus(target,"CHAOS_BOLT_LIGHTNING") == 0 and HasActiveStatus(target,"CHAOS_BOLT_POISON") == 0 and HasActiveStatus(target,"CHAOS_BOLT_PSYCHIC") == 0 and HasActiveStatus(target,"CHAOS_BOLT_THUNDER") == 0 then
		Osi.ApplyStatus(target, "CHAOS_BOLT_LIGHTNING",6.0,1,caster)
		Osi.SetVarInteger(caster,"RandomNumbe2r",ran)
	elseif	(spell == "Target_ChaosBolt" or spell == "Target_ChaosBolt_2" or spell == "Target_ChaosBolt_3" or spell == "Target_ChaosBolt_4" or spell == "Target_ChaosBolt_5" or spell == "Target_ChaosBolt_6" or spell == "Target_ChaosBolt_7" or spell == "Target_ChaosBolt_8" or spell == "Target_ChaosBolt_9") and ran == 5 and HasActiveStatus(target,"CHAOS_BOLT_ACID") == 0 and HasActiveStatus(target,"CHAOS_BOLT_COLD") == 0 and HasActiveStatus(target,"CHAOS_BOLT_FIRE") == 0 and HasActiveStatus(target,"CHAOS_BOLT_FORCE") == 0 and HasActiveStatus(target,"CHAOS_BOLT_LIGHTNING") == 0 and HasActiveStatus(target,"CHAOS_BOLT_POISON") == 0 and HasActiveStatus(target,"CHAOS_BOLT_PSYCHIC") == 0 and HasActiveStatus(target,"CHAOS_BOLT_THUNDER") == 0 then
		Osi.ApplyStatus(target, "CHAOS_BOLT_POISON",6.0,1,caster)
		Osi.SetVarInteger(caster,"RandomNumbe2r",ran)
	elseif	(spell == "Target_ChaosBolt" or spell == "Target_ChaosBolt_2" or spell == "Target_ChaosBolt_3" or spell == "Target_ChaosBolt_4" or spell == "Target_ChaosBolt_5" or spell == "Target_ChaosBolt_6" or spell == "Target_ChaosBolt_7" or spell == "Target_ChaosBolt_8" or spell == "Target_ChaosBolt_9") and ran == 6 and HasActiveStatus(target,"CHAOS_BOLT_ACID") == 0 and HasActiveStatus(target,"CHAOS_BOLT_COLD") == 0 and HasActiveStatus(target,"CHAOS_BOLT_FIRE") == 0 and HasActiveStatus(target,"CHAOS_BOLT_FORCE") == 0 and HasActiveStatus(target,"CHAOS_BOLT_LIGHTNING") == 0 and HasActiveStatus(target,"CHAOS_BOLT_POISON") == 0 and HasActiveStatus(target,"CHAOS_BOLT_PSYCHIC") == 0 and HasActiveStatus(target,"CHAOS_BOLT_THUNDER") == 0 then
		Osi.ApplyStatus(target, "CHAOS_BOLT_PSYCHIC",6.0,1,caster)
		Osi.SetVarInteger(caster,"RandomNumbe2r",ran)
	elseif	(spell == "Target_ChaosBolt" or spell == "Target_ChaosBolt_2" or spell == "Target_ChaosBolt_3" or spell == "Target_ChaosBolt_4" or spell == "Target_ChaosBolt_5" or spell == "Target_ChaosBolt_6" or spell == "Target_ChaosBolt_7" or spell == "Target_ChaosBolt_8" or spell == "Target_ChaosBolt_9") and ran == 7 and HasActiveStatus(target,"CHAOS_BOLT_ACID") == 0 and HasActiveStatus(target,"CHAOS_BOLT_COLD") == 0 and HasActiveStatus(target,"CHAOS_BOLT_FIRE") == 0 and HasActiveStatus(target,"CHAOS_BOLT_FORCE") == 0 and HasActiveStatus(target,"CHAOS_BOLT_LIGHTNING") == 0 and HasActiveStatus(target,"CHAOS_BOLT_POISON") == 0 and HasActiveStatus(target,"CHAOS_BOLT_PSYCHIC") == 0 and HasActiveStatus(target,"CHAOS_BOLT_THUNDER") == 0 then
		Osi.ApplyStatus(target, "CHAOS_BOLT_THUNDER",6.0,1,caster)
		Osi.SetVarInteger(caster,"RandomNumbe2r",ran)
	elseif	(spell == "Target_ChaosBolt" or spell == "Target_ChaosBolt_2" or spell == "Target_ChaosBolt_3" or spell == "Target_ChaosBolt_4" or spell == "Target_ChaosBolt_5" or spell == "Target_ChaosBolt_6" or spell == "Target_ChaosBolt_7" or spell == "Target_ChaosBolt_8" or spell == "Target_ChaosBolt_9") and ran == 0 and (HasActiveStatus(target,"CHAOS_BOLT_ACID") == 1 and HasActiveStatus(target,"CHAOS_BOLT_COLD") == 1 and HasActiveStatus(target,"CHAOS_BOLT_FIRE") == 1 or HasActiveStatus(target,"CHAOS_BOLT_FORCE") == 1 or HasActiveStatus(target,"CHAOS_BOLT_LIGHTNING") == 1 or HasActiveStatus(target,"CHAOS_BOLT_POISON") == 1 or HasActiveStatus(target,"CHAOS_BOLT_PSYCHIC") == 1 or HasActiveStatus(target,"CHAOS_BOLT_THUNDER") == 1) then
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
	elseif	(spell == "Target_ChaosBolt" or spell == "Target_ChaosBolt_2" or spell == "Target_ChaosBolt_3" or spell == "Target_ChaosBolt_4" or spell == "Target_ChaosBolt_5" or spell == "Target_ChaosBolt_6" or spell == "Target_ChaosBolt_7" or spell == "Target_ChaosBolt_8" or spell == "Target_ChaosBolt_9") and ran == 1 and (HasActiveStatus(target,"CHAOS_BOLT_ACID") == 1 and HasActiveStatus(target,"CHAOS_BOLT_COLD") == 1 and HasActiveStatus(target,"CHAOS_BOLT_FIRE") == 1 or HasActiveStatus(target,"CHAOS_BOLT_FORCE") == 1 or HasActiveStatus(target,"CHAOS_BOLT_LIGHTNING") == 1 or HasActiveStatus(target,"CHAOS_BOLT_POISON") == 1 or HasActiveStatus(target,"CHAOS_BOLT_PSYCHIC") == 1 or HasActiveStatus(target,"CHAOS_BOLT_THUNDER") == 1) then
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
	elseif	(spell == "Target_ChaosBolt" or spell == "Target_ChaosBolt_2" or spell == "Target_ChaosBolt_3" or spell == "Target_ChaosBolt_4" or spell == "Target_ChaosBolt_5" or spell == "Target_ChaosBolt_6" or spell == "Target_ChaosBolt_7" or spell == "Target_ChaosBolt_8" or spell == "Target_ChaosBolt_9") and ran == 2 and (HasActiveStatus(target,"CHAOS_BOLT_ACID") == 1 and HasActiveStatus(target,"CHAOS_BOLT_COLD") == 1 and HasActiveStatus(target,"CHAOS_BOLT_FIRE") == 1 or HasActiveStatus(target,"CHAOS_BOLT_FORCE") == 1 or HasActiveStatus(target,"CHAOS_BOLT_LIGHTNING") == 1 or HasActiveStatus(target,"CHAOS_BOLT_POISON") == 1 or HasActiveStatus(target,"CHAOS_BOLT_PSYCHIC") == 1 or HasActiveStatus(target,"CHAOS_BOLT_THUNDER") == 1) then
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
	elseif	(spell == "Target_ChaosBolt" or spell == "Target_ChaosBolt_2" or spell == "Target_ChaosBolt_3" or spell == "Target_ChaosBolt_4" or spell == "Target_ChaosBolt_5" or spell == "Target_ChaosBolt_6" or spell == "Target_ChaosBolt_7" or spell == "Target_ChaosBolt_8" or spell == "Target_ChaosBolt_9") and ran == 3 and (HasActiveStatus(target,"CHAOS_BOLT_ACID") == 1 and HasActiveStatus(target,"CHAOS_BOLT_COLD") == 1 and HasActiveStatus(target,"CHAOS_BOLT_FIRE") == 1 or HasActiveStatus(target,"CHAOS_BOLT_FORCE") == 1 or HasActiveStatus(target,"CHAOS_BOLT_LIGHTNING") == 1 or HasActiveStatus(target,"CHAOS_BOLT_POISON") == 1 or HasActiveStatus(target,"CHAOS_BOLT_PSYCHIC") == 1 or HasActiveStatus(target,"CHAOS_BOLT_THUNDER") == 1) then
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
	elseif	(spell == "Target_ChaosBolt" or spell == "Target_ChaosBolt_2" or spell == "Target_ChaosBolt_3" or spell == "Target_ChaosBolt_4" or spell == "Target_ChaosBolt_5" or spell == "Target_ChaosBolt_6" or spell == "Target_ChaosBolt_7" or spell == "Target_ChaosBolt_8" or spell == "Target_ChaosBolt_9") and ran == 4 and (HasActiveStatus(target,"CHAOS_BOLT_ACID") == 1 and HasActiveStatus(target,"CHAOS_BOLT_COLD") == 1 and HasActiveStatus(target,"CHAOS_BOLT_FIRE") == 1 or HasActiveStatus(target,"CHAOS_BOLT_FORCE") == 1 or HasActiveStatus(target,"CHAOS_BOLT_LIGHTNING") == 1 or HasActiveStatus(target,"CHAOS_BOLT_POISON") == 1 or HasActiveStatus(target,"CHAOS_BOLT_PSYCHIC") == 1 or HasActiveStatus(target,"CHAOS_BOLT_THUNDER") == 1) then
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
	elseif	(spell == "Target_ChaosBolt" or spell == "Target_ChaosBolt_2" or spell == "Target_ChaosBolt_3" or spell == "Target_ChaosBolt_4" or spell == "Target_ChaosBolt_5" or spell == "Target_ChaosBolt_6" or spell == "Target_ChaosBolt_7" or spell == "Target_ChaosBolt_8" or spell == "Target_ChaosBolt_9") and ran == 5 and (HasActiveStatus(target,"CHAOS_BOLT_ACID") == 1 and HasActiveStatus(target,"CHAOS_BOLT_COLD") == 1 and HasActiveStatus(target,"CHAOS_BOLT_FIRE") == 1 or HasActiveStatus(target,"CHAOS_BOLT_FORCE") == 1 or HasActiveStatus(target,"CHAOS_BOLT_LIGHTNING") == 1 or HasActiveStatus(target,"CHAOS_BOLT_POISON") == 1 or HasActiveStatus(target,"CHAOS_BOLT_PSYCHIC") == 1 or HasActiveStatus(target,"CHAOS_BOLT_THUNDER") == 1) then
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
	elseif	(spell == "Target_ChaosBolt" or spell == "Target_ChaosBolt_2" or spell == "Target_ChaosBolt_3" or spell == "Target_ChaosBolt_4" or spell == "Target_ChaosBolt_5" or spell == "Target_ChaosBolt_6" or spell == "Target_ChaosBolt_7" or spell == "Target_ChaosBolt_8" or spell == "Target_ChaosBolt_9") and ran == 6 and (HasActiveStatus(target,"CHAOS_BOLT_ACID") == 1 and HasActiveStatus(target,"CHAOS_BOLT_COLD") == 1 and HasActiveStatus(target,"CHAOS_BOLT_FIRE") == 1 or HasActiveStatus(target,"CHAOS_BOLT_FORCE") == 1 or HasActiveStatus(target,"CHAOS_BOLT_LIGHTNING") == 1 or HasActiveStatus(target,"CHAOS_BOLT_POISON") == 1 or HasActiveStatus(target,"CHAOS_BOLT_PSYCHIC") == 1 or HasActiveStatus(target,"CHAOS_BOLT_THUNDER") == 1) then
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
	elseif	(spell == "Target_ChaosBolt" or spell == "Target_ChaosBolt_2" or spell == "Target_ChaosBolt_3" or spell == "Target_ChaosBolt_4" or spell == "Target_ChaosBolt_5" or spell == "Target_ChaosBolt_6" or spell == "Target_ChaosBolt_7" or spell == "Target_ChaosBolt_8" or spell == "Target_ChaosBolt_9") and ran == 7 and (HasActiveStatus(target,"CHAOS_BOLT_ACID") == 1 and HasActiveStatus(target,"CHAOS_BOLT_COLD") == 1 and HasActiveStatus(target,"CHAOS_BOLT_FIRE") == 1 or HasActiveStatus(target,"CHAOS_BOLT_FORCE") == 1 or HasActiveStatus(target,"CHAOS_BOLT_LIGHTNING") == 1 or HasActiveStatus(target,"CHAOS_BOLT_POISON") == 1 or HasActiveStatus(target,"CHAOS_BOLT_PSYCHIC") == 1 or HasActiveStatus(target,"CHAOS_BOLT_THUNDER") == 1) then
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
Ext.Osiris.RegisterListener("GoldChanged", 2, "after", function (character, _)
	local amt = GetGold(character)
	if Osi.HasSpell(character,"Target_Ceremony") == 1 and amt > 24 and Osi.HasActiveStatus(character,"CEREMONY_GOLD_COST") == 0 then
		Osi.ApplyStatus(character,"CEREMONY_GOLD_COST",-1.0,1,character)
	elseif Osi.HasSpell(character,"Target_Ceremony") == 1 and amt < 25 and Osi.HasActiveStatus(character,"CEREMONY_GOLD_COST") == 1 then
		Osi.RemoveStatus(character,"CEREMONY_GOLD_COST")
    end
end)

-- Gold Removal
Ext.Osiris.RegisterListener("UsingSpell", 5, "after", function (caster, spell, _, _, _)
	if spell == "Target_Ceremony_BlessWater" or spell == "Target_Ceremony_ComingOfAge" or spell == "Target_Ceremony_Dedication" or spell == "Target_Ceremony_BlessWater_2" or spell == "Target_Ceremony_ComingOfAge_2" or spell == "Target_Ceremony_Dedication_2" or spell == "Target_Ceremony_BlessWater_3" or spell == "Target_Ceremony_ComingOfAge_3" or spell == "Target_Ceremony_Dedication_3" or spell == "Target_Ceremony_BlessWater_4" or spell == "Target_Ceremony_ComingOfAge_4" or spell == "Target_Ceremony_Dedication_4" or spell == "Target_Ceremony_BlessWater_5" or spell == "Target_Ceremony_ComingOfAge_5" or spell == "Target_Ceremony_Dedication_5" or spell == "Target_Ceremony_BlessWater_6" or spell == "Target_Ceremony_ComingOfAge_6" or spell == "Target_Ceremony_Dedication_6" or spell == "Target_Ceremony_BlessWater_7" or spell == "Target_Ceremony_ComingOfAge_7" or spell == "Target_Ceremony_Dedication_7" or spell == "Target_Ceremony_BlessWater_8" or spell == "Target_Ceremony_ComingOfAge_8" or spell == "Target_Ceremony_Dedication_8" or spell == "Target_Ceremony_BlessWater_9" or spell == "Target_Ceremony_ComingOfAge_9" or spell == "Target_Ceremony_Dedication_9" then
		Osi.AddGold(caster, -25)
		Osi.ApplyStatus(caster, "CEREMONY_GOLD_COST_PROC",0.0,1,caster)
    end
end)

-- Gold Check after Removal
Ext.Osiris.RegisterListener("StatusApplied", 4, "after", function (character, status, _, _)
	local amt = GetGold(character)
	if status == "CEREMONY_GOLD_COST_PROC" and amt > 24 and Osi.HasActiveStatus(character,"CEREMONY_GOLD_COST") == 0 then
		Osi.ApplyStatus(character,"CEREMONY_GOLD_COST",-1.0,1,character)
	elseif status == "CEREMONY_GOLD_COST_PROC" and amt < 25 and Osi.HasActiveStatus(character,"CEREMONY_GOLD_COST") == 1 then
		Osi.RemoveStatus(character,"CEREMONY_GOLD_COST")
    end
end)

-- Ceremony Bless Water Part 1
Ext.Osiris.RegisterListener("TemplateAddedTo", 4, "after", function (template, _, character, _)
	if	(template == "CONS_Drink_Water_A_640302a8-d841-44d6-996d-2addda644306" or template == "CONS_Drink_Water_A_Wicker_00253e1b-375c-4ef4-8808-974cab615ff7" or template == "CONS_Drink_Water_Bottle_A_d8fff9cf-05b9-4aeb-b5b4-0f6bb98b7f2c" or template == "CONS_Drink_Water_B_Wicker_e8e427ac-9078-4471-85f2-4b8bbc3e00b5" or template == "CONS_Drink_Water_Bottle_B_6f5abf98-cca0-43a7-a064-10c17643bb72" or template == "CONS_Drink_Water_B_94f1d6d2-8a70-4ab9-a8cf-376dd0bc294a" or template == "CONS_Drink_Water_Jug_A_cb2e851f-8a75-4899-b705-0f079e8e55bc") and Osi.HasSpell(character,"Target_Ceremony") == 1 and HasActiveStatus(character,"CEREMONY_BLESSED_WATER_TECHNICAL") == 0 then
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
	if	Osi.HasSpell(character,"Target_Ceremony") == 1 and HasActiveStatus(character,"CEREMONY_BLESSED_WATER_TECHNICAL") == 1 and not (item or item2 or item3 or item4 or item5 or item6 or item7) then
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
--		Osi.ShowNotification(character, "Works")
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

-- Nathair's Mischief
Ext.Osiris.RegisterListener("StatusApplied", 4, "after", function (item, status, causee, _)
	if	status == "NATHAIRS_MISCHIEF_EFFECT" then
		local number = Random(4)
--		local num = IntegerToString(number)
--		Osi.ShowNotification(causee,num)
		if	number == 0 then
			Osi.ApplyStatus(item, "NATHAIRS_MISCHIEF_CHARMED_EFFECT", 6.0, 1, causee)
		elseif	number == 1 then
			Osi.ApplyStatus(item, "NATHAIRS_MISCHIEF_BLINDED_EFFECT", 6.0, 1, causee)
		elseif	number == 2 then
			Osi.ApplyStatus(item, "NATHAIRS_MISCHIEF_INCAPACITATED_EFFECT", 6.0, 1, causee)
		elseif	number == 3 then
			Osi.ApplyStatus(item, "NATHAIRS_MISCHIEF_DIFFICULT_TERRAIN_EFFECT", 6.0, 1, causee)
		end
    end
end)

-- Life Transference Setup
Ext.Osiris.RegisterListener("UsingSpell", 5, "before", function (caster, spell, _, _, _)
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
		local targethp = GetHitpoints(character)
--		local num = IntegerToString(previoushp)
--		Osi.ShowNotification(causee,num)
		local hp = 0
		local newhp = 0
		hp = previoushp - currenthp
		hp = hp * 2
--		Osi.SetHitpoints(character, hp, "Vitality")
		newhp = targethp + hp
		if hp == 2 then
			Osi.ApplyStatus(character, "LIFE_TRANSFERENCE_HP_2", 0.0, 1, causee)
		elseif hp == 4 then
			Osi.ApplyStatus(character, "LIFE_TRANSFERENCE_HP_4", 0.0, 1, causee)
		elseif hp == 6 then
			Osi.ApplyStatus(character, "LIFE_TRANSFERENCE_HP_6", 0.0, 1, causee)
		elseif hp == 8 then
			Osi.ApplyStatus(character, "LIFE_TRANSFERENCE_HP_8", 0.0, 1, causee)
		elseif hp == 10 then
			Osi.ApplyStatus(character, "LIFE_TRANSFERENCE_HP_10", 0.0, 1, causee)
		elseif hp == 12 then
			Osi.ApplyStatus(character, "LIFE_TRANSFERENCE_HP_12", 0.0, 1, causee)
		elseif hp == 14 then
			Osi.ApplyStatus(character, "LIFE_TRANSFERENCE_HP_14", 0.0, 1, causee)
		elseif hp == 16 then
			Osi.ApplyStatus(character, "LIFE_TRANSFERENCE_HP_16", 0.0, 1, causee)
		elseif hp == 18 then
			Osi.ApplyStatus(character, "LIFE_TRANSFERENCE_HP_18", 0.0, 1, causee)
		elseif hp == 20 then
			Osi.ApplyStatus(character, "LIFE_TRANSFERENCE_HP_20", 0.0, 1, causee)
		elseif hp == 22 then
			Osi.ApplyStatus(character, "LIFE_TRANSFERENCE_HP_22", 0.0, 1, causee)
		elseif hp == 24 then
			Osi.ApplyStatus(character, "LIFE_TRANSFERENCE_HP_24", 0.0, 1, causee)
		elseif hp == 26 then
			Osi.ApplyStatus(character, "LIFE_TRANSFERENCE_HP_26", 0.0, 1, causee)
		elseif hp == 28 then
			Osi.ApplyStatus(character, "LIFE_TRANSFERENCE_HP_28", 0.0, 1, causee)
		elseif hp == 30 then
			Osi.ApplyStatus(character, "LIFE_TRANSFERENCE_HP_30", 0.0, 1, causee)
		elseif hp == 32 then
			Osi.ApplyStatus(character, "LIFE_TRANSFERENCE_HP_32", 0.0, 1, causee)
		elseif hp == 34 then
			Osi.ApplyStatus(character, "LIFE_TRANSFERENCE_HP_34", 0.0, 1, causee)
		elseif hp == 36 then
			Osi.ApplyStatus(character, "LIFE_TRANSFERENCE_HP_36", 0.0, 1, causee)
		elseif hp == 38 then
			Osi.ApplyStatus(character, "LIFE_TRANSFERENCE_HP_38", 0.0, 1, causee)
		elseif hp == 40 then
			Osi.ApplyStatus(character, "LIFE_TRANSFERENCE_HP_40", 0.0, 1, causee)
		elseif hp == 42 then
			Osi.ApplyStatus(character, "LIFE_TRANSFERENCE_HP_42", 0.0, 1, causee)
		elseif hp == 44 then
			Osi.ApplyStatus(character, "LIFE_TRANSFERENCE_HP_44", 0.0, 1, causee)
		elseif hp == 46 then
			Osi.ApplyStatus(character, "LIFE_TRANSFERENCE_HP_46", 0.0, 1, causee)
		elseif hp == 48 then
			Osi.ApplyStatus(character, "LIFE_TRANSFERENCE_HP_48", 0.0, 1, causee)
		elseif hp == 50 then
			Osi.ApplyStatus(character, "LIFE_TRANSFERENCE_HP_50", 0.0, 1, causee)
		elseif hp == 52 then
			Osi.ApplyStatus(character, "LIFE_TRANSFERENCE_HP_52", 0.0, 1, causee)
		elseif hp == 54 then
			Osi.ApplyStatus(character, "LIFE_TRANSFERENCE_HP_54", 0.0, 1, causee)
		elseif hp == 56 then
			Osi.ApplyStatus(character, "LIFE_TRANSFERENCE_HP_56", 0.0, 1, causee)
		elseif hp == 58 then
			Osi.ApplyStatus(character, "LIFE_TRANSFERENCE_HP_58", 0.0, 1, causee)
		elseif hp == 60 then
			Osi.ApplyStatus(character, "LIFE_TRANSFERENCE_HP_60", 0.0, 1, causee)
		elseif hp == 62 then
			Osi.ApplyStatus(character, "LIFE_TRANSFERENCE_HP_62", 0.0, 1, causee)
		elseif hp == 64 then
			Osi.ApplyStatus(character, "LIFE_TRANSFERENCE_HP_64", 0.0, 1, causee)
		end
	elseif status == "LIFE_TRANSFERENCE_4" then
		local previoushp = GetVarInteger(causee, "BeforeHP")
		local currenthp = GetHitpoints(causee)
		local targethp = GetHitpoints(character)
		local hp = 0
		local newhp = 0
		hp = previoushp - currenthp
		hp = hp * 2
		newhp = targethp + hp
		if hp == 2 then
			Osi.ApplyStatus(character, "LIFE_TRANSFERENCE_HP_4TH_2", 0.0, 1, causee)
		elseif hp == 4 then
			Osi.ApplyStatus(character, "LIFE_TRANSFERENCE_HP_4TH_4", 0.0, 1, causee)
		elseif hp == 6 then
			Osi.ApplyStatus(character, "LIFE_TRANSFERENCE_HP_4TH_6", 0.0, 1, causee)
		elseif hp == 8 then
			Osi.ApplyStatus(character, "LIFE_TRANSFERENCE_HP_4TH_8", 0.0, 1, causee)
		elseif hp == 10 then
			Osi.ApplyStatus(character, "LIFE_TRANSFERENCE_HP_4TH_10", 0.0, 1, causee)
		elseif hp == 12 then
			Osi.ApplyStatus(character, "LIFE_TRANSFERENCE_HP_4TH_12", 0.0, 1, causee)
		elseif hp == 14 then
			Osi.ApplyStatus(character, "LIFE_TRANSFERENCE_HP_4TH_14", 0.0, 1, causee)
		elseif hp == 16 then
			Osi.ApplyStatus(character, "LIFE_TRANSFERENCE_HP_4TH_16", 0.0, 1, causee)
		elseif hp == 18 then
			Osi.ApplyStatus(character, "LIFE_TRANSFERENCE_HP_4TH_18", 0.0, 1, causee)
		elseif hp == 20 then
			Osi.ApplyStatus(character, "LIFE_TRANSFERENCE_HP_4TH_20", 0.0, 1, causee)
		elseif hp == 22 then
			Osi.ApplyStatus(character, "LIFE_TRANSFERENCE_HP_4TH_22", 0.0, 1, causee)
		elseif hp == 24 then
			Osi.ApplyStatus(character, "LIFE_TRANSFERENCE_HP_4TH_24", 0.0, 1, causee)
		elseif hp == 26 then
			Osi.ApplyStatus(character, "LIFE_TRANSFERENCE_HP_4TH_26", 0.0, 1, causee)
		elseif hp == 28 then
			Osi.ApplyStatus(character, "LIFE_TRANSFERENCE_HP_4TH_28", 0.0, 1, causee)
		elseif hp == 30 then
			Osi.ApplyStatus(character, "LIFE_TRANSFERENCE_HP_4TH_30", 0.0, 1, causee)
		elseif hp == 32 then
			Osi.ApplyStatus(character, "LIFE_TRANSFERENCE_HP_4TH_32", 0.0, 1, causee)
		elseif hp == 34 then
			Osi.ApplyStatus(character, "LIFE_TRANSFERENCE_HP_4TH_34", 0.0, 1, causee)
		elseif hp == 36 then
			Osi.ApplyStatus(character, "LIFE_TRANSFERENCE_HP_4TH_36", 0.0, 1, causee)
		elseif hp == 38 then
			Osi.ApplyStatus(character, "LIFE_TRANSFERENCE_HP_4TH_38", 0.0, 1, causee)
		elseif hp == 40 then
			Osi.ApplyStatus(character, "LIFE_TRANSFERENCE_HP_4TH_40", 0.0, 1, causee)
		elseif hp == 42 then
			Osi.ApplyStatus(character, "LIFE_TRANSFERENCE_HP_4TH_42", 0.0, 1, causee)
		elseif hp == 44 then
			Osi.ApplyStatus(character, "LIFE_TRANSFERENCE_HP_4TH_44", 0.0, 1, causee)
		elseif hp == 46 then
			Osi.ApplyStatus(character, "LIFE_TRANSFERENCE_HP_4TH_46", 0.0, 1, causee)
		elseif hp == 48 then
			Osi.ApplyStatus(character, "LIFE_TRANSFERENCE_HP_4TH_48", 0.0, 1, causee)
		elseif hp == 50 then
			Osi.ApplyStatus(character, "LIFE_TRANSFERENCE_HP_4TH_50", 0.0, 1, causee)
		elseif hp == 52 then
			Osi.ApplyStatus(character, "LIFE_TRANSFERENCE_HP_4TH_52", 0.0, 1, causee)
		elseif hp == 54 then
			Osi.ApplyStatus(character, "LIFE_TRANSFERENCE_HP_4TH_54", 0.0, 1, causee)
		elseif hp == 56 then
			Osi.ApplyStatus(character, "LIFE_TRANSFERENCE_HP_4TH_56", 0.0, 1, causee)
		elseif hp == 58 then
			Osi.ApplyStatus(character, "LIFE_TRANSFERENCE_HP_4TH_58", 0.0, 1, causee)
		elseif hp == 60 then
			Osi.ApplyStatus(character, "LIFE_TRANSFERENCE_HP_4TH_60", 0.0, 1, causee)
		elseif hp == 62 then
			Osi.ApplyStatus(character, "LIFE_TRANSFERENCE_HP_4TH_62", 0.0, 1, causee)
		elseif hp == 64 then
			Osi.ApplyStatus(character, "LIFE_TRANSFERENCE_HP_4TH_64", 0.0, 1, causee)
		elseif hp == 66 then
			Osi.ApplyStatus(character, "LIFE_TRANSFERENCE_HP_4TH_66", 0.0, 1, causee)
		elseif hp == 68 then
			Osi.ApplyStatus(character, "LIFE_TRANSFERENCE_HP_4TH_68", 0.0, 1, causee)
		elseif hp == 70 then
			Osi.ApplyStatus(character, "LIFE_TRANSFERENCE_HP_4TH_70", 0.0, 1, causee)
		elseif hp == 72 then
			Osi.ApplyStatus(character, "LIFE_TRANSFERENCE_HP_4TH_72", 0.0, 1, causee)
		elseif hp == 74 then
			Osi.ApplyStatus(character, "LIFE_TRANSFERENCE_HP_4TH_74", 0.0, 1, causee)
		elseif hp == 76 then
			Osi.ApplyStatus(character, "LIFE_TRANSFERENCE_HP_4TH_76", 0.0, 1, causee)
		elseif hp == 78 then
			Osi.ApplyStatus(character, "LIFE_TRANSFERENCE_HP_4TH_78", 0.0, 1, causee)
		elseif hp == 80 then
			Osi.ApplyStatus(character, "LIFE_TRANSFERENCE_HP_4TH_80", 0.0, 1, causee)
		end
	elseif status == "LIFE_TRANSFERENCE_5" then
		local previoushp = GetVarInteger(causee, "BeforeHP")
		local currenthp = GetHitpoints(causee)
		local targethp = GetHitpoints(character)
		local hp = 0
		local newhp = 0
		hp = previoushp - currenthp
		hp = hp * 2
		newhp = targethp + hp
		if hp == 2 then
			Osi.ApplyStatus(character, "LIFE_TRANSFERENCE_HP_5TH_2", 0.0, 1, causee)
		elseif hp == 4 then
			Osi.ApplyStatus(character, "LIFE_TRANSFERENCE_HP_5TH_4", 0.0, 1, causee)
		elseif hp == 6 then
			Osi.ApplyStatus(character, "LIFE_TRANSFERENCE_HP_5TH_6", 0.0, 1, causee)
		elseif hp == 8 then
			Osi.ApplyStatus(character, "LIFE_TRANSFERENCE_HP_5TH_8", 0.0, 1, causee)
		elseif hp == 10 then
			Osi.ApplyStatus(character, "LIFE_TRANSFERENCE_HP_5TH_10", 0.0, 1, causee)
		elseif hp == 12 then
			Osi.ApplyStatus(character, "LIFE_TRANSFERENCE_HP_5TH_12", 0.0, 1, causee)
		elseif hp == 14 then
			Osi.ApplyStatus(character, "LIFE_TRANSFERENCE_HP_5TH_14", 0.0, 1, causee)
		elseif hp == 16 then
			Osi.ApplyStatus(character, "LIFE_TRANSFERENCE_HP_5TH_16", 0.0, 1, causee)
		elseif hp == 18 then
			Osi.ApplyStatus(character, "LIFE_TRANSFERENCE_HP_5TH_18", 0.0, 1, causee)
		elseif hp == 20 then
			Osi.ApplyStatus(character, "LIFE_TRANSFERENCE_HP_5TH_20", 0.0, 1, causee)
		elseif hp == 22 then
			Osi.ApplyStatus(character, "LIFE_TRANSFERENCE_HP_5TH_22", 0.0, 1, causee)
		elseif hp == 24 then
			Osi.ApplyStatus(character, "LIFE_TRANSFERENCE_HP_5TH_24", 0.0, 1, causee)
		elseif hp == 26 then
			Osi.ApplyStatus(character, "LIFE_TRANSFERENCE_HP_5TH_26", 0.0, 1, causee)
		elseif hp == 28 then
			Osi.ApplyStatus(character, "LIFE_TRANSFERENCE_HP_5TH_28", 0.0, 1, causee)
		elseif hp == 30 then
			Osi.ApplyStatus(character, "LIFE_TRANSFERENCE_HP_5TH_30", 0.0, 1, causee)
		elseif hp == 32 then
			Osi.ApplyStatus(character, "LIFE_TRANSFERENCE_HP_5TH_32", 0.0, 1, causee)
		elseif hp == 34 then
			Osi.ApplyStatus(character, "LIFE_TRANSFERENCE_HP_5TH_34", 0.0, 1, causee)
		elseif hp == 36 then
			Osi.ApplyStatus(character, "LIFE_TRANSFERENCE_HP_5TH_36", 0.0, 1, causee)
		elseif hp == 38 then
			Osi.ApplyStatus(character, "LIFE_TRANSFERENCE_HP_5TH_38", 0.0, 1, causee)
		elseif hp == 40 then
			Osi.ApplyStatus(character, "LIFE_TRANSFERENCE_HP_5TH_40", 0.0, 1, causee)
		elseif hp == 42 then
			Osi.ApplyStatus(character, "LIFE_TRANSFERENCE_HP_5TH_42", 0.0, 1, causee)
		elseif hp == 44 then
			Osi.ApplyStatus(character, "LIFE_TRANSFERENCE_HP_5TH_44", 0.0, 1, causee)
		elseif hp == 46 then
			Osi.ApplyStatus(character, "LIFE_TRANSFERENCE_HP_5TH_46", 0.0, 1, causee)
		elseif hp == 48 then
			Osi.ApplyStatus(character, "LIFE_TRANSFERENCE_HP_5TH_48", 0.0, 1, causee)
		elseif hp == 50 then
			Osi.ApplyStatus(character, "LIFE_TRANSFERENCE_HP_5TH_50", 0.0, 1, causee)
		elseif hp == 52 then
			Osi.ApplyStatus(character, "LIFE_TRANSFERENCE_HP_5TH_52", 0.0, 1, causee)
		elseif hp == 54 then
			Osi.ApplyStatus(character, "LIFE_TRANSFERENCE_HP_5TH_54", 0.0, 1, causee)
		elseif hp == 56 then
			Osi.ApplyStatus(character, "LIFE_TRANSFERENCE_HP_5TH_56", 0.0, 1, causee)
		elseif hp == 58 then
			Osi.ApplyStatus(character, "LIFE_TRANSFERENCE_HP_5TH_58", 0.0, 1, causee)
		elseif hp == 60 then
			Osi.ApplyStatus(character, "LIFE_TRANSFERENCE_HP_5TH_60", 0.0, 1, causee)
		elseif hp == 62 then
			Osi.ApplyStatus(character, "LIFE_TRANSFERENCE_HP_5TH_62", 0.0, 1, causee)
		elseif hp == 64 then
			Osi.ApplyStatus(character, "LIFE_TRANSFERENCE_HP_5TH_64", 0.0, 1, causee)
		elseif hp == 66 then
			Osi.ApplyStatus(character, "LIFE_TRANSFERENCE_HP_5TH_66", 0.0, 1, causee)
		elseif hp == 68 then
			Osi.ApplyStatus(character, "LIFE_TRANSFERENCE_HP_5TH_68", 0.0, 1, causee)
		elseif hp == 70 then
			Osi.ApplyStatus(character, "LIFE_TRANSFERENCE_HP_5TH_70", 0.0, 1, causee)
		elseif hp == 72 then
			Osi.ApplyStatus(character, "LIFE_TRANSFERENCE_HP_5TH_72", 0.0, 1, causee)
		elseif hp == 74 then
			Osi.ApplyStatus(character, "LIFE_TRANSFERENCE_HP_5TH_74", 0.0, 1, causee)
		elseif hp == 76 then
			Osi.ApplyStatus(character, "LIFE_TRANSFERENCE_HP_5TH_76", 0.0, 1, causee)
		elseif hp == 78 then
			Osi.ApplyStatus(character, "LIFE_TRANSFERENCE_HP_5TH_78", 0.0, 1, causee)
		elseif hp == 80 then
			Osi.ApplyStatus(character, "LIFE_TRANSFERENCE_HP_5TH_80", 0.0, 1, causee)
		elseif hp == 82 then
			Osi.ApplyStatus(character, "LIFE_TRANSFERENCE_HP_5TH_82", 0.0, 1, causee)
		elseif hp == 84 then
			Osi.ApplyStatus(character, "LIFE_TRANSFERENCE_HP_5TH_84", 0.0, 1, causee)
		elseif hp == 86 then
			Osi.ApplyStatus(character, "LIFE_TRANSFERENCE_HP_5TH_86", 0.0, 1, causee)
		elseif hp == 88 then
			Osi.ApplyStatus(character, "LIFE_TRANSFERENCE_HP_5TH_88", 0.0, 1, causee)
		elseif hp == 90 then
			Osi.ApplyStatus(character, "LIFE_TRANSFERENCE_HP_5TH_90", 0.0, 1, causee)
		elseif hp == 92 then
			Osi.ApplyStatus(character, "LIFE_TRANSFERENCE_HP_5TH_92", 0.0, 1, causee)
		elseif hp == 94 then
			Osi.ApplyStatus(character, "LIFE_TRANSFERENCE_HP_5TH_94", 0.0, 1, causee)
		elseif hp == 96 then
			Osi.ApplyStatus(character, "LIFE_TRANSFERENCE_HP_5TH_96", 0.0, 1, causee)
		end
	elseif status == "LIFE_TRANSFERENCE_6" then
		local previoushp = GetVarInteger(causee, "BeforeHP")
		local currenthp = GetHitpoints(causee)
		local targethp = GetHitpoints(character)
		local hp = 0
		local newhp = 0
		hp = previoushp - currenthp
		hp = hp * 2
		newhp = targethp + hp
		if hp == 2 then
			Osi.ApplyStatus(character, "LIFE_TRANSFERENCE_HP_6TH_2", 0.0, 1, causee)
		elseif hp == 4 then
			Osi.ApplyStatus(character, "LIFE_TRANSFERENCE_HP_6TH_4", 0.0, 1, causee)
		elseif hp == 6 then
			Osi.ApplyStatus(character, "LIFE_TRANSFERENCE_HP_6TH_6", 0.0, 1, causee)
		elseif hp == 8 then
			Osi.ApplyStatus(character, "LIFE_TRANSFERENCE_HP_6TH_8", 0.0, 1, causee)
		elseif hp == 10 then
			Osi.ApplyStatus(character, "LIFE_TRANSFERENCE_HP_6TH_10", 0.0, 1, causee)
		elseif hp == 12 then
			Osi.ApplyStatus(character, "LIFE_TRANSFERENCE_HP_6TH_12", 0.0, 1, causee)
		elseif hp == 14 then
			Osi.ApplyStatus(character, "LIFE_TRANSFERENCE_HP_6TH_14", 0.0, 1, causee)
		elseif hp == 16 then
			Osi.ApplyStatus(character, "LIFE_TRANSFERENCE_HP_6TH_16", 0.0, 1, causee)
		elseif hp == 18 then
			Osi.ApplyStatus(character, "LIFE_TRANSFERENCE_HP_6TH_18", 0.0, 1, causee)
		elseif hp == 20 then
			Osi.ApplyStatus(character, "LIFE_TRANSFERENCE_HP_6TH_20", 0.0, 1, causee)
		elseif hp == 22 then
			Osi.ApplyStatus(character, "LIFE_TRANSFERENCE_HP_6TH_22", 0.0, 1, causee)
		elseif hp == 24 then
			Osi.ApplyStatus(character, "LIFE_TRANSFERENCE_HP_6TH_24", 0.0, 1, causee)
		elseif hp == 26 then
			Osi.ApplyStatus(character, "LIFE_TRANSFERENCE_HP_6TH_26", 0.0, 1, causee)
		elseif hp == 28 then
			Osi.ApplyStatus(character, "LIFE_TRANSFERENCE_HP_6TH_28", 0.0, 1, causee)
		elseif hp == 30 then
			Osi.ApplyStatus(character, "LIFE_TRANSFERENCE_HP_6TH_30", 0.0, 1, causee)
		elseif hp == 32 then
			Osi.ApplyStatus(character, "LIFE_TRANSFERENCE_HP_6TH_32", 0.0, 1, causee)
		elseif hp == 34 then
			Osi.ApplyStatus(character, "LIFE_TRANSFERENCE_HP_6TH_34", 0.0, 1, causee)
		elseif hp == 36 then
			Osi.ApplyStatus(character, "LIFE_TRANSFERENCE_HP_6TH_36", 0.0, 1, causee)
		elseif hp == 38 then
			Osi.ApplyStatus(character, "LIFE_TRANSFERENCE_HP_6TH_38", 0.0, 1, causee)
		elseif hp == 40 then
			Osi.ApplyStatus(character, "LIFE_TRANSFERENCE_HP_6TH_40", 0.0, 1, causee)
		elseif hp == 42 then
			Osi.ApplyStatus(character, "LIFE_TRANSFERENCE_HP_6TH_42", 0.0, 1, causee)
		elseif hp == 44 then
			Osi.ApplyStatus(character, "LIFE_TRANSFERENCE_HP_6TH_44", 0.0, 1, causee)
		elseif hp == 46 then
			Osi.ApplyStatus(character, "LIFE_TRANSFERENCE_HP_6TH_46", 0.0, 1, causee)
		elseif hp == 48 then
			Osi.ApplyStatus(character, "LIFE_TRANSFERENCE_HP_6TH_48", 0.0, 1, causee)
		elseif hp == 60 then
			Osi.ApplyStatus(character, "LIFE_TRANSFERENCE_HP_6TH_60", 0.0, 1, causee)
		elseif hp == 62 then
			Osi.ApplyStatus(character, "LIFE_TRANSFERENCE_HP_6TH_62", 0.0, 1, causee)
		elseif hp == 64 then
			Osi.ApplyStatus(character, "LIFE_TRANSFERENCE_HP_6TH_64", 0.0, 1, causee)
		elseif hp == 66 then
			Osi.ApplyStatus(character, "LIFE_TRANSFERENCE_HP_6TH_66", 0.0, 1, causee)
		elseif hp == 68 then
			Osi.ApplyStatus(character, "LIFE_TRANSFERENCE_HP_6TH_68", 0.0, 1, causee)
		elseif hp == 60 then
			Osi.ApplyStatus(character, "LIFE_TRANSFERENCE_HP_6TH_60", 0.0, 1, causee)
		elseif hp == 62 then
			Osi.ApplyStatus(character, "LIFE_TRANSFERENCE_HP_6TH_62", 0.0, 1, causee)
		elseif hp == 64 then
			Osi.ApplyStatus(character, "LIFE_TRANSFERENCE_HP_6TH_64", 0.0, 1, causee)
		elseif hp == 66 then
			Osi.ApplyStatus(character, "LIFE_TRANSFERENCE_HP_6TH_66", 0.0, 1, causee)
		elseif hp == 68 then
			Osi.ApplyStatus(character, "LIFE_TRANSFERENCE_HP_6TH_68", 0.0, 1, causee)
		elseif hp == 70 then
			Osi.ApplyStatus(character, "LIFE_TRANSFERENCE_HP_6TH_70", 0.0, 1, causee)
		elseif hp == 72 then
			Osi.ApplyStatus(character, "LIFE_TRANSFERENCE_HP_6TH_72", 0.0, 1, causee)
		elseif hp == 74 then
			Osi.ApplyStatus(character, "LIFE_TRANSFERENCE_HP_6TH_74", 0.0, 1, causee)
		elseif hp == 76 then
			Osi.ApplyStatus(character, "LIFE_TRANSFERENCE_HP_6TH_76", 0.0, 1, causee)
		elseif hp == 78 then
			Osi.ApplyStatus(character, "LIFE_TRANSFERENCE_HP_6TH_78", 0.0, 1, causee)
		elseif hp == 80 then
			Osi.ApplyStatus(character, "LIFE_TRANSFERENCE_HP_6TH_80", 0.0, 1, causee)
		elseif hp == 82 then
			Osi.ApplyStatus(character, "LIFE_TRANSFERENCE_HP_6TH_82", 0.0, 1, causee)
		elseif hp == 84 then
			Osi.ApplyStatus(character, "LIFE_TRANSFERENCE_HP_6TH_84", 0.0, 1, causee)
		elseif hp == 86 then
			Osi.ApplyStatus(character, "LIFE_TRANSFERENCE_HP_6TH_86", 0.0, 1, causee)
		elseif hp == 88 then
			Osi.ApplyStatus(character, "LIFE_TRANSFERENCE_HP_6TH_88", 0.0, 1, causee)
		elseif hp == 90 then
			Osi.ApplyStatus(character, "LIFE_TRANSFERENCE_HP_6TH_90", 0.0, 1, causee)
		elseif hp == 92 then
			Osi.ApplyStatus(character, "LIFE_TRANSFERENCE_HP_6TH_92", 0.0, 1, causee)
		elseif hp == 94 then
			Osi.ApplyStatus(character, "LIFE_TRANSFERENCE_HP_6TH_94", 0.0, 1, causee)
		elseif hp == 96 then
			Osi.ApplyStatus(character, "LIFE_TRANSFERENCE_HP_6TH_96", 0.0, 1, causee)
		elseif hp == 98 then
			Osi.ApplyStatus(character, "LIFE_TRANSFERENCE_HP_6TH_98", 0.0, 1, causee)
		elseif hp == 100 then
			Osi.ApplyStatus(character, "LIFE_TRANSFERENCE_HP_6TH_100", 0.0, 1, causee)
		elseif hp == 102 then
			Osi.ApplyStatus(character, "LIFE_TRANSFERENCE_HP_6TH_102", 0.0, 1, causee)
		elseif hp == 104 then
			Osi.ApplyStatus(character, "LIFE_TRANSFERENCE_HP_6TH_104", 0.0, 1, causee)
		elseif hp == 106 then
			Osi.ApplyStatus(character, "LIFE_TRANSFERENCE_HP_6TH_106", 0.0, 1, causee)
		elseif hp == 108 then
			Osi.ApplyStatus(character, "LIFE_TRANSFERENCE_HP_6TH_108", 0.0, 1, causee)
		elseif hp == 110 then
			Osi.ApplyStatus(character, "LIFE_TRANSFERENCE_HP_6TH_110", 0.0, 1, causee)
		elseif hp == 112 then
			Osi.ApplyStatus(character, "LIFE_TRANSFERENCE_HP_6TH_112", 0.0, 1, causee)
		end
	elseif status == "LIFE_TRANSFERENCE_7" then
		local previoushp = GetVarInteger(causee, "BeforeHP")
		local currenthp = GetHitpoints(causee)
		local targethp = GetHitpoints(character)
		local hp = 0
		local newhp = 0
		hp = previoushp - currenthp
		hp = hp * 2
		newhp = targethp + hp
		if hp == 2 then
			Osi.ApplyStatus(character, "LIFE_TRANSFERENCE_HP_7TH_2", 0.0, 1, causee)
		elseif hp == 4 then
			Osi.ApplyStatus(character, "LIFE_TRANSFERENCE_HP_7TH_4", 0.0, 1, causee)
		elseif hp == 6 then
			Osi.ApplyStatus(character, "LIFE_TRANSFERENCE_HP_7TH_6", 0.0, 1, causee)
		elseif hp == 8 then
			Osi.ApplyStatus(character, "LIFE_TRANSFERENCE_HP_7TH_8", 0.0, 1, causee)
		elseif hp == 10 then
			Osi.ApplyStatus(character, "LIFE_TRANSFERENCE_HP_7TH_10", 0.0, 1, causee)
		elseif hp == 12 then
			Osi.ApplyStatus(character, "LIFE_TRANSFERENCE_HP_7TH_12", 0.0, 1, causee)
		elseif hp == 14 then
			Osi.ApplyStatus(character, "LIFE_TRANSFERENCE_HP_7TH_14", 0.0, 1, causee)
		elseif hp == 16 then
			Osi.ApplyStatus(character, "LIFE_TRANSFERENCE_HP_7TH_16", 0.0, 1, causee)
		elseif hp == 18 then
			Osi.ApplyStatus(character, "LIFE_TRANSFERENCE_HP_7TH_18", 0.0, 1, causee)
		elseif hp == 20 then
			Osi.ApplyStatus(character, "LIFE_TRANSFERENCE_HP_7TH_20", 0.0, 1, causee)
		elseif hp == 22 then
			Osi.ApplyStatus(character, "LIFE_TRANSFERENCE_HP_7TH_22", 0.0, 1, causee)
		elseif hp == 24 then
			Osi.ApplyStatus(character, "LIFE_TRANSFERENCE_HP_7TH_24", 0.0, 1, causee)
		elseif hp == 26 then
			Osi.ApplyStatus(character, "LIFE_TRANSFERENCE_HP_7TH_26", 0.0, 1, causee)
		elseif hp == 28 then
			Osi.ApplyStatus(character, "LIFE_TRANSFERENCE_HP_7TH_28", 0.0, 1, causee)
		elseif hp == 30 then
			Osi.ApplyStatus(character, "LIFE_TRANSFERENCE_HP_7TH_30", 0.0, 1, causee)
		elseif hp == 32 then
			Osi.ApplyStatus(character, "LIFE_TRANSFERENCE_HP_7TH_32", 0.0, 1, causee)
		elseif hp == 34 then
			Osi.ApplyStatus(character, "LIFE_TRANSFERENCE_HP_7TH_34", 0.0, 1, causee)
		elseif hp == 36 then
			Osi.ApplyStatus(character, "LIFE_TRANSFERENCE_HP_7TH_36", 0.0, 1, causee)
		elseif hp == 38 then
			Osi.ApplyStatus(character, "LIFE_TRANSFERENCE_HP_7TH_38", 0.0, 1, causee)
		elseif hp == 40 then
			Osi.ApplyStatus(character, "LIFE_TRANSFERENCE_HP_7TH_40", 0.0, 1, causee)
		elseif hp == 42 then
			Osi.ApplyStatus(character, "LIFE_TRANSFERENCE_HP_7TH_42", 0.0, 1, causee)
		elseif hp == 44 then
			Osi.ApplyStatus(character, "LIFE_TRANSFERENCE_HP_7TH_44", 0.0, 1, causee)
		elseif hp == 46 then
			Osi.ApplyStatus(character, "LIFE_TRANSFERENCE_HP_7TH_46", 0.0, 1, causee)
		elseif hp == 48 then
			Osi.ApplyStatus(character, "LIFE_TRANSFERENCE_HP_7TH_48", 0.0, 1, causee)
		elseif hp == 60 then
			Osi.ApplyStatus(character, "LIFE_TRANSFERENCE_HP_7TH_60", 0.0, 1, causee)
		elseif hp == 62 then
			Osi.ApplyStatus(character, "LIFE_TRANSFERENCE_HP_7TH_62", 0.0, 1, causee)
		elseif hp == 64 then
			Osi.ApplyStatus(character, "LIFE_TRANSFERENCE_HP_7TH_64", 0.0, 1, causee)
		elseif hp == 66 then
			Osi.ApplyStatus(character, "LIFE_TRANSFERENCE_HP_7TH_66", 0.0, 1, causee)
		elseif hp == 68 then
			Osi.ApplyStatus(character, "LIFE_TRANSFERENCE_HP_7TH_68", 0.0, 1, causee)
		elseif hp == 60 then
			Osi.ApplyStatus(character, "LIFE_TRANSFERENCE_HP_7TH_60", 0.0, 1, causee)
		elseif hp == 62 then
			Osi.ApplyStatus(character, "LIFE_TRANSFERENCE_HP_7TH_62", 0.0, 1, causee)
		elseif hp == 64 then
			Osi.ApplyStatus(character, "LIFE_TRANSFERENCE_HP_7TH_64", 0.0, 1, causee)
		elseif hp == 66 then
			Osi.ApplyStatus(character, "LIFE_TRANSFERENCE_HP_7TH_66", 0.0, 1, causee)
		elseif hp == 68 then
			Osi.ApplyStatus(character, "LIFE_TRANSFERENCE_HP_7TH_68", 0.0, 1, causee)
		elseif hp == 70 then
			Osi.ApplyStatus(character, "LIFE_TRANSFERENCE_HP_7TH_70", 0.0, 1, causee)
		elseif hp == 72 then
			Osi.ApplyStatus(character, "LIFE_TRANSFERENCE_HP_7TH_72", 0.0, 1, causee)
		elseif hp == 74 then
			Osi.ApplyStatus(character, "LIFE_TRANSFERENCE_HP_7TH_74", 0.0, 1, causee)
		elseif hp == 76 then
			Osi.ApplyStatus(character, "LIFE_TRANSFERENCE_HP_7TH_76", 0.0, 1, causee)
		elseif hp == 78 then
			Osi.ApplyStatus(character, "LIFE_TRANSFERENCE_HP_7TH_78", 0.0, 1, causee)
		elseif hp == 80 then
			Osi.ApplyStatus(character, "LIFE_TRANSFERENCE_HP_7TH_80", 0.0, 1, causee)
		elseif hp == 82 then
			Osi.ApplyStatus(character, "LIFE_TRANSFERENCE_HP_7TH_82", 0.0, 1, causee)
		elseif hp == 84 then
			Osi.ApplyStatus(character, "LIFE_TRANSFERENCE_HP_7TH_84", 0.0, 1, causee)
		elseif hp == 86 then
			Osi.ApplyStatus(character, "LIFE_TRANSFERENCE_HP_7TH_86", 0.0, 1, causee)
		elseif hp == 88 then
			Osi.ApplyStatus(character, "LIFE_TRANSFERENCE_HP_7TH_88", 0.0, 1, causee)
		elseif hp == 90 then
			Osi.ApplyStatus(character, "LIFE_TRANSFERENCE_HP_7TH_90", 0.0, 1, causee)
		elseif hp == 92 then
			Osi.ApplyStatus(character, "LIFE_TRANSFERENCE_HP_7TH_92", 0.0, 1, causee)
		elseif hp == 94 then
			Osi.ApplyStatus(character, "LIFE_TRANSFERENCE_HP_7TH_94", 0.0, 1, causee)
		elseif hp == 96 then
			Osi.ApplyStatus(character, "LIFE_TRANSFERENCE_HP_7TH_96", 0.0, 1, causee)
		elseif hp == 98 then
			Osi.ApplyStatus(character, "LIFE_TRANSFERENCE_HP_7TH_98", 0.0, 1, causee)
		elseif hp == 100 then
			Osi.ApplyStatus(character, "LIFE_TRANSFERENCE_HP_7TH_100", 0.0, 1, causee)
		elseif hp == 102 then
			Osi.ApplyStatus(character, "LIFE_TRANSFERENCE_HP_7TH_102", 0.0, 1, causee)
		elseif hp == 104 then
			Osi.ApplyStatus(character, "LIFE_TRANSFERENCE_HP_7TH_104", 0.0, 1, causee)
		elseif hp == 106 then
			Osi.ApplyStatus(character, "LIFE_TRANSFERENCE_HP_7TH_106", 0.0, 1, causee)
		elseif hp == 108 then
			Osi.ApplyStatus(character, "LIFE_TRANSFERENCE_HP_7TH_108", 0.0, 1, causee)
		elseif hp == 110 then
			Osi.ApplyStatus(character, "LIFE_TRANSFERENCE_HP_7TH_110", 0.0, 1, causee)
		elseif hp == 112 then
			Osi.ApplyStatus(character, "LIFE_TRANSFERENCE_HP_7TH_112", 0.0, 1, causee)
		elseif hp == 114 then
			Osi.ApplyStatus(character, "LIFE_TRANSFERENCE_HP_7TH_114", 0.0, 1, causee)
		elseif hp == 116 then
			Osi.ApplyStatus(character, "LIFE_TRANSFERENCE_HP_7TH_116", 0.0, 1, causee)
		elseif hp == 118 then
			Osi.ApplyStatus(character, "LIFE_TRANSFERENCE_HP_7TH_118", 0.0, 1, causee)
		elseif hp == 120 then
			Osi.ApplyStatus(character, "LIFE_TRANSFERENCE_HP_7TH_120", 0.0, 1, causee)
		elseif hp == 122 then
			Osi.ApplyStatus(character, "LIFE_TRANSFERENCE_HP_7TH_122", 0.0, 1, causee)
		elseif hp == 124 then
			Osi.ApplyStatus(character, "LIFE_TRANSFERENCE_HP_7TH_124", 0.0, 1, causee)
		elseif hp == 126 then
			Osi.ApplyStatus(character, "LIFE_TRANSFERENCE_HP_7TH_126", 0.0, 1, causee)
		elseif hp == 128 then
			Osi.ApplyStatus(character, "LIFE_TRANSFERENCE_HP_7TH_128", 0.0, 1, causee)
		end
	elseif status == "LIFE_TRANSFERENCE_8" then
		local previoushp = GetVarInteger(causee, "BeforeHP")
		local currenthp = GetHitpoints(causee)
		local targethp = GetHitpoints(character)
		local hp = 0
		local newhp = 0
		hp = previoushp - currenthp
		hp = hp * 2
		newhp = targethp + hp
		if hp == 2 then
			Osi.ApplyStatus(character, "LIFE_TRANSFERENCE_HP_8TH_2", 0.0, 1, causee)
		elseif hp == 4 then
			Osi.ApplyStatus(character, "LIFE_TRANSFERENCE_HP_8TH_4", 0.0, 1, causee)
		elseif hp == 6 then
			Osi.ApplyStatus(character, "LIFE_TRANSFERENCE_HP_8TH_6", 0.0, 1, causee)
		elseif hp == 8 then
			Osi.ApplyStatus(character, "LIFE_TRANSFERENCE_HP_8TH_8", 0.0, 1, causee)
		elseif hp == 10 then
			Osi.ApplyStatus(character, "LIFE_TRANSFERENCE_HP_8TH_10", 0.0, 1, causee)
		elseif hp == 12 then
			Osi.ApplyStatus(character, "LIFE_TRANSFERENCE_HP_8TH_12", 0.0, 1, causee)
		elseif hp == 14 then
			Osi.ApplyStatus(character, "LIFE_TRANSFERENCE_HP_8TH_14", 0.0, 1, causee)
		elseif hp == 16 then
			Osi.ApplyStatus(character, "LIFE_TRANSFERENCE_HP_8TH_16", 0.0, 1, causee)
		elseif hp == 18 then
			Osi.ApplyStatus(character, "LIFE_TRANSFERENCE_HP_8TH_18", 0.0, 1, causee)
		elseif hp == 20 then
			Osi.ApplyStatus(character, "LIFE_TRANSFERENCE_HP_8TH_20", 0.0, 1, causee)
		elseif hp == 22 then
			Osi.ApplyStatus(character, "LIFE_TRANSFERENCE_HP_8TH_22", 0.0, 1, causee)
		elseif hp == 24 then
			Osi.ApplyStatus(character, "LIFE_TRANSFERENCE_HP_8TH_24", 0.0, 1, causee)
		elseif hp == 26 then
			Osi.ApplyStatus(character, "LIFE_TRANSFERENCE_HP_8TH_26", 0.0, 1, causee)
		elseif hp == 28 then
			Osi.ApplyStatus(character, "LIFE_TRANSFERENCE_HP_8TH_28", 0.0, 1, causee)
		elseif hp == 30 then
			Osi.ApplyStatus(character, "LIFE_TRANSFERENCE_HP_8TH_30", 0.0, 1, causee)
		elseif hp == 32 then
			Osi.ApplyStatus(character, "LIFE_TRANSFERENCE_HP_8TH_32", 0.0, 1, causee)
		elseif hp == 34 then
			Osi.ApplyStatus(character, "LIFE_TRANSFERENCE_HP_8TH_34", 0.0, 1, causee)
		elseif hp == 36 then
			Osi.ApplyStatus(character, "LIFE_TRANSFERENCE_HP_8TH_36", 0.0, 1, causee)
		elseif hp == 38 then
			Osi.ApplyStatus(character, "LIFE_TRANSFERENCE_HP_8TH_38", 0.0, 1, causee)
		elseif hp == 40 then
			Osi.ApplyStatus(character, "LIFE_TRANSFERENCE_HP_8TH_40", 0.0, 1, causee)
		elseif hp == 42 then
			Osi.ApplyStatus(character, "LIFE_TRANSFERENCE_HP_8TH_42", 0.0, 1, causee)
		elseif hp == 44 then
			Osi.ApplyStatus(character, "LIFE_TRANSFERENCE_HP_8TH_44", 0.0, 1, causee)
		elseif hp == 46 then
			Osi.ApplyStatus(character, "LIFE_TRANSFERENCE_HP_8TH_46", 0.0, 1, causee)
		elseif hp == 48 then
			Osi.ApplyStatus(character, "LIFE_TRANSFERENCE_HP_8TH_48", 0.0, 1, causee)
		elseif hp == 60 then
			Osi.ApplyStatus(character, "LIFE_TRANSFERENCE_HP_8TH_60", 0.0, 1, causee)
		elseif hp == 62 then
			Osi.ApplyStatus(character, "LIFE_TRANSFERENCE_HP_8TH_62", 0.0, 1, causee)
		elseif hp == 64 then
			Osi.ApplyStatus(character, "LIFE_TRANSFERENCE_HP_8TH_64", 0.0, 1, causee)
		elseif hp == 66 then
			Osi.ApplyStatus(character, "LIFE_TRANSFERENCE_HP_8TH_66", 0.0, 1, causee)
		elseif hp == 68 then
			Osi.ApplyStatus(character, "LIFE_TRANSFERENCE_HP_8TH_68", 0.0, 1, causee)
		elseif hp == 60 then
			Osi.ApplyStatus(character, "LIFE_TRANSFERENCE_HP_8TH_60", 0.0, 1, causee)
		elseif hp == 62 then
			Osi.ApplyStatus(character, "LIFE_TRANSFERENCE_HP_8TH_62", 0.0, 1, causee)
		elseif hp == 64 then
			Osi.ApplyStatus(character, "LIFE_TRANSFERENCE_HP_8TH_64", 0.0, 1, causee)
		elseif hp == 66 then
			Osi.ApplyStatus(character, "LIFE_TRANSFERENCE_HP_8TH_66", 0.0, 1, causee)
		elseif hp == 68 then
			Osi.ApplyStatus(character, "LIFE_TRANSFERENCE_HP_8TH_68", 0.0, 1, causee)
		elseif hp == 80 then
			Osi.ApplyStatus(character, "LIFE_TRANSFERENCE_HP_8TH_80", 0.0, 1, causee)
		elseif hp == 82 then
			Osi.ApplyStatus(character, "LIFE_TRANSFERENCE_HP_8TH_82", 0.0, 1, causee)
		elseif hp == 84 then
			Osi.ApplyStatus(character, "LIFE_TRANSFERENCE_HP_8TH_84", 0.0, 1, causee)
		elseif hp == 86 then
			Osi.ApplyStatus(character, "LIFE_TRANSFERENCE_HP_8TH_86", 0.0, 1, causee)
		elseif hp == 88 then
			Osi.ApplyStatus(character, "LIFE_TRANSFERENCE_HP_8TH_88", 0.0, 1, causee)
		elseif hp == 80 then
			Osi.ApplyStatus(character, "LIFE_TRANSFERENCE_HP_8TH_80", 0.0, 1, causee)
		elseif hp == 82 then
			Osi.ApplyStatus(character, "LIFE_TRANSFERENCE_HP_8TH_82", 0.0, 1, causee)
		elseif hp == 84 then
			Osi.ApplyStatus(character, "LIFE_TRANSFERENCE_HP_8TH_84", 0.0, 1, causee)
		elseif hp == 86 then
			Osi.ApplyStatus(character, "LIFE_TRANSFERENCE_HP_8TH_86", 0.0, 1, causee)
		elseif hp == 88 then
			Osi.ApplyStatus(character, "LIFE_TRANSFERENCE_HP_8TH_88", 0.0, 1, causee)
		elseif hp == 90 then
			Osi.ApplyStatus(character, "LIFE_TRANSFERENCE_HP_8TH_90", 0.0, 1, causee)
		elseif hp == 92 then
			Osi.ApplyStatus(character, "LIFE_TRANSFERENCE_HP_8TH_92", 0.0, 1, causee)
		elseif hp == 94 then
			Osi.ApplyStatus(character, "LIFE_TRANSFERENCE_HP_8TH_94", 0.0, 1, causee)
		elseif hp == 96 then
			Osi.ApplyStatus(character, "LIFE_TRANSFERENCE_HP_8TH_96", 0.0, 1, causee)
		elseif hp == 98 then
			Osi.ApplyStatus(character, "LIFE_TRANSFERENCE_HP_8TH_98", 0.0, 1, causee)
		elseif hp == 100 then
			Osi.ApplyStatus(character, "LIFE_TRANSFERENCE_HP_8TH_100", 0.0, 1, causee)
		elseif hp == 102 then
			Osi.ApplyStatus(character, "LIFE_TRANSFERENCE_HP_8TH_102", 0.0, 1, causee)
		elseif hp == 104 then
			Osi.ApplyStatus(character, "LIFE_TRANSFERENCE_HP_8TH_104", 0.0, 1, causee)
		elseif hp == 106 then
			Osi.ApplyStatus(character, "LIFE_TRANSFERENCE_HP_8TH_106", 0.0, 1, causee)
		elseif hp == 108 then
			Osi.ApplyStatus(character, "LIFE_TRANSFERENCE_HP_8TH_108", 0.0, 1, causee)
		elseif hp == 110 then
			Osi.ApplyStatus(character, "LIFE_TRANSFERENCE_HP_8TH_110", 0.0, 1, causee)
		elseif hp == 112 then
			Osi.ApplyStatus(character, "LIFE_TRANSFERENCE_HP_8TH_112", 0.0, 1, causee)
		elseif hp == 114 then
			Osi.ApplyStatus(character, "LIFE_TRANSFERENCE_HP_8TH_114", 0.0, 1, causee)
		elseif hp == 116 then
			Osi.ApplyStatus(character, "LIFE_TRANSFERENCE_HP_8TH_116", 0.0, 1, causee)
		elseif hp == 118 then
			Osi.ApplyStatus(character, "LIFE_TRANSFERENCE_HP_8TH_118", 0.0, 1, causee)
		elseif hp == 120 then
			Osi.ApplyStatus(character, "LIFE_TRANSFERENCE_HP_8TH_120", 0.0, 1, causee)
		elseif hp == 122 then
			Osi.ApplyStatus(character, "LIFE_TRANSFERENCE_HP_8TH_122", 0.0, 1, causee)
		elseif hp == 124 then
			Osi.ApplyStatus(character, "LIFE_TRANSFERENCE_HP_8TH_124", 0.0, 1, causee)
		elseif hp == 126 then
			Osi.ApplyStatus(character, "LIFE_TRANSFERENCE_HP_8TH_126", 0.0, 1, causee)
		elseif hp == 128 then
			Osi.ApplyStatus(character, "LIFE_TRANSFERENCE_HP_8TH_128", 0.0, 1, causee)
		elseif hp == 130 then
			Osi.ApplyStatus(character, "LIFE_TRANSFERENCE_HP_8TH_130", 0.0, 1, causee)
		elseif hp == 132 then
			Osi.ApplyStatus(character, "LIFE_TRANSFERENCE_HP_8TH_132", 0.0, 1, causee)
		elseif hp == 134 then
			Osi.ApplyStatus(character, "LIFE_TRANSFERENCE_HP_8TH_134", 0.0, 1, causee)
		elseif hp == 136 then
			Osi.ApplyStatus(character, "LIFE_TRANSFERENCE_HP_8TH_136", 0.0, 1, causee)
		elseif hp == 138 then
			Osi.ApplyStatus(character, "LIFE_TRANSFERENCE_HP_8TH_138", 0.0, 1, causee)
		elseif hp == 140 then
			Osi.ApplyStatus(character, "LIFE_TRANSFERENCE_HP_8TH_140", 0.0, 1, causee)
		elseif hp == 142 then
			Osi.ApplyStatus(character, "LIFE_TRANSFERENCE_HP_8TH_142", 0.0, 1, causee)
		elseif hp == 144 then
			Osi.ApplyStatus(character, "LIFE_TRANSFERENCE_HP_8TH_144", 0.0, 1, causee)
		end
	elseif status == "LIFE_TRANSFERENCE_9" then
		local previoushp = GetVarInteger(causee, "BeforeHP")
		local currenthp = GetHitpoints(causee)
		local targethp = GetHitpoints(character)
		local hp = 0
		local newhp = 0
		hp = previoushp - currenthp
		hp = hp * 2
		newhp = targethp + hp
		if hp == 2 then
			Osi.ApplyStatus(character, "LIFE_TRANSFERENCE_HP_9TH_2", 0.0, 1, causee)
		elseif hp == 4 then
			Osi.ApplyStatus(character, "LIFE_TRANSFERENCE_HP_9TH_4", 0.0, 1, causee)
		elseif hp == 6 then
			Osi.ApplyStatus(character, "LIFE_TRANSFERENCE_HP_9TH_6", 0.0, 1, causee)
		elseif hp == 8 then
			Osi.ApplyStatus(character, "LIFE_TRANSFERENCE_HP_9TH_8", 0.0, 1, causee)
		elseif hp == 10 then
			Osi.ApplyStatus(character, "LIFE_TRANSFERENCE_HP_9TH_10", 0.0, 1, causee)
		elseif hp == 12 then
			Osi.ApplyStatus(character, "LIFE_TRANSFERENCE_HP_9TH_12", 0.0, 1, causee)
		elseif hp == 14 then
			Osi.ApplyStatus(character, "LIFE_TRANSFERENCE_HP_9TH_14", 0.0, 1, causee)
		elseif hp == 16 then
			Osi.ApplyStatus(character, "LIFE_TRANSFERENCE_HP_9TH_16", 0.0, 1, causee)
		elseif hp == 18 then
			Osi.ApplyStatus(character, "LIFE_TRANSFERENCE_HP_9TH_18", 0.0, 1, causee)
		elseif hp == 20 then
			Osi.ApplyStatus(character, "LIFE_TRANSFERENCE_HP_9TH_20", 0.0, 1, causee)
		elseif hp == 22 then
			Osi.ApplyStatus(character, "LIFE_TRANSFERENCE_HP_9TH_22", 0.0, 1, causee)
		elseif hp == 24 then
			Osi.ApplyStatus(character, "LIFE_TRANSFERENCE_HP_9TH_24", 0.0, 1, causee)
		elseif hp == 26 then
			Osi.ApplyStatus(character, "LIFE_TRANSFERENCE_HP_9TH_26", 0.0, 1, causee)
		elseif hp == 28 then
			Osi.ApplyStatus(character, "LIFE_TRANSFERENCE_HP_9TH_28", 0.0, 1, causee)
		elseif hp == 30 then
			Osi.ApplyStatus(character, "LIFE_TRANSFERENCE_HP_9TH_30", 0.0, 1, causee)
		elseif hp == 32 then
			Osi.ApplyStatus(character, "LIFE_TRANSFERENCE_HP_9TH_32", 0.0, 1, causee)
		elseif hp == 34 then
			Osi.ApplyStatus(character, "LIFE_TRANSFERENCE_HP_9TH_34", 0.0, 1, causee)
		elseif hp == 36 then
			Osi.ApplyStatus(character, "LIFE_TRANSFERENCE_HP_9TH_36", 0.0, 1, causee)
		elseif hp == 38 then
			Osi.ApplyStatus(character, "LIFE_TRANSFERENCE_HP_9TH_38", 0.0, 1, causee)
		elseif hp == 40 then
			Osi.ApplyStatus(character, "LIFE_TRANSFERENCE_HP_9TH_40", 0.0, 1, causee)
		elseif hp == 42 then
			Osi.ApplyStatus(character, "LIFE_TRANSFERENCE_HP_9TH_42", 0.0, 1, causee)
		elseif hp == 44 then
			Osi.ApplyStatus(character, "LIFE_TRANSFERENCE_HP_9TH_44", 0.0, 1, causee)
		elseif hp == 46 then
			Osi.ApplyStatus(character, "LIFE_TRANSFERENCE_HP_9TH_46", 0.0, 1, causee)
		elseif hp == 48 then
			Osi.ApplyStatus(character, "LIFE_TRANSFERENCE_HP_9TH_48", 0.0, 1, causee)
		elseif hp == 60 then
			Osi.ApplyStatus(character, "LIFE_TRANSFERENCE_HP_9TH_60", 0.0, 1, causee)
		elseif hp == 62 then
			Osi.ApplyStatus(character, "LIFE_TRANSFERENCE_HP_9TH_62", 0.0, 1, causee)
		elseif hp == 64 then
			Osi.ApplyStatus(character, "LIFE_TRANSFERENCE_HP_9TH_64", 0.0, 1, causee)
		elseif hp == 66 then
			Osi.ApplyStatus(character, "LIFE_TRANSFERENCE_HP_9TH_66", 0.0, 1, causee)
		elseif hp == 68 then
			Osi.ApplyStatus(character, "LIFE_TRANSFERENCE_HP_9TH_68", 0.0, 1, causee)
		elseif hp == 60 then
			Osi.ApplyStatus(character, "LIFE_TRANSFERENCE_HP_9TH_60", 0.0, 1, causee)
		elseif hp == 62 then
			Osi.ApplyStatus(character, "LIFE_TRANSFERENCE_HP_9TH_62", 0.0, 1, causee)
		elseif hp == 64 then
			Osi.ApplyStatus(character, "LIFE_TRANSFERENCE_HP_9TH_64", 0.0, 1, causee)
		elseif hp == 66 then
			Osi.ApplyStatus(character, "LIFE_TRANSFERENCE_HP_9TH_66", 0.0, 1, causee)
		elseif hp == 68 then
			Osi.ApplyStatus(character, "LIFE_TRANSFERENCE_HP_9TH_68", 0.0, 1, causee)
		elseif hp == 80 then
			Osi.ApplyStatus(character, "LIFE_TRANSFERENCE_HP_9TH_80", 0.0, 1, causee)
		elseif hp == 82 then
			Osi.ApplyStatus(character, "LIFE_TRANSFERENCE_HP_9TH_82", 0.0, 1, causee)
		elseif hp == 84 then
			Osi.ApplyStatus(character, "LIFE_TRANSFERENCE_HP_9TH_84", 0.0, 1, causee)
		elseif hp == 86 then
			Osi.ApplyStatus(character, "LIFE_TRANSFERENCE_HP_9TH_86", 0.0, 1, causee)
		elseif hp == 88 then
			Osi.ApplyStatus(character, "LIFE_TRANSFERENCE_HP_9TH_88", 0.0, 1, causee)
		elseif hp == 80 then
			Osi.ApplyStatus(character, "LIFE_TRANSFERENCE_HP_9TH_80", 0.0, 1, causee)
		elseif hp == 82 then
			Osi.ApplyStatus(character, "LIFE_TRANSFERENCE_HP_9TH_82", 0.0, 1, causee)
		elseif hp == 84 then
			Osi.ApplyStatus(character, "LIFE_TRANSFERENCE_HP_9TH_84", 0.0, 1, causee)
		elseif hp == 86 then
			Osi.ApplyStatus(character, "LIFE_TRANSFERENCE_HP_9TH_86", 0.0, 1, causee)
		elseif hp == 88 then
			Osi.ApplyStatus(character, "LIFE_TRANSFERENCE_HP_9TH_88", 0.0, 1, causee)
		elseif hp == 90 then
			Osi.ApplyStatus(character, "LIFE_TRANSFERENCE_HP_9TH_90", 0.0, 1, causee)
		elseif hp == 92 then
			Osi.ApplyStatus(character, "LIFE_TRANSFERENCE_HP_9TH_92", 0.0, 1, causee)
		elseif hp == 94 then
			Osi.ApplyStatus(character, "LIFE_TRANSFERENCE_HP_9TH_94", 0.0, 1, causee)
		elseif hp == 96 then
			Osi.ApplyStatus(character, "LIFE_TRANSFERENCE_HP_9TH_96", 0.0, 1, causee)
		elseif hp == 98 then
			Osi.ApplyStatus(character, "LIFE_TRANSFERENCE_HP_9TH_98", 0.0, 1, causee)
		elseif hp == 100 then
			Osi.ApplyStatus(character, "LIFE_TRANSFERENCE_HP_9TH_100", 0.0, 1, causee)
		elseif hp == 102 then
			Osi.ApplyStatus(character, "LIFE_TRANSFERENCE_HP_9TH_102", 0.0, 1, causee)
		elseif hp == 104 then
			Osi.ApplyStatus(character, "LIFE_TRANSFERENCE_HP_9TH_104", 0.0, 1, causee)
		elseif hp == 106 then
			Osi.ApplyStatus(character, "LIFE_TRANSFERENCE_HP_9TH_106", 0.0, 1, causee)
		elseif hp == 108 then
			Osi.ApplyStatus(character, "LIFE_TRANSFERENCE_HP_9TH_108", 0.0, 1, causee)
		elseif hp == 110 then
			Osi.ApplyStatus(character, "LIFE_TRANSFERENCE_HP_9TH_110", 0.0, 1, causee)
		elseif hp == 112 then
			Osi.ApplyStatus(character, "LIFE_TRANSFERENCE_HP_9TH_112", 0.0, 1, causee)
		elseif hp == 114 then
			Osi.ApplyStatus(character, "LIFE_TRANSFERENCE_HP_9TH_114", 0.0, 1, causee)
		elseif hp == 116 then
			Osi.ApplyStatus(character, "LIFE_TRANSFERENCE_HP_9TH_116", 0.0, 1, causee)
		elseif hp == 118 then
			Osi.ApplyStatus(character, "LIFE_TRANSFERENCE_HP_9TH_118", 0.0, 1, causee)
		elseif hp == 120 then
			Osi.ApplyStatus(character, "LIFE_TRANSFERENCE_HP_9TH_120", 0.0, 1, causee)
		elseif hp == 122 then
			Osi.ApplyStatus(character, "LIFE_TRANSFERENCE_HP_9TH_122", 0.0, 1, causee)
		elseif hp == 124 then
			Osi.ApplyStatus(character, "LIFE_TRANSFERENCE_HP_9TH_124", 0.0, 1, causee)
		elseif hp == 126 then
			Osi.ApplyStatus(character, "LIFE_TRANSFERENCE_HP_9TH_126", 0.0, 1, causee)
		elseif hp == 128 then
			Osi.ApplyStatus(character, "LIFE_TRANSFERENCE_HP_9TH_128", 0.0, 1, causee)
		elseif hp == 130 then
			Osi.ApplyStatus(character, "LIFE_TRANSFERENCE_HP_9TH_130", 0.0, 1, causee)
		elseif hp == 132 then
			Osi.ApplyStatus(character, "LIFE_TRANSFERENCE_HP_9TH_132", 0.0, 1, causee)
		elseif hp == 134 then
			Osi.ApplyStatus(character, "LIFE_TRANSFERENCE_HP_9TH_134", 0.0, 1, causee)
		elseif hp == 136 then
			Osi.ApplyStatus(character, "LIFE_TRANSFERENCE_HP_9TH_136", 0.0, 1, causee)
		elseif hp == 138 then
			Osi.ApplyStatus(character, "LIFE_TRANSFERENCE_HP_9TH_138", 0.0, 1, causee)
		elseif hp == 140 then
			Osi.ApplyStatus(character, "LIFE_TRANSFERENCE_HP_9TH_140", 0.0, 1, causee)
		elseif hp == 142 then
			Osi.ApplyStatus(character, "LIFE_TRANSFERENCE_HP_9TH_142", 0.0, 1, causee)
		elseif hp == 144 then
			Osi.ApplyStatus(character, "LIFE_TRANSFERENCE_HP_9TH_144", 0.0, 1, causee)
		elseif hp == 146 then
			Osi.ApplyStatus(character, "LIFE_TRANSFERENCE_HP_9TH_146", 0.0, 1, causee)
		elseif hp == 148 then
			Osi.ApplyStatus(character, "LIFE_TRANSFERENCE_HP_9TH_148", 0.0, 1, causee)
		elseif hp == 150 then
			Osi.ApplyStatus(character, "LIFE_TRANSFERENCE_HP_9TH_150", 0.0, 1, causee)
		elseif hp == 152 then
			Osi.ApplyStatus(character, "LIFE_TRANSFERENCE_HP_9TH_152", 0.0, 1, causee)
		elseif hp == 154 then
			Osi.ApplyStatus(character, "LIFE_TRANSFERENCE_HP_9TH_154", 0.0, 1, causee)
		elseif hp == 156 then
			Osi.ApplyStatus(character, "LIFE_TRANSFERENCE_HP_9TH_156", 0.0, 1, causee)
		elseif hp == 158 then
			Osi.ApplyStatus(character, "LIFE_TRANSFERENCE_HP_9TH_158", 0.0, 1, causee)
		elseif hp == 160 then
			Osi.ApplyStatus(character, "LIFE_TRANSFERENCE_HP_9TH_160", 0.0, 1, causee)
		end
    end
end)

-- SCAGtrips War Magic Extra Attack
Ext.Osiris.RegisterListener("UsingSpellOnTarget", 6, "before", function (caster, target, spell, _, _, _)
	if	(spell == "Target_GreenFlameBlade" or spell == "Target_BoomingBlade") and (Osi.HasPassive(caster,"ExtraAttack") == 1 or Osi.HasPassive(caster,"ExtraAttack_2") == 1 or Osi.HasPassive(caster,"ThirstingBlade_Blade") == 1 or Osi.HasPassive(caster,"WarPriest") == 1 or Osi.HasPassive(caster,"StalkersFlurry") == 1) then
		Osi.ApplyStatus(caster, "EXTRA_ATTACK_BLOCK_SCAGTRIPS",6.0,1,caster)
    end
end)

-- SCAGtrips War Magic/Bladesinging
Ext.Osiris.RegisterListener("UsingSpellOnTarget", 6, "after", function (caster, target, spell, _, _, _)
	if	(spell == "Target_GreenFlameBlade" or spell == "Target_BoomingBlade") and Osi.HasPassive(caster,"WarMagic") == 1 and Osi.HasPassive(caster,"ExtraAttack_Bladesinging") == 0 and (Osi.HasPassive(caster,"ExtraAttack") == 1 or Osi.HasPassive(caster,"ExtraAttack_2") == 1) and (Osi.IsInForceTurnBasedMode(caster) == 1 or Osi.IsInCombat(caster) == 1) and HasPassive(caster,"RAW_OnTurnTracker") == 0 then
		Osi.ApplyStatus(caster, "EXTRA_ATTACK_WAR_MAGIC_REPLACEMENT",6.0,1,caster)
	elseif	(spell == "Target_GreenFlameBlade" or spell == "Target_BoomingBlade") and Osi.HasPassive(caster,"ExtraAttack_Bladesinging") == 1 and (Osi.IsInForceTurnBasedMode(caster) == 1 or Osi.IsInCombat(caster) == 1) and HasActiveStatus(caster,"EXTRA_ATTACK_BLADESINGING") == 0 and HasActiveStatus(caster,"EXTRA_ATTACK_CANTRIP") == 0 and HasPassive(caster,"RAW_OnTurnTracker") == 0 then
		Osi.ApplyStatus(caster, "EXTRA_ATTACK_CANTRIP",6.0,1,caster)
	elseif	(spell == "Target_GreenFlameBlade" or spell == "Target_BoomingBlade") and Osi.HasPassive(caster,"WarMagic") == 1 and Osi.HasPassive(caster,"ExtraAttack_Bladesinging") == 0 and (Osi.HasPassive(caster,"ExtraAttack") == 1 or Osi.HasPassive(caster,"ExtraAttack_2") == 1) and (Osi.IsInForceTurnBasedMode(caster) == 1 or Osi.IsInCombat(caster) == 1) and HasPassive(caster,"RAW_OnTurnTracker") == 1 then
		Osi.ApplyStatus(caster, "RAW_EXTRA_ATTACK_WAR_MAGIC_REPLACEMENT",6.0,1,caster)
	elseif	(spell == "Target_GreenFlameBlade" or spell == "Target_BoomingBlade") and Osi.HasPassive(caster,"ExtraAttack_Bladesinging") == 1 and (Osi.IsInForceTurnBasedMode(caster) == 1 or Osi.IsInCombat(caster) == 1) and HasActiveStatus(caster,"RAW_EXTRA_ATTACK_BLADESINGING") == 0 and HasActiveStatus(caster,"RAW_EXTRA_ATTACK_CANTRIP") == 0 and HasPassive(caster,"RAW_OnTurnTracker") == 1 then
		Osi.ApplyStatus(caster, "RAW_EXTRA_ATTACK_CANTRIP",6.0,1,caster)
    end
end)

-- SCAGtrips Extra Attacks
Ext.Osiris.RegisterListener("StatusApplied", 4, "after", function (character, status, _, _)
	if (Osi.HasSpell(character,"Target_BoomingBlade") == 1 or Osi.HasSpell(character,"Target_GreenFlameBlade") == 1) and HasPassive(character,"RAW_OnTurnTracker") == 0 and HasPassive(character,"RAW_Loading_Block_ExtraAttack") == 0 and HasPassive(character,"RAW_Walk") == 0 then
		if	status == "EXTRA_ATTACK" then
			Osi.ApplyStatus(character, "EXTRA_ATTACK_REPLACEMENT",6.0,1,character)
		elseif	status == "EXTRA_ATTACK_THIRSTING_BLADE" then
			Osi.RemoveStatus(character, "EXTRA_ATTACK_THIRSTING_BLADE")
			Osi.RemoveStatus(character, "EXTRA_ATTACK_Q")
			Osi.ApplyStatus(character, "EXTRA_ATTACK_THIRSTING_BLADE_REPLACEMENT",6.0,1,character)
		elseif	status == "EXTRA_ATTACK_WAR_PRIEST" then
			Osi.ApplyStatus(character, "EXTRA_ATTACK_WAR_PRIEST_REPLACEMENT",6.0,1,character)
		elseif	status == "EXTRA_ATTACK_2" then
			Osi.ApplyStatus(character, "EXTRA_ATTACK_2_REPLACEMENT",6.0,1,character)
		elseif	status == "COMMANDERS_STRIKE_D8" then
			Osi.ApplyStatus(character, "COMMANDERS_STRIKE_D8_REPLACEMENT",6.0,1,character)
		elseif	status == "COMMANDERS_STRIKE_D10" then
			Osi.ApplyStatus(character, "COMMANDERS_STRIKE_D10_REPLACEMENT",6.0,1,character)
		elseif	status == "MAG_MARTIAL_EXERTION" then
			Osi.ApplyStatus(character, "MAG_MARTIAL_EXERTION_REPLACEMENT",6.0,1,character)
		elseif	status == "WILDSTRIKE_EXTRA_ATTACK" then
			Osi.ApplyStatus(character, "WILDSTRIKE_EXTRA_ATTACK_REPLACEMENT",6.0,1,character)
		elseif	status == "WILDSTRIKE_2_EXTRA_ATTACK" then
			Osi.ApplyStatus(character, "WILDSTRIKE_2_EXTRA_ATTACK_REPLACEMENT",6.0,1,character)
		elseif	status == "STALKERS_FLURRY" then
			Osi.ApplyStatus(character, "STALKERS_FLURRY_REPLACEMENT",6.0,1,character)
		elseif	(status == "EXTRA_ATTACK" or status == "EXTRA_ATTACK_THIRSTING_BLADE") and Osi.HasPassive(character,"ExtraAttack_Bladesinging") == 1 and Osi.HasActiveStatus(character,"EXTRA_ATTACK_BLADESINGING") == 0 then
			Osi.ApplyStatus(character, "EXTRA_ATTACK_BLADESINGING",6.0,1,character)
		end
	elseif (Osi.HasSpell(character,"Target_BoomingBlade") == 1 or Osi.HasSpell(character,"Target_GreenFlameBlade") == 1) and (HasPassive(character,"RAW_OnTurnTracker") == 1 or HasPassive(character,"RAW_Loading_Block_ExtraAttack") == 1 or HasPassive(character,"RAW_Walk") == 1) then
		if	status == "EXTRA_ATTACK" then
			Osi.ApplyStatus(character, "RAW_EXTRA_ATTACK_REPLACEMENT",6.0,1,character)
		elseif	status == "EXTRA_ATTACK_THIRSTING_BLADE" then
			Osi.RemoveStatus(character, "EXTRA_ATTACK_THIRSTING_BLADE")
			Osi.RemoveStatus(character, "EXTRA_ATTACK_Q")
			Osi.ApplyStatus(character, "RAW_EXTRA_ATTACK_THIRSTING_BLADE_REPLACEMENT",6.0,1,character)
		elseif	status == "EXTRA_ATTACK_WAR_PRIEST" then
			Osi.ApplyStatus(character, "EXTRA_ATTACK_WAR_PRIEST_REPLACEMENT",6.0,1,character)
		elseif	status == "EXTRA_ATTACK_2" then
			Osi.ApplyStatus(character, "RAW_EXTRA_ATTACK_2_REPLACEMENT",6.0,1,character)
		elseif	status == "COMMANDERS_STRIKE_D8" then
			Osi.ApplyStatus(character, "RAW_COMMANDERS_STRIKE_D8_REPLACEMENT",6.0,1,character)
		elseif	status == "COMMANDERS_STRIKE_D10" then
			Osi.ApplyStatus(character, "RAW_COMMANDERS_STRIKE_D10_REPLACEMENT",6.0,1,character)
		elseif	status == "MAG_MARTIAL_EXERTION" then
			Osi.ApplyStatus(character, "RAW_MAG_MARTIAL_EXERTION_REPLACEMENT",6.0,1,character)
		elseif	status == "WILDSTRIKE_EXTRA_ATTACK" then
			Osi.ApplyStatus(character, "RAW_WILDSTRIKE_EXTRA_ATTACK_REPLACEMENT",6.0,1,character)
		elseif	status == "WILDSTRIKE_2_EXTRA_ATTACK" then
			Osi.ApplyStatus(character, "RAW_WILDSTRIKE_2_EXTRA_ATTACK_REPLACEMENT",6.0,1,character)
		elseif	status == "STALKERS_FLURRY" then
			Osi.ApplyStatus(character, "RAW_STALKERS_FLURRY_REPLACEMENT",6.0,1,character)
		elseif	(status == "EXTRA_ATTACK" or status == "EXTRA_ATTACK_THIRSTING_BLADE") and Osi.HasPassive(character,"ExtraAttack_Bladesinging") == 1 and Osi.HasActiveStatus(character,"RAW_EXTRA_ATTACK_BLADESINGING") == 0 then
			Osi.ApplyStatus(character, "RAW_EXTRA_ATTACK_BLADESINGING",6.0,1,character)
		end
    end
end)

-- Slow Extra Attack Replacement Removal
Ext.Osiris.RegisterListener("StatusApplied", 4, "after", function (character, status, _, _)
	if status == "SLOW" then
		Osi.RemoveStatus(character,"EXTRA_ATTACK_REPLACEMENT")
		Osi.RemoveStatus(character,"EXTRA_ATTACK_2_REPLACEMENT")
		Osi.RemoveStatus(character,"EXTRA_ATTACK_THIRSTING_BLADE_REPLACEMENT")
		Osi.RemoveStatus(character,"EXTRA_ATTACK_WAR_MAGIC_REPLACEMENT")
		Osi.RemoveStatus(character,"EXTRA_ATTACK_WAR_PRIEST_REPLACEMENT")
		Osi.RemoveStatus(character,"STALKERS_FLURRY_REPLACEMENT")
		Osi.RemoveStatus(character,"MAG_MARTIAL_EXERTION")
		Osi.RemoveStatus(character,"COMMANDERS_STRIKE_D8_REPLACEMENT")
		Osi.RemoveStatus(character,"COMMANDERS_STRIKE_D10_REPLACEMENT")
		Osi.RemoveStatus(character,"WILDSTRIKE_EXTRA_ATTACK_REPLACEMENT")
		Osi.RemoveStatus(character,"WILDSTRIKE_EXTRA_ATTACK_REPLACEMENT")
		Osi.RemoveStatus(character,"WILDSTRIKE_2_EXTRA_ATTACK_REPLACEMENT")
		Osi.RemoveStatus(character,"RAW_EXTRA_ATTACK_REPLACEMENT")
		Osi.RemoveStatus(character,"RAW_EXTRA_ATTACK_2_REPLACEMENT")
		Osi.RemoveStatus(character,"RAW_EXTRA_ATTACK_THIRSTING_BLADE_REPLACEMENT")
		Osi.RemoveStatus(character,"RAW_EXTRA_ATTACK_WAR_MAGIC_REPLACEMENT")
		Osi.RemoveStatus(character,"RAW_EXTRA_ATTACK_WAR_PRIEST_REPLACEMENT")
		Osi.RemoveStatus(character,"RAW_STALKERS_FLURRY_REPLACEMENT")
		Osi.RemoveStatus(character,"RAW_MAG_MARTIAL_EXERTION")
		Osi.RemoveStatus(character,"RAW_COMMANDERS_STRIKE_D8_REPLACEMENT")
		Osi.RemoveStatus(character,"RAW_COMMANDERS_STRIKE_D10_REPLACEMENT")
		Osi.RemoveStatus(character,"RAW_WILDSTRIKE_EXTRA_ATTACK_REPLACEMENT")
		Osi.RemoveStatus(character,"RAW_WILDSTRIKE_EXTRA_ATTACK_REPLACEMENT")
		Osi.RemoveStatus(character,"RAW_WILDSTRIKE_2_EXTRA_ATTACK_REPLACEMENT")
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

--[[ Ritual Casting
Ext.Osiris.RegisterListener("StatusApplied", 4, "after", function (character, _, _, _)
	for i, name in pairs(Ext.Stats.GetStats("SpellData")) do
		local stat = Ext.Stats.Get(name)
		if stat.RitualCosts == "ActionPoint:1" then
			stat.RitualCosts = ""
			stat:Sync()
		end
	end
end)

-- Status Debug Text
Ext.Osiris.RegisterListener("StatusApplied", 4, "after", function (character, status, _, _)
	Osi.ShowNotification(character,status)
end)--]]