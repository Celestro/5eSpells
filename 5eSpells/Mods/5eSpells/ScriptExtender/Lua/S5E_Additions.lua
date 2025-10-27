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

--[[local lifeTransference = {
  "Projectile_LifeTransference_2",
  "Projectile_LifeTransference_4",
  "Projectile_LifeTransference_6",
  "Projectile_LifeTransference_8",
  "Projectile_LifeTransference_10",
  "Projectile_LifeTransference_12",
  "Projectile_LifeTransference_14",
  "Projectile_LifeTransference_16",
  "Projectile_LifeTransference_18",
  "Projectile_LifeTransference_20",
  "Projectile_LifeTransference_22",
  "Projectile_LifeTransference_24",
  "Projectile_LifeTransference_26",
  "Projectile_LifeTransference_28",
  "Projectile_LifeTransference_30",
  "Projectile_LifeTransference_32",
  "Projectile_LifeTransference_34",
  "Projectile_LifeTransference_36",
  "Projectile_LifeTransference_38",
  "Projectile_LifeTransference_40",
  "Projectile_LifeTransference_42",
  "Projectile_LifeTransference_44",
  "Projectile_LifeTransference_46",
  "Projectile_LifeTransference_48",
  "Projectile_LifeTransference_50",
  "Projectile_LifeTransference_52",
  "Projectile_LifeTransference_54",
  "Projectile_LifeTransference_56",
  "Projectile_LifeTransference_58",
  "Projectile_LifeTransference_60",
  "Projectile_LifeTransference_62",
  "Projectile_LifeTransference_64",
  "Projectile_LifeTransference_66",
  "Projectile_LifeTransference_68",
  "Projectile_LifeTransference_70",
  "Projectile_LifeTransference_72",
  "Projectile_LifeTransference_74",
  "Projectile_LifeTransference_76",
  "Projectile_LifeTransference_78",
  "Projectile_LifeTransference_80",
  "Projectile_LifeTransference_82",
  "Projectile_LifeTransference_84",
  "Projectile_LifeTransference_86",
  "Projectile_LifeTransference_88",
  "Projectile_LifeTransference_90",
  "Projectile_LifeTransference_92",
  "Projectile_LifeTransference_94",
  "Projectile_LifeTransference_96",
  "Projectile_LifeTransference_98",
  "Projectile_LifeTransference_100",
  "Projectile_LifeTransference_102",
  "Projectile_LifeTransference_104",
  "Projectile_LifeTransference_106",
  "Projectile_LifeTransference_108",
  "Projectile_LifeTransference_110",
  "Projectile_LifeTransference_112",
  "Projectile_LifeTransference_114",
  "Projectile_LifeTransference_116",
  "Projectile_LifeTransference_118",
  "Projectile_LifeTransference_120",
  "Projectile_LifeTransference_122",
  "Projectile_LifeTransference_124",
  "Projectile_LifeTransference_126",
  "Projectile_LifeTransference_128",
  "Projectile_LifeTransference_130",
  "Projectile_LifeTransference_132",
  "Projectile_LifeTransference_134",
  "Projectile_LifeTransference_136",
  "Projectile_LifeTransference_138",
  "Projectile_LifeTransference_140",
  "Projectile_LifeTransference_142",
  "Projectile_LifeTransference_144",
  "Projectile_LifeTransference_146",
  "Projectile_LifeTransference_148",
  "Projectile_LifeTransference_150",
  "Projectile_LifeTransference_152",
  "Projectile_LifeTransference_154",
  "Projectile_LifeTransference_156",
  "Projectile_LifeTransference_158",
  "Projectile_LifeTransference_160"
}

-- Life Transference Setup
Ext.Osiris.RegisterListener("StartedPreviewingSpell", 4, "before", function (caster, spell, _, _)
	if spell == "Target_LifeTransference" or spell == "Target_LifeTransference_4" or spell == "Target_LifeTransference_5" or spell == "Target_LifeTransference_6" or spell == "Target_LifeTransference_7" or spell == "Target_LifeTransference_8" or spell == "Target_LifeTransference_9" then
		local hp = GetHitpoints(caster)
--		local num = IntegerToString(hp)
--		Osi.ShowNotification(caster,num)
		Osi.SetVarInteger(caster,"BeforeHP",hp)
    end

	if spell == "Target_LifeTransference" then
		for _, spells in pairs(lifeTransference) do
			local proj = Ext.Stats.Get(spells)
			proj.Level = 3
			proj:Sync()
		end
	elseif spell == "Target_LifeTransference_4" then
		for _, spells in pairs(lifeTransference) do
			local proj = Ext.Stats.Get(spells)
			proj.Level = 4
			proj:Sync()
		end
	elseif spell == "Target_LifeTransference_5" then
		for _, spells in pairs(lifeTransference) do
			local proj = Ext.Stats.Get(spells)
			proj.Level = 5
			proj:Sync()
		end
	elseif spell == "Target_LifeTransference_6" then
		for _, spells in pairs(lifeTransference) do
			local proj = Ext.Stats.Get(spells)
			proj.Level = 6
			proj:Sync()
		end
	elseif spell == "Target_LifeTransference_7" then
		for _, spells in pairs(lifeTransference) do
			local proj = Ext.Stats.Get(spells)
			proj.Level = 7
			proj:Sync()
		end
	elseif spell == "Target_LifeTransference_8" then
		for _, spells in pairs(lifeTransference) do
			local proj = Ext.Stats.Get(spells)
			proj.Level = 8
			proj:Sync()
		end
	elseif spell == "Target_LifeTransference_9" then
		for _, spells in pairs(lifeTransference) do
			local proj = Ext.Stats.Get(spells)
			proj.Level = 9
			proj:Sync()
		end
	end
end)

-- Life Transference Heal
Ext.Osiris.RegisterListener("StatusApplied", 4, "before", function (character, status, causee, _)
	if status == "LIFE_TRANSFERENCE" then
		local previoushp = GetVarInteger(causee, "BeforeHP")
		local currenthp = GetHitpoints(causee)
		local hp = 0
		hp = previoushp - currenthp
		hp = hp * 2
		local ltstatus = "LIFE_TRANSFERENCE_HP_" .. hp
		Osi.ApplyStatus(character,ltstatus,0.0,1,causee)
	elseif status == "LIFE_TRANSFERENCE_4" then
		local previoushp = GetVarInteger(causee, "BeforeHP")
		local currenthp = GetHitpoints(causee)
		local hp = 0
		hp = previoushp - currenthp
		hp = hp * 2
		local ltstatus = "LIFE_TRANSFERENCE_HP_" .. hp
		Osi.ApplyStatus(character,ltstatus,0.0,1,causee)
	elseif status == "LIFE_TRANSFERENCE_5" then
		local previoushp = GetVarInteger(causee, "BeforeHP")
		local currenthp = GetHitpoints(causee)
		local hp = 0
		hp = previoushp - currenthp
		hp = hp * 2
		local ltstatus = "LIFE_TRANSFERENCE_HP_" .. hp
		Osi.ApplyStatus(character,ltstatus,0.0,1,causee)
	elseif status == "LIFE_TRANSFERENCE_6" then
		local previoushp = GetVarInteger(causee, "BeforeHP")
		local currenthp = GetHitpoints(causee)
		local hp = 0
		hp = previoushp - currenthp
		hp = hp * 2
		local ltstatus = "LIFE_TRANSFERENCE_HP_" .. hp
		Osi.ApplyStatus(character,ltstatus,0.0,1,causee)
	elseif status == "LIFE_TRANSFERENCE_7" then
		local previoushp = GetVarInteger(causee, "BeforeHP")
		local currenthp = GetHitpoints(causee)
		local hp = 0
		hp = previoushp - currenthp
		hp = hp * 2
		local ltstatus = "LIFE_TRANSFERENCE_HP_" .. hp
		Osi.ApplyStatus(character,ltstatus,0.0,1,causee)
	elseif status == "LIFE_TRANSFERENCE_8" then
		local previoushp = GetVarInteger(causee, "BeforeHP")
		local currenthp = GetHitpoints(causee)
		local hp = 0
		hp = previoushp - currenthp
		hp = hp * 2
		local ltstatus = "LIFE_TRANSFERENCE_HP_" .. hp
		Osi.ApplyStatus(character,ltstatus,0.0,1,causee)
	elseif status == "LIFE_TRANSFERENCE_9" then
		local previoushp = GetVarInteger(causee, "BeforeHP")
		local currenthp = GetHitpoints(causee)
		local hp = 0
		hp = previoushp - currenthp
		hp = hp * 2
		local ltstatus = "LIFE_TRANSFERENCE_HP_" .. hp
		Osi.ApplyStatus(character,ltstatus,0.0,1,causee)
	end
end)--]]

