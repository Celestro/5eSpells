-- ============================================
-- Scoped removal plumbing
-- ============================================

local function Ord(n)
  if n == 1 then return "1st" end
  if n == 2 then return "2nd" end
  if n == 3 then return "3rd" end
  return tostring(n) .. "th"
end

-- Safe get nested table key
local function get(tbl, k) return tbl and tbl[k] or nil end

-- Collect spells from a precise sublist:
--  - classKey: e.g., "Bard", "Wizard", "Feats"
--  - opts:
--      listNameExact   -> exact child list under class (e.g., "SpellSniper")
--      suffixMatch     -> a single suffix to match (kept for backward compat)
--      suffixes        -> array of suffixes to match any of (preferred)
--      onlyUnder       -> restrict search under a specific nested bucket (e.g., "MagicalSecrets")
local function CollectPreciseSpells(classKey, opts)
  local out = {}
  local function addAll(list)
    for _, s in ipairs(list) do out[s] = true end
  end
  local function isList(tbl) return type(tbl) == "table" and #tbl > 0 and type(tbl[1]) == "string" end

  local root = SpellLists and SpellLists[classKey]
  if type(root) ~= "table" then return out end

  -- exact list (e.g., Feats.SpellSniper)
  if opts and opts.listNameExact then
    local lst = root[opts.listNameExact]
    if isList(lst) then addAll(lst) return out end
    if opts.onlyUnder and type(root[opts.onlyUnder]) == "table" then
      local nested = root[opts.onlyUnder][opts.listNameExact]
      if isList(nested) then addAll(nested) end
    end
    return out
  end

  -- suffix(es) matching
  local suffixes = nil
  if opts and type(opts.suffixes) == "table" then
    suffixes = opts.suffixes
  elseif opts and type(opts.suffixMatch) == "string" then
    suffixes = { opts.suffixMatch }
  else
    return out
  end

  local function nameHasAnySuffix(name)
    for _, sx in ipairs(suffixes) do
      if #name >= #sx and name:sub(-#sx) == sx then
        return true
      end
    end
    return false
  end

  local function scanBucket(bucket)
    for subName, subList in pairs(bucket) do
      if isList(subList) and nameHasAnySuffix(subName) then
        addAll(subList)
      end
    end
  end

  if opts.onlyUnder then
    local bucket = root[opts.onlyUnder]
    if type(bucket) == "table" then scanBucket(bucket) end
  else
    -- scan direct lists
    scanBucket(root)
    -- scan one nested level (e.g., MagicalSecrets.*)
    for k, v in pairs(root) do
      if type(v) == "table" and not isList(v) then
        scanBucket(v)
      end
    end
  end

  return out
end

-- Safe getter for list_v2 (returns Lua array)
local function MCMGetList(settingID)
    if Mods and Mods.BG3MCM and Mods.BG3MCM.MCMAPI then
        local ok, val = pcall(function()
            return Mods.BG3MCM.MCMAPI:GetSettingValue(settingID, ModuleUUID)
        end)
        if ok and type(val) == "table" then
            return val
        else
            Ext.Utils.PrintWarning(string.format("5eSpells:[MCM] Could not retrieve list '%s' (returned %s)", settingID, tostring(val)))
        end
    end
    return {}
end

-- Convert the list_v2 structure into a fast lookup table of enabled names
local function BuildExemptions()
    local raw = MCMGetList("SpellExemptions")
    local set = {}

    if type(raw) ~= "table" then
        Ext.Utils.Print("5eSpells:[MCM] BuildExemptions: MCM returned non-table for SpellExemptions.")
        return set
    end

    -- Normalize to the actual list of entries
    local data = raw
    if raw.Default and type(raw.Default) == "table" and raw.Default.elements then
        data = raw.Default.elements
    elseif raw.elements and type(raw.elements) == "table" then
        data = raw.elements
    elseif raw.settings and raw.settings.SpellExemptions then
        local sx = raw.settings.SpellExemptions
        data = (sx.elements and sx.elements) or sx
    end

    if type(data) ~= "table" then
        Ext.Utils.Print("5eSpells:[MCM] BuildExemptions: no usable elements table found.")
        return set
    end

    for _, entry in ipairs(data) do
        if type(entry) == "table" then
            if entry.enabled and entry.name and entry.name ~= "" then
                set[entry.name] = true
            end
        elseif type(entry) == "string" then
            set[entry] = true
        end
    end

    return set
end

-- Global cache populated during OnStatsLoaded
ExemptionsSet = {}

-- Remove specific spells from a single SpellList stat by UUID
local function RemoveSpellsFromUUID(spellSet, uuid)
    if not uuid then return end

    local sd = Ext.StaticData.Get(uuid, "SpellList")
    if not sd or not sd.Spells then return end

    local arr = Ext.Types.Serialize(sd.Spells)
    local changed = false
    local exemptions = ExemptionsSet or {}

    for i = #arr, 1, -1 do
        local spellId = arr[i]
        -- remove only if in removal set AND not exempted
        if spellSet[spellId] and not exemptions[spellId] then
            table.remove(arr, i)
            changed = true
        elseif spellSet[spellId] and exemptions[spellId] then
            Ext.Utils.Print(string.format("5eSpells: Exempted spell '%s' in %s", spellId, uuid))
        end
    end

    if changed then
        Ext.Types.Unserialize(sd.Spells, arr)
    end
end


-- Add specific spells to a single SpellList stat by UUID
local function AddSpellsToUUID(spellArray, uuid)
  if uuid ~= nil then
    local sd   = Ext.StaticData.Get(uuid, "SpellList")
    local list = sd and sd.Spells or nil
    if not list then return end

    local arr      = Ext.Types.Serialize(list)
    local has      = {}
    local changed  = false

    for _, s in ipairs(arr) do has[s] = true end
    for _, s in ipairs(spellArray) do
      if not has[s] then
        table.insert(arr, s)
        changed = true
      end
    end

    if changed then
      Ext.Types.Unserialize(list, arr)
    end
  end
end

-- === Normalize Magical Secrets to a top-level bucket ===
local function NormalizeMagicalSecrets()
  if SpellLists and SpellLists.Bard and type(SpellLists.Bard.MagicalSecrets) == "table" then
    SpellLists.MagicalSecrets = SpellLists.MagicalSecrets or {}
    for subName, subList in pairs(SpellLists.Bard.MagicalSecrets) do
      local normalized = subName:gsub("^SecretSpells", "Spells")
      SpellLists.MagicalSecrets[normalized] = subList
    end
    SpellLists.Bard.MagicalSecrets = nil
  end

  -- Backfill aliases just in case older list names exist
  local aliasPairs = {
    {"SecretSpells1stTCoE","Spells1stTCoE"}, {"SecretSpells2ndTCoE","Spells2ndTCoE"},
    {"SecretSpells3rdTCoE","Spells3rdTCoE"}, {"SecretSpells4thTCoE","Spells4thTCoE"},
    {"SecretSpells5thTCoE","Spells5thTCoE"}, {"SecretSpells6thTCoE","Spells6thTCoE"},
    {"SecretSpells7thTCoE","Spells7thTCoE"}, {"SecretSpells8thTCoE","Spells8thTCoE"},
    {"SecretSpells9thTCoE","Spells9thTCoE"},

    {"SecretSpells1stOther","Spells1stOther"}, {"SecretSpells2ndOther","Spells2ndOther"},
    {"SecretSpells3rdOther","Spells3rdOther"}, {"SecretSpells4thOther","Spells4thOther"},
    {"SecretSpells5thOther","Spells5thOther"}, {"SecretSpells6thOther","Spells6thOther"},
    {"SecretSpells7thOther","Spells7thOther"}, {"SecretSpells8thOther","Spells8thOther"},
    {"SecretSpells9thOther","Spells9thOther"},
  }
  if SpellLists and SpellLists.MagicalSecrets then
    for _, pair in ipairs(aliasPairs) do
      local old, new = pair[1], pair[2]
      if SpellLists.MagicalSecrets[old] and not SpellLists.MagicalSecrets[new] then
        SpellLists.MagicalSecrets[new] = SpellLists.MagicalSecrets[old]
      end
    end
  end
end
NormalizeMagicalSecrets()

-- Cantrips: treat any MS or MagicalSecrets key as class "MagicalSecrets"
local function BuildCantripIndex(map)
  local idx = {}
  for key, uuid in pairs(map) do
    if key == "SpellSniper" then
      table.insert(idx, { uuid = uuid, class = "Feats", opts = { listNameExact = "SpellSniper" } })
    elseif key:find("^MagicalSecrets") or key:find("MS", 1, true) then
      table.insert(idx, {
        uuid = uuid,
        class = "MagicalSecrets",
        -- accept all the common cantrip list name shapes you use
        opts = { suffixes = { "Cantrips", "CantripsTCoE", "CantripsOther" } }
      })
    else
      local class = key:gsub("Cantrip$", "")
      table.insert(idx, { uuid = uuid, class = class, opts = { suffixMatch = "Cantrips" } })
    end
  end
  return idx
end

-- Helper: "1st".."9th" -> index (reuse if already defined above)
local _lvl_to_idx = { ["1st"]=1, ["2nd"]=2, ["3rd"]=3, ["4th"]=4, ["5th"]=5, ["6th"]=6, ["7th"]=7, ["8th"]=8, ["9th"]=9 }
local _labels = { "1st","2nd","3rd","4th","5th","6th","7th","8th","9th" }
local function LevelIdxFromKey(key)
  for i = 1, #_labels do
    if key:find(_labels[i], 1, true) then return i end
  end
  return nil
end

-- TCoE: remove level N only from targets whose own list is greater than N
local function BuildTCoEIndex(map, level)
  local idx, levelKey = {}, Ord(level)
  local currentIdx = _lvl_to_idx[levelKey]
  local suffixes = { ("Spells%sTCoE"):format(levelKey), ("%sTCoE"):format(levelKey) }

  for key, uuid in pairs(map) do
    if type(uuid) == "string" then
      local targetIdx = LevelIdxFromKey(key)
      if targetIdx and targetIdx >= currentIdx then
        if key:find("^MagicalSecrets") or key:find("MS", 1, true) then
          table.insert(idx, { uuid = uuid, class = "MagicalSecrets", opts = { suffixes = suffixes } })
        else
          local class = (key:find("^WFiend") or key:find("^WGoO") or key:find("^WArchfey")) and "Warlock" or key:match("^(%a+)")
          if class then table.insert(idx, { uuid = uuid, class = class, opts = { suffixes = suffixes } }) end
        end
      end
    end
  end
  return idx
end

-- Other (mod-specific) levels
local function BuildOtherIndex(map, level)
  local idx, levelKey = {}, Ord(level)
  local currentIdx = _lvl_to_idx[levelKey]
  local suffixes = { ("Spells%sOther"):format(levelKey), ("%sOther"):format(levelKey) }

  for key, uuid in pairs(map) do
    if type(uuid) == "string" then
      if key == "RitualCaster" then
        if level == 1 then table.insert(idx, { uuid = uuid, class = "Feats", opts = { listNameExact = "RitualCaster" } }) end
      else
        local targetIdx = LevelIdxFromKey(key)
        if targetIdx and targetIdx >= currentIdx then
          if key:find("^MagicalSecrets") or key:find("MS", 1, true) then
            table.insert(idx, { uuid = uuid, class = "MagicalSecrets", opts = { suffixes = suffixes } })
          else
            local class = (key:find("^WFiend") or key:find("^WGoO") or key:find("^WArchfey")) and "Warlock" or key:match("^(%a+)")
            if class then table.insert(idx, { uuid = uuid, class = class, opts = { suffixes = suffixes } }) end
          end
        end
      end
    end
  end
  return idx
end

local function RemoveByIndex(indexEntries)
  -- De-dupe by UUID, compute spell set per UUID
  for _, ent in ipairs(indexEntries) do
    local spellsSet = CollectPreciseSpells(ent.class, ent.opts)
    -- If there are exemptions cached, remove them early from the set
    if ExemptionsSet then
      for spellId in pairs(ExemptionsSet) do
        spellsSet[spellId] = nil
      end
    end
    if next(spellsSet) ~= nil then
      RemoveSpellsFromUUID(spellsSet, ent.uuid)
    end
  end
end

local function prependInterruptConditions(name, change)
    local stat = Ext.Stats.Get(name)

    local cond = stat.Conditions or ""

    cond = cond:gsub("%s*;%s*$", "")

    if cond:find(change, 1, true) then
        return
    end

    if cond == "" then
        stat.Conditions = change
    else
        stat.Conditions = change .. " and " .. cond
    end
end

local function prependTargetConditions(name, change)
    local stat = Ext.Stats.Get(name)

    local cond = stat.TargetConditions or ""

    cond = cond:gsub("%s*;%s*$", "")

    if cond:find(change, 1, true) then
        return
    end

    if cond == "" then
        stat.TargetConditions = change
    else
        stat.TargetConditions = change .. " and " .. cond
    end
end

-- ============================================
-- 5e Spells Changes
-- ============================================

