local function SE5_AddChaosBoltPassives(char)
	char.Passives = "ChaosBolt;ChaosBolt_2;ChaosBolt_3;ChaosBolt_4;ChaosBolt_5;ChaosBolt_6;ChaosBolt_7;ChaosBolt_8;ChaosBolt_9;ChaosBolt_Explosion" .. ";" .. char.Passives
end

function S5E_ChaosBoltPassives()

   for _, name in pairs(Ext.Stats.GetStats("Character")) do
        local char = Ext.Stats.Get(name)		
		if char ~= nil and string.find(char.Passives, "WeaponThrow") and string.find(char.Passives, "CombatStartAttack") then
			SE5_AddChaosBoltPassives(char)
		end
	end
end

function S5E_RogueSCAGtripSneakAttack()

	local passive = Ext.Stats.Get("SneakAttack_Unlock")		
	passive.Boosts = passive.Boosts .. ";UnlockSpell(Target_BoomingBlade_SneakAttack);UnlockSpell(Target_GreenFlameBlade_SneakAttack)"
end

--[[function S5E_Levitate()

   for _, name in pairs(Ext.Stats.GetStats("SpellData")) do
        local spell = Ext.Stats.Get(name)
		if spell.SpellType == "Target" and (spell.TargetRadius == "MeleeMainWeaponRange" or spell.TargetRadius == "1.5") then
			spell.TargetConditions = spell.TargetConditions .. " and not HasStatus('LEVITATE_PSION')"
		end
	end
end--]]

local rawHealingWordMass = {
  "Shout_HealingWord_Mass",
  "Shout_HealingWord_Mass_4",
  "Shout_HealingWord_Mass_5",
  "Shout_HealingWord_Mass_6",
  "Shout_HealingWord_Mass_7",
  "Shout_HealingWord_Mass_8",
  "Shout_HealingWord_Mass_9"
}

local rawAid = {
  "Shout_Aid",
  "Shout_Aid_3",
  "Shout_Aid_4",
  "Shout_Aid_5",
  "Shout_Aid_6",
  "Shout_Aid_7",
  "Shout_Aid_8",
  "Shout_Aid_9"
}

local rawPrayerOfHealing = {
  "Shout_PrayerOfHealing",
  "Shout_PrayerOfHealing_3",
  "Shout_PrayerOfHealing_4",
  "Shout_PrayerOfHealing_5",
  "Shout_PrayerOfHealing_6",
  "Shout_PrayerOfHealing_7",
  "Shout_PrayerOfHealing_8",
  "Shout_PrayerOfHealing_9"
}

function S5E_Changes()
	local sneakAttack = Ext.Stats.Get("Interrupt_SneakAttack")
	local sneakAttackCritical = Ext.Stats.Get("Interrupt_SneakAttack_Critical")
	sneakAttack.Conditions = sneakAttack.Conditions .. " and not SpellId('Target_BoomingBlade_SneakAttack') and not SpellId('Target_GreenFlameBlade_SneakAttack')"
	sneakAttackCritical.Conditions = sneakAttackCritical.Conditions .. " and not SpellId('Target_BoomingBlade_SneakAttack') and not SpellId('Target_GreenFlameBlade_SneakAttack')"

	local aoo = Ext.Stats.Get("Interrupt_AttackOfOpportunity")
	local pam = Ext.Stats.Get("Interrupt_PolearmMaster")
	local warc = Ext.Stats.Get("Interrupt_WarCaster")
	aoo.Conditions = aoo.Conditions .. " and (not S5E_IsInvisibleSeen() or S5E_CanSeeInvisible())"
	pam.Conditions = pam.Conditions .. " and (not S5E_IsInvisibleSeen() or S5E_CanSeeInvisible())"
	warc.Conditions = warc.Conditions .. " and (not S5E_IsInvisibleSeen() or S5E_CanSeeInvisible())"

	local guidance = Ext.Stats.Get("Target_Guidance")
	local huntersMark = Ext.Stats.Get("Target_HuntersMark")
	local huntersMarkReapply = Ext.Stats.Get("Target_HuntersMark_Reapply")
	local trueStrike = Ext.Stats.Get("Target_TrueStrike")
	guidance.TargetConditions = guidance.TargetConditions .. " and not IsImmuneToStatus('GUIDANCE')"
	huntersMark.TargetConditions = huntersMark.TargetConditions .. " and not IsImmuneToStatus('HUNTERS_MARK')"
	huntersMarkReapply.TargetConditions = huntersMarkReapply.TargetConditions .. " and not IsImmuneToStatus('HUNTERS_MARK')"
	trueStrike.TargetConditions = trueStrike.TargetConditions .. " and not IsImmuneToStatus('TRUE_STRIKE')"

	local potentSpellcasting = Ext.Stats.Get("PotentSpellcasting")
	potentSpellcasting.Boosts = potentSpellcasting.Boosts .. ";IF(SpellId('Target_TollTheDead')):DamageBonus(max(0, WisdomModifier))"

	for _, name in pairs(Ext.Stats.GetStats("StatusData")) do
		local invisstatus = Ext.Stats.Get(name)
		if invisstatus.StatusType == "INVISIBLE" and string.find(invisstatus.Boosts, "Advantage") and invisstatus.Boosts ~= "IF((not HasStatus('MIND_SPIKE_OWNER', context.Target) and not HasStatus('MIND_SPIKE',context.Source,context.Target))):Advantage(AttackRoll);" then
			invisstatus.Boosts = string.gsub(invisstatus.Boosts, "Advantage", "IF((not HasStatus('MIND_SPIKE_OWNER', context.Target) and not HasStatus('MIND_SPIKE',context.Source,context.Target))):Advantage")
		end
	end

	if Ext.Mod.IsModLoaded("f19c68ed-70be-4c3d-b610-e94afc5c5103") then
	   for _, name in pairs(rawHealingWordMass) do
			local spell = Ext.Stats.Get(name)
			local flags = spell.SpellFlags
			table.insert(flags, "IgnorePreviouslyPickedEntities")
			spell.SpellFlags = flags
			spell.SpellType = "Target"
			spell.TargetRadius = "18"
			spell.AreaRadius = 0
			spell.AmountOfTargets = "6"
		end

	   for _, name in pairs(rawAid) do
			local spell = Ext.Stats.Get(name)
			local flags = spell.SpellFlags
			table.insert(flags, "IgnorePreviouslyPickedEntities")
			spell.SpellFlags = flags
			spell.SpellType = "Target"
			spell.TargetRadius = "9"
			spell.AreaRadius = 0
			spell.AmountOfTargets = "3"
		end

	   for _, name in pairs(rawPrayerOfHealing) do
			local spell = Ext.Stats.Get(name)
			local flags = spell.SpellFlags
			table.insert(flags, "IgnorePreviouslyPickedEntities")
			spell.SpellFlags = flags
			spell.SpellType = "Target"
			spell.TargetRadius = "9"
			spell.AreaRadius = 0
			spell.AmountOfTargets = "6"
		end

		local spell = Ext.Stats.Get("Shout_AuraOfVitality")
		local flags = spell.SpellFlags
		table.insert(flags, "IsConcentration")
		spell.SpellFlags = flags

		local spell = Ext.Stats.Get("Target_MageHand")
		spell.RequirementConditions = ""

		local spell = Ext.Stats.Get("Zone_Sunbeam_Recreate")
		local flags = spell.SpellFlags
		flags = {
			"IsHarmful",
			"Wildshape",
			"Temporary"
		}
		spell.SpellFlags = flags
	end
end

Spells = {  
	SpellList = "Spells",
}