--[[ Magic Stone & Dragon's Breath
local MAGIC_STONE = "MAGIC_STONE"
local DRAGONS_BREATH_PREFIX = "DRAGONS_BREATH"
local NULL_GUID = "NULL_00000000-0000-0000-0000-000000000000"

local dragonsBreathTypes = { "FIRE", "COLD", "ACID", "LIGHTNING", "POISON" }

local function SafeGetEntity(guid)
    local success, entity = pcall(Ext.Entity.Get, guid)
    if success and entity then return entity end
end

local function NormalizeAbility(ability)
    if type(ability) == "number" then
        return AbilityNames[ability] or "Intelligence" -- default fallback
    end
    return tostring(ability)
end

local function GetSpellcastingAbility(entity, spellPrototype)
    if not entity or not entity.SpellBook then return nil end
    for _, spell in pairs(entity.SpellBook.Spells) do
        if spell.Id.Prototype == spellPrototype then
            return spell.SpellCastingAbility
        end
    end
end

local function ApplyAbilityModifierStatus(target, source, ability, prefix)
    ability = NormalizeAbility(ability)
    local diff = Osi.GetAbility(target, ability) - Osi.GetAbility(source, ability)
    if diff == 0 then return end
    local status = string.format("%s_MODIFIER_%d", prefix, diff)
    if Osi.HasActiveStatus(target, status) == 0 then
        Osi.ApplyStatus(target, status, -1.0, 1, source)
    end
end

local function RemoveAssociatedBonuses(character, prefix)
    for i = -10, 10 do
        Osi.RemoveStatus(character, string.format("%s_MODIFIER_%d", prefix, i))
    end
end

-- Track Source for Targets
Ext.Osiris.RegisterListener("StatusApplied", 4, "after", function(character, status, causee, _)
    if not character or not causee then return end
    if Osi.GetUUID(character) == Osi.GetUUID(causee) then return end

    if status == MAGIC_STONE then
        Osi.SetVarObject(character, "StoreSource", causee)
        return
    end

    for _, dtype in ipairs(dragonsBreathTypes) do
        if status:find(DRAGONS_BREATH_PREFIX .. "_" .. dtype) then
            Osi.SetVarObject(character, "StoreSource", causee)
            return
        end
    end
end)

-- Apply Spellcasting Ability Statuses
Ext.Osiris.RegisterListener("StartedPreviewingSpell", 4, "after", function(character, spell, _, _)
    if spell == "Target_MagicStone" then
        local ability = GetSpellcastingAbility(sourceEntity, "Target_MagicStone")
        if ability then
			if ability == "Intelligence" then
				Osi.ApplyStatus(character,"MAGIC_STONE_OWNER_INTELLIGENCE",60.0,1,character)
			elseif ability == "Wisdom" then
				Osi.ApplyStatus(character,"MAGIC_STONE_OWNER_WISDOM",60.0,1,character)
			elseif ability == "Charisma" then
				Osi.ApplyStatus(character,"MAGIC_STONE_OWNER_CHARISMA",60.0,1,character)
			end
        end
    end
end)

-- Apply or Remove Modifiers
Ext.Osiris.RegisterListener("StartedPreviewingSpell", 4, "after", function(caster, spell, _, _)
    local source = Osi.GetVarObject(caster, "StoreSource")
    if not source or source == NULL_GUID or source == caster then return end
    local sourceEntity = SafeGetEntity(source)
    if not sourceEntity then return end

    if spell == "Projectile_MagicStone" or spell == "Projectile_MagicStone_Wisdom" or spell == "Projectile_MagicStone_Charisma" then
        local ability = GetSpellcastingAbility(sourceEntity, "Target_MagicStone")
        if ability then
            ApplyAbilityModifierStatus(caster, source, ability, "MAGIC_STONE")
			_D(caster)
			_D(source)
			_D(ability)
        end
        return
	else
        RemoveAssociatedBonuses(character, "MAGIC_STONE")
    end

    for _, dtype in ipairs(dragonsBreathTypes) do
        if spell:find("Zone_DragonsBreath_" .. dtype) then
            local base = "Target_DragonsBreath_" .. dtype
            local ability = GetSpellcastingAbility(sourceEntity, base)
            if ability then
                ApplyAbilityModifierStatus(caster, source, ability, "DRAGONS_BREATH")
            end
            return
        end
	else
        for _, dtype in ipairs(dragonsBreathTypes) do
            if status:find(DRAGONS_BREATH_PREFIX .. "_" .. dtype) then
                RemoveAssociatedBonuses(character, "DRAGONS_BREATH")
                break
            end
        end
    end
end)

-- Clear any linked bonus statuses
Ext.Osiris.RegisterListener("StatusRemoved", 4, "after", function(character, status, cause, _)
    if status == MAGIC_STONE then
        RemoveAssociatedBonuses(character, "MAGIC_STONE")
    else
        for _, dtype in ipairs(dragonsBreathTypes) do
            if status:find(DRAGONS_BREATH_PREFIX .. "_" .. dtype) then
                RemoveAssociatedBonuses(character, "DRAGONS_BREATH")
                break
            end
        end
    end
end)--]]