function S5E_Changes()

	local rogueprogression = Ext.StaticData.Get("16f00e7f-12f6-4cff-b610-4ee738b02d62","Progression")
	rogueprogression["PassivesAdded"] = rogueprogression["PassivesAdded"] .. ";S5E_SCAGtrips_SneakAttack"
	local lifeclericprogression = Ext.StaticData.Get("20ce2664-ba58-4291-be05-dca5b2c4293d","Progression")
	lifeclericprogression["PassivesAdded"] = lifeclericprogression["PassivesAdded"] .. ";S5E_SCAGtrips_DivineStrike_Life"
	local natureclericprogression = Ext.StaticData.Get("f5a8a6b4-8514-494d-bbe8-2a0196dc8efa","Progression")
	natureclericprogression["PassivesAdded"] = natureclericprogression["PassivesAdded"] .. ";S5E_SCAGtrips_DivineStrike_Nature"
	local tempestclericprogression = Ext.StaticData.Get("cf1e11e2-5561-49b7-9c6a-83edffcd0f09","Progression")
	tempestclericprogression["PassivesAdded"] = tempestclericprogression["PassivesAdded"] .. ";S5E_SCAGtrips_DivineStrike_Tempest"
	local trickeryclericprogression = Ext.StaticData.Get("f39b339b-e367-403b-b33e-8191eb8363e0","Progression")
	trickeryclericprogression.PassivesAdded = trickeryclericprogression.PassivesAdded .. ";S5E_SCAGtrips_DivineStrike_Trickery"
	local warclericprogression = Ext.StaticData.Get("bb079588-93de-40de-bf1f-2718b1e08512","Progression")
	warclericprogression["PassivesAdded"] = warclericprogression["PassivesAdded"] .. ";S5E_SCAGtrips_DivineStrike_War"
	local deathclericprogression = Ext.StaticData.Get("25d9e305-146b-45cf-947f-d7840f5905fc","Progression")
	if deathclericprogression ~= nil then
		deathclericprogression["PassivesAdded"] = deathclericprogression["PassivesAdded"] .. ";S5E_SCAGtrips_DivineStrike_Death"
	end

	prependInterruptConditions("Interrupt_SneakAttack", "not SpellId('Target_BoomingBlade_SneakAttack') and not SpellId('Target_GreenFlameBlade_SneakAttack')")
	prependInterruptConditions("Interrupt_SneakAttack_Critical", "not SpellId('Target_BoomingBlade_SneakAttack') and not SpellId('Target_GreenFlameBlade_SneakAttack')")
	prependInterruptConditions("Interrupt_DivineStrike_Cold", "not SpellId('Target_BoomingBlade_DivineStrike_Cold') and not SpellId('Target_GreenFlameBlade_DivineStrike_Cold')")
	prependInterruptConditions("Interrupt_DivineStrike_Cold_Critical", "not SpellId('Target_BoomingBlade_DivineStrike_Cold') and not SpellId('Target_GreenFlameBlade_DivineStrike_Cold')")
	prependInterruptConditions("Interrupt_DivineStrike_Fire", "not SpellId('Target_BoomingBlade_DivineStrike_Fire') and not SpellId('Target_GreenFlameBlade_DivineStrike_Fire')")
	prependInterruptConditions("Interrupt_DivineStrike_Fire_Critical", "not SpellId('Target_BoomingBlade_DivineStrike_Fire') and not SpellId('Target_GreenFlameBlade_DivineStrike_Fire')")
	prependInterruptConditions("Interrupt_DivineStrike_Lightning", "not SpellId('Target_BoomingBlade_DivineStrike_Lightning') and not SpellId('Target_GreenFlameBlade_DivineStrike_Lightning')")
	prependInterruptConditions("Interrupt_DivineStrike_Lightning_Critical", "not SpellId('Target_BoomingBlade_DivineStrike_Lightning') and not SpellId('Target_GreenFlameBlade_DivineStrike_Lightning')")
	prependInterruptConditions("Interrupt_DivineStrike_Poison", "not SpellId('Target_BoomingBlade_DivineStrike_Poison') and not SpellId('Target_GreenFlameBlade_DivineStrike_Poison')")
	prependInterruptConditions("Interrupt_DivineStrike_Poison_Critical", "not SpellId('Target_BoomingBlade_DivineStrike_Poison') and not SpellId('Target_GreenFlameBlade_DivineStrike_Poison')")
	prependInterruptConditions("Interrupt_DivineStrike_Radiant", "not SpellId('Target_BoomingBlade_DivineStrike_Radiant') and not SpellId('Target_GreenFlameBlade_DivineStrike_Radiant')")
	prependInterruptConditions("Interrupt_DivineStrike_Radiant_Critical", "not SpellId('Target_BoomingBlade_DivineStrike_Radiant') and not SpellId('Target_GreenFlameBlade_DivineStrike_Radiant')")
	prependInterruptConditions("Interrupt_DivineStrike_Thunder", "not SpellId('Target_BoomingBlade_DivineStrike_Thunder') and not SpellId('Target_GreenFlameBlade_DivineStrike_Thunder')")
	prependInterruptConditions("Interrupt_DivineStrike_Thunder_Critical", "not SpellId('Target_BoomingBlade_DivineStrike_Thunder') and not SpellId('Target_GreenFlameBlade_DivineStrike_Thunder')")
	prependInterruptConditions("Interrupt_DivineStrike_MeleeWeapon", "not SpellId('Target_BoomingBlade_DivineStrike_MeleeWeapon') and not SpellId('Target_GreenFlameBlade_DivineStrike_MeleeWeapon')")
	prependInterruptConditions("Interrupt_DivineStrike_MeleeWeapon_Critical", "not SpellId('Target_BoomingBlade_DivineStrike_MeleeWeapon') and not SpellId('Target_GreenFlameBlade_DivineStrike_MeleeWeapon')")
	prependInterruptConditions("Interrupt_DivineStrike_Necrotic", "not SpellId('Target_BoomingBlade_DivineStrike_Necrotic') and not SpellId('Target_GreenFlameBlade_DivineStrike_Necrotic')")
	prependInterruptConditions("Interrupt_DivineStrike_Necrotic_Critical", "not SpellId('Target_BoomingBlade_DivineStrike_Necrotic') and not SpellId('Target_GreenFlameBlade_DivineStrike_Necrotic')")
	prependInterruptConditions("Interrupt_AttackOfOpportunity", "not S5E_IsInvisibleSeen()")
	prependInterruptConditions("Interrupt_PolearmMaster", "not S5E_IsInvisibleSeen()")
	prependInterruptConditions("Interrupt_WarCaster", "not S5E_IsInvisibleSeen()")
	prependTargetConditions("Target_Guidance", "not IsImmuneToStatus('GUIDANCE')")
	prependTargetConditions("Target_HuntersMark", "not IsImmuneToStatus('HUNTERS_MARK')")
	prependTargetConditions("Target_HuntersMark_Reapply", "not IsImmuneToStatus('HUNTERS_MARK')")
	prependTargetConditions("Target_TrueStrike", "not IsImmuneToStatus('TRUE_STRIKE')")

	local potentSpellcasting = Ext.Stats.Get("PotentSpellcasting")
	potentSpellcasting.Boosts = potentSpellcasting.Boosts .. ";IF(SpellId('Target_TollTheDead') or SpellId('Shout_WordOfRadiance')):DamageBonus(max(0, WisdomModifier))"

--[[	for _, name in pairs(Ext.Stats.GetStats("StatusData")) do
		local invisstatus = Ext.Stats.Get(name)
		if invisstatus.StatusType == "INVISIBLE" and string.find(invisstatus.Boosts, "Advantage") and invisstatus.Boosts ~= "IF(not CanSeeInvisible()):Disadvantage(AttackTarget); IF(not CanSeeInvisible(context.Target)):Advantage(AttackRoll);" and invisstatus.Boosts ~= "IF(not CanSeeInvisible()):Disadvantage(AttackTarget); IF(not CanSeeInvisible(context.Target)):Advantage(AttackRoll); Skill(Stealth, 10)" and invisstatus.Boosts ~= "IF(not CanSeeInvisible()):Disadvantage(AttackTarget); IF(not CanSeeInvisible(context.Target)):Advantage(AttackRoll); UnlockSpell(Target_MistyStep_Free)" and invisstatus.Boosts ~= "IF(not CanSeeInvisible()):Disadvantage(AttackTarget); IF(not CanSeeInvisible(context.Target)):Advantage(AttackRoll); Advantage(Skill, Stealth)" then
			invisstatus.Boosts = string.gsub(invisstatus.Boosts, "Advantage", "IF(not EXP_CanSeeInvisible(context.Target) and not IsElusive(context.Target)):Advantage")
			invisstatus.Boosts = invisstatus.Boosts .. ";IF(not EXP_CanSeeInvisible() and not IsElusive()):Disadvantage(AttackTarget)"
		end
	end--]]

	for _, name in pairs(Ext.Stats.GetStats("SpellData")) do
		local stat = Ext.Stats.Get(name)
		if stat.TargetConditions then
			if stat.TargetConditions:find("HasStatus%('FRIGHTENED'") then
				stat.TargetConditions = stat.TargetConditions:gsub("HasStatus%('FRIGHTENED'","HasStatus('SG_Frightened'")
			end
		end
	end

	for _, name in pairs(Ext.Stats.GetStats("InterruptData")) do
		local stat = Ext.Stats.Get(name)
		if stat.Conditions then
			if stat.Conditions:find("HasStatus%('FRIGHTENED'") then
				stat.Conditions = stat.Conditions:gsub("HasStatus%('FRIGHTENED'","HasStatus('SG_Frightened'")
			end
		end
	end

	local elementalaffinity = Ext.Stats.Get("ELEMENTALAFFINITY_FIRE_EXTRA_DAMAGE_TECHNICAL")
    local elementalgish = Ext.Stats.Get("MAG_ElementalGish_CantripBooster_Amulet_Passive")
    local charismacaster = Ext.Stats.Get("MAG_CharismaCaster_CantripBooster_Passive")
	local elementalinfusion = Ext.Stats.Get("MAG_ElementalGish_ElementalInfusion_Ring")
	local revgloves = Ext.Stats.Get("MAG_Thunder_Reverberation_Gloves_Passive")
	if string.find(elementalaffinity.Boosts, "IsSpell%(%) and IsDamageTypeFire%(%)") then
		elementalaffinity.Boosts = string.gsub(elementalaffinity.Boosts, "IsSpell%(%) and IsDamageTypeFire%(%)", "IsSpell() and IsDamageTypeFire() and not IsWeaponAttack()")
	end
    elementalaffinity.Boosts = "IF(SpellDamageTypeIs(DamageType.Fire) and (SpellId('Target_GreenFlameBlade') or SpellId('Target_GreenFlameBlade_Default') or SpellId('Target_GreenFlameBlade_SneakAttack') or SpellId('Target_GreenFlameBlade_DivineStrike_Radiant') or SpellId('Target_GreenFlameBlade_DivineStrike_Cold') or SpellId('Target_GreenFlameBlade_DivineStrike_Fire') or SpellId('Target_GreenFlameBlade_DivineStrike_Lightning') or SpellId('Target_GreenFlameBlade_DivineStrike_Thunder') or SpellId('Target_GreenFlameBlade_DivineStrike_Poison') or SpellId('Target_GreenFlameBlade_DivineStrike_MeleeWeapon') or SpellId('Target_GreenFlameBlade_DivineStrike_Necrotic') or SpellId('Target_GreenFlameBlade_DivineStrike_Psychic')) and CharacterLevelGreaterThan(4)):CharacterWeaponDamage(max(0, CharismaModifier),Fire);" .. elementalaffinity.Boosts
	if string.find(elementalgish.Boosts, "IsCantrip%(%)") then
		elementalgish.Boosts = string.gsub(elementalgish.Boosts, "IsCantrip%(%)", "IsCantrip() and not IsWeaponAttack()")
	end
    elementalgish.Boosts = elementalgish.Boosts .. ";IF((SpellId('Target_GreenFlameBlade_Default') or SpellId('Target_GreenFlameBlade_SneakAttack') or SpellId('Target_GreenFlameBlade_DivineStrike_Radiant') or SpellId('Target_GreenFlameBlade_DivineStrike_Cold') or SpellId('Target_GreenFlameBlade_DivineStrike_Fire') or SpellId('Target_GreenFlameBlade_DivineStrike_Lightning') or SpellId('Target_GreenFlameBlade_DivineStrike_Thunder') or SpellId('Target_GreenFlameBlade_DivineStrike_Poison') or SpellId('Target_GreenFlameBlade_DivineStrike_MeleeWeapon') or SpellId('Target_GreenFlameBlade_DivineStrike_Necrotic') or SpellId('Target_GreenFlameBlade_DivineStrike_Psychic')) and CharacterLevelGreaterThan(4)):CharacterWeaponDamage(max(1, SpellCastingAbilityModifier),Fire);IF((SpellId('Target_BoomingBlade_Default') or SpellId('Target_BoomingBlade_SneakAttack') or SpellId('Target_BoomingBlade_DivineStrike_Radiant') or SpellId('Target_BoomingBlade_DivineStrike_Cold') or SpellId('Target_BoomingBlade_DivineStrike_Fire') or SpellId('Target_BoomingBlade_DivineStrike_Lightning') or SpellId('Target_BoomingBlade_DivineStrike_Thunder') or SpellId('Target_BoomingBlade_DivineStrike_Poison') or SpellId('Target_BoomingBlade_DivineStrike_MeleeWeapon') or SpellId('Target_BoomingBlade_DivineStrike_Necrotic') or SpellId('Target_BoomingBlade_DivineStrike_Psychic')) and CharacterLevelGreaterThan(4)):CharacterWeaponDamage(max(1, SpellCastingAbilityModifier),Thunder)"
	if string.find(charismacaster.Boosts, "IsCantrip%(%)") then
		charismacaster.Boosts = string.gsub(charismacaster.Boosts, "IsCantrip%(%)", "IsCantrip() and not IsWeaponAttack()")
	end
    charismacaster.Boosts = charismacaster.Boosts .. ";IF((SpellId('Target_GreenFlameBlade_Default') or SpellId('Target_GreenFlameBlade_SneakAttack') or SpellId('Target_GreenFlameBlade_DivineStrike_Radiant') or SpellId('Target_GreenFlameBlade_DivineStrike_Cold') or SpellId('Target_GreenFlameBlade_DivineStrike_Fire') or SpellId('Target_GreenFlameBlade_DivineStrike_Lightning') or SpellId('Target_GreenFlameBlade_DivineStrike_Thunder') or SpellId('Target_GreenFlameBlade_DivineStrike_Poison') or SpellId('Target_GreenFlameBlade_DivineStrike_MeleeWeapon') or SpellId('Target_GreenFlameBlade_DivineStrike_Necrotic') or SpellId('Target_GreenFlameBlade_DivineStrike_Psychic')) and CharacterLevelGreaterThan(4)):CharacterWeaponDamage(max(1, CharismaModifier),Fire);IF((SpellId('Target_BoomingBlade_Default') or SpellId('Target_BoomingBlade_SneakAttack') or SpellId('Target_BoomingBlade_DivineStrike_Radiant') or SpellId('Target_BoomingBlade_DivineStrike_Cold') or SpellId('Target_BoomingBlade_DivineStrike_Fire') or SpellId('Target_BoomingBlade_DivineStrike_Lightning') or SpellId('Target_BoomingBlade_DivineStrike_Thunder') or SpellId('Target_BoomingBlade_DivineStrike_Poison') or SpellId('Target_BoomingBlade_DivineStrike_MeleeWeapon') or SpellId('Target_BoomingBlade_DivineStrike_Necrotic') or SpellId('Target_BoomingBlade_DivineStrike_Psychic')) and CharacterLevelGreaterThan(4)):CharacterWeaponDamage(max(1, CharismaModifier),Thunder)"
    elementalinfusion.PassivesOnEquip = elementalinfusion.PassivesOnEquip .. ";S5E_ElementalGish_ElementalInfusion_Ring_Passive"
	revgloves.Conditions = "((SpellId('Target_BoomingBlade_Default') or SpellId('Target_BoomingBlade_SneakAttack') or SpellId('Target_BoomingBlade_DivineStrike_Radiant') or SpellId('Target_BoomingBlade_DivineStrike_Cold') or SpellId('Target_BoomingBlade_DivineStrike_Fire') or SpellId('Target_BoomingBlade_DivineStrike_Lightning') or SpellId('Target_BoomingBlade_DivineStrike_Thunder') or SpellId('Target_BoomingBlade_DivineStrike_Poison') or SpellId('Target_BoomingBlade_DivineStrike_MeleeWeapon') or SpellId('Target_BoomingBlade_DivineStrike_Necrotic') or SpellId('Target_BoomingBlade_DivineStrike_Psychic')) and CharacterLevelGreaterThan(4)) or " .. revgloves.Conditions

	local mhnp = Ext.Stats.Get("MAG_Heightened_Necromancy_Passive")
	if string.find(mhnp.Boosts, "HeightenedNecromancySpellCheck%(%)") then
		mhnp.Boosts = string.gsub(mhnp.Boosts, "HeightenedNecromancySpellCheck%(%)", "HeightenedNecromancySpellCheck() | HasStringInSpellRoll('SpellAutoResolveOnUndead')")
	end

