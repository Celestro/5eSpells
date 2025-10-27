local ritualspells = {
	S5E_RITUAL_SPELL_CEREMONY = "Target_Ceremony",
	S5E_RITUAL_SPELL_DETECT_MAGIC = "Shout_DetectMagic",
	S5E_RITUAL_SPELL_UNSEEN_SERVANT = "Target_UnseenServant",
	S5E_RITUAL_SPELL_WATER_WALK = "Shout_WaterWalk",
	S5E_RITUAL_SPELL_COMMUNE_WITH_NATURE = "Shout_CommuneWithNature",
	S5E_RITUAL_SPELL_TELEPATHIC_BOND = "Target_RarysTelepathicBond",
	S5E_RITUAL_SPELL_SILENCE = "Target_Silence",
	S5E_RITUAL_SPELL_FEIGN_DEATH = "Target_FeignDeath",
	S5E_RITUAL_SPELL_SPEAK_WITH_ANIMALS = "Shout_SpeakWithAnimals",
	S5E_RITUAL_SPELL_FIND_FAMILIAR = "Target_FindFamiliar",
	S5E_RITUAL_SPELL_GENTLE_REPOSE = "Target_GentleRepose"
}

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

local function RitualSpellEnabled()
  return _G.RitualSpellsEnabled ~= false
end

-- Ritual Spells Status Check 1
Ext.Osiris.RegisterListener("GainedControl", 1, "after", function(character)
    if not RitualSpellEnabled() then return end
	DelayedCall(1000, function ()
		if (Osi.HasPassive(character,"S5E_RitualCasting_Wizard")) == 1 or (HasPassive(character,"PactOfTheTome") == 1 and HasPassive(character,"BookOfAncientSecrets") == 1 and Osi.HasPassive(character,"S5E_RitualCasting_Warlock") == 1) then
			for _,spelldata in pairs(Ext.Entity.Get(character).SpellBook.Spells) do
				if spelldata.Id.SourceType == "ProgressionClass" or spelldata.Id.SourceType == "ProgressionSubClass" or spelldata.Id.SourceType == "Boost" or spelldata.Id.SourceType == "Boost2" or spelldata.Id.SourceType == "Learned" or spelldata.Id.SourceType == "Progression" or spelldata.Id.SourceType == "ProgressionRace" then
--					_D("Spelldata is " .. spelldata.Id.Prototype)
					for status, spellname in pairs(ritualspells) do
						local spell = Ext.Stats.Get(spelldata.Id.Prototype)
						if (spellname == spelldata.Id.Prototype or spellname == spell.Using) and spellname ~= "Target_FindFamiliar" and spellname ~= "Shout_SpeakWithAnimals" and spellname ~= "Target_Silence" and Osi.HasActiveStatus(character,status) == 0 then
							Osi.ApplyStatus(character,status,-1.0,1,character)
						end

						if (spellname == spelldata.Id.Prototype or spellname == spell.Using) and HasSpell(character,"Target_FindFamiliar_Ritual") == 0 and Osi.HasActiveStatus(character,"S5E_RITUAL_SPELL_FIND_FAMILIAR") == 0 then
							Osi.ApplyStatus(character,"S5E_RITUAL_SPELL_FIND_FAMILIAR",-1.0,1,character)
						end

						if (spellname == spelldata.Id.Prototype or spellname == spell.Using) and HasSpell(character,"Shout_SpeakWithAnimals_Ritual") == 0 and HasSpell(character,"Shout_SpeakWithAnimals_BeastSpeech") == 0 and HasSpell(character,"Shout_SpeakWithAnimals_SpiritSeeker") == 0 and HasSpell(character,"Shout_SpeakWithAnimals_Barbarian") == 0 and HasSpell(character,"Shout_SpeakWithAnimals_ForestGnome") == 0 and Osi.HasActiveStatus(character,"S5E_RITUAL_SPELL_SPEAK_WITH_ANIMALS") == 0 then
							Osi.ApplyStatus(character,"S5E_RITUAL_SPELL_SPEAK_WITH_ANIMALS",-1.0,1,character)
						end

						if (spellname == spelldata.Id.Prototype or spellname == spell.Using) and HasSpell(character,"Target_Silence_Ritual") == 0 and Osi.HasActiveStatus(character,"S5E_RITUAL_SPELL_SILENCE") == 0 then
							Osi.ApplyStatus(character,"S5E_RITUAL_SPELL_SILENCE",-1.0,1,character)
						end
					end
				end
			end
		elseif (Osi.HasPassive(character,"S5E_RitualCasting_Wizard")) == 0 or ( Osi.HasPassive(character,"S5E_RitualCasting_Warlock") == 0) then
			Osi.ApplyStatus(character,"S5E_RITUAL_SPELL_REMOVAL",0.0,1)
		end
	end)
end)