Ext.Osiris.RegisterListener("PROC_AbilityCheckCalculations", 1, "after", function(character)
	_D("This part is working at least")
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
end)

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

-- Spellcasting Ability Status
Ext.Osiris.RegisterListener("LevelGameplayStarted", 2, "after", function(level, _)
    if level ~= "SYS_CC_I" then
		local party = Osi.DB_Players:Get(nil)
		for _,p in pairs(party) do
			for _, spell in pairs(Ext.Entity.Get(p[1]).SpellContainer.Spells) do
				if (spell.SpellId.OriginatorPrototype == "Projectile_Jump" and spell.SpellCastingAbility == "Intelligence") or (spell.SpellId.OriginatorPrototype == "Shout_Dash_NPC" and spell.SpellCastingAbility == "Intelligence") and Osi.HasActiveStatus(p[1],"INTELLIGENCE_SPELLCASTING") == 0 then
					Osi.ApplyStatus(p[1],"INTELLIGENCE_SPELLCASTING",-1.0,1)
				elseif (spell.SpellId.OriginatorPrototype == "Projectile_Jump" and spell.SpellCastingAbility == "Wisdom") or (spell.SpellId.OriginatorPrototype == "Shout_Dash_NPC" and spell.SpellCastingAbility == "Wisdom") and Osi.HasActiveStatus(p[1],"WISDOM_SPELLCASTING") == 0 then
					Osi.ApplyStatus(p[1],"WISDOM_SPELLCASTING",-1.0,1)
				elseif (spell.SpellId.OriginatorPrototype == "Projectile_Jump" and spell.SpellCastingAbility == "Charisma") or (spell.SpellId.OriginatorPrototype == "Shout_Dash_NPC" and spell.SpellCastingAbility == "Charisma") and Osi.HasActiveStatus(p[1],"CHARISMA_SPELLCASTING") == 0 then
					Osi.ApplyStatus(p[1],"CHARISMA_SPELLCASTING",-1.0,1)
				end
			end
		end
    end
end)