-- SRD's Cleric Subclasses
	if Ext.Mod.IsModLoaded("a6474f89-8efc-443d-cc95-9cdf142f931e") then
		local dstwilightpassive = Ext.Stats.Get("Divine_Strike_Twilight_Toggle")
		dstwilightpassive.Boosts = dstwilightpassive.Boosts .. ";UnlockSpell(Target_BoomingBlade_DivineStrike_Radiant);UnlockSpell(Target_GreenFlameBlade_DivineStrike_Radiant)"
		local dsorderpassive = Ext.Stats.Get("Divine_Strike_Order_Toggle")
		dsorderpassive.Boosts = dsorderpassive.Boosts .. ";UnlockSpell(Target_BoomingBlade_DivineStrike_Psychic);UnlockSpell(Target_GreenFlameBlade_DivineStrike_Psychic)"
		local intsrddsradiant = Ext.Stats.Get("Interrupt_SRD_DivineStrike_Radiant")
		local intsrddsradiantcrit = Ext.Stats.Get("Interrupt_SRD_DivineStrike_Radiant_Critical")
		intsrddsradiant.Conditions = "not SpellId('Target_BoomingBlade_DivineStrike_Radiant') and not SpellId('Target_GreenFlameBlade_DivineStrike_Radiant') and " .. intsrddsradiant.Conditions
		intsrddsradiantcrit.Conditions = "not SpellId('Target_BoomingBlade_DivineStrike_Radiant') and not SpellId('Target_GreenFlameBlade_DivineStrike_Radiant') and " .. intsrddsradiantcrit.Conditions
		local intsrddspsychic = Ext.Stats.Get("Interrupt_SRD_DivineStrike_Psychic")
		local intsrddspsychiccrit = Ext.Stats.Get("Interrupt_SRD_DivineStrike_Psychic_Critical")
		intsrddspsychic.Conditions = "not SpellId('Target_BoomingBlade_DivineStrike_Psychic') and not SpellId('Target_GreenFlameBlade_DivineStrike_Psychic') and " .. intsrddspsychic.Conditions
		intsrddspsychiccrit.Conditions = "not SpellId('Target_BoomingBlade_DivineStrike_Psychic') and not SpellId('Target_GreenFlameBlade_DivineStrike_Psychic') and " .. intsrddspsychiccrit.Conditions
	end

	local metamagicTwinned = Ext.Stats.Get("Metamagic_Twinned")

	if string.find(metamagicTwinned.Boosts, "TwinnedTargetTouchSpellCheck%(%)") then
		metamagicTwinned.Boosts = string.gsub(metamagicTwinned.Boosts, "TwinnedTargetTouchSpellCheck%(%)", "TwinnedTargetTouchSpellCheck() & ~HasStringInSpellRoll('SCAGtrips')")
	end

	if string.find(metamagicTwinned.Boosts, "TwinnedTargetTouchSpellCheckReaper%(%)") then
		metamagicTwinned.Boosts = string.gsub(metamagicTwinned.Boosts, "TwinnedTargetTouchSpellCheckReaper%(%)", "TwinnedTargetTouchSpellCheckReaper() & ~HasStringInSpellRoll('SCAGtrips')")
	end

	if Ext.Mod.IsModLoaded("84958e84-fd62-474f-bd1f-cbabc132c4b3") then
		local metamagicTwinned = Ext.Stats.Get("Metamagic_Twinned")
		if string.find(metamagicTwinned.Boosts, "TwinnedProjectileSpellCheck%(%)") then
			metamagicTwinned.Boosts = string.gsub(metamagicTwinned.Boosts, "TwinnedProjectileSpellCheck%(%)", "TwinnedProjectileSpellCheck() & ~IsSpellChildOrVariantFromContext('Projectile_JumpingJolt')")
		end

		if string.find(metamagicTwinned.Boosts, "TwinnedProjectileSpellCheckReaper%(%)") then
			metamagicTwinned.Boosts = string.gsub(metamagicTwinned.Boosts, "TwinnedProjectileSpellCheckReaper%(%)", "TwinnedProjectileSpellCheckReaper() & ~IsSpellChildOrVariantFromContext('Projectile_JumpingJolt')")
		end
	end

   for _, name in pairs(Ext.Stats.GetStats("SpellData")) do
        local spell = Ext.Stats.Get(name)
		if string.find(spell.TargetConditions, "IsTargetableCorpse%(%)")  then
			spell.TargetConditions = string.gsub(spell.TargetConditions, "IsTargetableCorpse%(%)", "IsTargetableCorpse() and NotGentleReposed()")
		end
	end

	local blur = Ext.Stats.Get("BLUR")
	if string.find(blur.Boosts,"not Tagged%('BLINDSIGHT', context.Source%)") and not string.find(blur.Boosts,"not HasStatus%('TRUESIGHT', context.Source%)") then
		blur.Boosts = string.gsub(blur.Boosts, "not Tagged%('BLINDSIGHT', context.Source%)", "not Tagged('BLINDSIGHT', context.Source) and not (HasStatus('TRUESIGHT', context.Source) or DistanceToTargetGreaterThan(36.5))")
	end

   for _, name in pairs(Ext.Stats.GetStats("Weapon")) do
        local weapon = Ext.Stats.Get(name)
		if string.find(weapon.DefaultBoosts, "WeaponProperty%(Magical%)") then
			weapon.DefaultBoosts = "Tag(MAGIC_ITEM_DETECT_MAGIC);" .. weapon.DefaultBoosts
		end
	end

	for _, name in pairs(Ext.Stats.GetStats("Armor")) do
		local armor = Ext.Stats.Get(name)
		if armor.Shield == "Yes" then
			local armorTemplate = armor.RootTemplate
			local template = Ext.Template.GetTemplate(armorTemplate)
			if template and template.Tags and template.Tags.Tags then
				local tags = template.Tags.Tags
				local checkTag = "7b96246c-54ba-43ea-b01d-4e0b20ad35f1"

				local hasTag = false
				for _, tag in pairs(tags) do
					if type(tag) == "string" and tag == checkTag then
						hasTag = true
						break
					end
				end

				for k, tag in pairs(tags) do
					if type(tag) ~= "string" then
--						_D("Non-string tag entry in " .. name .. ": key=" .. tostring(k) .. " value=" .. tostring(tag))
					end
				end

				if hasTag then
--					_D(name .. " has tag " .. checkTag)
				end
			end
		end
	end

	if Ext.Mod.IsModLoaded("f19c68ed-70be-4c3d-b610-e94afc5c5103") then
	   for _, name in pairs(Ext.Stats.GetStats("StatusData")) do
			local status = Ext.Stats.Get(name)
			if status.ModId == "f19c68ed-70be-4c3d-b610-e94afc5c5103" and string.find(status.Boosts,"UnlockSpellVariant") and string.find(name,"RAW_HIT_DICE") then
				status.Boosts = string.gsub(status.Boosts, "UnlockSpellVariant%(", "UnlockSpellVariant(WitherAndBloomHPSpells() | ")
			end
		end
	end

	for _, name in pairs(Ext.Stats.GetStats("StatusData")) do
		local status = Ext.Stats.Get(name)
		if name:find("PERFORM_POSITIVE") or name:find("PERFORM_NEGATIVE") then
			if Ext.Mod.IsModLoaded("f19c68ed-70be-4c3d-b610-e94afc5c5103") then
				status.RemoveConditions = "not StatusId('MAGIC_STONE_MODIFIER_REMOVAL') and not StatusId('DRAGONS_BREATH_MODIFIER_REMOVAL') and " .. status.RemoveConditions
--				status.RemoveConditions = status.RemoveConditions:gsub("not IsStatusEvent%(StatusEvent.OnStatusApplied%) or not RAW_StatusDoesNotInterruptPerform%(%)","not IsStatusEvent(StatusEvent.OnStatusApplied) or (not RAW_StatusDoesNotInterruptPerform() or not S5E_StatusDoesNotInterruptPerform())")
			else
				status.RemoveConditions = "not StatusId('MAGIC_STONE_MODIFIER_REMOVAL') and not StatusId('DRAGONS_BREATH_MODIFIER_REMOVAL') and " .. status.RemoveConditions
			end
		end
	end

--[[   for _, name in pairs(Ext.Stats.GetStats("SpellData")) do
        local spell = Ext.Stats.Get(name)
		if spell.SpellType == "Target" and (spell.TargetRadius == "MeleeMainWeaponRange" or spell.TargetRadius == "1.5") then
			spell.TargetConditions = spell.TargetConditions .. " and not HasStatus('LEVITATE_PSION')"
		end
	end--]]
end

function S5E_SpareTheDying()
	if not Ext.Mod.IsModLoaded("f19c68ed-70be-4c3d-b610-e94afc5c5103") then
		local helpact = Ext.Stats.Get("Target_Help")
		helpact:SetRawAttribute("SpellProperties","RemoveStatus(SG_Helpable_Condition);RemoveStatus(BURNING);RemoveStatus(SG_Prone);RemoveStatus(SG_Restrained);RemoveStatus(PRONE);RemoveStatus(SLEEPING);RemoveStatus(SLEEP);RemoveStatus(ENSNARING_STRIKE);RemoveStatus(WEB);RemoveStatus(HYPNOTIC_PATTERN)")
		helpact:SetRawAttribute("SpellSuccess","IF(IsDowned()):ApplyStatus(S5E_STABILIZED,100,-1)")
		helpact.SpellRoll = "not IsDowned() or SkillCheck(Skill.Medicine,10)"
		helpact:Sync()
	end
end

function S5E_SpareTheDying()
	if Ext.Mod.IsModLoaded("f19c68ed-70be-4c3d-b610-e94afc5c5103") then
		local helpact = Ext.Stats.Get("Target_Help")
		helpact:SetRawAttribute("SpellProperties","RemoveStatus(SG_Helpable_Condition);RemoveStatus(BURNING);RemoveStatus(SG_Prone);RemoveStatus(SG_Restrained);RemoveStatus(PRONE);RemoveStatus(SLEEPING);RemoveStatus(SLEEP);RemoveStatus(ENSNARING_STRIKE);RemoveStatus(WEB);RemoveStatus(HYPNOTIC_PATTERN)")
		helpact:SetRawAttribute("SpellSuccess","IF(IsDowned()):ApplyStatus(S5E_STABILIZED,100,-1)")
		helpact.SpellRoll = "not IsDowned() or SkillCheck(Skill.Medicine,10)"
		helpact:Sync()
	else
		local helpact = Ext.Stats.Get("Target_Help")
		helpact:SetRawAttribute("SpellProperties","RemoveStatus(SG_Sleeping);RemoveStatus(SG_Helpable_Condition);RemoveStatus(BURNING);RemoveStatus(SG_Prone);RemoveStatus(SG_Restrained);RemoveStatus(PRONE);RemoveStatus(SLEEPING);RemoveStatus(SLEEP);RemoveStatus(ENSNARING_STRIKE);RemoveStatus(WEB);IF(IsDowned()):RegainHitPoints(1);RemoveStatus(HYPNOTIC_PATTERN)")
		helpact:SetRawAttribute("SpellSuccess","")
		helpact.SpellRoll = ""
		helpact:Sync()
	end
end

function S5E_RaiseDead()
	local revivify = Ext.Stats.Get("Teleportation_Revivify")
	revivify.OriginTargetConditions = "NotDeadLongerThanAMinute() and " .. revivify.OriginTargetConditions
	revivify.TooltipPermanentWarnings = "827eba69-f29d-4365-802a-2effbc26a6f8;1"
	local revivify4 = Ext.Stats.Get("Teleportation_Revivify_4")
	revivify4.OriginTargetConditions = "NotDeadLongerThanAMinute() and " .. revivify4.OriginTargetConditions
	revivify4.TooltipPermanentWarnings = "827eba69-f29d-4365-802a-2effbc26a6f8;1"
	local revivify5 = Ext.Stats.Get("Teleportation_Revivify_5")
	revivify5.OriginTargetConditions = "NotDeadLongerThanAMinute() and " .. revivify5.OriginTargetConditions
	revivify5.TooltipPermanentWarnings = "827eba69-f29d-4365-802a-2effbc26a6f8;1"
	local revivify6 = Ext.Stats.Get("Teleportation_Revivify_6")
	revivify6.OriginTargetConditions = "NotDeadLongerThanAMinute() and " .. revivify6.OriginTargetConditions
	revivify6.TooltipPermanentWarnings = "827eba69-f29d-4365-802a-2effbc26a6f8;1"
	local revivifyscroll = Ext.Stats.Get("Teleportation_Revivify_Scroll")
	revivifyscroll.OriginTargetConditions = "NotDeadLongerThanAMinute() and " .. revivifyscroll.OriginTargetConditions
	revivifyscroll.TooltipPermanentWarnings = "827eba69-f29d-4365-802a-2effbc26a6f8;1"

	Ext.Loca.UpdateTranslatedString("h2d014c36g7457g49f8ga0d5g748fb44cb940","Casting Revivify or Raise Dead can bring the creature back to life but Revivify can't if it has been dead for at least 10 turns.")

	local dst = Ext.Stats.Get("DeathSavingThrows")
	dst.Conditions = "StatusId('DYING')"
	dst:SetRawAttribute("StatsFunctors", "IF(not HasAnyStatus({'DEAD_TECHNICAL_REMOVAL_STATUS','DEAD_TECHNICAL_REMOVAL_STATUS_2','DEAD_TECHNICAL_REMOVAL_STATUS_3','DEAD_TECHNICAL_REMOVAL_STATUS_4','DEAD_TECHNICAL_REMOVAL_STATUS_5','DEAD_TECHNICAL_REMOVAL_STATUS_6','DEAD_TECHNICAL_REMOVAL_STATUS_7','DEAD_TECHNICAL_REMOVAL_STATUS_8','DEAD_TECHNICAL_REMOVAL_STATUS_9','DEAD_TECHNICAL_REMOVAL_STATUS_10'},{},{},context.Source)):ApplyStatus(DEAD_TECHNICAL,100,10)")
	local flags = dst.StatsFunctorContext
	table.insert(flags, "OnStatusApplied")
	dst.StatsFunctorContext = flags

	if Ext.Mod.IsModLoaded("a2c4b0fc-e745-41df-81b7-fa53950d86a0") then
	local revivify7 = Ext.Stats.Get("Teleportation_Revivify_7")
	revivify7.OriginTargetConditions = "NotDeadLongerThanAMinute() and " .. revivify7.OriginTargetConditions
	revivify7.TooltipPermanentWarnings = "827eba69-f29d-4365-802a-2effbc26a6f8;1"
	local revivify8 = Ext.Stats.Get("Teleportation_Revivify_8")
	revivify8.OriginTargetConditions = "NotDeadLongerThanAMinute() and " .. revivify8.OriginTargetConditions
	revivify8.TooltipPermanentWarnings = "827eba69-f29d-4365-802a-2effbc26a6f8;1"
	local revivify9 = Ext.Stats.Get("Teleportation_Revivify_9")
	revivify9.OriginTargetConditions = "NotDeadLongerThanAMinute() and " .. revivify9.OriginTargetConditions
	revivify9.TooltipPermanentWarnings = "827eba69-f29d-4365-802a-2effbc26a6f8;1"
	else
		return
	end

	for _, name in pairs(Ext.Stats.GetStats("Character")) do
		local char = Ext.Stats.Get(name)
		if char ~= nil and string.find(char.Passives, "WeaponThrow") and string.find(char.Passives, "CombatStartAttack") then
			char.Passives = "S5E_NoInstantDeath;" .. char.Passives
		end
	end

	for _, name in pairs(Ext.Stats.GetStats("SpellData")) do
		local spell = Ext.Stats.Get(name)
		if name == "Target_GentleRepose" or spell.Using == "Target_GentleRepose" then
			spell.ExtraDescription = "h33b4bde3gb46dg4572g9be1g13775b35b6d5;1"
			Ext.Stats.Get("GENTLE_REPOSE").Description = "h2ff60f98g116ag4008ga830ga2b51384f174;1"
		end
	end
end

local ritualCasterSpells = {
  RitualCaster = "8c32c900-a8ea-4f2f-9f6f-eccd0d361a9d"
}

