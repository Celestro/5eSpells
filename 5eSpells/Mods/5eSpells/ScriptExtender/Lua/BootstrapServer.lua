-- Spiritual Weapon Scaling
--local SpiritualWeapon = function (character, status, causee)
--	if status == "SPIRITUAL_WEAPON_TETHERED" then
--		Osi.ApplyStatus(character, status, -1.0, 1, character)
--		end
--	end
--end

--Ext.Osiris.RegisterListener("StatusApplied", 3, "after", SpiritualWeapon)

-- Maximilian's Earthen Grasp
local MaximiliansEarthGrasp = function (character, status, causee)
	if status == "MAXIMILIANS_EARTHEN_GRASP" then
		Osi.SetVarObject(character, "MEGSource", causee)
		Osi.SetVarObject(causee, "MEGTarget", character)
		Osi.AddSpell(causee,"Target_MaximiliansEarthenGrasp_Spells",0,0)
	end
end

Ext.Osiris.RegisterListener("StatusApplied", 3, "after", MaximiliansEarthGrasp)

-- Maximilian's Earthen Grasp Cast on new target w/ status
local MaximiliansEarthGraspReapplied = function (character, status, causee)
	if HasActiveStatus(causee,"MAXIMILIANS_EARTHEN_GRASP_CASTER") == 1 and status == "MAXIMILIANS_EARTHEN_GRASP_CHANGE" then
		local affected = GetVarObject(causee,"MEGTarget")
		local turns = GetStatusTurns(causee,"MAXIMILIANS_EARTHEN_GRASP_CASTER")
		turns = turns * 6
		local rturns = IntegerToReal(turns)
		Osi.RemoveStatus(affected,"MAXIMILIANS_EARTHEN_GRASP")
		Osi.ApplyStatus(character,"MAXIMILIANS_EARTHEN_GRASP",rturns,0,causee)
		Osi.SetVarObject(character, "MEGSource", causee)
		Osi.SetVarObject(causee, "MEGTarget", character)
	end
end

Ext.Osiris.RegisterListener("StatusApplied", 3, "after", MaximiliansEarthGraspReapplied)

-- Maximilian's Earthen Grasp removal from new target
local MaximiliansEarthGraspRemoval = function (character, status, causee)
	if status == "MAXIMILIANS_EARTHEN_GRASP_CASTER" then
		local affected = GetVarObject(character,"MEGTarget")
		if HasActiveStatus(affected,"MAXIMILIANS_EARTHEN_GRASP") == 1 then
			Osi.RemoveStatus(affected,"MAXIMILIANS_EARTHEN_GRASP")
			Osi.ClearVarObject(affected, "MEGSource")
			Osi.ClearVarObject(character, "MEGTarget")
			Osi.RemoveSpell(character,"Target_MaximiliansEarthenGrasp_Spells")
		end
	end
end

Ext.Osiris.RegisterListener("StatusRemoved", 3, "after", MaximiliansEarthGraspRemoval)

-- Vampiric Touch
local VampiricTouchProc = function (character, spell, spelltype, spellelement, storyid)
	if spell == "Target_VampiricTouch" or spell == "Target_VampiricTouch_Free" then
		ApplyStatus(character,"VAMPIRIC_TOUCH_PROC",100,1)
	end
end

Ext.Osiris.RegisterListener("UsingSpell", 5, "before", VampiricTouchProc)

-- Vampiric Touch Heal
local VampiricTouchHeal = function (defender, attackowner, attacker, damagetype, damage, damagecause, storyid)
	local hp = GetHitpoints(attacker)
	if HasActiveStatus(attacker,"VAMPIRIC_TOUCH_PROC") == 1 and damagetype == "Necrotic" then
		damage = damage / 2
		hp = hp + damage
		Osi.SetHitpoints(attacker,hp)
	end
end

Ext.Osiris.RegisterListener("AttackedBy", 7, "after", VampiricTouchHeal)

-- Blink Setup
local Blink = function (character)
	if HasActiveStatus(character,"BLINK") == 1 then
		local ran = Random(20)
		if ran > 9 then
			Osi.ApplyStatus(character,"BANISHED",6.0,1)
		end
	end
end

Ext.Osiris.RegisterListener("TurnEnded", 1, "before", Blink)

-- Blink Removal
local BlinkRemoval = function (character, spell, spelltype, element, id)
	if spell == "Target_Blink_Activate" then
		Osi.RemoveStatus(character,"BLINK")
		Osi.RemoveStatus(character,"BLINK_ACTIVATE")
		Osi.RemoveStatus(character,"BANISHED")
	end
end

Ext.Osiris.RegisterListener("CastedSpell", 5, "after", BlinkRemoval)

-- Thunder Step
local ThunderStep = function (character, x, y, z, spell, spelltype, spellelement, id)
	local oldx, oldy, oldz = GetPosition(character)
	if spell == "Target_ThunderStep" then
		Osi.CreateExplosionAtPosition(oldx, oldy, oldz, "Projectile_ThunderStep_Explosion", 1, character)
	end
end

Ext.Osiris.RegisterListener("UsingSpellAtPosition", 8, "before", ThunderStep)