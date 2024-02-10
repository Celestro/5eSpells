local ritualspells = {
	S5E_RITUAL_SPELL_CEREMONY = "Target_Ceremony",
	S5E_RITUAL_SPELL_DETECT_MAGIC = "Shout_DetectMagic",
	S5E_RITUAL_SPELL_UNSEEN_SERVANT = "Target_UnseenServant",
	S5E_RITUAL_SPELL_WATER_WALK = "Shout_WaterWalk",
	S5E_RITUAL_SPELL_COMMUNE_WITH_NATURE = "Shout_CommuneWithNature",
	S5E_RITUAL_SPELL_TELEPATHIC_BOND = "Target_RarysTelepathicBond",
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

-- Ritual Spells Status Check 1
Ext.Osiris.RegisterListener("GainedControl", 1, "after", function(character)
	DelayedCall(3000, function ()
		if	Osi.IsTagged(character,"BARD_d93434bd-6b71-4789-b128-ee24156057cc") == 0 and Osi.IsTagged(character,"CLERIC_1671b4bf-4f47-4bb7-9cb9-80bb1f6009d5") == 0 and Osi.IsTagged(character,"DRUID_44ac4317-4d38-4d28-80e2-94024c6e42f0") == 0 and Osi.IsTagged(character,"WIZARD_6fe3ae27-dc6c-4fc9-9245-710c790c396c") == 0 and HasPassive(character,"BookOfAncientSecrets") == 0 and Osi.IsTagged(character,"PALADIN_6d85ab2d-5c23-498c-a61e-98f05a00177a") == 0 then
			for _,fc in pairs(Ext.Entity.Get(character).LevelUp.field_18) do
				for _,sc in pairs(fc.Upgrades.Spells) do
					if	sc.Class ~= "f3370916-6b35-4c5b-af36-19ca888cb43e" then
						for _,spell in pairs(sc.Spells) do
							for _,tc in pairs(Ext.Entity.Get(character).SpellBook.Spells) do
								for status,spellname in pairs(ritualspells) do
									if spell == spellname then
										local ritualspell = Ext.Stats.Get(spellname)
										ritualspell.RitualCosts = ""
										ritualspell:Sync()
	--[[									local disname = Osi.GetDisplayName(character)
										local name = Osi.ResolveTranslatedString(disname)
										local spellsname = Osi.ResolveTranslatedString(ritualspell.DisplayName)
										local strg = name .. "'s " .. spellsname
										_D(strg .. " isn't a ritual spell")--]]
									elseif tc.Id.Prototype == spellname then
										local ritualspell = Ext.Stats.Get(spellname)
										ritualspell.RitualCosts = ""
										ritualspell:Sync()
	--[[									local disname = Osi.GetDisplayName(character)
										local name = Osi.ResolveTranslatedString(disname)
										local spellsname = Osi.ResolveTranslatedString(ritualspell.DisplayName)
										local strg = name .. "'s " .. spellsname
										_D(strg .. " isn't a ritual spell")--]]
									end
								end
							end
						end
					end
				end
			end
		elseif	Osi.IsTagged(character,"BARD_d93434bd-6b71-4789-b128-ee24156057cc") == 1 or Osi.IsTagged(character,"CLERIC_1671b4bf-4f47-4bb7-9cb9-80bb1f6009d5") == 1 or Osi.IsTagged(character,"DRUID_44ac4317-4d38-4d28-80e2-94024c6e42f0") == 1 or Osi.IsTagged(character,"WIZARD_6fe3ae27-dc6c-4fc9-9245-710c790c396c") == 1 or HasPassive(character,"BookOfAncientSecrets") == 1 then
		   for _, name in pairs(ritualspells) do
				local spell = Ext.Stats.Get(name)
				spell.RitualCosts = "ActionPoint:1"
				spell:Sync()
	--[[			local namestrg = Osi.GetDisplayName(character)
				local disname = Osi.ResolveTranslatedString(namestrg)
				local spellsname = Osi.ResolveTranslatedString(spell.DisplayName)
				local strg = namestrg .. "'s " .. spellsname
				_D(strg .. " is a ritual spell")--]]
			end
		end

		if	Osi.IsTagged(character,"PALADIN_6d85ab2d-5c23-498c-a61e-98f05a00177a") == 1 then
			for _,fc in pairs(Ext.Entity.Get(character).SpellBook.Spells) do
				for status,spellname in pairs(ritualspells) do
					if fc.Id.Prototype == spellname then
						local ritualspell = Ext.Stats.Get(spellname)
						ritualspell.RitualCosts = ""
						ritualspell:Sync()
	--[[					local disname = Osi.GetDisplayName(character)
						local name = Osi.ResolveTranslatedString(disname)
						local spellsname = Osi.ResolveTranslatedString(ritualspell.DisplayName)
						local strg = name .. "'s the Paladin" .. spellsname
						_D(strg .. " isn't a ritual spell")--]]
					end
				end
			end
		end

		if	HasPassive(character,"RitualCaster_FreeSpells") == 1 then
			for _,fc in pairs(Ext.Entity.Get(character).LevelUp.field_18) do
				for _,sc in pairs(fc.Upgrades.Spells) do
					if	sc.Class == "f3370916-6b35-4c5b-af36-19ca888cb43e" then
						for _,spell in pairs(sc.Spells) do
							for status,spellname in pairs(ritualspells) do
								if spell == spellname then
									local ritualspell = Ext.Stats.Get(spellname)
									ritualspell.RitualCosts = "ActionPoint:1"
									ritualspell:Sync()
	--[[								local disname = Osi.GetDisplayName(character)
									local name = Osi.ResolveTranslatedString(disname)
									local spellsname = Osi.ResolveTranslatedString(ritualspell.DisplayName)
									local strg = name .. "'s " .. spellsname
									_D(strg .. " should always be a ritual spell")--]]
								end
							end
						end
					end
				end
			end
		end

		if Osi.IsTagged(character,"WIZARD_6fe3ae27-dc6c-4fc9-9245-710c790c396c") == 1 or HasPassive(character,"BookOfAncientSecrets") == 1 then
			for status, spell in pairs(ritualspells) do
				if HasSpell(character,spell) == 1 and Osi.HasActiveStatus(character,status) == 0 then
					Osi.ApplyStatus(character,status,-1.0,1,character)
				end

				if HasSpell(character,"Target_FindFamiliar") == 1 and Osi.HasActiveStatus(character,"S5E_RITUAL_SPELL_FIND_FAMILIAR") == 0 then
					Osi.ApplyStatus(character,"S5E_RITUAL_SPELL_FIND_FAMILIAR",-1.0,1,character)
				end
			end
		end
	end)
end)

--_D(Ext.Entity.Get(entity.Uuid.EntityUuid).LevelUp.field_18[4].Upgrades.Spells[3].Spells[1])

-- Ritual Spells Status Check 2
Ext.Osiris.RegisterListener("LeveledUp", 1, "after", function(character)
	DelayedCall(2000, function ()
		if Osi.IsTagged(character,"WIZARD_6fe3ae27-dc6c-4fc9-9245-710c790c396c") == 1 or HasPassive(character,"BookOfAncientSecrets") == 1 then
			for status, spell in pairs(ritualspells) do
				if Osi.HasSpell(character,spell) == 1 and Osi.HasActiveStatus(character,status) == 0 then
					Osi.ApplyStatus(character,status,-1.0,1,character)
				end

				if HasSpell(character,"Target_FindFamiliar") == 1 and Osi.HasActiveStatus(character,"S5E_RITUAL_SPELL_FIND_FAMILIAR") == 0 then
					Osi.ApplyStatus(character,"S5E_RITUAL_SPELL_FIND_FAMILIAR",-1.0,1,character)
				end
			end
		end

		if	Osi.IsTagged(character,"BARD_d93434bd-6b71-4789-b128-ee24156057cc") == 0 and Osi.IsTagged(character,"CLERIC_1671b4bf-4f47-4bb7-9cb9-80bb1f6009d5") == 0 and Osi.IsTagged(character,"DRUID_44ac4317-4d38-4d28-80e2-94024c6e42f0") == 0 and Osi.IsTagged(character,"WIZARD_6fe3ae27-dc6c-4fc9-9245-710c790c396c") == 0 and HasPassive(character,"BookOfAncientSecrets") == 0 and Osi.IsTagged(character,"PALADIN_6d85ab2d-5c23-498c-a61e-98f05a00177a") == 0 then
			for _,fc in pairs(Ext.Entity.Get(character).LevelUp.field_18) do
				for _,sc in pairs(fc.Upgrades.Spells) do
					if	sc.Class ~= "f3370916-6b35-4c5b-af36-19ca888cb43e" then
						for _,spell in pairs(sc.Spells) do
							for _,tc in pairs(Ext.Entity.Get(character).SpellBook.Spells) do
								for status,spellname in pairs(ritualspells) do
									if spell == spellname then
										local ritualspell = Ext.Stats.Get(spellname)
										ritualspell.RitualCosts = ""
										ritualspell:Sync()
									elseif tc.Id.Prototype == spellname then
										local ritualspell = Ext.Stats.Get(spellname)
										ritualspell.RitualCosts = ""
										ritualspell:Sync()
									end
								end
							end
						end
					end
				end
			end
		elseif	Osi.IsTagged(character,"BARD_d93434bd-6b71-4789-b128-ee24156057cc") == 1 or Osi.IsTagged(character,"CLERIC_1671b4bf-4f47-4bb7-9cb9-80bb1f6009d5") == 1 or Osi.IsTagged(character,"DRUID_44ac4317-4d38-4d28-80e2-94024c6e42f0") == 1 or Osi.IsTagged(character,"WIZARD_6fe3ae27-dc6c-4fc9-9245-710c790c396c") == 1 or HasPassive(character,"BookOfAncientSecrets") == 1 then
		   for _, name in pairs(ritualspells) do
				local spell = Ext.Stats.Get(name)
				spell.RitualCosts = "ActionPoint:1"
				spell:Sync()
			end
		end

		if	Osi.IsTagged(character,"PALADIN_6d85ab2d-5c23-498c-a61e-98f05a00177a") == 1 then
			for _,fc in pairs(Ext.Entity.Get(character).SpellBook.Spells) do
				for status,spellname in pairs(ritualspells) do
					if fc.Id.Prototype == spellname then
						local ritualspell = Ext.Stats.Get(spellname)
						ritualspell.RitualCosts = ""
						ritualspell:Sync()
						local disname = Osi.GetDisplayName(character)
						local name = Osi.ResolveTranslatedString(disname)
						local spellsname = Osi.ResolveTranslatedString(ritualspell.DisplayName)
						local strg = name .. "'s " .. spellsname
--						_D(strg .. " isn't a ritual spell")
					end
				end
			end
		end

		if	HasPassive(character,"RitualCaster_FreeSpells") == 1 then
			for _,fc in pairs(Ext.Entity.Get(character).LevelUp.field_18) do
				for _,sc in pairs(fc.Upgrades.Spells) do
					if	sc.Class == "f3370916-6b35-4c5b-af36-19ca888cb43e" then
						for _,spell in pairs(sc.Spells) do
							for status,spellname in pairs(ritualspells) do
								if spell == spellname then
									local ritualspell = Ext.Stats.Get(spellname)
									ritualspell.RitualCosts = "ActionPoint:1"
									ritualspell:Sync()
								end
							end
						end
					end
				end
			end
		end
	end)
end)

-- Ritual Spells Status Check 3
Ext.Osiris.RegisterListener("LearnedSpell", 2, "after", function(character, spell)
	DelayedCall(2000, function ()
		if Osi.IsTagged(character,"WIZARD_6fe3ae27-dc6c-4fc9-9245-710c790c396c") == 1 or HasPassive(character,"BookOfAncientSecrets") == 1 then
			for status, spellname in pairs(ritualspells) do
				if spell == spellname and Osi.HasActiveStatus(character,status) == 0 then
					Osi.ApplyStatus(character,status,-1.0,1,character)
				end

				if HasSpell(character,"Target_FindFamiliar") == 1 and Osi.HasActiveStatus(character,"S5E_RITUAL_SPELL_FIND_FAMILIAR") == 0 then
					Osi.ApplyStatus(character,"S5E_RITUAL_SPELL_FIND_FAMILIAR",-1.0,1,character)
				end
			end
		end

		if	Osi.IsTagged(character,"BARD_d93434bd-6b71-4789-b128-ee24156057cc") == 0 and Osi.IsTagged(character,"CLERIC_1671b4bf-4f47-4bb7-9cb9-80bb1f6009d5") == 0 and Osi.IsTagged(character,"DRUID_44ac4317-4d38-4d28-80e2-94024c6e42f0") == 0 and Osi.IsTagged(character,"WIZARD_6fe3ae27-dc6c-4fc9-9245-710c790c396c") == 0 and HasPassive(character,"BookOfAncientSecrets") == 0 and Osi.IsTagged(character,"PALADIN_6d85ab2d-5c23-498c-a61e-98f05a00177a") == 0 then
			for _,fc in pairs(Ext.Entity.Get(character).LevelUp.field_18) do
				for _,sc in pairs(fc.Upgrades.Spells) do
					if	sc.Class ~= "f3370916-6b35-4c5b-af36-19ca888cb43e" then
						for _,spell in pairs(sc.Spells) do
							for _,tc in pairs(Ext.Entity.Get(character).SpellBook.Spells) do
								for status,spellname in pairs(ritualspells) do
									if spell == spellname then
										local ritualspell = Ext.Stats.Get(spellname)
										ritualspell.RitualCosts = ""
										ritualspell:Sync()
									elseif tc.Id.Prototype == spellname then
										local ritualspell = Ext.Stats.Get(spellname)
										ritualspell.RitualCosts = ""
										ritualspell:Sync()
									end
								end
							end
						end
					end
				end
			end
		elseif	Osi.IsTagged(character,"BARD_d93434bd-6b71-4789-b128-ee24156057cc") == 1 or Osi.IsTagged(character,"CLERIC_1671b4bf-4f47-4bb7-9cb9-80bb1f6009d5") == 1 or Osi.IsTagged(character,"DRUID_44ac4317-4d38-4d28-80e2-94024c6e42f0") == 1 or Osi.IsTagged(character,"WIZARD_6fe3ae27-dc6c-4fc9-9245-710c790c396c") == 1 or HasPassive(character,"BookOfAncientSecrets") == 1 then
		   for _, name in pairs(ritualspells) do
				local spell = Ext.Stats.Get(name)
				spell.RitualCosts = "ActionPoint:1"
				spell:Sync()
			end
		end

		if	Osi.IsTagged(character,"PALADIN_6d85ab2d-5c23-498c-a61e-98f05a00177a") == 1 then
			for _,fc in pairs(Ext.Entity.Get(character).SpellBook.Spells) do
				for status,spellname in pairs(ritualspells) do
					if fc.Id.Prototype == spellname then
						local ritualspell = Ext.Stats.Get(spellname)
						ritualspell.RitualCosts = ""
						ritualspell:Sync()
						local disname = Osi.GetDisplayName(character)
						local name = Osi.ResolveTranslatedString(disname)
						local spellsname = Osi.ResolveTranslatedString(ritualspell.DisplayName)
						local strg = name .. "'s " .. spellsname
--						_D(strg .. " isn't a ritual spell")
					end
				end
			end
		end

		if	HasPassive(character,"RitualCaster_FreeSpells") == 1 then
			for _,fc in pairs(Ext.Entity.Get(character).LevelUp.field_18) do
				for _,sc in pairs(fc.Upgrades.Spells) do
					if	sc.Class == "f3370916-6b35-4c5b-af36-19ca888cb43e" then
						for _,spell in pairs(sc.Spells) do
							for status,spellname in pairs(ritualspells) do
								if spell == spellname then
									local ritualspell = Ext.Stats.Get(spellname)
									ritualspell.RitualCosts = "ActionPoint:1"
									ritualspell:Sync()
								end
							end
						end
					end
				end
			end
		end
	end)
end)

-- Ritual Spells Status Check 4
Ext.Osiris.RegisterListener("RespecCompleted", 1, "after", function(character)
	DelayedCall(2000, function ()
		if Osi.IsTagged(character,"WIZARD_6fe3ae27-dc6c-4fc9-9245-710c790c396c") == 1 or HasPassive(character,"BookOfAncientSecrets") == 1 then
			for status, spell in pairs(ritualspells) do
				if HasSpell(character,spell) == 1 and Osi.HasActiveStatus(character,status) == 0 then
					Osi.ApplyStatus(character,status,-1.0,1,character)
				end

				if HasSpell(character,"Target_FindFamiliar") == 1 and Osi.HasActiveStatus(character,"S5E_RITUAL_SPELL_FIND_FAMILIAR") == 0 then
					Osi.ApplyStatus(character,"S5E_RITUAL_SPELL_FIND_FAMILIAR",-1.0,1,character)
				end
			end
		end

		if	Osi.IsTagged(character,"BARD_d93434bd-6b71-4789-b128-ee24156057cc") == 0 and Osi.IsTagged(character,"CLERIC_1671b4bf-4f47-4bb7-9cb9-80bb1f6009d5") == 0 and Osi.IsTagged(character,"DRUID_44ac4317-4d38-4d28-80e2-94024c6e42f0") == 0 and Osi.IsTagged(character,"WIZARD_6fe3ae27-dc6c-4fc9-9245-710c790c396c") == 0 and HasPassive(character,"BookOfAncientSecrets") == 0 and Osi.IsTagged(character,"PALADIN_6d85ab2d-5c23-498c-a61e-98f05a00177a") == 0 then
			for _,fc in pairs(Ext.Entity.Get(character).LevelUp.field_18) do
				for _,sc in pairs(fc.Upgrades.Spells) do
					if	sc.Class ~= "f3370916-6b35-4c5b-af36-19ca888cb43e" then
						for _,spell in pairs(sc.Spells) do
							for _,tc in pairs(Ext.Entity.Get(character).SpellBook.Spells) do
								for status,spellname in pairs(ritualspells) do
									if spell == spellname then
										local ritualspell = Ext.Stats.Get(spellname)
										ritualspell.RitualCosts = ""
										ritualspell:Sync()
									elseif tc.Id.Prototype == spellname then
										local ritualspell = Ext.Stats.Get(spellname)
										ritualspell.RitualCosts = ""
										ritualspell:Sync()
									end
								end
							end
						end
					end
				end
			end
		elseif	Osi.IsTagged(character,"BARD_d93434bd-6b71-4789-b128-ee24156057cc") == 1 or Osi.IsTagged(character,"CLERIC_1671b4bf-4f47-4bb7-9cb9-80bb1f6009d5") == 1 or Osi.IsTagged(character,"DRUID_44ac4317-4d38-4d28-80e2-94024c6e42f0") == 1 or Osi.IsTagged(character,"WIZARD_6fe3ae27-dc6c-4fc9-9245-710c790c396c") == 1 or HasPassive(character,"BookOfAncientSecrets") == 1 then
		   for _, name in pairs(ritualspells) do
				local spell = Ext.Stats.Get(name)
				spell.RitualCosts = "ActionPoint:1"
				spell:Sync()
			end
		end

		if	Osi.IsTagged(character,"PALADIN_6d85ab2d-5c23-498c-a61e-98f05a00177a") == 1 then
			for _,fc in pairs(Ext.Entity.Get(character).SpellBook.Spells) do
				for status,spellname in pairs(ritualspells) do
					if fc.Id.Prototype == spellname then
						local ritualspell = Ext.Stats.Get(spellname)
						ritualspell.RitualCosts = ""
						ritualspell:Sync()
--[[						local disname = Osi.GetDisplayName(character)
						local name = Osi.ResolveTranslatedString(disname)
						local spellsname = Osi.ResolveTranslatedString(ritualspell.DisplayName)
						local strg = name .. "'s " .. spellsname
						_D(strg .. " isn't a ritual spell")--]]
					end
				end
			end
		end

		if	HasPassive(character,"RitualCaster_FreeSpells") == 1 then
			for _,fc in pairs(Ext.Entity.Get(character).LevelUp.field_18) do
				for _,sc in pairs(fc.Upgrades.Spells) do
					if	sc.Class == "f3370916-6b35-4c5b-af36-19ca888cb43e" then
						for _,spell in pairs(sc.Spells) do
							for status,spellname in pairs(ritualspells) do
								if spell == spellname then
									local ritualspell = Ext.Stats.Get(spellname)
									ritualspell.RitualCosts = "ActionPoint:1"
									ritualspell:Sync()
								end
							end
						end
					end
				end
			end
		end
	end)
end)