-- Ritual Spells Status Check 2
Ext.Osiris.RegisterListener("LeveledUp", 1, "after", function(character)
    if not RitualSpellEnabled() then return end
	DelayedCall(1000, function ()
		if (Osi.HasPassive(character,"S5E_RitualCasting_Wizard")) == 1 or (HasPassive(character,"PactOfTheTome") == 1 and HasPassive(character,"BookOfAncientSecrets") == 1 and Osi.HasPassive(character,"S5E_RitualCasting_Warlock") == 1) then
			for _,spelldata in pairs(Ext.Entity.Get(character).SpellBook.Spells) do
				if spelldata.Id.SourceType == "ProgressionClass" or spelldata.Id.SourceType == "ProgressionSubClass" or spelldata.Id.SourceType == "Boost" or spelldata.Id.SourceType == "Boost2" or spelldata.Id.SourceType == "Learned" or spelldata.Id.SourceType == "Progression" or spelldata.Id.SourceType == "ProgressionRace" then
--					_D("Spelldata is " .. spelldata.Id.Prototype)
					for status, spellname in pairs(ritualspells) do
						local spell = Ext.Stats.Get(spelldata.Id.Prototype)
						if (spellname == spelldata.Id.Prototype or spellname == spell.Using) and spellname ~= "Target_FindFamiliar" and spellname ~= "Shout_SpeakWithAnimals" and spellname ~= "Target_Silence" and Osi.HasActiveStatus(character,status) == 0 then
							Osi.ApplyStatus(character,status,-1.0,1,character)
						end

						if (spellname == spelldata.Id.Prototype or spellname == spell.Using) and HasSpell(character,"Target_FindFamiliar_Ritual") == 0 and Osi.HasActiveStatus(character,"S5E_RITUAL_SPELL_FIND_FAMILIAR") == 0 then
							Osi.ApplyStatus(character,"S5E_RITUAL_SPELL_FIND_FAMILIAR",-1.0,1,character)
						end

						if (spellname == spelldata.Id.Prototype or spellname == spell.Using) and HasSpell(character,"Shout_SpeakWithAnimals_Ritual") == 0 and HasSpell(character,"Shout_SpeakWithAnimals_BeastSpeech") == 0 and HasSpell(character,"Shout_SpeakWithAnimals_SpiritSeeker") == 0 and HasSpell(character,"Shout_SpeakWithAnimals_Barbarian") == 0 and HasSpell(character,"Shout_SpeakWithAnimals_ForestGnome") == 0 and Osi.HasActiveStatus(character,"S5E_RITUAL_SPELL_SPEAK_WITH_ANIMALS") == 0 then
							Osi.ApplyStatus(character,"S5E_RITUAL_SPELL_SPEAK_WITH_ANIMALS",-1.0,1,character)
						end

						if (spellname == spelldata.Id.Prototype or spellname == spell.Using) and HasSpell(character,"Target_Silence_Ritual") == 0 and Osi.HasActiveStatus(character,"S5E_RITUAL_SPELL_SILENCE") == 0 then
							Osi.ApplyStatus(character,"S5E_RITUAL_SPELL_SILENCE",-1.0,1,character)
						end
					end
				end
			end
		elseif (Osi.HasPassive(character,"S5E_RitualCasting_Wizard")) == 0 or ( Osi.HasPassive(character,"S5E_RitualCasting_Warlock") == 0) then
			Osi.ApplyStatus(character,"S5E_RITUAL_SPELL_REMOVAL",0.0,1)
		end
	end)
end)