function S5E_RitualSpells()

	RemoveSpellsFromUUID({ ["Target_FindFamiliar"] = true }, "8c32c900-a8ea-4f2f-9f6f-eccd0d361a9d")
	RemoveSpellsFromUUID({ ["Shout_SpeakWithAnimals"] = true }, "8c32c900-a8ea-4f2f-9f6f-eccd0d361a9d")
	AddSpellsToUUID({ "Target_FindFamiliar_Ritual" }, "8c32c900-a8ea-4f2f-9f6f-eccd0d361a9d")
	AddSpellsToUUID({ "Shout_SpeakWithAnimals_Ritual" }, "8c32c900-a8ea-4f2f-9f6f-eccd0d361a9d")

   for _, name in pairs(Ext.Stats.GetStats("SpellData")) do
        local spell = Ext.Stats.Get(name)
		if spell.RitualCosts == "ActionPoint:1" and (spell.OriginalModId == "ed539163-bb70-431b-96a7-f5b2eda5376b" or spell.OriginalModId == "3d0c5ff8-c95d-c907-ff3e-34b204f1c630" or spell.OriginalModId == "991c9c7a-fb80-40cb-8f0d-b92d4e80e9b1" or spell.OriginalModId == "28ac9ce2-2aba-8cda-b3b5-6e922f71b6b8" or spell.OriginalModId == "fb5f528d-4d48-4bf2-a668-2274d3cfba96") and not (string.find(name,"_Ritual") or string.find(name,"PactOfTheChain") or string.find(name,"Target_Silence_BookOfAncientSecrets") or string.find(name,"Shout_SpeakWithAnimals_BeastSpeech") or string.find(name,"Shout_SpeakWithAnimals_SpiritSeeker") or string.find(name,"Shout_SpeakWithAnimals_Barbarian") or string.find(name,"Shout_SpeakWithAnimals_ForestGnome")) then
			spell.RitualCosts = ""
			if spell.RequirementConditions == "" then
				spell.RequirementConditions = "RitualSpellsInCombat()"
			else
				spell.RequirementConditions = "RitualSpellsInCombat() and " .. spell.RequirementConditions
			end
		end

		if name == "Target_FindFamiliar_Ritual" then
			spell.DisplayName = "h855d4c06g93d1g46fdg826eg3698553077fb;1"
		end

		if name == "Target_Silence_Ritual" then
			spell.DisplayName = "h2ed05105g110fg4556gb79cg9eb7f51b763a;1"
		end

		if name == "Target_SpeakWithAnimals_Ritual" then
			spell.DisplayName = "h28ff535fg8615g42c1g828eg1b89f615537e;1"
		end
	end

	if Ext.Mod.IsModLoaded("88fadf2c-152d-404e-b863-c12273559e1c") then	
		local artificerprog = Ext.StaticData.Get("c1965de9-87f1-47ee-93c7-43c54f685f2d","Progression")
		artificerprog["PassivesAdded"] = "S5E_RitualCasting;" .. artificerprog["PassivesAdded"]
		local artificermulticlassprog = Ext.StaticData.Get("0192a55b-231e-4f28-9ad3-c1c0c0ab91d3","Progression")
		artificermulticlassprog["PassivesAdded"] = "S5E_RitualCasting;" .. artificermulticlassprog["PassivesAdded"]
	end
	local bardprog = Ext.StaticData.Get("374c3aae-828b-44d8-b4e3-51ba802977dd","Progression")
	bardprog["PassivesAdded"] = "S5E_RitualCasting_SpellsKnown;" .. bardprog["PassivesAdded"]
	local bardmulticlassprog = Ext.StaticData.Get("d1e6f60f-7b72-43c7-8ed2-45cf9c3d34d3","Progression")
	bardmulticlassprog["PassivesAdded"] = "S5E_RitualCasting_SpellsKnown;" .. bardmulticlassprog["PassivesAdded"]
	local clericprog = Ext.StaticData.Get("1dbce574-fff1-49be-b7da-704f9b73cad9","Progression")
	clericprog["PassivesAdded"] = "S5E_RitualCasting;" .. clericprog["PassivesAdded"]
	local clericmulticlassprog = Ext.StaticData.Get("2b249feb-bba5-4922-8385-c2dd9baaa049","Progression")
	clericmulticlassprog["PassivesAdded"] = "S5E_RitualCasting;" .. clericmulticlassprog["PassivesAdded"]
	local druidprog = Ext.StaticData.Get("b499258c-2823-42f1-b8ca-0a5ee8455e11","Progression")
	druidprog["PassivesAdded"] = "S5E_RitualCasting;" .. druidprog["PassivesAdded"]
	local druidmulticlassprog = Ext.StaticData.Get("a13110fc-3555-4b33-9b8a-47f70586f567","Progression")
	druidmulticlassprog["PassivesAdded"] = "S5E_RitualCasting;" .. druidmulticlassprog["PassivesAdded"]
	local wizardprog = Ext.StaticData.Get("c201c736-3717-4c3c-9e36-2ae7387597a3","Progression")
	wizardprog["PassivesAdded"] = "S5E_RitualCasting_Wizard;" .. wizardprog["PassivesAdded"]
	local wizardmulticlassprog = Ext.StaticData.Get("92744093-a9b4-4df1-9e84-9d0b1dfea91d","Progression")
	wizardmulticlassprog["PassivesAdded"] = "S5E_RitualCasting_Wizard;" .. wizardmulticlassprog["PassivesAdded"]
	local warlockprog = Ext.StaticData.Get("a7767dc5-e6ab-4e05-96fd-f0424256121c","Progression")
	warlockprog["PassivesAdded"] = "S5E_RitualCasting_Warlock;" .. warlockprog["PassivesAdded"]
	local warlockmulticlassprog = Ext.StaticData.Get("20015e25-8aa9-41bf-b959-aa587ba0aa27","Progression")
	warlockmulticlassprog["PassivesAdded"] = "S5E_RitualCasting_Warlock;" .. warlockmulticlassprog["PassivesAdded"]
end

Spells = {  
	SpellList = "Spells",
}

SpellLists = {
  Feats = {
    SpellSniper = {
      "Target_GreenFlameBlade",
      "Target_PrimalSavagery"
    },
    RitualCaster = {
      "Target_Ceremony_Ritual",
      "Shout_DetectMagic_Ritual",
      "Target_UnseenServant_Ritual"
    }
  },

  Bard = {
    Cantrips = {
      "Target_Prestidigitation",
      "Shout_Thunderclap"
    },
    Spells1stTCoE = {
      "Zone_ColorSpray",
      "Target_Command_Container"
    },
    Spells1stOther = {
      "Shout_DetectMagic",
      "Shout_EarthTremor",
      "Target_UnseenServant"
    },
    Spells2ndTCoE = {
      "Shout_Aid",
      "Target_EnlargeReduce",
      "Target_Knock",
      "Shout_MirrorImage"
    },
    Spells2ndOther = {
      "Shout_BorrowedKnowledge",
      "Shout_KineticJaunt",
      "Target_NathairsMischief",
      "Shout_WardingWind",
      "Target_ZoneofTruth"
    },
    Spells3rdTCoE = {
      "Shout_HealingWord_Mass",
      "Target_Slow"
    },
    Spells3rdOther = {
      "Target_Antagonize",
      "Target_Catnap",
      "Target_EnemiesAbound",
      "Target_IntellectFortress",
      "Target_MotivationalSpeech",
      "Target_Nondetection"
    },
    Spells4thTCoE = {
      "Target_PhantasmalKiller"
    },
    Spells4thOther = {
      "Target_CharmMonster",
      "Projectile_RaulothimsPsychicLance"
    },
    Spells5thOther = {
      "Target_Mislead",
      "Target_RaiseDead",
      "Target_SkillEmpowerment",
      "Target_SynapticStatic",
      "Teleportation_TeleportationCircle"
    },
    Spells6thTCoE = {
      "Shout_HeroesFeast"
    },
    Spells6thOther = {
      "Target_TrueSeeing"
    },
    Spells7thOther = {
      "Target_Regenerate"
    },
    Spells8thOther = {
      "Target_DominateMonster",
      "Target_Feeblemind",
      "Target_MindBlank"
    },
    Spells9thOther = {
      "Target_Foresight",
      "Target_PowerWordHeal",
      "Target_PowerWordKill"
    },

    MagicalSecrets = {
      CantripsTCoE = {
        "Projectile_AcidSplash",
        "Shout_BladeWard",
        "Target_ChillTouch",
        "Target_DancingLights",
        "Target_Friends",
        "Target_Guidance",
        "Target_Light",
        "Target_MageHand",
        "Target_MinorIllusion",
        "Projectile_PoisonSpray",
        "Shout_ProduceFlame",
        "Target_Resistance",
        "Shout_Shillelagh",
        "Target_ShockingGrasp",
        "Shout_Thaumaturgy",
        "Target_ThornWhip",
        "Target_TrueStrike"
      },
      SecretSpells1stTCoE = {
        "Target_AnimalFriendship",
        "Shout_ArmsOfHadar",
        "Target_Bane",
        "Zone_BurningHands",
        "Target_CharmPerson",
        "Zone_ColorSpray",
        "Target_CreateDestroyWater",
        "Target_CureWounds",
        "Shout_DisguiseSelf",
        "Target_DissonantWhispers",
        "Projectile_EnsnaringStrike_Container",
        "Shout_ExpeditiousRetreat",
        "Target_FaerieFire",
        "Shout_FeatherFall",
        "Target_FindFamiliar",
        "Target_FogCloud",
        "Target_Goodberry",
        "Target_Grease",
        "Projectile_HailOfThorns",
        "Target_HealingWord",
        "Target_Heroism",
        "Target_HideousLaughter",
        "Target_HuntersMark",
        "Target_InflictWounds",
        "Target_Jump",
        "Target_Longstrider",
        "Target_MageArmor",
        "Target_ProtectionFromEvilAndGood",
        "Projectile_RayOfSickness",
        "Shout_Shield_Wizard",
        "Target_ShieldOfFaith",
        "Target_Sleep",
        "Target_Smite_Searing",
        "Target_Smite_Wrathful",
        "Shout_SpeakWithAnimals",
        "Zone_Thunderwave",
        "Projectile_WitchBolt"
      },
      SecretSpells2ndTCoE = {
        "Projectile_AcidArrow",
        "Shout_Aid",
        "Target_Barkskin",
        "Target_Blindness",
        "Target_Smite_Branding_Container",
        "Target_CalmEmotions",
        "Target_CloudOfDaggers",
        "Target_CrownOfMadness",
        "Shout_DetectThoughts",
        "Target_EnhanceAbility",
        "Target_EnlargeReduce",
        "Target_Enthrall",
        "Shout_FlameBlade",
        "Target_FlamingSphere",
        "Zone_GustOfWind",
        "Target_HeatMetal",
        "Target_HoldPerson",
        "Target_Invisibility",
        "Target_Knock",
        "Target_LesserRestoration",
        "Target_MagicWeapon",
        "Shout_MirrorImage",
        "Target_Moonbeam",
        "Target_PhantasmalForce",
        "Shout_PrayerOfHealing",
        "Target_ProtectionFromPoison",
        "Shout_SeeInvisibility",
        "Target_Shatter",
        "Target_Silence",
        "Target_WardingBond"
      },
      SecretSpells3rdTCoE = {
        "Shout_BeaconOfHope",
        "Target_BestowCurse",
        "Target_Smite_Blinding",
        "Shout_Blink",
        "Zone_ConjureBarrage",
        "Shout_CrusadersMantle",
        "Target_ElementalWeapon",
        "Zone_Fear",
        "Target_FeignDeath",
        "Target_GlyphOfWarding",
        "Target_HungerOfHadar",
        "Target_HypnoticPattern",
        "Projectile_LightningArrow",
        "Target_PlantGrowth",
        "Target_ProtectionFromEnergy",
        "Target_SpeakWithDead",
        "Target_StinkingCloud",
        "Target_VampiricTouch"
      },
      SecretSpells4thTCoE = {
        "Target_Confusion",
        "Target_ConjureElementals_Minor_Container",
        "Target_ConjureWoodlandBeings",
        "Teleportation_DimensionDoor",
        "Target_BlackTentacles",
        "Target_FreedomOfMovement",
        "Target_GraspingVine",
        "Target_Invisibility_Greater",
        "Target_PhantasmalKiller",
        "Target_Polymorph",
        "Target_ResilientSphere",
        "Target_Stoneskin"
      },
      SecretSpells5thTCoE = {
        "Target_Cloudkill",
        "Shout_DestructiveWave",
        "Target_DominatePerson",
        "Target_FlameStrike",
        "Target_GreaterRestoration",
        "Target_InsectPlague",
        "Target_CureWounds_Mass",
        "Target_PlanarBinding",
        "Target_Seeming",
        "Throw_Telekinesis"
      },
      SecretSpells6thTCoE = {
        "Wall_BladeBarrier",
        "Projectile_ChainLightning",
        "Target_CircleOfDeath",
        "Target_CreateUndead",
        "Projectile_Disintegrate",
        "Target_Eyebite",
        "Target_FreezingSphere",
        "Target_GlobeOfInvulnerability",
        "Target_FleshToStone",
        "Target_IrresistibleDance",
        "Target_Heal",
        "Target_Harm",
        "Shout_HeroesFeast",
        "Target_PlanarAlly_Container",
        "Wall_WallOfIce",
        "Wall_WallOfThorns",
        "Shout_WindWalk",
        "Zone_Sunbeam"
      },
      CantripsOther = {
        "Target_BoomingBlade_5e",
        "Target_ControlFlames",
        "Target_CreateBonfire",
        "Shout_Druidcraft",
        "Target_Frostbite",
        "Target_GreenFlameBlade",
        "Target_Gust",
        "Target_Infestation",
        "Target_LightningLure",
        "Target_MagicStone",
        "Target_MindSliver",
        "Target_MoldEarth",
        "Target_Prestidigitation",
        "Target_ShapeWater",
        "Target_SpareTheDying",
        "Shout_SwordBurst",
        "Shout_Thunderclap",
        "Shout_WordOfRadiance"
      },
      SecretSpells1stOther = {
        "Shout_AbsorbElements",
        "Throw_Catapult",
        "Target_CauseFear",
        "Target_Ceremony",
        "Target_ChaosBolt",
        "Shout_DetectEvilAndGood",
        "Zone_FrostFingers",
        "Target_Snare",
        "Zone_TashasCausticBrew",
        "Shout_ZephyrStrike"
      },
      SecretSpells2ndOther = {
        "Zone_AganazzarsScorcher",
        "Shout_AlterSelf",
        "Target_ContinualFlame",
        "Target_DragonsBreath",
        "Target_DustDevil",
        "Shout_FindTraps",
        "Target_FlockOfFamiliars",
        "Target_GentleRepose",
        "Target_HealingSpirit",
        "Target_MaximiliansEarthenGrasp",
        "Target_TashasMindWhip",
        "Target_MindSpike",
        "Zone_RimesBindingIce",
        "Target_SnillocsSnowballStorm",
        "Target_VortexWarp",
        "Target_WitherAndBloom",
        "Target_ZoneofTruth"
      },
      SecretSpells3rdOther = {
        "Target_Antagonize",
        "Target_ConjureAnimals_Container",
        "Target_CreateFoodAndWater",
        "Target_EnemiesAbound",
        "Target_EruptingEarth",
        "Target_FlameArrows",
        "Target_MagicCircle",
        "Projectile_MinuteMeteors",
        "Shout_SpiritShroud",
        "Target_SummonFey",
        "Target_SummonShadowspawn",
        "Teleportation_ThunderStep",
        "Shout_WaterWalk"
      },
      SecretSpells4thOther = {
        "Target_ArcaneEye",
        "Shout_AuraOfLife",
        "Shout_GuardianOfNature",
        "Shout_ShadowOfMoil",
        "Target_SummonBeholderkin",
        "Target_SummonConstruct",
        "Target_SummonElemental",
        "Projectile_VitriolicSphere"
      },
      SecretSpells5thOther = {
        "Shout_AntilifeShell",
        "Shout_CircleOfPower",
        "Shout_CommuneWithNature",
        "ProjectileStrike_ConjureVolley",
        "Target_FarStep",
        "Target_HoldMonster",
        "Target_HolyWeapon",
        "Target_Maelstrom",
        "Target_Mislead",
        "Projectile_NegativeEnergyFlood",
        "Target_SteelWindStrike",
        "Target_StormSphere",
        "Shout_SwiftQuiver",
		"Teleportation_TeleportationCircle"
      },
      SecretSpells6thOther = {
        "Teleportation_ArcaneGate",
        "Shout_TensersTransformation",
        "Target_TrueSeeing"
      },
      SecretSpells7thOther = {
        "Target_FingerOfDeath",
        "Target_Regenerate"
      },
      SecretSpells8thOther = {
        "Target_DominateMonster",
        "Target_Feeblemind",
        "Shout_HolyAura",
        "Target_MindBlank"
      },
      SecretSpells9thOther = {
        "Target_Foresight",
        "Target_PowerWordHeal",
        "Target_PowerWordKill"
      }
    }
  },

  Cleric = {
    Cantrips = {
      "Target_SpareTheDying",
      "Shout_WordOfRadiance"
    },
    Spells1stOther = {
      "Target_Ceremony",
      "Shout_DetectEvilAndGood",
      "Shout_DetectMagic"
    },
    Spells2ndOther = {
      "Shout_BorrowedKnowledge",
      "Target_ContinualFlame",
      "Shout_FindTraps",
      "Target_GentleRepose",
      "Target_ZoneofTruth"
    },
    Spells3rdTCoE = {
      "Shout_AuraOfVitality"
    },
    Spells3rdOther = {
      "Target_CreateFoodAndWater",
      "Target_LifeTransference",
      "Target_MagicCircle",
      "Target_MotivationalSpeech",
      "Shout_SpiritShroud",
      "Shout_WaterWalk"
    },
    Spells4thOther = {
      "Shout_AuraOfLife"
    },
    Spells5thOther = {
      "Target_HolyWeapon",
      "Target_RaiseDead"
    },
    Spells6thTCoE = {
      "Zone_Sunbeam"
    },
    Spells6thOther = {
      "Target_TrueSeeing"
    },
    Spells7thOther = {
      "Target_Regenerate"
    },
    Spells8thOther = {
      "Shout_HolyAura"
    },
    Spells9thOther = {
      "Target_PowerWordHeal"
    }
  },

  Druid = {
    Cantrips = {
      "Target_ControlFlames",
      "Target_CreateBonfire",
      "Shout_Druidcraft",
      "Target_Frostbite",
      "Target_Gust",
      "Target_Infestation",
      "Target_MagicStone",
      "Target_MoldEarth",
      "Target_PrimalSavagery",
      "Target_ShapeWater",
      "Shout_Thunderclap"
    },
    Spells1stTCoE = {
      "Target_ProtectionFromEvilAndGood"
    },
    Spells1stOther = {
      "Shout_AbsorbElements",
      "Target_BeastBond",
      "Shout_DetectMagic",
      "Shout_EarthTremor",
      "Target_Snare"
    },
    Spells2ndTCoE = {
      "Target_EnlargeReduce"
    },
    Spells2ndOther = {
      "Target_ContinualFlame",
      "Target_DustDevil",
      "Shout_FindTraps",
      "Target_HealingSpirit",
      "Target_SummonBeast",
      "Target_WitherAndBloom",
      "Shout_WardingWind"
    },
    Spells3rdTCoE = {
      "Shout_AuraOfVitality",
      "Target_ElementalWeapon",
      "Teleportation_Revivify"
    },
    Spells3rdOther = {
      "Target_ConjureAnimals_Container",
      "Target_EruptingEarth",
      "Target_FlameArrows",
      "Target_SummonFey",
      "Shout_WaterWalk"
    },
    Spells4thTCoE = {
      "Shout_FireShield"
    },
    Spells4thOther = {
      "Target_CharmMonster",
      "Shout_GuardianOfNature",
      "Target_SummonElemental"
    },
    Spells5thTCoE = {
      "Zone_ConeOfCold"
    },
    Spells5thOther = {
      "Shout_AntilifeShell",
      "Shout_CommuneWithNature",
      "Target_Maelstrom"
    },
    Spells6thTCoE = {
      "Target_FleshToStone"
    },
    Spells7thOther = {
      "Target_Regenerate"
    },
    Spells8thOther = {
      "Target_Feeblemind"
    },
    Spells9thOther = {
      "Target_Foresight"
    }
  },

  FighterEK = {
    Spells1stOther = {
      "Shout_AbsorbElements",
      "Shout_EarthTremor",
      "Zone_FrostFingers",
      "Target_Snare",
      "Zone_TashasCausticBrew"
    },
    Spells2ndOther = {
      "Zone_AganazzarsScorcher",
      "Target_ContinualFlame",
      "Zone_RimesBindingIce",
      "Target_SnillocsSnowballStorm",
      "Shout_WardingWind"
    },
    Spells3rdOther = {
      "Target_IntellectFortress",
      "Target_MagicCircle",
      "Projectile_MinuteMeteors",
      "Target_Nondetection"
    },
    Spells4thOther = {
      "Target_StormSphere",
      "Projectile_VitriolicSphere"
    }
  },

  Paladin = {
    Spells1stOther = {
      "Target_Ceremony",
      "Shout_DetectEvilAndGood",
      "Shout_DetectMagic"
    },
    Spells2ndTCoE = {
      "Shout_PrayerOfHealing",
      "Target_WardingBond"
    },
    Spells2ndOther = {
      "Target_GentleRepose",
      "Target_ZoneofTruth"
    },
    Spells3rdOther = {
      "Target_CreateFoodAndWater",
      "Target_MagicCircle",
      "Shout_SpiritShroud"
    },
    Spells4thOther = {
      "Shout_AuraOfLife"
    },
    Spells5thOther = {
      "Shout_CircleOfPower",
      "Target_HolyWeapon",
      "Target_RaiseDead"
    }
  },

  Ranger = {
    Spells1stTCoE = {
      "Target_Entangle",
      "Target_Smite_Searing"
    },
    Spells1stOther = {
      "Shout_AbsorbElements",
      "Target_BeastBond",
      "Shout_DetectMagic",
      "Target_Snare",
      "Shout_ZephyrStrike"
    },
    Spells2ndTCoE = {
      "Shout_Aid",
      "Target_EnhanceAbility",
      "Zone_GustOfWind",
      "Target_MagicWeapon"
    },
    Spells2ndOther = {
      "Shout_FindTraps",
      "Target_HealingSpirit",
      "Target_SummonBeast"
    },
    Spells3rdTCoE = {
      "Target_ElementalWeapon",
      "Teleportation_Revivify"
    },
    Spells3rdOther = {
      "Shout_AshardalonsStride",
      "Target_ConjureAnimals_Container",
      "Target_FlameArrows",
      "Target_Nondetection",
      "Target_SummonFey",
      "Shout_WaterWalk"
    },
    Spells4thTCoE = {
      "Target_DominateBeast"
    },
    Spells4thOther = {
      "Shout_GuardianOfNature",
      "Target_SummonElemental"
    },
    Spells5thTCoE = {
      "Target_GreaterRestoration"
    },
    Spells5thOther = {
      "Shout_CommuneWithNature",
      "ProjectileStrike_ConjureVolley",
      "Target_SteelWindStrike",
      "Shout_SwiftQuiver"
    }
  },

  RogueAT = {
    Spells2ndOther = {
      "Target_TashasMindWhip",
      "Target_NathairsMischief"
    },
    Spells3rdOther = {
      "Target_Antagonize",
      "Target_Catnap",
      "Target_EnemiesAbound"
    },
    Spells4thOther = {
      "Target_CharmMonster",
      "Projectile_RaulothimsPsychicLance"
    }
  },

  Sorcerer = {
    Cantrips = {
      "Target_ControlFlames",
      "Target_CreateBonfire",
      "Target_Frostbite",
      "Target_GreenFlameBlade",
      "Target_Gust",
      "Target_Infestation",
      "Target_LightningLure",
      "Target_MindSliver",
      "Target_MoldEarth",
      "Target_Prestidigitation",
      "Target_ShapeWater",
      "Shout_SwordBurst",
      "Shout_Thunderclap"
    },
    Spells1stTCoE = {
      "Target_Grease"
    },
    Spells1stOther = {
      "Shout_AbsorbElements",
      "Throw_Catapult",
      "Target_ChaosBolt",
      "Shout_DetectMagic",
      "Shout_EarthTremor",
      "Zone_TashasCausticBrew"
    },
    Spells2ndTCoE = {
      "Shout_FlameBlade",
      "Target_FlamingSphere",
      "Target_MagicWeapon"
    },
    Spells2ndOther = {
      "Zone_AganazzarsScorcher",
      "Shout_AlterSelf",
      "Target_DragonsBreath",
      "Target_DustDevil",
      "Shout_KineticJaunt",
      "Target_MaximiliansEarthenGrasp",
      "Target_TashasMindWhip",
      "Target_MindSpike",
      "Target_NathairsMischief",
      "Zone_RimesBindingIce",
      "Target_SnillocsSnowballStorm",
      "Target_VortexWarp",
      "Shout_WardingWind",
      "Target_WitherAndBloom"
    },
    Spells3rdTCoE = {
      "Target_VampiricTouch"
    },
    Spells3rdOther = {
      "Target_Antagonize",
      "Shout_AshardalonsStride",
      "Target_Catnap",
      "Target_EnemiesAbound",
      "Target_EruptingEarth",
      "Target_FlameArrows",
      "Target_IntellectFortress",
      "Projectile_MinuteMeteors",
      "Teleportation_ThunderStep",
      "Shout_WaterWalk"
    },
    Spells4thTCoE = {
      "Shout_FireShield"
    },
    Spells4thOther = {
      "Target_CharmMonster",
      "Projectile_RaulothimsPsychicLance",
      "Target_StormSphere",
      "Projectile_VitriolicSphere"
    },
    Spells5thOther = {
      "Target_FarStep",
      "Target_SkillEmpowerment",
      "Target_SynapticStatic"
    },
    Spells6thTCoE = {
      "Target_FleshToStone",
      "Target_FreezingSphere"
    },
    Spells6thOther = {
      "Target_TrueSeeing"
    },
    Spells7thOther = {
      "Target_FingerOfDeath"
    },
    Spells8thOther = {
      "Target_DominateMonster"
    },
    Spells9thOther = {
      "Target_PowerWordKill"
    }
  },

  Warlock = {
    Cantrips = {
      "Target_CreateBonfire",
      "Target_Frostbite",
      "Target_GreenFlameBlade",
      "Target_Gust",
      "Target_Infestation",
      "Target_LightningLure",
      "Target_MagicStone",
      "Target_MindSliver",
      "Target_Prestidigitation",
      "Target_ShapeWater",
      "Shout_SwordBurst",
      "Shout_Thunderclap",
      "Target_TollTheDead"
    },
    Spells1stOther = {
      "Target_CauseFear",
      "Target_UnseenServant"
    },
    Spells2ndOther = {
      "Shout_BorrowedKnowledge",
      "Target_FlockOfFamiliars",
      "Target_MindSpike"
    },
    Spells3rdOther = {
      "Target_Antagonize",
      "Target_EnemiesAbound",
      "Target_IntellectFortress",
      "Target_MagicCircle",
      "Shout_SpiritShroud",
      "Target_SummonFey",
      "Target_SummonShadowspawn",
      "Teleportation_ThunderStep"
    },
    Spells4thOther = {
      "Target_CharmMonster",
      "Projectile_RaulothimsPsychicLance",
      "Shout_ShadowOfMoil",
      "Target_SummonBeholderkin"
    },
    Spells5thTCoE = {
      "Target_Mislead",
      "Target_PlanarBinding",
      "Teleportation_TeleportationCircle"
    },
    Spells5thOther = {
      "Target_FarStep",
      "Projectile_NegativeEnergyFlood",
      "Target_SynapticStatic"
    },
    Spells6thOther = {
      "Target_TrueSeeing"
    },
    Spells7thOther = {
      "Target_FingerOfDeath"
    },
    Spells8thOther = {
      "Target_DominateMonster",
      "Target_Feeblemind"
    },
    Spells9thOther = {
      "Target_Foresight",
      "Target_PowerWordKill"
    }
  },

  Wizard = {
    Cantrips = {
      "Target_ControlFlames",
      "Target_CreateBonfire",
      "Target_Frostbite",
      "Target_GreenFlameBlade",
      "Target_Gust",
      "Target_Infestation",
      "Target_LightningLure",
      "Target_MindSliver",
      "Target_MoldEarth",
      "Target_Prestidigitation",
      "Target_ShapeWater",
      "Shout_SwordBurst",
      "Shout_Thunderclap",
      "Target_TollTheDead"
    },
    Spells1stOther = {
      "Shout_AbsorbElements",
      "Throw_Catapult",
      "Target_CauseFear",
      "Shout_DetectMagic",
      "Shout_EarthTremor",
      "Zone_FrostFingers",
      "Target_Snare",
      "Zone_TashasCausticBrew",
      "Target_UnseenServant"
    },
    Spells2ndTCoE = {
      "Target_EnhanceAbility"
    },
    Spells2ndOther = {
      "Zone_AganazzarsScorcher",
      "Shout_AlterSelf",
      "Shout_BorrowedKnowledge",
      "Target_ContinualFlame",
      "Target_DragonsBreath",
      "Target_DustDevil",
      "Target_FlockOfFamiliars",
      "Target_GentleRepose",
      "Shout_KineticJaunt",
      "Target_MaximiliansEarthenGrasp",
      "Target_TashasMindWhip",
      "Target_MindSpike",
      "Target_NathairsMischief",
      "Zone_RimesBindingIce",
      "Target_SnillocsSnowballStorm",
      "Target_VortexWarp",
      "Shout_WardingWind",
      "Target_WitherAndBloom"
    },
    Spells3rdTCoE = {
      "Target_SpeakWithDead"
    },
    Spells3rdOther = {
      "Target_Antagonize",
      "Shout_AshardalonsStride",
      "Target_Catnap",
      "Target_EnemiesAbound",
      "Target_EruptingEarth",
      "Target_FlameArrows",
      "Target_IntellectFortress",
      "Target_LifeTransference",
      "Target_MagicCircle",
      "Projectile_MinuteMeteors",
      "Target_Nondetection",
      "Shout_SpiritShroud",
      "Target_SummonFey",
      "Target_SummonShadowspawn",
      "Teleportation_ThunderStep"
    },
    Spells4thOther = {
      "Target_ArcaneEye",
      "Target_CharmMonster",
      "Projectile_RaulothimsPsychicLance",
      "Target_StormSphere",
      "Target_SummonBeholderkin",
      "Target_SummonConstruct",
      "Target_SummonElemental",
      "Projectile_VitriolicSphere"
    },
    Spells5thOther = {
      "Target_FarStep",
      "Target_Mislead",
      "Projectile_NegativeEnergyFlood",
      "Target_SkillEmpowerment",
      "Target_SteelWindStrike",
      "Target_SynapticStatic"
    },
    Spells6thOther = {
      "Shout_TensersTransformation",
      "Target_TrueSeeing"
    },
    Spells7thOther = {
      "Target_FingerOfDeath"
    },
    Spells8thOther = {
      "Target_DominateMonster",
      "Target_Feeblemind",
      "Target_MindBlank"
    },
    Spells9thOther = {
      "Target_Foresight",
      "Target_PowerWordKill"
    }
  },

  Variants = {
    BoomingBlade5e = { "Target_BoomingBlade_5e" },
    BoomingBladeLarian = { "Target_BoomingBlade_ClassSpell" }
  }
}