local spellSniper = {
  "Target_BoomingBlade",
  "Target_GreenFlameBlade",
  "Target_PrimalSavagery"
}
local ritualCaster = {
  "Target_Ceremony_Ritual",
  "Shout_DetectMagic_Ritual",
  "Target_UnseenServant_Ritual"
}
local bardCantrips = {
  "Target_Prestidigitation",
  "Shout_Thunderclap"
}
local bardSpells1st = {
	"Zone_ColorSpray",
	"Target_Command_Container",
	"Shout_DetectMagic",
	"Shout_EarthTremor",
	"Target_UnseenServant"
}
local bardSpells2nd = {
	"Shout_Aid",
	"Shout_BorrowedKnowledge",
	"Target_EnlargeReduce",
	"Shout_KineticJaunt",
	"Target_Knock",
	"Shout_MirrorImage",
	"Target_NathairsMischief",
	"Shout_WardingWind",
	"Zone_ColorSpray",
	"Target_Command_Container",
	"Shout_DetectMagic",
	"Shout_EarthTremor",
	"Target_UnseenServant"
}
local bardSpells3rd = {
	"Target_Antagonize",
	"Target_Catnap",
	"Target_EnemiesAbound",
	"Target_IntellectFortress",
	"Shout_HealingWord_Mass",
	"Target_MotivationalSpeech",
	"Target_Nondetection",
	"Target_Slow",
	"Shout_Aid",
	"Shout_BorrowedKnowledge",
	"Target_EnlargeReduce",
	"Shout_KineticJaunt",
	"Target_Knock",
	"Shout_MirrorImage",
	"Target_NathairsMischief",
	"Shout_WardingWind",
	"Zone_ColorSpray",
	"Target_Command_Container",
	"Shout_DetectMagic",
	"Shout_EarthTremor",
	"Target_UnseenServant"
}
local bardSpells4th = {
	"Target_CharmMonster",
	"Target_PhantasmalKiller",
	"Projectile_RaulothimsPsychicLance",
	"Target_Antagonize",
	"Target_Catnap",
	"Target_EnemiesAbound",
	"Target_IntellectFortress",
	"Shout_HealingWord_Mass",
	"Target_MotivationalSpeech",
	"Target_Nondetection",
	"Target_Slow",
	"Shout_Aid",
	"Shout_BorrowedKnowledge",
	"Target_EnlargeReduce",
	"Shout_KineticJaunt",
	"Target_Knock",
	"Shout_MirrorImage",
	"Target_NathairsMischief",
	"Shout_WardingWind",
	"Zone_ColorSpray",
	"Target_Command_Container",
	"Shout_DetectMagic",
	"Shout_EarthTremor",
	"Target_UnseenServant"
}
local bardSpells5th = {
	"Target_SkillEmpowerment",
	"Target_SynapticStatic",
	"Target_CharmMonster",
	"Target_PhantasmalKiller",
	"Projectile_RaulothimsPsychicLance",
	"Target_Antagonize",
	"Target_Catnap",
	"Target_EnemiesAbound",
	"Target_IntellectFortress",
	"Shout_HealingWord_Mass",
	"Target_MotivationalSpeech",
	"Target_Nondetection",
	"Target_Slow",
	"Shout_Aid",
	"Shout_BorrowedKnowledge",
	"Target_EnlargeReduce",
	"Shout_KineticJaunt",
	"Target_Knock",
	"Shout_MirrorImage",
	"Target_NathairsMischief",
	"Shout_WardingWind",
	"Zone_ColorSpray",
	"Target_Command_Container",
	"Shout_DetectMagic",
	"Shout_EarthTremor",
	"Target_UnseenServant"
}
local bardSpells6th = {
	"Shout_HeroesFeast",
	"Target_TrueSeeing",
	"Target_SkillEmpowerment",
	"Target_SynapticStatic",
	"Target_CharmMonster",
	"Target_PhantasmalKiller",
	"Projectile_RaulothimsPsychicLance",
	"Target_Antagonize",
	"Target_Catnap",
	"Target_EnemiesAbound",
	"Target_IntellectFortress",
	"Shout_HealingWord_Mass",
	"Target_MotivationalSpeech",
	"Target_Nondetection",
	"Target_Slow",
	"Shout_Aid",
	"Shout_BorrowedKnowledge",
	"Target_EnlargeReduce",
	"Shout_KineticJaunt",
	"Target_Knock",
	"Shout_MirrorImage",
	"Target_NathairsMischief",
	"Shout_WardingWind",
	"Zone_ColorSpray",
	"Target_Command_Container",
	"Shout_DetectMagic",
	"Shout_EarthTremor",
	"Target_UnseenServant"
}
local bardMagicalSecrets3rd = {
	"Target_Antagonize",
	"Shout_BeaconOfHope",
	"Target_Smite_Blinding",
	"Shout_Blink",
	"Zone_ConjureBarrage",
	"Target_CreateFoodAndWater",
	"Shout_CrusadersMantle",
	"Target_ElementalWeapon",
	"Target_EruptingEarth",
	"Target_FlameArrows",
	"Target_HungerOfHadar",
	"Projectile_LightningArrow",
	"Projectile_MinuteMeteors",
	"Target_ProtectionFromEnergy",
	"Teleportation_Revivify",
	"Target_SleetStorm",
	"Shout_SpiritShroud",
	"Target_SummonShadowspawn",
	"Teleportation_ThunderStep",
	"Target_VampiricTouch",
	"Shout_WaterWalk",
	"Zone_AganazzarsScorcher",
	"Shout_AlterSelf",
	"Target_Barkskin",
	"Target_Smite_Branding_Container",
	"Target_ContinualFlame",
	"Target_DragonsBreath",
	"Target_DustDevil",
	"Shout_FlameBlade",
	"Target_FlamingSphere",
	"Target_FlockOfFamiliars",
	"Zone_GustOfWind",
	"Target_HealingSpirit",
	"Target_MagicWeapon",
	"Target_MaximiliansEarthenGrasp",
	"Target_TashasMindWhip",
	"Target_MindSpike",
	"Target_Moonbeam",
	"Shout_PrayerOfHealing",
	"Target_ProtectionFromPoison",
	"Projectile_RayOfEnfeeblement",
	"Zone_RimesBindingIce",
	"Shout_ShadowBlade",
	"Target_SnillocsSnowballStorm",
	"Target_VortexWarp",
	"Target_WardingBond",
	"Target_WitherAndBloom",
	"Shout_AbsorbElements",
	"Shout_ArmsOfHadar",
	"Zone_BurningHands",
	"Throw_Catapult",
	"Target_CauseFear",
	"Target_Ceremony",
	"Target_ChaosBolt",
	"Target_CreateDestroyWater",
	"Shout_DetectEvilAndGood",
	"Projectile_EnsnaringStrike_Container",
	"Target_Entangle",
	"Shout_ExpeditiousRetreat",
	"Target_FindFamiliar",
	"Target_FogCloud",
	"Zone_FrostFingers",
	"Target_Goodberry",
	"Target_Grease",
	"Projectile_HailOfThorns",
	"Target_HuntersMark",
	"Target_InflictWounds",
	"Target_Jump",
	"Target_MageArmor",
	"Target_ProtectionFromEvilAndGood",
	"Projectile_RayOfSickness",
	"Target_Sanctuary",
	"Target_Smite_Searing",
	"Shout_Shield_Sorcerer",
	"Target_ShieldOfFaith",
	"Target_Sanctuary",
	"Target_Smite_Thunderous",
	"Target_Snare",
	"Shout_SpeakWithAnimals",
	"Zone_TashasCausticBrew",
	"Projectile_WitchBolt",
	"Target_Smite_Wrathful",
	"Shout_ZephyrStrike",
	"Projectile_AcidSplash",
	"Target_BoomingBlade",
	"Target_ChillTouch",
	"Target_ControlFlames",
	"Target_CreateBonfire",
	"Shout_Druidcraft",
	"Target_Frostbite",
	"Target_GreenFlameBlade",
	"Target_Guidance",
	"Target_Gust",
	"Target_LightningLure",
	"Target_MagicStone",
	"Target_MindSliver",
	"Target_MoldEarth",
	"Projectile_PoisonSpray",
	"Target_Prestidigitation",
	"Shout_ProduceFlame",
	"Target_Resistance",
	"Target_ShapeWater",
	"Shout_Shillelagh",
	"Target_ShockingGrasp",
	"Target_SpareTheDying",
	"Shout_SwordBurst",
	"Shout_Thaumaturgy",
	"Target_ThornWhip",
	"Shout_Thunderclap",
	"Target_TollTheDead",
	"Shout_WordOfRadiance"
}
local bardMagicalSecrets5th = {
	"Projectile_Smite_Banishing_Container",
	"Target_Cloudkill",
	"ProjectileStrike_ConjureVolley",
	"Shout_DestructiveWave",
	"Target_FarStep",
	"Target_FlameStrike",
	"Target_HolyWeapon",
	"Target_InsectPlague",
	"Projectile_NegativeEnergyFlood",
	"Target_SteelWindStrike",
	"Shout_SwiftQuiver",
	"Throw_Telekinesis",
	"Target_ConjureWoodlandBeings",
	"Target_BlackTentacles",
	"Target_GraspingVine",
	"Shout_GuardianOfNature",
	"Target_ResilientSphere",
	"Shout_ShadowOfMoil",
	"Target_Stoneskin",
	"Target_SummonElemental",
	"Target_Antagonize",
	"Shout_BeaconOfHope",
	"Target_Smite_Blinding",
	"Shout_Blink",
	"Zone_ConjureBarrage",
	"Target_CreateFoodAndWater",
	"Shout_CrusadersMantle",
	"Target_ElementalWeapon",
	"Target_EruptingEarth",
	"Target_FlameArrows",
	"Target_HungerOfHadar",
	"Projectile_LightningArrow",
	"Projectile_MinuteMeteors",
	"Target_ProtectionFromEnergy",
	"Teleportation_Revivify",
	"Target_SleetStorm",
	"Shout_SpiritShroud",
	"Target_SummonShadowspawn",
	"Teleportation_ThunderStep",
	"Target_VampiricTouch",
	"Shout_WaterWalk",
	"Zone_AganazzarsScorcher",
	"Shout_AlterSelf",
	"Target_Barkskin",
	"Target_Smite_Branding_Container",
	"Target_ContinualFlame",
	"Target_DragonsBreath",
	"Target_DustDevil",
	"Shout_FlameBlade",
	"Target_FlamingSphere",
	"Target_FlockOfFamiliars",
	"Zone_GustOfWind",
	"Target_HealingSpirit",
	"Target_MagicWeapon",
	"Target_MaximiliansEarthenGrasp",
	"Target_TashasMindWhip",
	"Target_MindSpike",
	"Target_Moonbeam",
	"Shout_PrayerOfHealing",
	"Target_ProtectionFromPoison",
	"Projectile_RayOfEnfeeblement",
	"Zone_RimesBindingIce",
	"Shout_ShadowBlade",
	"Target_SnillocsSnowballStorm",
	"Target_VortexWarp",
	"Target_WardingBond",
	"Target_WitherAndBloom",
	"Shout_AbsorbElements",
	"Shout_ArmsOfHadar",
	"Zone_BurningHands",
	"Throw_Catapult",
	"Target_CauseFear",
	"Target_Ceremony",
	"Target_ChaosBolt",
	"Target_CreateDestroyWater",
	"Shout_DetectEvilAndGood",
	"Projectile_EnsnaringStrike_Container",
	"Target_Entangle",
	"Shout_ExpeditiousRetreat",
	"Target_FindFamiliar",
	"Target_FogCloud",
	"Zone_FrostFingers",
	"Target_Goodberry",
	"Target_Grease",
	"Projectile_HailOfThorns",
	"Target_HuntersMark",
	"Target_InflictWounds",
	"Target_Jump",
	"Target_MageArmor",
	"Target_ProtectionFromEvilAndGood",
	"Projectile_RayOfSickness",
	"Target_Sanctuary",
	"Target_Smite_Searing",
	"Shout_Shield_Sorcerer",
	"Target_ShieldOfFaith",
	"Target_Sanctuary",
	"Shout_Shield_Sorcerer",
	"Target_Smite_Thunderous",
	"Target_Snare",
	"Shout_SpeakWithAnimals",
	"Zone_TashasCausticBrew",
	"Projectile_WitchBolt",
	"Target_Smite_Wrathful",
	"Shout_ZephyrStrike",
	"Projectile_AcidSplash",
	"Target_BoomingBlade",
	"Target_ChillTouch",
	"Target_ControlFlames",
	"Target_CreateBonfire",
	"Shout_Druidcraft",
	"Target_Frostbite",
	"Target_GreenFlameBlade",
	"Target_Guidance",
	"Target_Gust",
	"Target_LightningLure",
	"Target_MagicStone",
	"Target_MindSliver",
	"Target_MoldEarth",
	"Projectile_PoisonSpray",
	"Target_Prestidigitation",
	"Shout_ProduceFlame",
	"Target_Resistance",
	"Target_ShapeWater",
	"Shout_Shillelagh",
	"Target_ShockingGrasp",
	"Target_SpareTheDying",
	"Shout_SwordBurst",
	"Shout_Thaumaturgy",
	"Target_ThornWhip",
	"Shout_Thunderclap",
	"Target_TollTheDead",
	"Shout_WordOfRadiance"
}
local clericCantrips = {
	"Target_SpareTheDying",
	"Target_TollTheDead",
	"Shout_WordOfRadiance"
}
local clericSpells1st = {
	"Target_Ceremony",
	"Shout_DetectEvilAndGood",
	"Shout_DetectMagic"
}
local clericSpells2nd = {
	"Shout_BorrowedKnowledge",
	"Target_ContinualFlame"
}
local clericSpells3rd = {
	"Shout_AuraOfVitality",
	"Target_CreateFoodAndWater",
	"Target_LifeTransference",
	"Target_MotivationalSpeech",
	"Shout_SpiritShroud",
	"Shout_WaterWalk"
}
local clericSpells5th = {
	"Target_HolyWeapon"
}
local clericSpells6th = {
	"Target_TrueSeeing"
}
local druidCantrips = {
	"Target_ControlFlames",
	"Target_CreateBonfire",
	"Shout_Druidcraft",
	"Target_Frostbite",
	"Target_Gust",
	"Target_MagicStone",
	"Target_MoldEarth",
	"Target_PrimalSavagery",
	"Target_ShapeWater",
	"Shout_Thunderclap"
}
local druidSpells1st = {
	"Shout_AbsorbElements",
	"Target_BeastBond",
	"Shout_DetectMagic",
	"Shout_EarthTremor",
	"Target_Snare"
}
local druidSpells2nd = {
	"Target_ContinualFlame",
	"Target_DustDevil",
	"Target_EnlargeReduce",
	"Target_HealingSpirit",
	"Target_SummonBeast",
	"Target_WitherAndBloom",
	"Shout_WardingWind"
}
local druidSpells3rd = {
	"Shout_AuraOfVitality",
	"Target_ElementalWeapon",
	"Target_EruptingEarth",
	"Target_FlameArrows",
	"Teleportation_Revivify",
	"Shout_WaterWalk"
}
local druidSpells4th = {
	"Target_CharmMonster",
	"Shout_GuardianOfNature",
	"Target_SummonElemental"
}
local druidSpells5th = {
	"Shout_CommuneWithNature",
	"Zone_ConeOfCold"
}
local fighterEKSpells1st = {
	"Shout_AbsorbElements",
	"Shout_EarthTremor",
	"Zone_FrostFingers",
	"Target_Snare",
	"Zone_TashasCausticBrew"
}
local fighterEKSpells2nd = {
	"Zone_AganazzarsScorcher",
	"Target_ContinualFlame",
	"Zone_RimesBindingIce",
	"Target_SnillocsSnowballStorm",
	"Shout_WardingWind",
	"Shout_AbsorbElements",
	"Shout_EarthTremor",
	"Zone_FrostFingers",
	"Target_Snare",
	"Zone_TashasCausticBrew"
}
local paladinSpells1st = {
	"Target_Ceremony",
	"Shout_DetectEvilAndGood",
	"Shout_DetectMagic"
}
local paladinSpells2nd = {
	"Shout_PrayerOfHealing",
	"Target_WardingBond"
}
local paladinSpells3rd = {
	"Target_CreateFoodAndWater",
	"Shout_SpiritShroud"
}
local rangerSpells1st = {
	"Shout_AbsorbElements",
	"Target_BeastBond",
	"Shout_DetectMagic",
	"Target_Snare",
	"Shout_ZephyrStrike"
}
local rangerSpells2nd = {
	"Shout_Aid",
	"Target_EnhanceAbility",
	"Zone_GustOfWind",
	"Target_HealingSpirit",
	"Target_MagicWeapon",
	"Target_SummonBeast",
	"Shout_AbsorbElements",
	"Target_BeastBond",
	"Shout_DetectMagic",
	"Target_Snare",
	"Shout_ZephyrStrike"
}
local rangerSpells3rd = {
	"Shout_AshardalonsStride",
	"Target_ElementalWeapon",
	"Target_FlameArrows",
	"Target_Nondetection",
	"Teleportation_Revivify",
	"Shout_WaterWalk",
	"Shout_Aid",
	"Target_EnhanceAbility",
	"Zone_GustOfWind",
	"Target_HealingSpirit",
	"Target_MagicWeapon",
	"Target_SummonBeast",
	"Shout_AbsorbElements",
	"Target_BeastBond",
	"Shout_DetectMagic",
	"Target_Snare",
	"Shout_ZephyrStrike"
}
local rogueATSpells2nd = {
	"Target_TashasMindWhip",
	"Target_NathairsMischief",
	"Shout_ShadowBlade"
}
local sorcererCantrips = {
	"Target_BoomingBlade",
	"Target_ControlFlames",
	"Target_CreateBonfire",
	"Target_Frostbite",
	"Target_GreenFlameBlade",
	"Target_Gust",
	"Target_LightningLure",
	"Target_MindSliver",
	"Target_MoldEarth",
	"Target_Prestidigitation",
	"Target_ShapeWater",
	"Shout_SwordBurst",
	"Shout_Thunderclap"
}
local sorcererSpells1st = {
	"Shout_AbsorbElements",
	"Throw_Catapult",
	"Target_ChaosBolt",
	"Shout_DetectMagic",
	"Shout_EarthTremor",
	"Target_Grease",
	"Zone_TashasCausticBrew"
}
local sorcererSpells2nd = {
	"Zone_AganazzarsScorcher",
	"Shout_AlterSelf",
	"Target_DragonsBreath",
	"Target_DustDevil",
	"Shout_FlameBlade",
	"Target_FlamingSphere",
	"Shout_KineticJaunt",
	"Target_MagicWeapon",
	"Target_MaximiliansEarthenGrasp",
	"Target_TashasMindWhip",
	"Target_MindSpike",
	"Target_NathairsMischief",
	"Zone_RimesBindingIce",
	"Shout_ShadowBlade",
	"Target_SnillocsSnowballStorm",
	"Target_VortexWarp",
	"Shout_WardingWind",
	"Target_WitherAndBloom",
	"Shout_AbsorbElements",
	"Throw_Catapult",
	"Target_ChaosBolt",
	"Shout_DetectMagic",
	"Shout_EarthTremor",
	"Target_Grease",
	"Zone_TashasCausticBrew"
}
local sorcererSpells3rd = {
	"Target_Antagonize",
	"Shout_AshardalonsStride",
	"Target_Catnap",
	"Target_EnemiesAbound",
	"Target_EruptingEarth",
	"Target_FlameArrows",
	"Target_IntellectFortress",
	"Projectile_MinuteMeteors",
	"Teleportation_ThunderStep",
	"Target_VampiricTouch",
	"Shout_WaterWalk",
	"Zone_AganazzarsScorcher",
	"Shout_AlterSelf",
	"Target_DragonsBreath",
	"Target_DustDevil",
	"Shout_FlameBlade",
	"Target_FlamingSphere",
	"Shout_KineticJaunt",
	"Target_MagicWeapon",
	"Target_MaximiliansEarthenGrasp",
	"Target_TashasMindWhip",
	"Target_MindSpike",
	"Target_NathairsMischief",
	"Zone_RimesBindingIce",
	"Shout_ShadowBlade",
	"Target_SnillocsSnowballStorm",
	"Target_VortexWarp",
	"Shout_WardingWind",
	"Target_WitherAndBloom",
	"Shout_AbsorbElements",
	"Throw_Catapult",
	"Target_ChaosBolt",
	"Shout_DetectMagic",
	"Shout_EarthTremor",
	"Target_Grease",
	"Zone_TashasCausticBrew"
}
local sorcererSpells4th = {
	"Target_CharmMonster",
	"Shout_FireShield",
	"Projectile_RaulothimsPsychicLance",
	"Target_Antagonize",
	"Shout_AshardalonsStride",
	"Target_Catnap",
	"Target_EnemiesAbound",
	"Target_EruptingEarth",
	"Target_FlameArrows",
	"Target_IntellectFortress",
	"Projectile_MinuteMeteors",
	"Teleportation_ThunderStep",
	"Target_VampiricTouch",
	"Shout_WaterWalk",
	"Zone_AganazzarsScorcher",
	"Shout_AlterSelf",
	"Target_DragonsBreath",
	"Target_DustDevil",
	"Shout_FlameBlade",
	"Target_FlamingSphere",
	"Shout_KineticJaunt",
	"Target_MagicWeapon",
	"Target_MaximiliansEarthenGrasp",
	"Target_TashasMindWhip",
	"Target_MindSpike",
	"Target_NathairsMischief",
	"Zone_RimesBindingIce",
	"Shout_ShadowBlade",
	"Target_SnillocsSnowballStorm",
	"Target_VortexWarp",
	"Shout_WardingWind",
	"Target_WitherAndBloom",
	"Shout_AbsorbElements",
	"Throw_Catapult",
	"Target_ChaosBolt",
	"Shout_DetectMagic",
	"Shout_EarthTremor",
	"Target_Grease",
	"Zone_TashasCausticBrew"
}
local sorcererSpells5th = {
	"Target_FarStep",
	"Target_SkillEmpowerment",
	"Target_SynapticStatic",
	"Target_CharmMonster",
	"Shout_FireShield",
	"Projectile_RaulothimsPsychicLance",
	"Target_Antagonize",
	"Shout_AshardalonsStride",
	"Target_Catnap",
	"Target_EnemiesAbound",
	"Target_EruptingEarth",
	"Target_FlameArrows",
	"Target_IntellectFortress",
	"Projectile_MinuteMeteors",
	"Teleportation_ThunderStep",
	"Target_VampiricTouch",
	"Shout_WaterWalk",
	"Zone_AganazzarsScorcher",
	"Shout_AlterSelf",
	"Target_DragonsBreath",
	"Target_DustDevil",
	"Shout_FlameBlade",
	"Target_FlamingSphere",
	"Shout_KineticJaunt",
	"Target_MagicWeapon",
	"Target_MaximiliansEarthenGrasp",
	"Target_TashasMindWhip",
	"Target_MindSpike",
	"Target_NathairsMischief",
	"Zone_RimesBindingIce",
	"Shout_ShadowBlade",
	"Target_SnillocsSnowballStorm",
	"Target_VortexWarp",
	"Shout_WardingWind",
	"Target_WitherAndBloom",
	"Shout_AbsorbElements",
	"Throw_Catapult",
	"Target_ChaosBolt",
	"Shout_DetectMagic",
	"Shout_EarthTremor",
	"Target_Grease",
	"Zone_TashasCausticBrew"
}
local sorcererSpells6th = {
	"Target_TrueSeeing",
	"Target_FarStep",
	"Target_SkillEmpowerment",
	"Target_SynapticStatic",
	"Target_CharmMonster",
	"Shout_FireShield",
	"Projectile_RaulothimsPsychicLance",
	"Target_Antagonize",
	"Shout_AshardalonsStride",
	"Target_Catnap",
	"Target_EnemiesAbound",
	"Target_EruptingEarth",
	"Target_FlameArrows",
	"Target_IntellectFortress",
	"Projectile_MinuteMeteors",
	"Teleportation_ThunderStep",
	"Target_VampiricTouch",
	"Shout_WaterWalk",
	"Zone_AganazzarsScorcher",
	"Shout_AlterSelf",
	"Target_DragonsBreath",
	"Target_DustDevil",
	"Shout_FlameBlade",
	"Target_FlamingSphere",
	"Shout_KineticJaunt",
	"Target_MagicWeapon",
	"Target_MaximiliansEarthenGrasp",
	"Target_TashasMindWhip",
	"Target_MindSpike",
	"Target_NathairsMischief",
	"Zone_RimesBindingIce",
	"Shout_ShadowBlade",
	"Target_SnillocsSnowballStorm",
	"Target_VortexWarp",
	"Shout_WardingWind",
	"Target_WitherAndBloom",
	"Shout_AbsorbElements",
	"Throw_Catapult",
	"Target_ChaosBolt",
	"Shout_DetectMagic",
	"Shout_EarthTremor",
	"Target_Grease",
	"Zone_TashasCausticBrew"
}
local warlockCantrips = {
	"Target_BoomingBlade",
	"Target_CreateBonfire",
	"Target_Frostbite",
	"Target_GreenFlameBlade",
	"Target_Gust",
	"Target_LightningLure",
	"Target_MagicStone",
	"Target_MindSliver",
	"Target_Prestidigitation",
	"Target_ShapeWater",
	"Shout_SwordBurst",
	"Shout_Thunderclap",
	"Target_TollTheDead"
}
local warlockSpells1st = {
	"Target_CauseFear",
	"Target_UnseenServant"
}
local warlockSpells2nd = {
	"Shout_BorrowedKnowledge",
	"Target_FlockOfFamiliars",
	"Target_MindSpike",
	"Shout_ShadowBlade",
	"Target_CauseFear",
	"Target_UnseenServant"
}
local warlockSpells3rd = {
	"Target_Antagonize",
	"Target_EnemiesAbound",
	"Target_IntellectFortress",
	"Shout_SpiritShroud",
	"Target_SummonShadowspawn",
	"Teleportation_ThunderStep",
	"Shout_BorrowedKnowledge",
	"Target_FlockOfFamiliars",
	"Target_MindSpike",
	"Shout_ShadowBlade",
	"Target_CauseFear",
	"Target_UnseenServant"
}
local warlockSpells4th = {
	"Target_CharmMonster",
	"Projectile_RaulothimsPsychicLance",
	"Shout_ShadowOfMoil",
	"Target_Antagonize",
	"Target_EnemiesAbound",
	"Target_IntellectFortress",
	"Shout_SpiritShroud",
	"Target_SummonShadowspawn",
	"Teleportation_ThunderStep",
	"Shout_BorrowedKnowledge",
	"Target_FlockOfFamiliars",
	"Target_MindSpike",
	"Shout_ShadowBlade",
	"Target_CauseFear",
	"Target_UnseenServant"
}
local warlockSpells5th = {
	"Target_FarStep",
	"Projectile_NegativeEnergyFlood",
	"Target_SynapticStatic",
	"Target_PlanarBinding",
	"Target_CharmMonster",
	"Projectile_RaulothimsPsychicLance",
	"Shout_ShadowOfMoil",
	"Target_Antagonize",
	"Target_EnemiesAbound",
	"Target_IntellectFortress",
	"Shout_SpiritShroud",
	"Target_SummonShadowspawn",
	"Teleportation_ThunderStep",
	"Shout_BorrowedKnowledge",
	"Target_FlockOfFamiliars",
	"Target_MindSpike",
	"Shout_ShadowBlade",
	"Target_CauseFear",
	"Target_UnseenServant"
}
local warlockSpells6th = {
	"Target_TrueSeeing"
}
local wizardCantrips = {
	"Target_BoomingBlade",
	"Target_ControlFlames",
	"Target_CreateBonfire",
	"Target_Frostbite",
	"Target_GreenFlameBlade",
	"Target_Gust",
	"Target_LightningLure",
	"Target_MindSliver",
	"Target_MoldEarth",
	"Target_Prestidigitation",
	"Target_ShapeWater",
	"Shout_SwordBurst",
	"Shout_Thunderclap",
	"Target_TollTheDead"
}
local wizardSpells1st = {
	"Shout_AbsorbElements",
	"Throw_Catapult",
	"Target_CauseFear",
	"Shout_DetectMagic",
	"Shout_EarthTremor",
	"Zone_FrostFingers",
	"Target_Snare",
	"Zone_TashasCausticBrew",
	"Target_UnseenServant"
}
local wizardSpells2nd = {
	"Zone_AganazzarsScorcher",
	"Shout_AlterSelf",
	"Shout_BorrowedKnowledge",
	"Target_ContinualFlame",
	"Target_DragonsBreath",
	"Target_DustDevil",
	"Target_EnhanceAbility",
	"Target_FlockOfFamiliars",
	"Shout_KineticJaunt",
	"Target_MaximiliansEarthenGrasp",
	"Target_TashasMindWhip",
	"Target_MindSpike",
	"Target_NathairsMischief",
	"Zone_RimesBindingIce",
	"Shout_ShadowBlade",
	"Target_SnillocsSnowballStorm",
	"Target_VortexWarp",
	"Shout_WardingWind",
	"Target_WitherAndBloom",
	"Shout_AbsorbElements",
	"Throw_Catapult",
	"Target_CauseFear",
	"Shout_DetectMagic",
	"Shout_EarthTremor",
	"Zone_FrostFingers",
	"Target_Snare",
	"Zone_TashasCausticBrew",
	"Target_UnseenServant"
}
local wizardSpells3rd = {
	"Target_Antagonize",
	"Shout_AshardalonsStride",
	"Target_Catnap",
	"Target_EnemiesAbound",
	"Target_EruptingEarth",
	"Target_FlameArrows",
	"Target_IntellectFortress",
	"Target_LifeTransference",
	"Projectile_MinuteMeteors",
	"Target_Nondetection",
	"Shout_SpiritShroud",
	"Target_SummonShadowspawn",
	"Teleportation_ThunderStep",
	"Target_VampiricTouch",
	"Zone_AganazzarsScorcher",
	"Shout_AlterSelf",
	"Shout_BorrowedKnowledge",
	"Target_ContinualFlame",
	"Target_DragonsBreath",
	"Target_DustDevil",
	"Target_EnhanceAbility",
	"Target_FlockOfFamiliars",
	"Shout_KineticJaunt",
	"Target_MaximiliansEarthenGrasp",
	"Target_TashasMindWhip",
	"Target_MindSpike",
	"Target_NathairsMischief",
	"Zone_RimesBindingIce",
	"Shout_ShadowBlade",
	"Target_SnillocsSnowballStorm",
	"Target_VortexWarp",
	"Shout_WardingWind",
	"Target_WitherAndBloom",
	"Shout_AbsorbElements",
	"Throw_Catapult",
	"Target_CauseFear",
	"Shout_DetectMagic",
	"Shout_EarthTremor",
	"Zone_FrostFingers",
	"Target_Snare",
	"Zone_TashasCausticBrew",
	"Target_UnseenServant"
}
local wizardSpells4th = {
	"Target_CharmMonster",
	"Shout_FireShield",
	"Projectile_RaulothimsPsychicLance",
	"Target_SummonElemental",
	"Target_Antagonize",
	"Shout_AshardalonsStride",
	"Target_Catnap",
	"Target_EnemiesAbound",
	"Target_EruptingEarth",
	"Target_FlameArrows",
	"Target_IntellectFortress",
	"Target_LifeTransference",
	"Projectile_MinuteMeteors",
	"Target_Nondetection",
	"Shout_SpiritShroud",
	"Target_SummonShadowspawn",
	"Teleportation_ThunderStep",
	"Target_VampiricTouch",
	"Zone_AganazzarsScorcher",
	"Shout_AlterSelf",
	"Shout_BorrowedKnowledge",
	"Target_ContinualFlame",
	"Target_DragonsBreath",
	"Target_DustDevil",
	"Target_EnhanceAbility",
	"Target_FlockOfFamiliars",
	"Shout_KineticJaunt",
	"Target_MaximiliansEarthenGrasp",
	"Target_TashasMindWhip",
	"Target_MindSpike",
	"Target_NathairsMischief",
	"Zone_RimesBindingIce",
	"Shout_ShadowBlade",
	"Target_SnillocsSnowballStorm",
	"Target_VortexWarp",
	"Shout_WardingWind",
	"Target_WitherAndBloom",
	"Shout_AbsorbElements",
	"Throw_Catapult",
	"Target_CauseFear",
	"Shout_DetectMagic",
	"Shout_EarthTremor",
	"Zone_FrostFingers",
	"Target_Snare",
	"Zone_TashasCausticBrew",
	"Target_UnseenServant"
}
local wizardSpells5th = {
	"Target_FarStep",
	"Projectile_NegativeEnergyFlood",
	"Target_SkillEmpowerment",
	"Target_SteelWindStrike",
	"Target_SynapticStatic",
	"Target_CharmMonster",
	"Shout_FireShield",
	"Projectile_RaulothimsPsychicLance",
	"Target_SummonElemental",
	"Target_Antagonize",
	"Shout_AshardalonsStride",
	"Target_Catnap",
	"Target_EnemiesAbound",
	"Target_EruptingEarth",
	"Target_FlameArrows",
	"Target_IntellectFortress",
	"Target_LifeTransference",
	"Projectile_MinuteMeteors",
	"Target_Nondetection",
	"Shout_SpiritShroud",
	"Target_SummonShadowspawn",
	"Teleportation_ThunderStep",
	"Target_VampiricTouch",
	"Zone_AganazzarsScorcher",
	"Shout_AlterSelf",
	"Shout_BorrowedKnowledge",
	"Target_ContinualFlame",
	"Target_DragonsBreath",
	"Target_DustDevil",
	"Target_EnhanceAbility",
	"Target_FlockOfFamiliars",
	"Shout_KineticJaunt",
	"Target_MaximiliansEarthenGrasp",
	"Target_TashasMindWhip",
	"Target_MindSpike",
	"Target_NathairsMischief",
	"Zone_RimesBindingIce",
	"Shout_ShadowBlade",
	"Target_SnillocsSnowballStorm",
	"Target_VortexWarp",
	"Shout_WardingWind",
	"Target_WitherAndBloom",
	"Shout_AbsorbElements",
	"Throw_Catapult",
	"Target_CauseFear",
	"Shout_DetectMagic",
	"Shout_EarthTremor",
	"Zone_FrostFingers",
	"Target_Snare",
	"Zone_TashasCausticBrew",
	"Target_UnseenServant"
}
local wizardSpells6th = {
	"Shout_TensersTransformation",
	"Target_TrueSeeing",
	"Target_FarStep",
	"Projectile_NegativeEnergyFlood",
	"Target_SkillEmpowerment",
	"Target_SteelWindStrike",
	"Target_SynapticStatic",
	"Target_CharmMonster",
	"Shout_FireShield",
	"Projectile_RaulothimsPsychicLance",
	"Target_SummonElemental",
	"Target_Antagonize",
	"Shout_AshardalonsStride",
	"Target_Catnap",
	"Target_EnemiesAbound",
	"Target_EruptingEarth",
	"Target_FlameArrows",
	"Target_IntellectFortress",
	"Target_LifeTransference",
	"Projectile_MinuteMeteors",
	"Target_Nondetection",
	"Shout_SpiritShroud",
	"Target_SummonShadowspawn",
	"Teleportation_ThunderStep",
	"Target_VampiricTouch",
	"Zone_AganazzarsScorcher",
	"Shout_AlterSelf",
	"Shout_BorrowedKnowledge",
	"Target_ContinualFlame",
	"Target_DragonsBreath",
	"Target_DustDevil",
	"Target_EnhanceAbility",
	"Target_FlockOfFamiliars",
	"Shout_KineticJaunt",
	"Target_MaximiliansEarthenGrasp",
	"Target_TashasMindWhip",
	"Target_MindSpike",
	"Target_NathairsMischief",
	"Zone_RimesBindingIce",
	"Shout_ShadowBlade",
	"Target_SnillocsSnowballStorm",
	"Target_VortexWarp",
	"Shout_WardingWind",
	"Target_WitherAndBloom",
	"Shout_AbsorbElements",
	"Throw_Catapult",
	"Target_CauseFear",
	"Shout_DetectMagic",
	"Shout_EarthTremor",
	"Zone_FrostFingers",
	"Target_Snare",
	"Zone_TashasCausticBrew",
	"Target_UnseenServant"
}
local spellList5ES = {
  SpellSniper = "64784e08-e31e-4850-a743-ecfb3fd434d7",
  RitualCaster = "8c32c900-a8ea-4f2f-9f6f-eccd0d361a9d",
  BardCantrip = "61f79a30-2cac-4a7a-b5fe-50c89d307dd6",
  Bard1st = "dcb45167-86bd-4297-9b9d-c295be51af5b",
  Bard2nd = "7ea8f476-97a1-4256-8f10-afa76a845cce",
  Bard3rd = "c213ca01-3767-457b-a5c8-fd4c1dd656e2",
  Bard4th = "75e04c40-be8f-40a5-9acc-0b5d59d5f3a6",
  Bard5th = "bd71fffb-e4d2-4233-9a31-13d43fba36e3",
  Bard6th = "586a8796-34f4-41f5-a3ef-95738561d55d",
  BardMS3rd ="175ceed7-5a53-4f48-823c-41c4f72d18ae",
  BardMS5th = "858d4322-9e9f-4aa4-aada-9c68835dc6fe",
  ClericCantrip = "2f43a103-5bf1-4534-b14f-663decc0c525",
  Cleric1st = "269d1a3b-eed8-4131-8901-a562238f5289",
  Cleric2nd = "2968a3e6-6c8a-4c2e-882a-ad295a2ad8ac",
  Cleric3rd = "21be0992-499f-4c7a-a77a-4430085e947a",
  Cleric5th = "b73aeea5-1ff9-4cac-b61d-b5aa6dfe31c2",
  Cleric6th = "f8ba7b05-1237-4eaa-97fa-1d3623d5862b",
  DruidCantrip = "b8faf12f-ca42-45c0-84f8-6951b526182a",
  Druid1st = "2cd54137-2fe5-4100-aad3-df64735a8145",
  Druid2nd = "92126d17-7f1a-41d2-ae6c-a8d254d2b135",
  Druid3rd = "3156daf5-9266-41d0-b52c-5bc559a98654",
  Druid4th = "09c326c9-672c-4198-a4c0-6f07323bde27",
  Druid5th = "ff711c12-b59f-4fde-b9ea-6e5c38ec8f23",
  FighterEK1st = "32aeba85-13bd-4a6f-8e06-cd4447b746d8",
  FighterEK2nd = "4a86443c-6a21-4b8d-b1bf-55a99e021354",
  Paladin1st = "c6288ac5-c68b-40ed-bbdd-2ff388575831",
  Paladin2nd = "c14c9564-1503-47a1-be19-98e77f22ff59",
  Paladin3rd = "d18dec04-478f-41c3-b816-239d5cfcf2a2",
  Ranger1st = "458be063-60d4-4548-ae7d-50117fa0226f",
  Ranger2nd = "e7cfb80a-f5c2-4304-8446-9b00ea6a9814",
  Ranger3rd = "9a60f649-7f82-4152-90b1-0499c5c9f3e2",
  RogueAT2nd = "f9fd64f1-f417-4544-94a9-51d8876d68df",
  SorcererCantrip = "485a68b4-c678-4888-be63-4a702efbe391",
  Sorcerer1st = "92c4751f-6255-4f67-822c-a75d53830b27",
  Sorcerer2nd = "f80396e2-cb76-4694-b0db-5c34da61a478",
  Sorcerer3rd = "dcbaf2ae-1f45-453e-ab83-cd154f8277a4",
  Sorcerer4th = "5fe40622-1d3e-4cc1-8d89-e66fe51d8c5c",
  Sorcerer5th = "3276fcfe-e143-4559-b6e0-7d7aa0ffcb53",
  Sorcerer6th = "1270a6db-980b-4e3b-bf26-2924da61dfd5",
  WarlockCantrip = "f5c4af9c-5d8d-4526-9057-94a4b243cd40",
  WFiend1st = "4823a292-f584-4f7f-8434-6630c72e5411",
  WFiend2nd = "835aeca7-c64a-4aaa-a25c-143aa14a5cec",
  WFiend3rd = "5dec41aa-f16a-434e-b209-50c07e64e4ed",
  WFiend4th = "7ad7dbd0-751b-4bcd-8034-53bcc7bfb19d",
  WFiend5th = "deab57bf-4eec-4085-82f7-87335bce3f5d",
  WGoO1st = "65952d48-bb16-4ad7-b173-532182bf7770",
  WGoO2nd = "fe101a94-8619-49b2-859d-a68c2c291054",
  WGoO3rd = "30e9b761-6be0-418e-bb28-5103c00c663b",
  WGoO4th = "b64e527e-1f97-4125-84f7-78376ab1440b",
  WGoO5th = "6d2edca9-71a7-4f3f-89f0-fccfff0bdee5",
  WArchfey1st = "e0099b15-2599-4cba-a54b-b25ae03d6519",
  WArchfey2nd = "0cc2c8ab-9bbc-43a7-a66d-08e47da4c172",
  WArchfey3rd = "f18ad912-e2f4-47a9-8744-73d6a51c2941",
  WArchfey4th = "c3d8a4a5-9dae-4193-8322-a5d1c5b89f47",
  WArchfey5th = "0a9b924f-64fb-4f22-b975-5eeedc99b2fd",
  Warlock6th = "e6ccab5e-3b3b-4b34-8fa2-1058dff2b3e6",
  WizardCantrip = "3cae2e56-9871-4cef-bba6-96845ea765fa",
  Wizard1st = "11f331b0-e8b7-473b-9d1f-19e8e4178d7d",
  Wizard2nd = "80c6b070-c3a6-4864-84ca-e78626784eb4",
  Wizard3rd = "22755771-ca11-49f4-b772-13d8b8fecd93",
  Wizard4th = "820b1220-0385-426d-ae15-458dc8a6f5c0",
  Wizard5th = "f781a25e-d288-43b4-bf5d-3d8d98846687",
  Wizard6th = "bc917f22-7f71-4a25-9a77-7d2f91a96a65"
}

