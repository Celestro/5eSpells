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

Ext.RegisterListener("OnDealDamage", function (functor, caster, target, position, isFromItem, spellId, originator, hit, damageSums, hitWith)
    --Ext.Utils.PrintWarning("Functor is: " .. tostring(functor))
    --for k,v in pairs(functor) do
    --    Ext.Utils.Print(k .. ": " .. Ext.Json.Stringify(v, true, true, true))
    --end
    --Ext.Utils.PrintWarning("--- end functor dump ---")

    if hitWith == "Target" and tostring(caster) ~= tostring(target) then
        --Ext.Utils.PrintWarning(" --- OnDealDamage --- ")
        Ext.Dump({functor, caster, target, position, isFromItem, spellId, originator, hit, damageSums, hitWith})
    end


end)