local cantripList5ES = {
  SpellSniper = "64784e08-e31e-4850-a743-ecfb3fd434d7",
  BardCantrip = "61f79a30-2cac-4a7a-b5fe-50c89d307dd6",
  BardMS3rdCantrip = "175ceed7-5a53-4f48-823c-41c4f72d18ae",
  BardMS5thCantrip = "858d4322-9e9f-4aa4-aada-9c68835dc6fe",
  BardMS7thCantrip = "95f80109-32b7-43f8-a99a-7ee2286a993a",
  BardMS9thCantrip = "cd83187f-c886-45c2-be81-34083981f240",
  ClericCantrip = "2f43a103-5bf1-4534-b14f-663decc0c525",
  DruidCantrip = "b8faf12f-ca42-45c0-84f8-6951b526182a",
  SorcererCantrip = "485a68b4-c678-4888-be63-4a702efbe391",
  WarlockCantrip = "3489b1a5-9f7c-439a-b6e3-8cceb21e34fd",
  WizardCantrip = "3cae2e56-9871-4cef-bba6-96845ea765fa"
}

local tcoe1stLevelList5ES = {
  Bard1stTCoE = "dcb45167-86bd-4297-9b9d-c295be51af5b",
  Bard2ndTCoE = "7ea8f476-97a1-4256-8f10-afa76a845cce",
  Bard3rdTCoE = "c213ca01-3767-457b-a5c8-fd4c1dd656e2",
  Bard4thTCoE = "75e04c40-be8f-40a5-9acc-0b5d59d5f3a6",
  Bard5thTCoE = "bd71fffb-e4d2-4233-9a31-13d43fba36e3",
  Bard6thTCoE = "586a8796-34f4-41f5-a3ef-95738561d55d",
  Bard7thTCoE = "f923e058-b1d9-4b02-98ef-9daaa82a71b6",
  Bard8thTCoE = "073c09e5-ccb9-4153-a210-001225a30cbb",
  Bard9thTCoE = "2bbd99d0-21b4-41cc-836e-e386a96fc8e6",
  BardMS3rdTCoE = "175ceed7-5a53-4f48-823c-41c4f72d18ae",
  BardMS5thTCoE = "858d4322-9e9f-4aa4-aada-9c68835dc6fe",
  BardMS7thTCoE = "95f80109-32b7-43f8-a99a-7ee2286a993a",
  BardMS9thTCoE = "cd83187f-c886-45c2-be81-34083981f240",
  Druid1stTCoE = "2cd54137-2fe5-4100-aad3-df64735a8145",
  Ranger1stTCoE = "458be063-60d4-4548-ae7d-50117fa0226f",
  Ranger2ndTCoE = "e7cfb80a-f5c2-4304-8446-9b00ea6a9814",
  Ranger3rdTCoE = "9a60f649-7f82-4152-90b1-0499c5c9f3e2",
  Ranger4thTCoE = "7022d937-b2e4-4b6e-a3c5-e168f5c00194",
  Ranger5thTCoE = "412d77e1-4aa2-4149-aa0e-c835b8c79f32",
  Sorcerer1stTCoE = "92c4751f-6255-4f67-822c-a75d53830b27",
  Sorcerer2ndTCoE = "f80396e2-cb76-4694-b0db-5c34da61a478",
  Sorcerer3rdTCoE = "dcbaf2ae-1f45-453e-ab83-cd154f8277a4",
  Sorcerer4thTCoE = "5fe40622-1d3e-4cc1-8d89-e66fe51d8c5c",
  Sorcerer5thTCoE = "3276fcfe-e143-4559-b6e0-7d7aa0ffcb53",
  Sorcerer6thTCoE = "1270a6db-980b-4e3b-bf26-2924da61dfd5",
  Sorcerer7thTCoE = "9e38e5ae-51e8-4dd4-aad5-869a571b1519",
  Sorcerer8thTCoE = "5a8a002c-352b-44e9-8233-da7e6112f4b0",
  Sorcerer9thTCoE = "d58ac072-e079-410b-b167-a5e43723b59f"
}