local witherAndBloomStatuses = {
  "WITHER_AND_BLOOM",
  "WITHER_AND_BLOOM_3",
  "WITHER_AND_BLOOM_4",
  "WITHER_AND_BLOOM_5",
  "WITHER_AND_BLOOM_6",
  "WITHER_AND_BLOOM_7",
  "WITHER_AND_BLOOM_8",
  "WITHER_AND_BLOOM_9"
}

-- Wither And Bloom
Ext.Osiris.RegisterListener("StatusApplied", 4, "after", function (character, status, causee, _)
	if string.sub(character,-36) ~= causee and (status == "WITHER_AND_BLOOM" or status == "WITHER_AND_BLOOM_3" or status == "WITHER_AND_BLOOM_4" or status == "WITHER_AND_BLOOM_5" or status == "WITHER_AND_BLOOM_6" or status == "WITHER_AND_BLOOM_7" or status == "WITHER_AND_BLOOM_8" or status == "WITHER_AND_BLOOM_9") then
		Osi.SetVarObject(string.sub(character,-36),"StoreSourceOfWAB",causee)
		Osi.ApplyStatus(character,"WITHER_AND_BLOOM_SPELLCASTING",6.0,1,causee)
	end
end)

Ext.Osiris.RegisterListener("StartedPreviewingSpell", 4, "after", function (caster, spell, _, _)
	if spell == "Shout_WitherAndBloom_RegainHP" or spell == "Shout_WitherAndBloom_RegainHP_3_OneDie" or spell == "Shout_WitherAndBloom_RegainHP_3_TwoDie" or spell == "Shout_WitherAndBloom_RegainHP_4_OneDie" or spell == "Shout_WitherAndBloom_RegainHP_4_TwoDie" or spell == "Shout_WitherAndBloom_RegainHP_4_ThreeDie" or spell == "Shout_WitherAndBloom_RegainHP_5_OneDie" or spell == "Shout_WitherAndBloom_RegainHP_5_TwoDie" or spell == "Shout_WitherAndBloom_RegainHP_5_ThreeDie" or spell == "Shout_WitherAndBloom_RegainHP_5_FourDie" or spell == "Shout_WitherAndBloom_RegainHP_6_OneDie" or spell == "Shout_WitherAndBloom_RegainHP_6_TwoDie" or spell == "Shout_WitherAndBloom_RegainHP_6_ThreeDie" or spell == "Shout_WitherAndBloom_RegainHP_6_FourDie" or spell == "Shout_WitherAndBloom_RegainHP_6_FiveDie" or spell == "Shout_WitherAndBloom_RegainHP_7_OneDie" or spell == "Shout_WitherAndBloom_RegainHP_7_TwoDie" or spell == "Shout_WitherAndBloom_RegainHP_7_ThreeDie" or spell == "Shout_WitherAndBloom_RegainHP_7_FourDie" or spell == "Shout_WitherAndBloom_RegainHP_7_FiveDie" or spell == "Shout_WitherAndBloom_RegainHP_7_SixDie" or spell == "Shout_WitherAndBloom_RegainHP_8_OneDie" or spell == "Shout_WitherAndBloom_RegainHP_8_TwoDie" or spell == "Shout_WitherAndBloom_RegainHP_8_ThreeDie" or spell == "Shout_WitherAndBloom_RegainHP_8_FourDie" or spell == "Shout_WitherAndBloom_RegainHP_8_FiveDie" or spell == "Shout_WitherAndBloom_RegainHP_8_SixDie" or spell == "Shout_WitherAndBloom_RegainHP_8_SevenDie" or spell == "Shout_WitherAndBloom_RegainHP_9_OneDie" or spell == "Shout_WitherAndBloom_RegainHP_9_TwoDie" or spell == "Shout_WitherAndBloom_RegainHP_9_ThreeDie" or spell == "Shout_WitherAndBloom_RegainHP_9_FourDie" or spell == "Shout_WitherAndBloom_RegainHP_9_FiveDie" or spell == "Shout_WitherAndBloom_RegainHP_9_SixDie" or spell == "Shout_WitherAndBloom_RegainHP_9_SevenDie" or spell == "Shout_WitherAndBloom_RegainHP_9_EightDie" then
		local source = Osi.GetVarObject(caster,"StoreSourceOfWAB")
		if string.sub(caster,-36) ~= string.sub(source,-36) and source ~= "NULL_00000000-0000-0000-0000-000000000000" then
			for _, spell in pairs(Ext.Entity.Get(source).SpellBook.Spells) do
				if (spell.Id.Prototype == "Target_WitherAndBloom" or spell.Id.Prototype == "Target_WitherAndBloom_3" or spell.Id.Prototype == "Target_WitherAndBloom_4" or spell.Id.Prototype == "Target_WitherAndBloom_5" or spell.Id.Prototype == "Target_WitherAndBloom_6" or spell.Id.Prototype == "Target_WitherAndBloom_7" or spell.Id.Prototype == "Target_WitherAndBloom_8" or spell.Id.Prototype == "Target_WitherAndBloom_9") and spell.SpellCastingAbility == "Intelligence" then
					local int = Osi.GetAbility(source,"Intelligence")
					local scastatus = "WITHER_AND_BLOOM_MODIFIER_" .. int
					if Osi.HasActiveStatus(caster,scastatus) == 0 then
						Osi.ApplyStatus(caster,scastatus,6.0,1,source)
					end
				elseif (spell.Id.Prototype == "Target_WitherAndBloom" or spell.Id.Prototype == "Target_WitherAndBloom_3" or spell.Id.Prototype == "Target_WitherAndBloom_4" or spell.Id.Prototype == "Target_WitherAndBloom_5" or spell.Id.Prototype == "Target_WitherAndBloom_6" or spell.Id.Prototype == "Target_WitherAndBloom_7" or spell.Id.Prototype == "Target_WitherAndBloom_8" or spell.Id.Prototype == "Target_WitherAndBloom_9") and spell.SpellCastingAbility == "Wisdom" then
					local wis = Osi.GetAbility(source,"Wisdom")
					local scastatus = "WITHER_AND_BLOOM_MODIFIER_" .. wis
					if Osi.HasActiveStatus(caster,scastatus) == 0 then
						Osi.ApplyStatus(caster,scastatus,6.0,1,source)
					end
				elseif (spell.Id.Prototype == "Target_WitherAndBloom" or spell.Id.Prototype == "Target_WitherAndBloom_3" or spell.Id.Prototype == "Target_WitherAndBloom_4" or spell.Id.Prototype == "Target_WitherAndBloom_5" or spell.Id.Prototype == "Target_WitherAndBloom_6" or spell.Id.Prototype == "Target_WitherAndBloom_7" or spell.Id.Prototype == "Target_WitherAndBloom_8" or spell.Id.Prototype == "Target_WitherAndBloom_9") and spell.SpellCastingAbility == "Charisma" then
					local cha = Osi.GetAbility(source,"Charisma")
					local scastatus = "WITHER_AND_BLOOM_MODIFIER_" .. cha
					if Osi.HasActiveStatus(caster,scastatus) == 0 then
						Osi.ApplyStatus(caster,scastatus,6.0,1,source)
					end
				end
			end
		end
	elseif spell == "Shout_WitherAndBloom_RegainHP" or spell ~= "Shout_WitherAndBloom_RegainHP_3_OneDie" or spell ~= "Shout_WitherAndBloom_RegainHP_3_TwoDie" or spell ~= "Shout_WitherAndBloom_RegainHP_4_OneDie" or spell ~= "Shout_WitherAndBloom_RegainHP_4_TwoDie" or spell ~= "Shout_WitherAndBloom_RegainHP_4_ThreeDie" or spell ~= "Shout_WitherAndBloom_RegainHP_5_OneDie" or spell ~= "Shout_WitherAndBloom_RegainHP_5_TwoDie" or spell ~= "Shout_WitherAndBloom_RegainHP_5_ThreeDie" or spell ~= "Shout_WitherAndBloom_RegainHP_5_FourDie" or spell ~= "Shout_WitherAndBloom_RegainHP_6_OneDie" or spell ~= "Shout_WitherAndBloom_RegainHP_6_TwoDie" or spell ~= "Shout_WitherAndBloom_RegainHP_6_ThreeDie" or spell ~= "Shout_WitherAndBloom_RegainHP_6_FourDie" or spell ~= "Shout_WitherAndBloom_RegainHP_6_FiveDie" or spell ~= "Shout_WitherAndBloom_RegainHP_7_OneDie" or spell ~= "Shout_WitherAndBloom_RegainHP_7_TwoDie" or spell ~= "Shout_WitherAndBloom_RegainHP_7_ThreeDie" or spell ~= "Shout_WitherAndBloom_RegainHP_7_FourDie" or spell ~= "Shout_WitherAndBloom_RegainHP_7_FiveDie" or spell ~= "Shout_WitherAndBloom_RegainHP_7_SixDie" or spell ~= "Shout_WitherAndBloom_RegainHP_8_OneDie" or spell ~= "Shout_WitherAndBloom_RegainHP_8_TwoDie" or spell ~= "Shout_WitherAndBloom_RegainHP_8_ThreeDie" or spell ~= "Shout_WitherAndBloom_RegainHP_8_FourDie" or spell ~= "Shout_WitherAndBloom_RegainHP_8_FiveDie" or spell ~= "Shout_WitherAndBloom_RegainHP_8_SixDie" or spell ~= "Shout_WitherAndBloom_RegainHP_8_SevenDie" or spell ~= "Shout_WitherAndBloom_RegainHP_9_OneDie" or spell ~= "Shout_WitherAndBloom_RegainHP_9_TwoDie" or spell ~= "Shout_WitherAndBloom_RegainHP_9_ThreeDie" or spell ~= "Shout_WitherAndBloom_RegainHP_9_FourDie" or spell ~= "Shout_WitherAndBloom_RegainHP_9_FiveDie" or spell ~= "Shout_WitherAndBloom_RegainHP_9_SixDie" or spell ~= "Shout_WitherAndBloom_RegainHP_9_SevenDie" or spell ~= "Shout_WitherAndBloom_RegainHP_9_EightDie" then
		Osi.ApplyStatus(caster,"WITHER_AND_BLOOM_MODIFIER_REMOVAL",0.0,1)
	end
end)

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

-- Detect Magic
Ext.Osiris.RegisterListener("StatusApplied", 4, "after", function (character, status, cause, _)
	if status == "DETECTED_MAGIC_INVENTORY" then
		Osi.IterateInventory(character,"DetectMagicItems_SE","")
	end
end)

-- Detect Magic
Ext.Osiris.RegisterListener("EntityEvent", 2, "after", function (item, event)
	if event == "DetectMagicItems_SE" then
		if Osi.IsItem(item) == 1 and Osi.IsTagged(item,"MAGIC_ITEM_DETECT_MAGIC_e6cc448b-0615-4459-860a-af50bf64aa0e") == 1 then
			local owner = Osi.GetOwner(item)
			Osi.ApplyStatus(character,"PRONE",-1.0,1)
		end
	end
end)