local function OnStatsLoaded()
	local additions = {
	SSCantrips = {
	  Spells = spellSniper,
	  SpellListID = spellList5ES.SpellSniper
	},
	RCSpells = {
	  Spells = ritualCaster,
	  SpellListID = spellList5ES.RitualCaster
	},
	BardCantrip = {
	  Spells = bardCantrips,
	  SpellListID = spellList5ES.BardCantrip
	},
	Bard1st = {
	  Spells = bardSpells1st,
	  SpellListID = spellList5ES.Bard1st
	},
	Bard2nd = {
	  Spells = bardSpells2nd,
	  SpellListID = spellList5ES.Bard2nd
	},
	Bard3rd = {
	  Spells = bardSpells3rd,
	  SpellListID = spellList5ES.Bard3rd
	},
	Bard4th = {
	  Spells = bardSpells4th,
	  SpellListID = spellList5ES.Bard4th
	},
	Bard5th = {
	  Spells = bardSpells5th,
	  SpellListID = spellList5ES.Bard5th
	},
	Bard6th = {
	  Spells = bardSpells6th,
	  SpellListID = spellList5ES.Bard6th
	},
	BardMS3rd = {
	  Spells = bardMagicalSecrets3rd,
	  SpellListID = spellList5ES.BardMS3rd
	},
	BardMS5th = {
	  Spells = bardMagicalSecrets5th,
	  SpellListID = spellList5ES.BardMS5th
	},
	ClericCantrip = {
	  Spells = clericCantrips,
	  SpellListID = spellList5ES.ClericCantrip
	},
	Cleric1st = {
	  Spells = clericSpells1st,
	  SpellListID = spellList5ES.Cleric1st
	},
	Cleric2nd = {
	  Spells = clericSpells2nd,
	  SpellListID = spellList5ES.Cleric2nd
	},
	Cleric3rd = {
	  Spells = clericSpells3rd,
	  SpellListID = spellList5ES.Cleric3rd
	},
	Cleric5th = {
	  Spells = clericSpells5th,
	  SpellListID = spellList5ES.Cleric5th
	},
	Cleric6th = {
	  Spells = clericSpells6th,
	  SpellListID = spellList5ES.Cleric6th
	},
	DruidCantrip = {
	  Spells = druidCantrips,
	  SpellListID = spellList5ES.DruidCantrip
	},
	Druid1st = {
	  Spells = druidSpells1st,
	  SpellListID = spellList5ES.Druid1st
	},
	Druid2nd = {
	  Spells = druidSpells2nd,
	  SpellListID = spellList5ES.Druid2nd
	},
	Druid3rd = {
	  Spells = druidSpells3rd,
	  SpellListID = spellList5ES.Druid3rd
	},
	Druid4th = {
	  Spells = druidSpells4th,
	  SpellListID = spellList5ES.Druid4th
	},
	Druid5th = {
	  Spells = druidSpells5th,
	  SpellListID = spellList5ES.Druid5th
	},
	FighterEK1st = {
	  Spells = fighterEKSpells1st,
	  SpellListID = spellList5ES.FighterEK1st
	},
	FighterEK2nd = {
	  Spells = fighterEKSpells2nd,
	  SpellListID = spellList5ES.FighterEK2nd
	},
	Paladin1st = {
	  Spells = paladinSpells1st,
	  SpellListID = spellList5ES.Paladin1st
	},
	Paladin2nd = {
	  Spells = paladinSpells2nd,
	  SpellListID = spellList5ES.Paladin2nd
	},
	Paladin3rd = {
	  Spells = paladinSpells3rd,
	  SpellListID = spellList5ES.Paladin3rd
	},
	Ranger1st = {
	  Spells = rangerSpells1st,
	  SpellListID = spellList5ES.Ranger1st
	},
	Ranger2nd = {
	  Spells = rangerSpells2nd,
	  SpellListID = spellList5ES.Ranger2nd
	},
	Ranger3rd = {
	  Spells = rangerSpells3rd,
	  SpellListID = spellList5ES.Ranger3rd
	},
	RogueAT2nd = {
	  Spells = rogueATSpells2nd,
	  SpellListID = spellList5ES.RogueAT2nd
	},
	SorcererCantrip = {
	  Spells = sorcererCantrips,
	  SpellListID = spellList5ES.SorcererCantrip
	},
	Sorcerer1st = {
	  Spells = sorcererSpells1st,
	  SpellListID = spellList5ES.Sorcerer1st
	},
	Sorcerer2nd = {
	  Spells = sorcererSpells2nd,
	  SpellListID = spellList5ES.Sorcerer2nd
	},
	Sorcerer3rd = {
	  Spells = sorcererSpells3rd,
	  SpellListID = spellList5ES.Sorcerer3rd
	},
	Sorcerer4th = {
	  Spells = sorcererSpells4th,
	  SpellListID = spellList5ES.Sorcerer4th
	},
	Sorcerer5th = {
	  Spells = sorcererSpells5th,
	  SpellListID = spellList5ES.Sorcerer5th
	},
	Sorcerer6th = {
	  Spells = sorcererSpells6th,
	  SpellListID = spellList5ES.Sorcerer6th
	},
	WarlockCantrip = {
	  Spells = warlockCantrips,
	  SpellListID = spellList5ES.WarlockCantrip
	},
	Fiend1st = {
	  Spells = warlockSpells1st,
	  SpellListID = spellList5ES.WFiend1st
	},
	Fiend2nd = {
	  Spells = warlockSpells2nd,
	  SpellListID = spellList5ES.WFiend2nd
	},
	Fiend3rd = {
	  Spells = warlockSpells3rd,
	  SpellListID = spellList5ES.WFiend3rd
	},
	Fiend4th = {
	  Spells = warlockSpells4th,
	  SpellListID = spellList5ES.WFiend4th
	},
	Fiend5th = {
	  Spells = warlockSpells5th,
	  SpellListID = spellList5ES.WFiend5th
	},
	GoO1st = {
	  Spells = warlockSpells1st,
	  SpellListID = spellList5ES.WGoO1st
	},
	GoO2nd = {
	  Spells = warlockSpells2nd,
	  SpellListID = spellList5ES.WGoO2nd
	},
	GoO3rd = {
	  Spells = warlockSpells3rd,
	  SpellListID = spellList5ES.WGoO3rd
	},
	GoO4th = {
	  Spells = warlockSpells4th,
	  SpellListID = spellList5ES.WGoO4th
	},
	GoO5th = {
	  Spells = warlockSpells5th,
	  SpellListID = spellList5ES.WGoO5th
	},
	Archfey1st = {
	  Spells = warlockSpells1st,
	  SpellListID = spellList5ES.WArchfey1st
	},
	Archfey2nd = {
	  Spells = warlockSpells2nd,
	  SpellListID = spellList5ES.WArchfey2nd
	},
	Archfey3rd = {
	  Spells = warlockSpells3rd,
	  SpellListID = spellList5ES.WArchfey3rd
	},
	Archfey4th = {
	  Spells = warlockSpells4th,
	  SpellListID = spellList5ES.WArchfey4th
	},
	Archfey5th = {
	  Spells = warlockSpells5th,
	  SpellListID = spellList5ES.WArchfey5th
	},
	Warlock6th = {
	  Spells = warlockSpells6th,
	  SpellListID = spellList5ES.Warlock6th
	},
	WizardCantrip = {
	  Spells = wizardCantrips,
	  SpellListID = spellList5ES.WizardCantrip
	},
	Wizard1st = {
	  Spells = wizardSpells1st,
	  SpellListID = spellList5ES.Wizard1st
	},
	Wizard2nd = {
	  Spells = wizardSpells2nd,
	  SpellListID = spellList5ES.Wizard2nd
	},
	Wizard3rd = {
	  Spells = wizardSpells3rd,
	  SpellListID = spellList5ES.Wizard3rd
	},
	Wizard4th = {
	  Spells = wizardSpells4th,
	  SpellListID = spellList5ES.Wizard4th
	},
	Wizard5th = {
	  Spells = wizardSpells5th,
	  SpellListID = spellList5ES.Wizard5th
	},
	Wizard6th = {
	  Spells = wizardSpells6th,
	  SpellListID = spellList5ES.Wizard6th
	},
	}

	S5E_SpellLists(additions)