local tcoe2ndLevelList5ES = {
  Bard2ndTCoE = "7ea8f476-97a1-4256-8f10-afa76a845cce",
  Bard3rdTCoE = "c213ca01-3767-457b-a5c8-fd4c1dd656e2",
  Bard4thTCoE = "75e04c40-be8f-40a5-9acc-0b5d59d5f3a6",
  Bard5thTCoE = "bd71fffb-e4d2-4233-9a31-13d43fba36e3",
  Bard6thTCoE = "586a8796-34f4-41f5-a3ef-95738561d55d",
  Bard7thTCoE = "f923e058-b1d9-4b02-98ef-9daaa82a71b6",
  Bard8thTCoE = "073c09e5-ccb9-4153-a210-001225a30cbb",
  Bard9thTCoE = "2bbd99d0-21b4-41cc-836e-e386a96fc8e6",
  BardMS3rdTCoE = "175ceed7-5a53-4f48-823c-41c4f72d18ae",
  BardMS5thTCoE = "858d4322-9e9f-4aa4-aada-9c68835dc6fe",
  BardMS7thTCoE = "95f80109-32b7-43f8-a99a-7ee2286a993a",
  BardMS9thTCoE = "cd83187f-c886-45c2-be81-34083981f240",
  Druid2ndTCoE = "92126d17-7f1a-41d2-ae6c-a8d254d2b135",
  Paladin2ndTCoE = "c14c9564-1503-47a1-be19-98e77f22ff59",
  Ranger2ndTCoE = "e7cfb80a-f5c2-4304-8446-9b00ea6a9814",
  Ranger3rdTCoE = "9a60f649-7f82-4152-90b1-0499c5c9f3e2",
  Ranger4thTCoE = "7022d937-b2e4-4b6e-a3c5-e168f5c00194",
  Ranger5thTCoE = "412d77e1-4aa2-4149-aa0e-c835b8c79f32",
  Sorcerer2ndTCoE = "f80396e2-cb76-4694-b0db-5c34da61a478",
  Sorcerer3rdTCoE = "dcbaf2ae-1f45-453e-ab83-cd154f8277a4",
  Sorcerer4thTCoE = "5fe40622-1d3e-4cc1-8d89-e66fe51d8c5c",
  Sorcerer5thTCoE = "3276fcfe-e143-4559-b6e0-7d7aa0ffcb53",
  Sorcerer6thTCoE = "1270a6db-980b-4e3b-bf26-2924da61dfd5",
  Sorcerer7thTCoE = "9e38e5ae-51e8-4dd4-aad5-869a571b1519",
  Sorcerer8thTCoE = "5a8a002c-352b-44e9-8233-da7e6112f4b0",
  Sorcerer9thTCoE = "d58ac072-e079-410b-b167-a5e43723b59f",
  Wizard2ndTCoE = "80c6b070-c3a6-4864-84ca-e78626784eb4",
  Wizard3rdTCoE = "22755771-ca11-49f4-b772-13d8b8fecd93",
  Wizard4thTCoE = "820b1220-0385-426d-ae15-458dc8a6f5c0",
  Wizard5thTCoE = "f781a25e-d288-43b4-bf5d-3d8d98846687",
  Wizard6thTCoE = "bc917f22-7f71-4a25-9a77-7d2f91a96a65",
  Wizard7thTCoE = "dff7917a-0abc-4671-b68f-c03e56212549",
  Wizard8thTCoE = "f27a2d0a-0d6c-4c01-98a5-60081abf4807",
  Wizard9thTCoE = "cb123d97-8809-4d71-a0cb-0ecb66177d15"
}

local tcoe3rdLevelList5ES = {
  Bard3rdTCoE = "c213ca01-3767-457b-a5c8-fd4c1dd656e2",
  Bard4thTCoE = "75e04c40-be8f-40a5-9acc-0b5d59d5f3a6",
  Bard5thTCoE = "bd71fffb-e4d2-4233-9a31-13d43fba36e3",
  Bard6thTCoE = "586a8796-34f4-41f5-a3ef-95738561d55d",
  Bard7thTCoE = "f923e058-b1d9-4b02-98ef-9daaa82a71b6",
  Bard8thTCoE = "073c09e5-ccb9-4153-a210-001225a30cbb",
  Bard9thTCoE = "2bbd99d0-21b4-41cc-836e-e386a96fc8e6",
  BardMS3rdTCoE = "175ceed7-5a53-4f48-823c-41c4f72d18ae",
  BardMS5thTCoE = "858d4322-9e9f-4aa4-aada-9c68835dc6fe",
  BardMS7thTCoE = "95f80109-32b7-43f8-a99a-7ee2286a993a",
  BardMS9thTCoE = "cd83187f-c886-45c2-be81-34083981f240",
  Cleric3rdTCoE = "21be0992-499f-4c7a-a77a-4430085e947a",
  Druid3rdTCoE = "3156daf5-9266-41d0-b52c-5bc559a98654",
  Ranger3rdTCoE = "9a60f649-7f82-4152-90b1-0499c5c9f3e2",
  Ranger4thTCoE = "7022d937-b2e4-4b6e-a3c5-e168f5c00194",
  Ranger5thTCoE = "412d77e1-4aa2-4149-aa0e-c835b8c79f32",
  Sorcerer3rdTCoE = "dcbaf2ae-1f45-453e-ab83-cd154f8277a4",
  Sorcerer4thTCoE = "5fe40622-1d3e-4cc1-8d89-e66fe51d8c5c",
  Sorcerer5thTCoE = "3276fcfe-e143-4559-b6e0-7d7aa0ffcb53",
  Sorcerer6thTCoE = "1270a6db-980b-4e3b-bf26-2924da61dfd5",
  Sorcerer7thTCoE = "9e38e5ae-51e8-4dd4-aad5-869a571b1519",
  Sorcerer8thTCoE = "5a8a002c-352b-44e9-8233-da7e6112f4b0",
  Sorcerer9thTCoE = "d58ac072-e079-410b-b167-a5e43723b59f",
  Wizard3rdTCoE = "22755771-ca11-49f4-b772-13d8b8fecd93",
  Wizard4thTCoE = "820b1220-0385-426d-ae15-458dc8a6f5c0",
  Wizard5thTCoE = "f781a25e-d288-43b4-bf5d-3d8d98846687",
  Wizard6thTCoE = "bc917f22-7f71-4a25-9a77-7d2f91a96a65",
  Wizard7thTCoE = "dff7917a-0abc-4671-b68f-c03e56212549",
  Wizard8thTCoE = "f27a2d0a-0d6c-4c01-98a5-60081abf4807",
  Wizard9thTCoE = "cb123d97-8809-4d71-a0cb-0ecb66177d15"
}

local tcoe4thLevelList5ES = {
  Bard4thTCoE = "75e04c40-be8f-40a5-9acc-0b5d59d5f3a6",
  Bard5thTCoE = "bd71fffb-e4d2-4233-9a31-13d43fba36e3",
  Bard6thTCoE = "586a8796-34f4-41f5-a3ef-95738561d55d",
  Bard7thTCoE = "f923e058-b1d9-4b02-98ef-9daaa82a71b6",
  Bard8thTCoE = "073c09e5-ccb9-4153-a210-001225a30cbb",
  Bard9thTCoE = "2bbd99d0-21b4-41cc-836e-e386a96fc8e6",
  BardMS5thTCoE = "858d4322-9e9f-4aa4-aada-9c68835dc6fe",
  BardMS7thTCoE = "95f80109-32b7-43f8-a99a-7ee2286a993a",
  BardMS9thTCoE = "cd83187f-c886-45c2-be81-34083981f240",
  Druid4thTCoE = "09c326c9-672c-4198-a4c0-6f07323bde27",
  Ranger4thTCoE = "7022d937-b2e4-4b6e-a3c5-e168f5c00194",
  Ranger5thTCoE = "412d77e1-4aa2-4149-aa0e-c835b8c79f32",
  Sorcerer4thTCoE = "5fe40622-1d3e-4cc1-8d89-e66fe51d8c5c",
  Sorcerer5thTCoE = "3276fcfe-e143-4559-b6e0-7d7aa0ffcb53",
  Sorcerer6thTCoE = "1270a6db-980b-4e3b-bf26-2924da61dfd5",
  Sorcerer7thTCoE = "9e38e5ae-51e8-4dd4-aad5-869a571b1519",
  Sorcerer8thTCoE = "5a8a002c-352b-44e9-8233-da7e6112f4b0",
  Sorcerer9thTCoE = "d58ac072-e079-410b-b167-a5e43723b59f",
  Wizard4thTCoE = "820b1220-0385-426d-ae15-458dc8a6f5c0",
  Wizard5thTCoE = "f781a25e-d288-43b4-bf5d-3d8d98846687",
  Wizard6thTCoE = "bc917f22-7f71-4a25-9a77-7d2f91a96a65",
  Wizard7thTCoE = "dff7917a-0abc-4671-b68f-c03e56212549",
  Wizard8thTCoE = "f27a2d0a-0d6c-4c01-98a5-60081abf4807",
  Wizard9thTCoE = "cb123d97-8809-4d71-a0cb-0ecb66177d15"
}

local tcoe5thLevelList5ES = {
  Bard5thTCoE = "bd71fffb-e4d2-4233-9a31-13d43fba36e3",
  Bard6thTCoE = "586a8796-34f4-41f5-a3ef-95738561d55d",
  Bard7thTCoE = "f923e058-b1d9-4b02-98ef-9daaa82a71b6",
  Bard8thTCoE = "073c09e5-ccb9-4153-a210-001225a30cbb",
  Bard9thTCoE = "2bbd99d0-21b4-41cc-836e-e386a96fc8e6",
  BardMS5thTCoE = "858d4322-9e9f-4aa4-aada-9c68835dc6fe",
  BardMS7thTCoE = "95f80109-32b7-43f8-a99a-7ee2286a993a",
  BardMS9thTCoE = "cd83187f-c886-45c2-be81-34083981f240",
  Druid5thTCoE = "ff711c12-b59f-4fde-b9ea-6e5c38ec8f23",
  Ranger5thTCoE = "412d77e1-4aa2-4149-aa0e-c835b8c79f32",
  Sorcerer5thTCoE = "3276fcfe-e143-4559-b6e0-7d7aa0ffcb53",
  Sorcerer6thTCoE = "1270a6db-980b-4e3b-bf26-2924da61dfd5",
  Sorcerer7thTCoE = "9e38e5ae-51e8-4dd4-aad5-869a571b1519",
  Sorcerer8thTCoE = "5a8a002c-352b-44e9-8233-da7e6112f4b0",
  Sorcerer9thTCoE = "d58ac072-e079-410b-b167-a5e43723b59f",
  WFiend5thTCoE = "deab57bf-4eec-4085-82f7-87335bce3f5d",
  WGoO5thTCoE = "6d2edca9-71a7-4f3f-89f0-fccfff0bdee5",
  WArchfey5thTCoE = "6d2edca9-71a7-4f3f-89f0-fccfff0bdee5",
  Wizard5thTCoE = "f781a25e-d288-43b4-bf5d-3d8d98846687",
  Wizard6thTCoE = "bc917f22-7f71-4a25-9a77-7d2f91a96a65",
  Wizard7thTCoE = "dff7917a-0abc-4671-b68f-c03e56212549",
  Wizard8thTCoE = "f27a2d0a-0d6c-4c01-98a5-60081abf4807",
  Wizard9thTCoE = "cb123d97-8809-4d71-a0cb-0ecb66177d15"
}

local tcoe6thLevelList5ES = {
  Bard6thTCoE = "586a8796-34f4-41f5-a3ef-95738561d55d",
  Bard7thTCoE = "f923e058-b1d9-4b02-98ef-9daaa82a71b6",
  Bard8thTCoE = "073c09e5-ccb9-4153-a210-001225a30cbb",
  Bard9thTCoE = "2bbd99d0-21b4-41cc-836e-e386a96fc8e6",
  BardMS7thTCoE = "95f80109-32b7-43f8-a99a-7ee2286a993a",
  BardMS9thTCoE = "cd83187f-c886-45c2-be81-34083981f240",
  Cleric6thTCoE = "f8ba7b05-1237-4eaa-97fa-1d3623d5862b",
  Druid6thTCoE = "6a4e2167-55f3-4ba8-900f-14666b293e93",
  Sorcerer6thTCoE = "1270a6db-980b-4e3b-bf26-2924da61dfd5",
  Sorcerer7thTCoE = "9e38e5ae-51e8-4dd4-aad5-869a571b1519",
  Sorcerer8thTCoE = "5a8a002c-352b-44e9-8233-da7e6112f4b0",
  Sorcerer9thTCoE = "d58ac072-e079-410b-b167-a5e43723b59f",
  Wizard6thTCoE = "bc917f22-7f71-4a25-9a77-7d2f91a96a65",
  Wizard7thTCoE = "dff7917a-0abc-4671-b68f-c03e56212549",
  Wizard8thTCoE = "f27a2d0a-0d6c-4c01-98a5-60081abf4807",
  Wizard9thTCoE = "cb123d97-8809-4d71-a0cb-0ecb66177d15"
}

local tcoe7thLevelList5ES = {
  Bard7thTCoE = "f923e058-b1d9-4b02-98ef-9daaa82a71b6",
  Bard8thTCoE = "073c09e5-ccb9-4153-a210-001225a30cbb",
  Bard9thTCoE = "2bbd99d0-21b4-41cc-836e-e386a96fc8e6",
  BardMS7thTCoE = "95f80109-32b7-43f8-a99a-7ee2286a993a",
  BardMS9thTCoE = "cd83187f-c886-45c2-be81-34083981f240",
  Sorcerer7thTCoE = "9e38e5ae-51e8-4dd4-aad5-869a571b1519",
  Sorcerer8thTCoE = "5a8a002c-352b-44e9-8233-da7e6112f4b0",
  Sorcerer9thTCoE = "d58ac072-e079-410b-b167-a5e43723b59f",
  Wizard7thTCoE = "dff7917a-0abc-4671-b68f-c03e56212549",
  Wizard8thTCoE = "f27a2d0a-0d6c-4c01-98a5-60081abf4807",
  Wizard9thTCoE = "cb123d97-8809-4d71-a0cb-0ecb66177d15"
}

local tcoe8thLevelList5ES = {
  Bard8thTCoE = "073c09e5-ccb9-4153-a210-001225a30cbb",
  Bard9thTCoE = "2bbd99d0-21b4-41cc-836e-e386a96fc8e6",
  BardMS9thTCoE = "cd83187f-c886-45c2-be81-34083981f240",
  Sorcerer8thTCoE = "5a8a002c-352b-44e9-8233-da7e6112f4b0",
  Sorcerer9thTCoE = "d58ac072-e079-410b-b167-a5e43723b59f",
  Wizard8thTCoE = "f27a2d0a-0d6c-4c01-98a5-60081abf4807",
  Wizard9thTCoE = "cb123d97-8809-4d71-a0cb-0ecb66177d15"
}

local tcoe9thLevelList5ES = {
  Bard9thTCoE = "2bbd99d0-21b4-41cc-836e-e386a96fc8e6",
  BardMS9thTCoE = "cd83187f-c886-45c2-be81-34083981f240",
  Sorcerer9thTCoE = "d58ac072-e079-410b-b167-a5e43723b59f",
  Wizard9thTCoE = "cb123d97-8809-4d71-a0cb-0ecb66177d15"
}