-- Ritual Spells Status Check 3
Ext.Osiris.RegisterListener("RespecCompleted", 1, "after", function(character)
    if not RitualSpellEnabled() then return end
	DelayedCall(1000, function ()
		if (Osi.HasPassive(character,"S5E_RitualCasting_Wizard")) == 1 or (HasPassive(character,"PactOfTheTome") == 1 and HasPassive(character,"BookOfAncientSecrets") == 1 and Osi.HasPassive(character,"S5E_RitualCasting_Warlock") == 1) then
			for _,spelldata in pairs(Ext.Entity.Get(character).SpellBook.Spells) do
				if spelldata.Id.SourceType == "ProgressionClass" or spelldata.Id.SourceType == "ProgressionSubClass" or spelldata.Id.SourceType == "Boost" or spelldata.Id.SourceType == "Boost2" or spelldata.Id.SourceType == "Learned" or spelldata.Id.SourceType == "Progression" or spelldata.Id.SourceType == "ProgressionRace" then
--					_D("Spelldata is " .. spelldata.Id.Prototype)
					for status, spellname in pairs(ritualspells) do
						local spell = Ext.Stats.Get(spelldata.Id.Prototype)
						if (spellname == spelldata.Id.Prototype or spellname == spell.Using) and spellname ~= "Target_FindFamiliar" and spellname ~= "Shout_SpeakWithAnimals" and spellname ~= "Target_Silence" and Osi.HasActiveStatus(character,status) == 0 then
							Osi.ApplyStatus(character,status,-1.0,1,character)
						end

						if (spellname == spelldata.Id.Prototype or spellname == spell.Using) and HasSpell(character,"Target_FindFamiliar_Ritual") == 0 and Osi.HasActiveStatus(character,"S5E_RITUAL_SPELL_FIND_FAMILIAR") == 0 then
							Osi.ApplyStatus(character,"S5E_RITUAL_SPELL_FIND_FAMILIAR",-1.0,1,character)
						end

						if (spellname == spelldata.Id.Prototype or spellname == spell.Using) and HasSpell(character,"Shout_SpeakWithAnimals_Ritual") == 0 and HasSpell(character,"Shout_SpeakWithAnimals_BeastSpeech") == 0 and HasSpell(character,"Shout_SpeakWithAnimals_SpiritSeeker") == 0 and HasSpell(character,"Shout_SpeakWithAnimals_Barbarian") == 0 and HasSpell(character,"Shout_SpeakWithAnimals_ForestGnome") == 0 and Osi.HasActiveStatus(character,"S5E_RITUAL_SPELL_SPEAK_WITH_ANIMALS") == 0 then
							Osi.ApplyStatus(character,"S5E_RITUAL_SPELL_SPEAK_WITH_ANIMALS",-1.0,1,character)
						end

						if (spellname == spelldata.Id.Prototype or spellname == spell.Using) and HasSpell(character,"Target_Silence_Ritual") == 0 and Osi.HasActiveStatus(character,"S5E_RITUAL_SPELL_SILENCE") == 0 then
							Osi.ApplyStatus(character,"S5E_RITUAL_SPELL_SILENCE",-1.0,1,character)
						end
					end
				end
			end
		elseif (Osi.HasPassive(character,"S5E_RitualCasting_Wizard")) == 0 or ( Osi.HasPassive(character,"S5E_RitualCasting_Warlock") == 0) then
			Osi.ApplyStatus(character,"S5E_RITUAL_SPELL_REMOVAL",0.0,1)
		end
	end)
end)