end
Ext.Events.StatsLoaded:Subscribe(OnStatsLoaded)

function S5E_SpellLists(additions)
if additions ~= nil then
    for _, add in pairs(additions) do
        if add ~= nil then
                local spellList = Spells["SpellList"]
                local list = Ext.StaticData.Get(add.SpellListID, "SpellList")
                list[spellList] = Set(list[spellList], add.Spells)
                end
            end
        end
    end

function Set(spelllist, spells)
  local result = {}
  local num = 0

  if spelllist ~= nil and spells ~= nil then
    result, num = Insert(spelllist, result, num)
    result, num = Insert(spells, result, num)
  end

  return result
end

function InTable(list, val)
  if list ~= nil then
    for _, value in pairs(list) do
      if val == value then
        return true
      end
    end
  end
  return false
end

function Insert(list, result, num)
	for _, value in pairs(list) do
		if not InTable(result, value) then
		  result[num] = value
		  num = num + 1
		end
	end
	return result, num
end

-- Static Data helpers
function S5E_ApplyStaticData(defTable)
    for defType, defList in pairs(defTable) do
        for guid, changes in pairs (defList) do
            local resource = Ext.StaticData.Get(guid, defType)
            for attribute, replacement in pairs(changes) do
                local newValue
                if type(resource[attribute]) == "userdata"  then
                    if replacement.Type == "add" then
                        newValue = Ext.Types.Serialize(resource[attribute])
                        for _, value in pairs(replacement.Value) do
                            table.insert(newValue, value)
                        end
                    end
                    Ext.Types.Unserialize(resource[attribute], newValue)
                end
            end
        end
    end
end

local function S5E_StatsLoaded()
    S5E_ChaosBoltPassives()
	S5E_Changes()
    S5E_RogueSCAGtripSneakAttack()
--	S5E_Levitate()
end

Ext.Events.StatsLoaded:Subscribe(S5E_StatsLoaded)