local others1stLevelList5ES = {
  RitualCaster = "8c32c900-a8ea-4f2f-9f6f-eccd0d361a9d",
  Bard1stOther = "dcb45167-86bd-4297-9b9d-c295be51af5b",
  Bard2ndOther = "7ea8f476-97a1-4256-8f10-afa76a845cce",
  Bard3rdOther = "c213ca01-3767-457b-a5c8-fd4c1dd656e2",
  Bard4thOther = "75e04c40-be8f-40a5-9acc-0b5d59d5f3a6",
  Bard5thOther = "bd71fffb-e4d2-4233-9a31-13d43fba36e3",
  Bard6thOther = "586a8796-34f4-41f5-a3ef-95738561d55d",
  Bard7thOther = "f923e058-b1d9-4b02-98ef-9daaa82a71b6",
  Bard8thOther = "073c09e5-ccb9-4153-a210-001225a30cbb",
  Bard9thOther = "2bbd99d0-21b4-41cc-836e-e386a96fc8e6",
  BardMS3rdOther = "175ceed7-5a53-4f48-823c-41c4f72d18ae",
  BardMS5thOther = "858d4322-9e9f-4aa4-aada-9c68835dc6fe",
  BardMS7thOther = "95f80109-32b7-43f8-a99a-7ee2286a993a",
  BardMS9thOther = "cd83187f-c886-45c2-be81-34083981f240",
  Cleric1stOther = "269d1a3b-eed8-4131-8901-a562238f5289",
  Druid1stOther = "2cd54137-2fe5-4100-aad3-df64735a8145",
  FighterEK1stOther = "32aeba85-13bd-4a6f-8e06-cd4447b746d8",
  FighterEK2ndOther = "4a86443c-6a21-4b8d-b1bf-55a99e021354",
  FighterEK3rdOther = "9ca503db-0e4b-4325-b1eb-e2f794a075d6",
  FighterEK4thOther = "5798e5a8-da36-40bc-acf5-2b736cf607a2",
  Paladin1stOther = "c6288ac5-c68b-40ed-bbdd-2ff388575831",
  Ranger1stOther = "458be063-60d4-4548-ae7d-50117fa0226f",
  Ranger2ndOther = "e7cfb80a-f5c2-4304-8446-9b00ea6a9814",
  Ranger3rdOther = "9a60f649-7f82-4152-90b1-0499c5c9f3e2",
  Ranger4thOther = "7022d937-b2e4-4b6e-a3c5-e168f5c00194",
  Ranger5thOther = "412d77e1-4aa2-4149-aa0e-c835b8c79f32",
  Sorcerer1stOther = "92c4751f-6255-4f67-822c-a75d53830b27",
  Sorcerer2ndOther = "f80396e2-cb76-4694-b0db-5c34da61a478",
  Sorcerer3rdOther = "dcbaf2ae-1f45-453e-ab83-cd154f8277a4",
  Sorcerer4thOther = "5fe40622-1d3e-4cc1-8d89-e66fe51d8c5c",
  Sorcerer5thOther = "3276fcfe-e143-4559-b6e0-7d7aa0ffcb53",
  Sorcerer6thOther = "1270a6db-980b-4e3b-bf26-2924da61dfd5",
  Sorcerer7thOther = "9e38e5ae-51e8-4dd4-aad5-869a571b1519",
  Sorcerer8thOther = "5a8a002c-352b-44e9-8233-da7e6112f4b0",
  Sorcerer9thOther = "d58ac072-e079-410b-b167-a5e43723b59f",
  WFiend1stOther = "4823a292-f584-4f7f-8434-6630c72e5411",
  WFiend2ndOther = "835aeca7-c64a-4aaa-a25c-143aa14a5cec",
  WFiend3rdOther = "5dec41aa-f16a-434e-b209-50c07e64e4ed",
  WFiend4thOther = "7ad7dbd0-751b-4bcd-8034-53bcc7bfb19d",
  WFiend5thOther = "deab57bf-4eec-4085-82f7-87335bce3f5d",
  WGoO1stOther = "65952d48-bb16-4ad7-b173-532182bf7770",
  WGoO2ndOther = "fe101a94-8619-49b2-859d-a68c2c291054",
  WGoO3rdOther = "30e9b761-6be0-418e-bb28-5103c00c663b",
  WGoO4thOther = "b64e527e-1f97-4125-84f7-78376ab1440b",
  WGoO5thOther = "6d2edca9-71a7-4f3f-89f0-fccfff0bdee5",
  WArchfey1stOther = "e0099b15-2599-4cba-a54b-b25ae03d6519",
  WArchfey2ndOther = "0cc2c8ab-9bbc-43a7-a66d-08e47da4c172",
  WArchfey3rdOther = "f18ad912-e2f4-47a9-8744-73d6a51c2941",
  WArchfey4thOther = "c3d8a4a5-9dae-4193-8322-a5d1c5b89f47",
  WArchfey5thOther = "0a9b924f-64fb-4f22-b975-5eeedc99b2fd",
  Wizard1stOther = "11f331b0-e8b7-473b-9d1f-19e8e4178d7d",
  Wizard2ndOther = "80c6b070-c3a6-4864-84ca-e78626784eb4",
  Wizard3rdOther = "22755771-ca11-49f4-b772-13d8b8fecd93",
  Wizard4thOther = "820b1220-0385-426d-ae15-458dc8a6f5c0",
  Wizard5thOther = "f781a25e-d288-43b4-bf5d-3d8d98846687",
  Wizard6thOther = "bc917f22-7f71-4a25-9a77-7d2f91a96a65",
  Wizard7thOther = "dff7917a-0abc-4671-b68f-c03e56212549",
  Wizard8thOther = "f27a2d0a-0d6c-4c01-98a5-60081abf4807",
  Wizard9thOther = "cb123d97-8809-4d71-a0cb-0ecb66177d15"
}

local others2ndLevelList5ES = {
  Bard2ndOther = "7ea8f476-97a1-4256-8f10-afa76a845cce",
  Bard3rdOther = "c213ca01-3767-457b-a5c8-fd4c1dd656e2",
  Bard4thOther = "75e04c40-be8f-40a5-9acc-0b5d59d5f3a6",
  Bard5thOther = "bd71fffb-e4d2-4233-9a31-13d43fba36e3",
  Bard6thOther = "586a8796-34f4-41f5-a3ef-95738561d55d",
  Bard7thOther = "f923e058-b1d9-4b02-98ef-9daaa82a71b6",
  Bard8thOther = "073c09e5-ccb9-4153-a210-001225a30cbb",
  Bard9thOther = "2bbd99d0-21b4-41cc-836e-e386a96fc8e6",
  BardMS3rdOther = "175ceed7-5a53-4f48-823c-41c4f72d18ae",
  BardMS5thOther = "858d4322-9e9f-4aa4-aada-9c68835dc6fe",
  BardMS7thOther = "95f80109-32b7-43f8-a99a-7ee2286a993a",
  BardMS9thOther = "cd83187f-c886-45c2-be81-34083981f240",
  Cleric2ndOther = "2968a3e6-6c8a-4c2e-882a-ad295a2ad8ac",
  Druid2ndOther = "92126d17-7f1a-41d2-ae6c-a8d254d2b135",
  FighterEK2ndOther = "4a86443c-6a21-4b8d-b1bf-55a99e021354",
  FighterEK3rdOther = "9ca503db-0e4b-4325-b1eb-e2f794a075d6",
  FighterEK4thOther = "5798e5a8-da36-40bc-acf5-2b736cf607a2",
  Ranger2ndOther = "e7cfb80a-f5c2-4304-8446-9b00ea6a9814",
  Ranger3rdOther = "9a60f649-7f82-4152-90b1-0499c5c9f3e2",
  Ranger4thOther = "7022d937-b2e4-4b6e-a3c5-e168f5c00194",
  Ranger5thOther = "412d77e1-4aa2-4149-aa0e-c835b8c79f32",
  RogueAT2ndOther = "f9fd64f1-f417-4544-94a9-51d8876d68df",
  RogueAT3rdOther = "c707cc1f-e5ed-4798-909a-3652ad497d24",
  RogueAT4thOther = "0329cc67-3e67-409c-9b22-fb510a564c98",
  Sorcerer2ndOther = "f80396e2-cb76-4694-b0db-5c34da61a478",
  Sorcerer3rdOther = "dcbaf2ae-1f45-453e-ab83-cd154f8277a4",
  Sorcerer4thOther = "5fe40622-1d3e-4cc1-8d89-e66fe51d8c5c",
  Sorcerer5thOther = "3276fcfe-e143-4559-b6e0-7d7aa0ffcb53",
  Sorcerer6thOther = "1270a6db-980b-4e3b-bf26-2924da61dfd5",
  Sorcerer7thOther = "9e38e5ae-51e8-4dd4-aad5-869a571b1519",
  Sorcerer8thOther = "5a8a002c-352b-44e9-8233-da7e6112f4b0",
  Sorcerer9thOther = "d58ac072-e079-410b-b167-a5e43723b59f",
  WFiend2ndOther = "835aeca7-c64a-4aaa-a25c-143aa14a5cec",
  WFiend3rdOther = "5dec41aa-f16a-434e-b209-50c07e64e4ed",
  WFiend4thOther = "7ad7dbd0-751b-4bcd-8034-53bcc7bfb19d",
  WFiend5thOther = "deab57bf-4eec-4085-82f7-87335bce3f5d",
  WGoO2ndOther = "fe101a94-8619-49b2-859d-a68c2c291054",
  WGoO2ndOther = "fe101a94-8619-49b2-859d-a68c2c291054",
  WGoO3rdOther = "30e9b761-6be0-418e-bb28-5103c00c663b",
  WGoO4thOther = "b64e527e-1f97-4125-84f7-78376ab1440b",
  WGoO5thOther = "6d2edca9-71a7-4f3f-89f0-fccfff0bdee5",
  WArchfey2ndOther = "0cc2c8ab-9bbc-43a7-a66d-08e47da4c172",
  WArchfey3rdOther = "f18ad912-e2f4-47a9-8744-73d6a51c2941",
  WArchfey4thOther = "c3d8a4a5-9dae-4193-8322-a5d1c5b89f47",
  WArchfey5thOther = "0a9b924f-64fb-4f22-b975-5eeedc99b2fd",
  Wizard2ndOther = "80c6b070-c3a6-4864-84ca-e78626784eb4",
  Wizard3rdOther = "22755771-ca11-49f4-b772-13d8b8fecd93",
  Wizard4thOther = "820b1220-0385-426d-ae15-458dc8a6f5c0",
  Wizard5thOther = "f781a25e-d288-43b4-bf5d-3d8d98846687",
  Wizard6thOther = "bc917f22-7f71-4a25-9a77-7d2f91a96a65",
  Wizard7thOther = "dff7917a-0abc-4671-b68f-c03e56212549",
  Wizard8thOther = "f27a2d0a-0d6c-4c01-98a5-60081abf4807",
  Wizard9thOther = "cb123d97-8809-4d71-a0cb-0ecb66177d15"
}

local others3rdLevelList5ES = {
  Bard3rdOther = "c213ca01-3767-457b-a5c8-fd4c1dd656e2",
  Bard4thOther = "75e04c40-be8f-40a5-9acc-0b5d59d5f3a6",
  Bard5thOther = "bd71fffb-e4d2-4233-9a31-13d43fba36e3",
  Bard6thOther = "586a8796-34f4-41f5-a3ef-95738561d55d",
  Bard7thOther = "f923e058-b1d9-4b02-98ef-9daaa82a71b6",
  Bard8thOther = "073c09e5-ccb9-4153-a210-001225a30cbb",
  Bard9thOther = "2bbd99d0-21b4-41cc-836e-e386a96fc8e6",
  BardMS3rdOther = "175ceed7-5a53-4f48-823c-41c4f72d18ae",
  BardMS5thOther = "858d4322-9e9f-4aa4-aada-9c68835dc6fe",
  BardMS7thOther = "95f80109-32b7-43f8-a99a-7ee2286a993a",
  BardMS9thOther = "cd83187f-c886-45c2-be81-34083981f240",
  Cleric3rdOther = "21be0992-499f-4c7a-a77a-4430085e947a",
  Druid3rdOther = "3156daf5-9266-41d0-b52c-5bc559a98654",
  FighterEK3rdOther = "9ca503db-0e4b-4325-b1eb-e2f794a075d6",
  FighterEK4thOther = "5798e5a8-da36-40bc-acf5-2b736cf607a2",
  Paladin3rdOther = "d18dec04-478f-41c3-b816-239d5cfcf2a2",
  Ranger3rdOther = "9a60f649-7f82-4152-90b1-0499c5c9f3e2",
  Ranger4thOther = "7022d937-b2e4-4b6e-a3c5-e168f5c00194",
  Ranger5thOther = "412d77e1-4aa2-4149-aa0e-c835b8c79f32",
  RogueAT3rdOther = "c707cc1f-e5ed-4798-909a-3652ad497d24",
  RogueAT4thOther = "0329cc67-3e67-409c-9b22-fb510a564c98",
  Sorcerer3rdOther = "dcbaf2ae-1f45-453e-ab83-cd154f8277a4",
  Sorcerer4thOther = "5fe40622-1d3e-4cc1-8d89-e66fe51d8c5c",
  Sorcerer5thOther = "3276fcfe-e143-4559-b6e0-7d7aa0ffcb53",
  Sorcerer6thOther = "1270a6db-980b-4e3b-bf26-2924da61dfd5",
  Sorcerer7thOther = "9e38e5ae-51e8-4dd4-aad5-869a571b1519",
  Sorcerer8thOther = "5a8a002c-352b-44e9-8233-da7e6112f4b0",
  Sorcerer9thOther = "d58ac072-e079-410b-b167-a5e43723b59f",
  WFiend3rdOther = "5dec41aa-f16a-434e-b209-50c07e64e4ed",
  WFiend4thOther = "7ad7dbd0-751b-4bcd-8034-53bcc7bfb19d",
  WFiend5thOther = "deab57bf-4eec-4085-82f7-87335bce3f5d",
  WGoO3rdOther = "30e9b761-6be0-418e-bb28-5103c00c663b",
  WGoO4thOther = "b64e527e-1f97-4125-84f7-78376ab1440b",
  WGoO5thOther = "6d2edca9-71a7-4f3f-89f0-fccfff0bdee5",
  WArchfey3rdOther = "f18ad912-e2f4-47a9-8744-73d6a51c2941",
  WArchfey4thOther = "c3d8a4a5-9dae-4193-8322-a5d1c5b89f47",
  WArchfey5thOther = "0a9b924f-64fb-4f22-b975-5eeedc99b2fd",
  Wizard3rdOther = "22755771-ca11-49f4-b772-13d8b8fecd93",
  Wizard4thOther = "820b1220-0385-426d-ae15-458dc8a6f5c0",
  Wizard5thOther = "f781a25e-d288-43b4-bf5d-3d8d98846687",
  Wizard6thOther = "bc917f22-7f71-4a25-9a77-7d2f91a96a65",
  Wizard7thOther = "dff7917a-0abc-4671-b68f-c03e56212549",
  Wizard8thOther = "f27a2d0a-0d6c-4c01-98a5-60081abf4807",
  Wizard9thOther = "cb123d97-8809-4d71-a0cb-0ecb66177d15"
}

local others4thLevelList5ES = {
  Bard4thOther = "75e04c40-be8f-40a5-9acc-0b5d59d5f3a6",
  Bard5thOther = "bd71fffb-e4d2-4233-9a31-13d43fba36e3",
  Bard6thOther = "586a8796-34f4-41f5-a3ef-95738561d55d",
  Bard7thOther = "f923e058-b1d9-4b02-98ef-9daaa82a71b6",
  Bard8thOther = "073c09e5-ccb9-4153-a210-001225a30cbb",
  Bard9thOther = "2bbd99d0-21b4-41cc-836e-e386a96fc8e6",
  BardMS5thOther = "858d4322-9e9f-4aa4-aada-9c68835dc6fe",
  BardMS7thOther = "95f80109-32b7-43f8-a99a-7ee2286a993a",
  BardMS9thOther = "cd83187f-c886-45c2-be81-34083981f240",
  Cleric4thOther = "37e9b20b-5fd1-45c5-b1c5-159c42397c83",
  Druid4thOther = "09c326c9-672c-4198-a4c0-6f07323bde27",
  FighterEK4thOther = "5798e5a8-da36-40bc-acf5-2b736cf607a2",
  Paladin4thOther = "11d0c2a0-41c6-4ec0-98fe-5d987f7e1665",
  Ranger4thOther = "7022d937-b2e4-4b6e-a3c5-e168f5c00194",
  Ranger5thOther = "412d77e1-4aa2-4149-aa0e-c835b8c79f32",
  RogueAT4thOther = "0329cc67-3e67-409c-9b22-fb510a564c98",
  Sorcerer4thOther = "5fe40622-1d3e-4cc1-8d89-e66fe51d8c5c",
  Sorcerer5thOther = "3276fcfe-e143-4559-b6e0-7d7aa0ffcb53",
  Sorcerer6thOther = "1270a6db-980b-4e3b-bf26-2924da61dfd5",
  Sorcerer7thOther = "9e38e5ae-51e8-4dd4-aad5-869a571b1519",
  Sorcerer8thOther = "5a8a002c-352b-44e9-8233-da7e6112f4b0",
  Sorcerer9thOther = "d58ac072-e079-410b-b167-a5e43723b59f",
  WFiend4thOther = "7ad7dbd0-751b-4bcd-8034-53bcc7bfb19d",
  WFiend5thOther = "deab57bf-4eec-4085-82f7-87335bce3f5d",
  WGoO4thOther = "b64e527e-1f97-4125-84f7-78376ab1440b",
  WGoO5thOther = "6d2edca9-71a7-4f3f-89f0-fccfff0bdee5",
  WArchfey4thOther = "c3d8a4a5-9dae-4193-8322-a5d1c5b89f47",
  WArchfey5thOther = "0a9b924f-64fb-4f22-b975-5eeedc99b2fd",
  Wizard4thOther = "820b1220-0385-426d-ae15-458dc8a6f5c0",
  Wizard5thOther = "f781a25e-d288-43b4-bf5d-3d8d98846687",
  Wizard6thOther = "bc917f22-7f71-4a25-9a77-7d2f91a96a65",
  Wizard7thOther = "dff7917a-0abc-4671-b68f-c03e56212549",
  Wizard8thOther = "f27a2d0a-0d6c-4c01-98a5-60081abf4807",
  Wizard9thOther = "cb123d97-8809-4d71-a0cb-0ecb66177d15"
}

local others5thLevelList5ES = {
  Bard5thOther = "bd71fffb-e4d2-4233-9a31-13d43fba36e3",
  Bard6thOther = "586a8796-34f4-41f5-a3ef-95738561d55d",
  Bard7thOther = "f923e058-b1d9-4b02-98ef-9daaa82a71b6",
  Bard8thOther = "073c09e5-ccb9-4153-a210-001225a30cbb",
  Bard9thOther = "2bbd99d0-21b4-41cc-836e-e386a96fc8e6",
  BardMS5thOther = "858d4322-9e9f-4aa4-aada-9c68835dc6fe",
  BardMS7thOther = "95f80109-32b7-43f8-a99a-7ee2286a993a",
  BardMS9thOther = "cd83187f-c886-45c2-be81-34083981f240",
  Cleric5thOther = "b73aeea5-1ff9-4cac-b61d-b5aa6dfe31c2",
  Druid5thOther = "ff711c12-b59f-4fde-b9ea-6e5c38ec8f23",
  Paladin5thOther = "f351595c-90f7-4804-9e55-18c4d624593c",
  Ranger5thOther = "412d77e1-4aa2-4149-aa0e-c835b8c79f32",
  Sorcerer5thOther = "3276fcfe-e143-4559-b6e0-7d7aa0ffcb53",
  Sorcerer6thOther = "1270a6db-980b-4e3b-bf26-2924da61dfd5",
  Sorcerer7thOther = "9e38e5ae-51e8-4dd4-aad5-869a571b1519",
  Sorcerer8thOther = "5a8a002c-352b-44e9-8233-da7e6112f4b0",
  Sorcerer9thOther = "d58ac072-e079-410b-b167-a5e43723b59f",
  WFiend5thOther = "deab57bf-4eec-4085-82f7-87335bce3f5d",
  WGoO5thOther = "6d2edca9-71a7-4f3f-89f0-fccfff0bdee5",
  WArchfey5thOther = "0a9b924f-64fb-4f22-b975-5eeedc99b2fd",
  Wizard5thOther = "f781a25e-d288-43b4-bf5d-3d8d98846687",
  Wizard6thOther = "bc917f22-7f71-4a25-9a77-7d2f91a96a65",
  Wizard7thOther = "dff7917a-0abc-4671-b68f-c03e56212549",
  Wizard8thOther = "f27a2d0a-0d6c-4c01-98a5-60081abf4807",
  Wizard9thOther = "cb123d97-8809-4d71-a0cb-0ecb66177d15"
}

local others6thLevelList5ES = {
  Bard6thOther = "586a8796-34f4-41f5-a3ef-95738561d55d",
  Bard7thOther = "f923e058-b1d9-4b02-98ef-9daaa82a71b6",
  Bard8thOther = "073c09e5-ccb9-4153-a210-001225a30cbb",
  Bard9thOther = "2bbd99d0-21b4-41cc-836e-e386a96fc8e6",
  BardMS7thOther = "95f80109-32b7-43f8-a99a-7ee2286a993a",
  BardMS9thOther = "cd83187f-c886-45c2-be81-34083981f240",
  Cleric6thOther = "f8ba7b05-1237-4eaa-97fa-1d3623d5862b",
  Sorcerer6thOther = "1270a6db-980b-4e3b-bf26-2924da61dfd5",
  Sorcerer7thOther = "9e38e5ae-51e8-4dd4-aad5-869a571b1519",
  Sorcerer8thOther = "5a8a002c-352b-44e9-8233-da7e6112f4b0",
  Sorcerer9thOther = "d58ac072-e079-410b-b167-a5e43723b59f",
  Warlock6thOther = "e6ccab5e-3b3b-4b34-8fa2-1058dff2b3e6",
  Wizard6thOther = "bc917f22-7f71-4a25-9a77-7d2f91a96a65",
  Wizard7thOther = "dff7917a-0abc-4671-b68f-c03e56212549",
  Wizard8thOther = "f27a2d0a-0d6c-4c01-98a5-60081abf4807",
  Wizard9thOther = "cb123d97-8809-4d71-a0cb-0ecb66177d15"
}

local others7thLevelList5ES = {
  Bard7thOther = "f923e058-b1d9-4b02-98ef-9daaa82a71b6",
  Bard8thOther = "073c09e5-ccb9-4153-a210-001225a30cbb",
  Bard9thOther = "2bbd99d0-21b4-41cc-836e-e386a96fc8e6",
  BardMS7thOther = "95f80109-32b7-43f8-a99a-7ee2286a993a",
  BardMS9thOther = "cd83187f-c886-45c2-be81-34083981f240",
  Cleric7thOther = "11862b36-c2d6-4d2f-b2d7-4af29f8fe31a",
  Druid7thOther = "29c9cf78-3bd6-47dc-88b4-2dce54710124",
  Sorcerer7thOther = "9e38e5ae-51e8-4dd4-aad5-869a571b1519",
  Sorcerer8thOther = "5a8a002c-352b-44e9-8233-da7e6112f4b0",
  Sorcerer9thOther = "d58ac072-e079-410b-b167-a5e43723b59f",
  Warlock7thOther = "388cd3b0-914a-44b6-a828-1315323b9fd7",
  Wizard7thOther = "dff7917a-0abc-4671-b68f-c03e56212549",
  Wizard8thOther = "f27a2d0a-0d6c-4c01-98a5-60081abf4807",
  Wizard9thOther = "cb123d97-8809-4d71-a0cb-0ecb66177d15"
}

local others8thLevelList5ES = {
  Bard8thOther = "073c09e5-ccb9-4153-a210-001225a30cbb",
  Bard9thOther = "2bbd99d0-21b4-41cc-836e-e386a96fc8e6",
  BardMS9thOther = "cd83187f-c886-45c2-be81-34083981f240",
  Cleric8thOther = "a0df1e32-1c61-4017-939f-44cc7695a924",
  Druid8thOther = "bdff0cba-d631-4b83-9562-63c0187df380",
  Sorcerer8thOther = "5a8a002c-352b-44e9-8233-da7e6112f4b0",
  Sorcerer9thOther = "d58ac072-e079-410b-b167-a5e43723b59f",
  Warlock8thOther = "070495e1-ccf4-4c05-9add-61c5010b8204",
  Wizard8thOther = "f27a2d0a-0d6c-4c01-98a5-60081abf4807",
  Wizard9thOther = "cb123d97-8809-4d71-a0cb-0ecb66177d15"
}

local others9thLevelList5ES = {
  Bard9thOther = "2bbd99d0-21b4-41cc-836e-e386a96fc8e6",
  BardMS9thOther = "cd83187f-c886-45c2-be81-34083981f240",
  Cleric9thOther = "9ea2891d-f0f9-42d0-b13d-7f1a5df154c3",
  Druid9thOther = "9e388f0f-7432-4f29-bfe5-5358ebde4491",
  Sorcerer9thOther = "d58ac072-e079-410b-b167-a5e43723b59f",
  Warlock9thOther = "47766c27-e791-4e6e-9b3d-2bb379106e62",
  Wizard9thOther = "cb123d97-8809-4d71-a0cb-0ecb66177d15"
}

local boomingbladeLarianSpellLists = {
  SorcererCantripBB = "485a68b4-c678-4888-be63-4a702efbe391",
  WarlockCantripBB = "f5c4af9c-5d8d-4526-9057-94a4b243cd40",
  WizardCantripBB = "3cae2e56-9871-4cef-bba6-96845ea765fa"
}

local boomingblade5eSpellLists = {
  SpellSniperBB5E = "64784e08-e31e-4850-a743-ecfb3fd434d7",
  SorcererCantripBB5E = "485a68b4-c678-4888-be63-4a702efbe391",
  WarlockCantripBB5E = "f5c4af9c-5d8d-4526-9057-94a4b243cd40",
  WizardCantripBB5E = "3cae2e56-9871-4cef-bba6-96845ea765fa",
  BardMS3rdOtherBB5E = "175ceed7-5a53-4f48-823c-41c4f72d18ae",
  BardMS5thOtherBB5E = "858d4322-9e9f-4aa4-aada-9c68835dc6fe",
  BardMS7thOtherBB5E = "95f80109-32b7-43f8-a99a-7ee2286a993a",
  BardMS9thOtherBB5E = "cd83187f-c886-45c2-be81-34083981f240"
}

-- ============================================
-- OnStatsLoaded
-- ============================================

local function OnStatsLoaded()

	if Ext.Mod.IsModLoaded("755a8a72-407f-4f0d-9a33-274ac0f0b53d") then
		function MCMGet(settingID)
			return Mods.BG3MCM.MCMAPI:GetSettingValue(settingID, ModuleUUID)
		end

		Vars = {
		Cantrips = MCMGet("Cantrips"),
		TCoE1st = MCMGet("TCoE1st"),
		TCoE2nd = MCMGet("TCoE2nd"),
		TCoE3rd = MCMGet("TCoE3rd"),
		TCoE4th = MCMGet("TCoE4th"),
		TCoE5th = MCMGet("TCoE5th"),
		TCoE6th = MCMGet("TCoE6th"),
		TCoE7th = MCMGet("TCoE7th"),
		TCoE8th = MCMGet("TCoE8th"),
		TCoE9th = MCMGet("TCoE9th"),
		S5e1st = MCMGet("5e1st"),
		S5e2nd = MCMGet("5e2nd"),
		S5e3rd = MCMGet("5e3rd"),
		S5e4th = MCMGet("5e4th"),
		S5e5th = MCMGet("5e5th"),
		S5e6th = MCMGet("5e6th"),
		S5e7th = MCMGet("5e7th"),
		S5e8th = MCMGet("5e8th"),
		S5e9th = MCMGet("5e9th"),
		SparetheDying = MCMGet("SparetheDying"),
		RaiseDead = MCMGet("RaiseDead"),
		BoomingBladeChange = MCMGet("BoomingBladeChange"),
		RitualSpells = MCMGet("RitualSpells")
		}

		ExemptionsSet = BuildExemptions()
		if next(ExemptionsSet) then
		local count = 0
		Ext.Utils.Print("5eSpells: Loaded the following spell removal exemptions from MCM:")
		for spellId in pairs(ExemptionsSet) do
			count = count + 1
			Ext.Utils.Print(string.format("   • %s", spellId))
		end
		else
		Ext.Utils.Print("5eSpells: No spell exemptions defined in MCM.")
		end

		-- Cantrips
		if Vars["Cantrips"] == true then
			print("5eSpells: Removing Cantrips from 5e Spells.")
			RemoveByIndex(BuildCantripIndex(cantripList5ES))
		else
			print("5eSpells: Keeping Cantrips from 5eSpells.")
		end

		-- Other 1..9
		local otherMaps = {
		others1stLevelList5ES, others2ndLevelList5ES, others3rdLevelList5ES,
		others4thLevelList5ES, others5thLevelList5ES, others6thLevelList5ES,
		others7thLevelList5ES, others8thLevelList5ES, others9thLevelList5ES
		}
		for lvl = 1, 9 do
		local key = "S5e" .. lvl .. (lvl==1 and "st" or lvl==2 and "nd" or lvl==3 and "rd" or "th")
		if Vars[key] == true then
		  print(("5eSpells: Removing 5e Spells %s spells."):format(Ord(lvl)))
		  RemoveByIndex(BuildOtherIndex(otherMaps[lvl], lvl))
		else
		  print(("5eSpells: Keeping 5e Spells %s spells."):format(Ord(lvl)))
		end
		end

		-- TCoE 1..9
		local tcoeMaps = {
		tcoe1stLevelList5ES, tcoe2ndLevelList5ES, tcoe3rdLevelList5ES,
		tcoe4thLevelList5ES, tcoe5thLevelList5ES, tcoe6thLevelList5ES,
		tcoe7thLevelList5ES, tcoe8thLevelList5ES, tcoe9thLevelList5ES
		}
		for lvl = 1, 9 do
		local key = "TCoE" .. Ord(lvl)
		if Vars[key] == true then
		  print(("5eSpells: Removing TCoE %s spells."):format(Ord(lvl)))
		  RemoveByIndex(BuildTCoEIndex(tcoeMaps[lvl], lvl))
		else
		  print(("5eSpells: Keeping TCoE %s spells."):format(Ord(lvl)))
		end
		end

		-- Spare the Dying / Revivify
		if Vars["SparetheDying"] == true then
		S5E_SpareTheDying()
		print(string.format("5eSpells: Modifying the Help action."))
		end

		if Vars["RaiseDead"] == true then
		S5E_RaiseDead()
		print(string.format("5eSpells: Modifying the Revivify spell and the scroll."))
		end

		if Vars["RitualSpells"] == true then
		S5E_RitualSpells()
		_G.RitualSpellsEnabled = Vars.RitualSpells
		print(string.format("5eSpells: Modifying base game and this mod's ritual spells."))
		end

		-- Booming Blade -> explicit lists only, no globals
		if Vars["BoomingBladeChange"] == true then
		local BB5E = { "Target_BoomingBlade_5e" }
		RemoveSpellsFromUUID({ ["Target_BoomingBlade_ClassSpell"] = true }, boomingbladeLarianSpellLists.SorcererCantripBB)
		RemoveSpellsFromUUID({ ["Target_BoomingBlade_ClassSpell"] = true }, boomingbladeLarianSpellLists.WarlockCantripBB)
		RemoveSpellsFromUUID({ ["Target_BoomingBlade_ClassSpell"] = true }, boomingbladeLarianSpellLists.WizardCantripBB)
		RemoveSpellsFromUUID({ ["Target_BoomingBlade_ClassSpell"] = true }, boomingblade5eSpellLists.BardMS3rdOtherBB5E)
		RemoveSpellsFromUUID({ ["Target_BoomingBlade_ClassSpell"] = true }, boomingblade5eSpellLists.BardMS5thOtherBB5E)
		RemoveSpellsFromUUID({ ["Target_BoomingBlade_ClassSpell"] = true }, boomingblade5eSpellLists.BardMS7thOtherBB5E)
		RemoveSpellsFromUUID({ ["Target_BoomingBlade_ClassSpell"] = true }, boomingblade5eSpellLists.BardMS9thOtherBB5E)
		AddSpellsToUUID(BB5E, boomingblade5eSpellLists.SpellSniperBB5E)
		AddSpellsToUUID(BB5E, boomingblade5eSpellLists.SorcererCantripBB5E)
		AddSpellsToUUID(BB5E, boomingblade5eSpellLists.WarlockCantripBB5E)
		AddSpellsToUUID(BB5E, boomingblade5eSpellLists.WizardCantripBB5E)
		AddSpellsToUUID(BB5E, boomingblade5eSpellLists.BardMS3rdOtherBB5E)
		AddSpellsToUUID(BB5E, boomingblade5eSpellLists.BardMS5thOtherBB5E)
		AddSpellsToUUID(BB5E, boomingblade5eSpellLists.BardMS7thOtherBB5E)
		AddSpellsToUUID(BB5E, boomingblade5eSpellLists.BardMS9thOtherBB5E)
		print(string.format("5eSpells: Replaced Larian's Booming Blade with 5e Spell's version."))
		end
	end
end

Ext.Events.StatsLoaded:Subscribe(OnStatsLoaded)

local function S5E_StatsLoaded()
	S5E_Changes()
end

Ext.Events.StatsLoaded:Subscribe(S5E_StatsLoaded)