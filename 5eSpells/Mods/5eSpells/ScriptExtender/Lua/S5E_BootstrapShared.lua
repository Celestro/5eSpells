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

	local mummymatk = Ext.Stats.Get("Target_Multiattack_Mummy")
	mummymatk.TargetConditions = "not Self() and not Dead() and HasStatus('SG_Frightened')"
	local fearray = Ext.Stats.Get("Target_FearRay_Spectator")
	fearray.TargetConditions = "Character() and Enemy() and not HasStatus('SG_Frightened')"
	local aotbhb = Ext.Stats.Get("AspectOfTheBeast_HoneyBadger")
	aotbhb.Conditions = "(HasStatus('SG_Poisoned', context.Source) or HasStatus('SG_Frightened', context.Source) or HasStatus('SG_Charmed', context.Source)) and RollDieAgainstDC(DiceType.d20,10) and not HasStatus('SG_Rage', context.Source)"
	local cloakeratk = Ext.Stats.Get("Target_Multiattack_Cloaker")
	cloakeratk.TargetConditions = "not Self() and not Dead() and HasStatus('SG_Frightened',context.Target)"
	local oskarscon = Ext.Stats.Get("Shout_LOW_OskarsBeloved_Visage_Confusion")
	oskarscon.TargetConditions = "not Self() and not Dead() and not Item() and not Tagged('UNDEAD') and Enemy() and not Tagged('OSKARSBELOVED_IMMUNITY') and not HasStatus('CONFUSION') and not HasStatus('SG_Frightened')"
	local oskarspos = Ext.Stats.Get("Target_LOW_OskarsBeloved_Possession")
	oskarspos.TargetConditions = "Character() and Enemy() and not Dead() and not HasStatus('SG_Frightened') and not HasStatus('CONFUSION') and not Tagged('OSKARSBELOVED_IMMUNITY') and not HasStatus('LOW_OSKARSBELOVED_UNNERVED')"
	local oskarsmummyatk = Ext.Stats.Get("Target_LOW_OskarsBeloved_Mummy_Multiattack")
	oskarsmummyatk.TargetConditions = "not Self() and not Dead() and HasStatus('SG_Frightened') and not Tagged('OSKARSBELOVED_IMMUNITY')"
	local oskarsmummyglare = Ext.Stats.Get("Target_LOW_OskarsBeloved_Mummy_Glare")
	oskarsmummyglare.TargetConditions = "Character() and IsCrowdControlled(context.Target) and not Tagged('OSKARSBELOVED_IMMUNITY') and not HasStatus('CONFUSION') and not HasStatus('SG_Frightened')"
	local hogdark = Ext.Stats.Get("Target_LOW_HouseOfGrief_ExploitFear_Darkness")
	hogdark.TargetConditions = "Tagged('ACT3_LOW_HOUSEOFGRIEF_VICTIM') and not HasStatus('SG_Frightened') and not Dead() and not HasStatus('CONTAGION_BLINDING_SICKNESS_3')"
	local hogdisease = Ext.Stats.Get("Target_LOW_HouseOfGrief_ExploitFear_Disease")
	hogdisease.TargetConditions = "Tagged('ACT3_LOW_HOUSEOFGRIEF_VICTIM') and not HasStatus('SG_Frightened') and not Dead() and not HasStatus('CONTAGION_FLESH_ROT_3')"
	local hogpowerless = Ext.Stats.Get("Target_LOW_HouseOfGrief_ExploitFear_Powerless")
	hogpowerless.TargetConditions = "Tagged('ACT3_LOW_HOUSEOFGRIEF_VICTIM') and not HasStatus('SG_Frightened') and not Dead() and not HasStatus('RAY_OF_ENFEEBLEMENT')"
	local hogbetray = Ext.Stats.Get("Target_LOW_HouseOfGrief_ExploitFear_Betrayal")
	hogbetray.AoEConditions = "Tagged('ACT3_LOW_HOUSEOFGRIEF_VICTIM') and not Dead() and not HasStatus('SG_Frightened')"
	local hogwolf = Ext.Stats.Get("Target_LOW_HouseOfGrief_ExploitFear_Wolf_2")
	hogwolf.TargetConditions = "Tagged('SHADOWHEART') and not HasStatus('SG_Frightened')"
	local hogspider = Ext.Stats.Get("Target_LOW_HouseOfGrief_ExploitFear_Spider_2")
	hogspider.TargetConditions = "Tagged('ACT3_LOW_HOUSEOFGRIEF_VICTIM') and not HasStatus('FRIGHTENED')"
	
	local elementalaffinity = Ext.Stats.Get("ELEMENTALAFFINITY_FIRE_EXTRA_DAMAGE_TECHNICAL")
    local elementalgish = Ext.Stats.Get("MAG_ElementalGish_CantripBooster_Amulet_Passive")
    local charismacaster = Ext.Stats.Get("MAG_CharismaCaster_CantripBooster_Passive")
	local elementalinfusion = Ext.Stats.Get("MAG_ElementalGish_ElementalInfusion_Ring")
    elementalaffinity.Boosts = "IF(IsSpell() and SpellDamageTypeIs(DamageType.Fire) and not SpellId('Target_GreenFlameBlade_Default') and not SpellId('Target_GreenFlameBlade_SneakAttack')):DamageBonus(max(0, CharismaModifier));IF(SpellDamageTypeIs(DamageType.Fire) and (SpellId('Target_GreenFlameBlade_Default') or SpellId('Target_GreenFlameBlade_SneakAttack')) and CharacterLevelGreaterThan(4)):CharacterWeaponDamage(max(0, CharismaModifier),Fire)"
    elementalgish.Boosts = "IF(IsCantrip() and not SpellId('Target_GreenFlameBlade_Default') and not SpellId('Target_GreenFlameBlade_SneakAttack') and not SpellId('Target_BoomingBlade_Default') and not SpellId('Target_BoomingBlade_SneakAttack') and (SpellDamageTypeIs(DamageType.Fire) or SpellDamageTypeIs(DamageType.Cold) or SpellDamageTypeIs(DamageType.Thunder) or SpellDamageTypeIs(DamageType.Acid) or SpellDamageTypeIs(DamageType.Lightning))):DamageBonus(max(1,SpellCastingAbilityModifier));IF((SpellId('Target_GreenFlameBlade_Default') or SpellId('Target_GreenFlameBlade_SneakAttack')) and CharacterLevelGreaterThan(4)):CharacterWeaponDamage(max(1, SpellCastingAbilityModifier),Fire);IF((SpellId('Target_BoomingBlade_Default') or SpellId('Target_BoomingBlade_SneakAttack')) and CharacterLevelGreaterThan(4)):CharacterWeaponDamage(max(1, SpellCastingAbilityModifier),Thunder)"
    charismacaster.Boosts = "IF(IsCantrip() and not SpellId('Target_GreenFlameBlade_Default') and not SpellId('Target_GreenFlameBlade_SneakAttack') and not SpellId('Target_BoomingBlade_Default') and not SpellId('Target_BoomingBlade_SneakAttack')):DamageBonus(max(1,CharismaModifier));IF((SpellId('Target_GreenFlameBlade_Default') or SpellId('Target_GreenFlameBlade_SneakAttack')) and CharacterLevelGreaterThan(4)):CharacterWeaponDamage(max(1, CharismaModifier),Fire);IF((SpellId('Target_BoomingBlade_Default') or SpellId('Target_BoomingBlade_SneakAttack')) and CharacterLevelGreaterThan(4)):CharacterWeaponDamage(max(1, CharismaModifier),Thunder)"
    elementalinfusion.PassivesOnEquip = elementalinfusion.PassivesOnEquip .. ";S5E_ElementalGish_ElementalInfusion_Ring_Passive"

	local shadowbladering = Ext.Stats.Get("MAG_Shadow_ShadowBlade_Ring")
	shadowbladering.Boosts = "UnlockSpell(Shout_ShadowBlade_Ring)"
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
local bardSpells1stTCoE = {
	"Zone_ColorSpray",
	"Target_Command_Container"
}
local bardSpells1stOther = {
	"Shout_DetectMagic",
	"Shout_EarthTremor",
	"Target_UnseenServant"
}
local bardSpells2ndTCoE = {
	"Shout_Aid",
	"Target_EnlargeReduce",
	"Target_Knock",
	"Shout_MirrorImage",
	"Zone_ColorSpray",
	"Target_Command_Container"
}
local bardSpells2ndOther = {
	"Shout_BorrowedKnowledge",
	"Shout_KineticJaunt",
	"Target_NathairsMischief",
	"Shout_WardingWind",
	"Shout_DetectMagic",
	"Shout_EarthTremor",
	"Target_UnseenServant"
}
local bardSpells3rdTCoE = {
	"Shout_HealingWord_Mass",
	"Target_Slow",
	"Shout_Aid",
	"Target_EnlargeReduce",
	"Target_Knock",
	"Shout_MirrorImage",
	"Zone_ColorSpray",
	"Target_Command_Container"
}
local bardSpells3rdOther = {
	"Target_Antagonize",
	"Target_Catnap",
	"Target_EnemiesAbound",
	"Target_IntellectFortress",
	"Target_MotivationalSpeech",
	"Target_Nondetection",
	"Shout_BorrowedKnowledge",
	"Shout_KineticJaunt",
	"Target_NathairsMischief",
	"Shout_WardingWind",
	"Shout_DetectMagic",
	"Shout_EarthTremor",
	"Target_UnseenServant"
}
local bardSpells4thTCoE = {
	"Target_PhantasmalKiller",
	"Shout_HealingWord_Mass",
	"Target_Slow",
	"Shout_Aid",
	"Target_EnlargeReduce",
	"Target_Knock",
	"Shout_MirrorImage",
	"Zone_ColorSpray",
	"Target_Command_Container"
}
local bardSpells4thOther = {
	"Target_CharmMonster",
	"Projectile_RaulothimsPsychicLance",
	"Target_Antagonize",
	"Target_Catnap",
	"Target_EnemiesAbound",
	"Target_IntellectFortress",
	"Target_MotivationalSpeech",
	"Target_Nondetection",
	"Shout_BorrowedKnowledge",
	"Shout_KineticJaunt",
	"Target_NathairsMischief",
	"Shout_WardingWind",
	"Shout_DetectMagic",
	"Shout_EarthTremor",
	"Target_UnseenServant"
}
local bardSpells5thTCoE = {
	"Target_PhantasmalKiller",
	"Shout_HealingWord_Mass",
	"Target_Slow",
	"Shout_Aid",
	"Target_EnlargeReduce",
	"Target_Knock",
	"Shout_MirrorImage",
	"Zone_ColorSpray",
	"Target_Command_Container"
}
local bardSpells5thOther = {
	"Target_SkillEmpowerment",
	"Target_SynapticStatic",
	"Target_CharmMonster",
	"Projectile_RaulothimsPsychicLance",
	"Target_Antagonize",
	"Target_Catnap",
	"Target_EnemiesAbound",
	"Target_IntellectFortress",
	"Target_MotivationalSpeech",
	"Target_Nondetection",
	"Shout_BorrowedKnowledge",
	"Shout_KineticJaunt",
	"Target_NathairsMischief",
	"Shout_WardingWind",
	"Shout_DetectMagic",
	"Shout_EarthTremor",
	"Target_UnseenServant"
}
local bardSpells6thTCoE = {
	"Shout_HeroesFeast",
	"Target_SkillEmpowerment",
	"Target_SynapticStatic",
	"Target_CharmMonster",
	"Projectile_RaulothimsPsychicLance",
	"Target_Antagonize",
	"Target_Catnap",
	"Target_EnemiesAbound",
	"Target_IntellectFortress",
	"Target_MotivationalSpeech",
	"Target_Nondetection",
	"Shout_BorrowedKnowledge",
	"Shout_KineticJaunt",
	"Target_NathairsMischief",
	"Shout_WardingWind",
	"Shout_DetectMagic",
	"Shout_EarthTremor",
	"Target_UnseenServant"
}
local bardSpells6thOther = {
	"Target_TrueSeeing",
	"Target_SkillEmpowerment",
	"Target_SynapticStatic",
	"Target_CharmMonster",
	"Projectile_RaulothimsPsychicLance",
	"Target_Antagonize",
	"Target_Catnap",
	"Target_EnemiesAbound",
	"Target_IntellectFortress",
	"Target_MotivationalSpeech",
	"Target_Nondetection",
	"Shout_BorrowedKnowledge",
	"Shout_KineticJaunt",
	"Target_NathairsMischief",
	"Shout_WardingWind",
	"Shout_DetectMagic",
	"Shout_EarthTremor",
	"Target_UnseenServant"
}
local bardMagicalSecrets3rdTCoE = {
	"Shout_BeaconOfHope",
	"Target_Smite_Blinding",
	"Shout_Blink",
	"Zone_ConjureBarrage",
	"Shout_CrusadersMantle",
	"Target_ElementalWeapon",
	"Target_HungerOfHadar",
	"Projectile_LightningArrow",
	"Target_ProtectionFromEnergy",
	"Teleportation_Revivify",
	"Target_SleetStorm",
	"Target_VampiricTouch",
	"Target_Barkskin",
	"Target_Smite_Branding_Container",
	"Shout_FlameBlade",
	"Target_FlamingSphere",
	"Zone_GustOfWind",
	"Target_MagicWeapon",
	"Target_Moonbeam",
	"Shout_PrayerOfHealing",
	"Target_ProtectionFromPoison",
	"Projectile_RayOfEnfeeblement",
	"Target_WardingBond",
	"Shout_ArmsOfHadar",
	"Zone_BurningHands",
	"Target_CreateDestroyWater",
	"Projectile_EnsnaringStrike_Container",
	"Target_Entangle",
	"Shout_ExpeditiousRetreat",
	"Target_FindFamiliar",
	"Target_FogCloud",
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
	"Shout_SpeakWithAnimals",
	"Projectile_WitchBolt",
	"Target_Smite_Wrathful"
}
local bardMagicalSecrets3rdOther = {
	"Target_Antagonize",
	"Target_CreateFoodAndWater",
	"Target_EruptingEarth",
	"Target_FlameArrows",
	"Projectile_MinuteMeteors",
	"Shout_SpiritShroud",
	"Target_SummonShadowspawn",
	"Teleportation_ThunderStep",
	"Shout_WaterWalk",
	"Zone_AganazzarsScorcher",
	"Shout_AlterSelf",
	"Target_ContinualFlame",
	"Target_DragonsBreath",
	"Target_DustDevil",
	"Target_FlockOfFamiliars",
	"Target_HealingSpirit",
	"Target_MaximiliansEarthenGrasp",
	"Target_TashasMindWhip",
	"Target_MindSpike",
	"Zone_RimesBindingIce",
	"Shout_ShadowBlade",
	"Target_SnillocsSnowballStorm",
	"Target_VortexWarp",
	"Target_WitherAndBloom",
	"Shout_AbsorbElements",
	"Throw_Catapult",
	"Target_CauseFear",
	"Target_Ceremony",
	"Target_ChaosBolt",
	"Shout_DetectEvilAndGood",
	"Zone_FrostFingers",
	"Target_Snare",
	"Zone_TashasCausticBrew",
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
	"Target_Infestation",
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
local bardMagicalSecrets5thTCoE = {
	"Projectile_Smite_Banishing_Container",
	"Target_Cloudkill",
	"Shout_DestructiveWave",
	"Target_FlameStrike",
	"Target_InsectPlague",
	"Throw_Telekinesis",
	"Target_ConjureWoodlandBeings",
	"Target_BlackTentacles",
	"Target_GraspingVine",
	"Target_ResilientSphere",
	"Target_Stoneskin",
	"Shout_BeaconOfHope",
	"Target_Smite_Blinding",
	"Shout_Blink",
	"Zone_ConjureBarrage",
	"Shout_CrusadersMantle",
	"Target_ElementalWeapon",
	"Target_HungerOfHadar",
	"Projectile_LightningArrow",
	"Target_ProtectionFromEnergy",
	"Teleportation_Revivify",
	"Target_SleetStorm",
	"Target_VampiricTouch",
	"Target_Barkskin",
	"Target_Smite_Branding_Container",
	"Shout_FlameBlade",
	"Target_FlamingSphere",
	"Zone_GustOfWind",
	"Target_MagicWeapon",
	"Target_Moonbeam",
	"Shout_PrayerOfHealing",
	"Target_ProtectionFromPoison",
	"Projectile_RayOfEnfeeblement",
	"Target_WardingBond",
	"Shout_ArmsOfHadar",
	"Zone_BurningHands",
	"Target_CreateDestroyWater",
	"Projectile_EnsnaringStrike_Container",
	"Target_Entangle",
	"Shout_ExpeditiousRetreat",
	"Target_FindFamiliar",
	"Target_FogCloud",
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
	"Shout_SpeakWithAnimals",
	"Projectile_WitchBolt",
	"Target_Smite_Wrathful"
}
local bardMagicalSecrets5thOther = {
	"ProjectileStrike_ConjureVolley",
	"Target_FarStep",
	"Target_HolyWeapon",
	"Target_Maelstrom",
	"Projectile_NegativeEnergyFlood",
	"Target_SteelWindStrike",
	"Target_StormSphere",
	"Shout_SwiftQuiver",
	"Shout_AuraOfLife",
	"Shout_GuardianOfNature",
	"Shout_ShadowOfMoil",
	"Target_SummonBeholderkin",
	"Target_SummonElemental",
	"Projectile_VitriolicSphere",
	"Target_Antagonize",
	"Target_CreateFoodAndWater",
	"Target_EruptingEarth",
	"Target_FlameArrows",
	"Projectile_MinuteMeteors",
	"Shout_SpiritShroud",
	"Target_SummonShadowspawn",
	"Teleportation_ThunderStep",
	"Shout_WaterWalk",
	"Zone_AganazzarsScorcher",
	"Shout_AlterSelf",
	"Target_ContinualFlame",
	"Target_DragonsBreath",
	"Target_DustDevil",
	"Target_FlockOfFamiliars",
	"Target_HealingSpirit",
	"Target_MaximiliansEarthenGrasp",
	"Target_TashasMindWhip",
	"Target_MindSpike",
	"Zone_RimesBindingIce",
	"Shout_ShadowBlade",
	"Target_SnillocsSnowballStorm",
	"Target_VortexWarp",
	"Target_WitherAndBloom",
	"Shout_AbsorbElements",
	"Throw_Catapult",
	"Target_CauseFear",
	"Target_Ceremony",
	"Target_ChaosBolt",
	"Shout_DetectEvilAndGood",
	"Zone_FrostFingers",
	"Target_Snare",
	"Zone_TashasCausticBrew",
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
	"Target_Infestation",
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
local clericSpells1stOther = {
	"Target_Ceremony",
	"Shout_DetectEvilAndGood",
	"Shout_DetectMagic"
}
local clericSpells2ndOther = {
	"Shout_BorrowedKnowledge",
	"Target_ContinualFlame"
}
local clericSpells3rdTCoE = {
	"Shout_AuraOfVitality"
}
local clericSpells3rdOther = {
	"Target_CreateFoodAndWater",
	"Target_LifeTransference",
	"Target_MotivationalSpeech",
	"Shout_SpiritShroud",
	"Shout_WaterWalk"
}
local clericSpells4thOther = {
	"Shout_AuraOfLife"
}
local clericSpells5thOther = {
	"Target_HolyWeapon"
}
local clericSpells6thTCoE = {
	"Zone_Sunbeam"
}
local clericSpells6thOther = {
	"Target_TrueSeeing"
}
local druidCantrips = {
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
}
local druidSpells1stTCoE = {
	"Target_ProtectionFromEvilAndGood"
}
local druidSpells1stOther = {
	"Shout_AbsorbElements",
	"Target_BeastBond",
	"Shout_DetectMagic",
	"Shout_EarthTremor",
	"Target_Snare"
}
local druidSpells2ndTCoE = {
	"Target_EnlargeReduce"
}
local druidSpells2ndOther = {
	"Target_ContinualFlame",
	"Target_DustDevil",
	"Target_HealingSpirit",
	"Target_SummonBeast",
	"Target_WitherAndBloom",
	"Shout_WardingWind"
}
local druidSpells3rdTCoE = {
	"Shout_AuraOfVitality",
	"Target_ElementalWeapon",
	"Teleportation_Revivify"
}
local druidSpells3rdOther = {
	"Target_EruptingEarth",
	"Target_FlameArrows",
	"Shout_WaterWalk"
}
local druidSpells4thTCoE = {
	"Shout_FireShield"
}
local druidSpells4thOther = {
	"Target_CharmMonster",
	"Shout_GuardianOfNature",
	"Target_SummonElemental"
}
local druidSpells5thTCoE = {
	"Zone_ConeOfCold"
}
local druidSpells5thOther = {
	"Shout_CommuneWithNature",
	"Target_Maelstrom"
}
local druidSpells6thTCoE = {
	"Target_FleshToStone"
}
local fighterEKSpells1stOther = {
	"Shout_AbsorbElements",
	"Shout_EarthTremor",
	"Zone_FrostFingers",
	"Target_Snare",
	"Zone_TashasCausticBrew"
}
local fighterEKSpells2ndOther = {
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
local paladinSpells1stOther = {
	"Target_Ceremony",
	"Shout_DetectEvilAndGood",
	"Shout_DetectMagic"
}
local paladinSpells2ndTCoE = {
	"Shout_PrayerOfHealing",
	"Target_WardingBond"
}
local paladinSpells3rdOther = {
	"Target_CreateFoodAndWater",
	"Shout_SpiritShroud"
}
local rangerSpells1stOther = {
	"Shout_AbsorbElements",
	"Target_BeastBond",
	"Shout_DetectMagic",
	"Target_Snare",
	"Shout_ZephyrStrike"
}
local rangerSpells2ndTCoE = {
	"Shout_Aid",
	"Target_EnhanceAbility",
	"Zone_GustOfWind",
	"Target_MagicWeapon"
}
local rangerSpells2ndOther = {
	"Target_HealingSpirit",
	"Target_SummonBeast",
	"Shout_AbsorbElements",
	"Target_BeastBond",
	"Shout_DetectMagic",
	"Target_Snare",
	"Shout_ZephyrStrike"
}
local rangerSpells3rdTCoE = {
	"Target_ElementalWeapon",
	"Teleportation_Revivify",
	"Shout_Aid",
	"Target_EnhanceAbility",
	"Zone_GustOfWind",
	"Target_MagicWeapon"
}
local rangerSpells3rdOther = {
	"Shout_AshardalonsStride",
	"Target_FlameArrows",
	"Target_Nondetection",
	"Shout_WaterWalk",
	"Target_HealingSpirit",
	"Target_SummonBeast",
	"Shout_AbsorbElements",
	"Target_BeastBond",
	"Shout_DetectMagic",
	"Target_Snare",
	"Shout_ZephyrStrike"
}
local rogueATSpells2ndOther = {
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
	"Target_Infestation",
	"Target_LightningLure",
	"Target_MindSliver",
	"Target_MoldEarth",
	"Target_Prestidigitation",
	"Target_ShapeWater",
	"Shout_SwordBurst",
	"Shout_Thunderclap"
}
local sorcererSpells1stTCoE = {
	"Target_Grease"
}
local sorcererSpells1stOther = {
	"Shout_AbsorbElements",
	"Throw_Catapult",
	"Target_ChaosBolt",
	"Shout_DetectMagic",
	"Shout_EarthTremor",
	"Zone_TashasCausticBrew"
}
local sorcererSpells2ndTCoE = {
	"Shout_FlameBlade",
	"Target_FlamingSphere",
	"Target_MagicWeapon",
	"Target_Grease"
}
local sorcererSpells2ndOther = {
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
	"Zone_TashasCausticBrew"
}
local sorcererSpells3rdTCoE = {
	"Target_VampiricTouch",
	"Shout_FlameBlade",
	"Target_FlamingSphere",
	"Target_MagicWeapon",
	"Target_Grease"
}
local sorcererSpells3rdOther = {
	"Target_Antagonize",
	"Shout_AshardalonsStride",
	"Target_Catnap",
	"Target_EnemiesAbound",
	"Target_EruptingEarth",
	"Target_FlameArrows",
	"Target_IntellectFortress",
	"Projectile_MinuteMeteors",
	"Teleportation_ThunderStep",
	"Shout_WaterWalk",
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
	"Zone_TashasCausticBrew"
}
local sorcererSpells4thTCoE = {
	"Shout_FireShield",
	"Target_VampiricTouch",
	"Shout_FlameBlade",
	"Target_FlamingSphere",
	"Target_MagicWeapon",
	"Target_Grease"
}
local sorcererSpells4thOther = {
	"Target_CharmMonster",
	"Projectile_RaulothimsPsychicLance",
	"Target_StormSphere",
	"Projectile_VitriolicSphere",
	"Target_Antagonize",
	"Shout_AshardalonsStride",
	"Target_Catnap",
	"Target_EnemiesAbound",
	"Target_EruptingEarth",
	"Target_FlameArrows",
	"Target_IntellectFortress",
	"Projectile_MinuteMeteors",
	"Teleportation_ThunderStep",
	"Shout_WaterWalk",
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
	"Zone_TashasCausticBrew"
}
local sorcererSpells5thTCoE = {
	"Shout_FireShield",
	"Target_VampiricTouch",
	"Shout_FlameBlade",
	"Target_FlamingSphere",
	"Target_MagicWeapon",
	"Target_Grease"
}
local sorcererSpells5thOther = {
	"Target_FarStep",
	"Target_SkillEmpowerment",
	"Target_SynapticStatic",
	"Target_CharmMonster",
	"Projectile_RaulothimsPsychicLance",
	"Target_StormSphere",
	"Projectile_VitriolicSphere",
	"Target_Antagonize",
	"Shout_AshardalonsStride",
	"Target_Catnap",
	"Target_EnemiesAbound",
	"Target_EruptingEarth",
	"Target_FlameArrows",
	"Target_IntellectFortress",
	"Projectile_MinuteMeteors",
	"Teleportation_ThunderStep",
	"Shout_WaterWalk",
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
	"Zone_TashasCausticBrew"
}
local sorcererSpells6thTCoE = {
	"Target_FleshToStone",
	"Target_FreezingSphere",
	"Shout_FireShield",
	"Target_VampiricTouch",
	"Shout_FlameBlade",
	"Target_FlamingSphere",
	"Target_MagicWeapon",
	"Target_Grease"
}
local sorcererSpells6thOther = {
	"Target_TrueSeeing",
	"Target_FarStep",
	"Target_SkillEmpowerment",
	"Target_SynapticStatic",
	"Target_CharmMonster",
	"Projectile_RaulothimsPsychicLance",
	"Target_StormSphere",
	"Projectile_VitriolicSphere",
	"Target_Antagonize",
	"Shout_AshardalonsStride",
	"Target_Catnap",
	"Target_EnemiesAbound",
	"Target_EruptingEarth",
	"Target_FlameArrows",
	"Target_IntellectFortress",
	"Projectile_MinuteMeteors",
	"Teleportation_ThunderStep",
	"Shout_WaterWalk",
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
	"Zone_TashasCausticBrew"
}
local warlockCantrips = {
	"Target_BoomingBlade",
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
}
local warlockSpells1stOther = {
	"Target_CauseFear",
	"Target_UnseenServant"
}
local warlockSpells2ndOther = {
	"Shout_BorrowedKnowledge",
	"Target_FlockOfFamiliars",
	"Target_MindSpike",
	"Shout_ShadowBlade",
	"Target_CauseFear",
	"Target_UnseenServant"
}
local warlockSpells3rdOther = {
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
local warlockSpells4thOther = {
	"Target_CharmMonster",
	"Projectile_RaulothimsPsychicLance",
	"Shout_ShadowOfMoil",
	"Target_SummonBeholderkin",
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
local warlockSpells5thTCoE = {
	"Target_PlanarBinding"
}
local warlockSpells5thOther = {
	"Target_FarStep",
	"Projectile_NegativeEnergyFlood",
	"Target_PlanarBinding",
	"Target_SynapticStatic",
	"Target_CharmMonster",
	"Projectile_RaulothimsPsychicLance",
	"Shout_ShadowOfMoil",
	"Target_SummonBeholderkin",
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
local warlockSpells6thOther = {
	"Target_TrueSeeing"
}
local wizardCantrips = {
	"Target_BoomingBlade",
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
}
local wizardSpells1stOther = {
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
local wizardSpells2ndTCoE = {
	"Target_EnhanceAbility"
}
local wizardSpells2ndOther = {
	"Zone_AganazzarsScorcher",
	"Shout_AlterSelf",
	"Shout_BorrowedKnowledge",
	"Target_ContinualFlame",
	"Target_DragonsBreath",
	"Target_DustDevil",
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
local wizardSpells3rdTCoE = {
	"Target_SpeakWithDead",
	"Target_EnhanceAbility"
}
local wizardSpells3rdOther = {
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
	"Zone_AganazzarsScorcher",
	"Shout_AlterSelf",
	"Shout_BorrowedKnowledge",
	"Target_ContinualFlame",
	"Target_DragonsBreath",
	"Target_DustDevil",
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
local wizardSpells4thTCoE = {
	"Target_SpeakWithDead",
	"Target_EnhanceAbility"
}
local wizardSpells4thOther = {
	"Target_CharmMonster",
	"Projectile_RaulothimsPsychicLance",
	"Target_StormSphere",
	"Target_SummonBeholderkin",
	"Target_SummonElemental",
	"Projectile_VitriolicSphere",
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
	"Zone_AganazzarsScorcher",
	"Shout_AlterSelf",
	"Shout_BorrowedKnowledge",
	"Target_ContinualFlame",
	"Target_DragonsBreath",
	"Target_DustDevil",
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
local wizardSpells5thTCoE = {
	"Target_SpeakWithDead",
	"Target_EnhanceAbility"
}
local wizardSpells5thOther = {
	"Target_FarStep",
	"Projectile_NegativeEnergyFlood",
	"Target_SkillEmpowerment",
	"Target_SteelWindStrike",
	"Target_SynapticStatic",
	"Target_CharmMonster",
	"Projectile_RaulothimsPsychicLance",
	"Target_StormSphere",
	"Target_SummonBeholderkin",
	"Target_SummonElemental",
	"Projectile_VitriolicSphere",
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
	"Zone_AganazzarsScorcher",
	"Shout_AlterSelf",
	"Shout_BorrowedKnowledge",
	"Target_ContinualFlame",
	"Target_DragonsBreath",
	"Target_DustDevil",
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
local wizardSpells6thTCoE = {
	"Target_SpeakWithDead",
	"Target_EnhanceAbility"
}
local wizardSpells6thOther = {
	"Shout_TensersTransformation",
	"Target_TrueSeeing",
	"Target_FarStep",
	"Projectile_NegativeEnergyFlood",
	"Target_SkillEmpowerment",
	"Target_SteelWindStrike",
	"Target_SynapticStatic",
	"Target_CharmMonster",
	"Projectile_RaulothimsPsychicLance",
	"Target_StormSphere",
	"Target_SummonBeholderkin",
	"Target_SummonElemental",
	"Projectile_VitriolicSphere",
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
	"Zone_AganazzarsScorcher",
	"Shout_AlterSelf",
	"Shout_BorrowedKnowledge",
	"Target_ContinualFlame",
	"Target_DragonsBreath",
	"Target_DustDevil",
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
local cantripList5ES = {
  SpellSniper = "64784e08-e31e-4850-a743-ecfb3fd434d7",
  BardCantrip = "61f79a30-2cac-4a7a-b5fe-50c89d307dd6",
  ClericCantrip = "2f43a103-5bf1-4534-b14f-663decc0c525",
  DruidCantrip = "b8faf12f-ca42-45c0-84f8-6951b526182a",
  SorcererCantrip = "485a68b4-c678-4888-be63-4a702efbe391",
  WarlockCantrip = "f5c4af9c-5d8d-4526-9057-94a4b243cd40",
  WizardCantrip = "3cae2e56-9871-4cef-bba6-96845ea765fa"
}

local tcoeList5ES = {
  Bard1stTCoE = "dcb45167-86bd-4297-9b9d-c295be51af5b",
  Bard2ndTCoE = "7ea8f476-97a1-4256-8f10-afa76a845cce",
  Bard3rdTCoE = "c213ca01-3767-457b-a5c8-fd4c1dd656e2",
  Bard4thTCoE = "75e04c40-be8f-40a5-9acc-0b5d59d5f3a6",
  Bard5thTCoE = "bd71fffb-e4d2-4233-9a31-13d43fba36e3",
  Bard6thTCoE = "586a8796-34f4-41f5-a3ef-95738561d55d",
  BardMS3rdTCoE = "175ceed7-5a53-4f48-823c-41c4f72d18ae",
  BardMS5thTCoE = "858d4322-9e9f-4aa4-aada-9c68835dc6fe",
  Cleric3rdTCoE = "21be0992-499f-4c7a-a77a-4430085e947a",
  Cleric6thTCoE = "f8ba7b05-1237-4eaa-97fa-1d3623d5862b",
  Druid1stTCoE = "2cd54137-2fe5-4100-aad3-df64735a8145",
  Druid2ndTCoE = "92126d17-7f1a-41d2-ae6c-a8d254d2b135",
  Druid3rdTCoE = "3156daf5-9266-41d0-b52c-5bc559a98654",
  Druid4thTCoE = "09c326c9-672c-4198-a4c0-6f07323bde27",
  Druid5thTCoE = "ff711c12-b59f-4fde-b9ea-6e5c38ec8f23",
  Druid6thTCoE = "6a4e2167-55f3-4ba8-900f-14666b293e93",
  Paladin2ndTCoE = "c14c9564-1503-47a1-be19-98e77f22ff59",
  Ranger2ndTCoE = "e7cfb80a-f5c2-4304-8446-9b00ea6a9814",
  Ranger3rdTCoE = "9a60f649-7f82-4152-90b1-0499c5c9f3e2",
  Sorcerer1stTCoE = "92c4751f-6255-4f67-822c-a75d53830b27",
  Sorcerer2ndTCoE = "f80396e2-cb76-4694-b0db-5c34da61a478",
  Sorcerer3rdTCoE = "dcbaf2ae-1f45-453e-ab83-cd154f8277a4",
  Sorcerer4thTCoE = "5fe40622-1d3e-4cc1-8d89-e66fe51d8c5c",
  Sorcerer5thTCoE = "3276fcfe-e143-4559-b6e0-7d7aa0ffcb53",
  Sorcerer6thTCoE = "1270a6db-980b-4e3b-bf26-2924da61dfd5",
  WFiend5thTCoE = "deab57bf-4eec-4085-82f7-87335bce3f5d",
  WGoO5thTCoE = "6d2edca9-71a7-4f3f-89f0-fccfff0bdee5",
  WArchfey5thTCoE = "6d2edca9-71a7-4f3f-89f0-fccfff0bdee5",
  Wizard2ndTCoE = "80c6b070-c3a6-4864-84ca-e78626784eb4",
  Wizard3rdTCoE = "22755771-ca11-49f4-b772-13d8b8fecd93",
  Wizard4thTCoE = "820b1220-0385-426d-ae15-458dc8a6f5c0",
  Wizard5thTCoE = "f781a25e-d288-43b4-bf5d-3d8d98846687",
  Wizard6thTCoE = "bc917f22-7f71-4a25-9a77-7d2f91a96a65"
}

local othersList5ES = {
  RitualCaster = "8c32c900-a8ea-4f2f-9f6f-eccd0d361a9d",
  Bard1stOther = "dcb45167-86bd-4297-9b9d-c295be51af5b",
  Bard2ndOther = "7ea8f476-97a1-4256-8f10-afa76a845cce",
  Bard3rdOther = "c213ca01-3767-457b-a5c8-fd4c1dd656e2",
  Bard4thOther = "75e04c40-be8f-40a5-9acc-0b5d59d5f3a6",
  Bard5thOther = "bd71fffb-e4d2-4233-9a31-13d43fba36e3",
  Bard6thOther = "586a8796-34f4-41f5-a3ef-95738561d55d",
  BardMS3rdOther = "175ceed7-5a53-4f48-823c-41c4f72d18ae",
  BardMS5thOther = "858d4322-9e9f-4aa4-aada-9c68835dc6fe",
  Cleric1stOther = "269d1a3b-eed8-4131-8901-a562238f5289",
  Cleric2ndOther = "2968a3e6-6c8a-4c2e-882a-ad295a2ad8ac",
  Cleric3rdOther = "21be0992-499f-4c7a-a77a-4430085e947a",
  Cleric4thOther = "37e9b20b-5fd1-45c5-b1c5-159c42397c83",
  Cleric5thOther = "b73aeea5-1ff9-4cac-b61d-b5aa6dfe31c2",
  Cleric6thOther = "f8ba7b05-1237-4eaa-97fa-1d3623d5862b",
  Druid1stOther = "2cd54137-2fe5-4100-aad3-df64735a8145",
  Druid2ndOther = "92126d17-7f1a-41d2-ae6c-a8d254d2b135",
  Druid3rdOther = "3156daf5-9266-41d0-b52c-5bc559a98654",
  Druid4thOther = "09c326c9-672c-4198-a4c0-6f07323bde27",
  Druid5thOther = "ff711c12-b59f-4fde-b9ea-6e5c38ec8f23",
  FighterEK1stOther = "32aeba85-13bd-4a6f-8e06-cd4447b746d8",
  FighterEK2ndOther = "4a86443c-6a21-4b8d-b1bf-55a99e021354",
  Paladin1stOther = "c6288ac5-c68b-40ed-bbdd-2ff388575831",
  Paladin3rdOther = "d18dec04-478f-41c3-b816-239d5cfcf2a2",
  Ranger1stOther = "458be063-60d4-4548-ae7d-50117fa0226f",
  Ranger2ndOther = "e7cfb80a-f5c2-4304-8446-9b00ea6a9814",
  Ranger3rdOther = "9a60f649-7f82-4152-90b1-0499c5c9f3e2",
  RogueAT2ndOther = "f9fd64f1-f417-4544-94a9-51d8876d68df",
  Sorcerer1stOther = "92c4751f-6255-4f67-822c-a75d53830b27",
  Sorcerer2ndOther = "f80396e2-cb76-4694-b0db-5c34da61a478",
  Sorcerer3rdOther = "dcbaf2ae-1f45-453e-ab83-cd154f8277a4",
  Sorcerer4thOther = "5fe40622-1d3e-4cc1-8d89-e66fe51d8c5c",
  Sorcerer5thOther = "3276fcfe-e143-4559-b6e0-7d7aa0ffcb53",
  Sorcerer6thOther = "1270a6db-980b-4e3b-bf26-2924da61dfd5",
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
  Warlock6thOther = "e6ccab5e-3b3b-4b34-8fa2-1058dff2b3e6",
  Wizard1stOther = "11f331b0-e8b7-473b-9d1f-19e8e4178d7d",
  Wizard2ndOther = "80c6b070-c3a6-4864-84ca-e78626784eb4",
  Wizard3rdOther = "22755771-ca11-49f4-b772-13d8b8fecd93",
  Wizard4thOther = "820b1220-0385-426d-ae15-458dc8a6f5c0",
  Wizard5thOther = "f781a25e-d288-43b4-bf5d-3d8d98846687",
  Wizard6thOther = "bc917f22-7f71-4a25-9a77-7d2f91a96a65"
}

local function OnStatsLoaded()
	local cantripadditions = {
	SSCantrips = {
	  Spells = spellSniper,
	  SpellListID = cantripList5ES.SpellSniper
	},
	BardCantrip = {
	  Spells = bardCantrips,
	  SpellListID = cantripList5ES.BardCantrip
	},
	ClericCantrip = {
	  Spells = clericCantrips,
	  SpellListID = cantripList5ES.ClericCantrip
	},
	DruidCantrip = {
	  Spells = druidCantrips,
	  SpellListID = cantripList5ES.DruidCantrip
	},
	SorcererCantrip = {
	  Spells = sorcererCantrips,
	  SpellListID = cantripList5ES.SorcererCantrip
	},
	WarlockCantrip = {
	  Spells = warlockCantrips,
	  SpellListID = cantripList5ES.WarlockCantrip
	},
	WizardCantrip = {
	  Spells = wizardCantrips,
	  SpellListID = cantripList5ES.WizardCantrip
	},
}

	local tcoeadditions = {
	Bard1stTCoE = {
	  Spells = bardSpells1stTCoE,
	  SpellListID = tcoeList5ES.Bard1stTCoE
	},
	Bard2ndTCoE = {
	  Spells = bardSpells2ndTCoE,
	  SpellListID = tcoeList5ES.Bard2ndTCoE
	},
	Bard3rdTCoE = {
	  Spells = bardSpells3rdTCoE,
	  SpellListID = tcoeList5ES.Bard3rdTCoE
	},
	Bard4thTCoE = {
	  Spells = bardSpells4thTCoE,
	  SpellListID = tcoeList5ES.Bard4thTCoE
	},
	Bard5thTCoE = {
	  Spells = bardSpells5thTCoE,
	  SpellListID = tcoeList5ES.Bard5thTCoE
	},
	Bard6thTCoE = {
	  Spells = bardSpells6thTCoE,
	  SpellListID = tcoeList5ES.Bard6thTCoE
	},
	BardMS3rdTCoE = {
	  Spells = bardMagicalSecrets3rdTCoE,
	  SpellListID = tcoeList5ES.BardMS3rdTCoE
	},
	BardMS5thTCoE = {
	  Spells = bardMagicalSecrets5thTCoE,
	  SpellListID = tcoeList5ES.BardMS5thTCoE
	},
	Cleric3rdTCoE = {
	  Spells = clericSpells3rdTCoE,
	  SpellListID = tcoeList5ES.Cleric3rdTCoE
	},
	Cleric6thTCoE = {
	  Spells = clericSpells6thTCoE,
	  SpellListID = tcoeList5ES.Cleric6thTCoE
	},
	Druid1stTCoE = {
	  Spells = druidSpells1stTCoE,
	  SpellListID = tcoeList5ES.Druid1stTCoE
	},
	Druid2ndTCoE = {
	  Spells = druidSpells2ndTCoE,
	  SpellListID = tcoeList5ES.Druid2ndTCoE
	},
	Druid3rdTCoE = {
	  Spells = druidSpells3rdTCoE,
	  SpellListID = tcoeList5ES.Druid3rdTCoE
	},
	Druid4thTCoE = {
	  Spells = druidSpells4thTCoE,
	  SpellListID = tcoeList5ES.Druid4thTCoE
	},
	Druid5thTCoE = {
	  Spells = druidSpells5thTCoE,
	  SpellListID = tcoeList5ES.Druid5thTCoE
	},
	Druid6thTCoE = {
	  Spells = druidSpells6thTCoE,
	  SpellListID = tcoeList5ES.Druid6thTCoE
	},
	Paladin2ndTCoE = {
	  Spells = paladinSpells2ndTCoE,
	  SpellListID = tcoeList5ES.Paladin2ndTCoE
	},
	Ranger2ndTCoE = {
	  Spells = rangerSpells2ndTCoE,
	  SpellListID = tcoeList5ES.Ranger2ndTCoE
	},
	Ranger3rdTCoE = {
	  Spells = rangerSpells3rdTCoE,
	  SpellListID = tcoeList5ES.Ranger3rdTCoE
	},
	Sorcerer1stTCoE = {
	  Spells = sorcererSpells1stTCoE,
	  SpellListID = tcoeList5ES.Sorcerer1stTCoE
	},
	Sorcerer2ndTCoE = {
	  Spells = sorcererSpells2ndTCoE,
	  SpellListID = tcoeList5ES.Sorcerer2ndTCoE
	},
	Sorcerer3rdTCoE = {
	  Spells = sorcererSpells3rdTCoE,
	  SpellListID = tcoeList5ES.Sorcerer3rdTCoE
	},
	Sorcerer4thTCoE = {
	  Spells = sorcererSpells4thTCoE,
	  SpellListID = tcoeList5ES.Sorcerer4thTCoE
	},
	Sorcerer5thTCoE = {
	  Spells = sorcererSpells5thTCoE,
	  SpellListID = tcoeList5ES.Sorcerer5thTCoE
	},
	Sorcerer6thTCoE = {
	  Spells = sorcererSpells6thTCoE,
	  SpellListID = tcoeList5ES.Sorcerer6thTCoE
	},
	Fiend5thTCoE = {
	  Spells = warlockSpells5thTCoE,
	  SpellListID = tcoeList5ES.WFiend5thTCoE
	},
	GoO5thTCoE = {
	  Spells = warlockSpells5thTCoE,
	  SpellListID = tcoeList5ES.WGoO5thTCoE
	},
	Archfey5thTCoE = {
	  Spells = warlockSpells5thTCoE,
	  SpellListID = tcoeList5ES.WArchfey5thTCoE
	},
	Wizard2ndTCoE = {
	  Spells = wizardSpells2ndTCoE,
	  SpellListID = tcoeList5ES.Wizard2ndTCoE
	},
	Wizard3rdTCoE = {
	  Spells = wizardSpells3rdTCoE,
	  SpellListID = tcoeList5ES.Wizard3rdTCoE
	},
	Wizard4thTCoE = {
	  Spells = wizardSpells4thTCoE,
	  SpellListID = tcoeList5ES.Wizard4thTCoE
	},
	Wizard5thTCoE = {
	  Spells = wizardSpells5thTCoE,
	  SpellListID = tcoeList5ES.Wizard5thTCoE
	},
	Wizard6thTCoE = {
	  Spells = wizardSpells6thTCoE,
	  SpellListID = tcoeList5ES.Wizard6thTCoE
	},
}

	local othersadditions = {
	RCSpells = {
	  Spells = ritualCaster,
	  SpellListID = othersList5ES.RitualCaster
	},
	Bard1stOther = {
	  Spells = bardSpells1stOther,
	  SpellListID = othersList5ES.Bard1stOther
	},
	Bard2ndOther = {
	  Spells = bardSpells2ndOther,
	  SpellListID = othersList5ES.Bard2ndOther
	},
	Bard3rdOther = {
	  Spells = bardSpells3rdOther,
	  SpellListID = othersList5ES.Bard3rdOther
	},
	Bard4thOther = {
	  Spells = bardSpells4thOther,
	  SpellListID = othersList5ES.Bard4thOther
	},
	Bard5thOther = {
	  Spells = bardSpells5thOther,
	  SpellListID = othersList5ES.Bard5thOther
	},
	Bard6thOther = {
	  Spells = bardSpells6thOther,
	  SpellListID = othersList5ES.Bard6thOther
	},
	BardMS3rdOther = {
	  Spells = bardMagicalSecrets3rdOther,
	  SpellListID = othersList5ES.BardMS3rdOther
	},
	BardMS5thOther = {
	  Spells = bardMagicalSecrets5thOther,
	  SpellListID = othersList5ES.BardMS5thOther
	},
	Cleric1stOther = {
	  Spells = clericSpells1stOther,
	  SpellListID = othersList5ES.Cleric1stOther
	},
	Cleric2ndOther = {
	  Spells = clericSpells2ndOther,
	  SpellListID = othersList5ES.Cleric2ndOther
	},
	Cleric3rdOther = {
	  Spells = clericSpells3rdOther,
	  SpellListID = othersList5ES.Cleric3rdOther
	},
	Cleric4thOther = {
	  Spells = clericSpells3rdOther,
	  SpellListID = othersList5ES.Cleric4thOther
	},
	Cleric5thOther = {
	  Spells = clericSpells5thOther,
	  SpellListID = othersList5ES.Cleric5thOther
	},
	Cleric6thOther = {
	  Spells = clericSpells6thOther,
	  SpellListID = othersList5ES.Cleric6thOther
	},
	Druid1stOther = {
	  Spells = druidSpells1stOther,
	  SpellListID = othersList5ES.Druid1stOther
	},
	Druid2ndOther = {
	  Spells = druidSpells2ndOther,
	  SpellListID = othersList5ES.Druid2ndOther
	},
	Druid3rdOther = {
	  Spells = druidSpells3rdOther,
	  SpellListID = othersList5ES.Druid3rdOther
	},
	Druid4thOther = {
	  Spells = druidSpells4thOther,
	  SpellListID = othersList5ES.Druid4thOther
	},
	Druid5thOther = {
	  Spells = druidSpells5thOther,
	  SpellListID = othersList5ES.Druid5thOther
	},
	FighterEK1stOther = {
	  Spells = fighterEKSpells1stOther,
	  SpellListID = othersList5ES.FighterEK1stOther
	},
	FighterEK2ndOther = {
	  Spells = fighterEKSpells2ndOther,
	  SpellListID = othersList5ES.FighterEK2ndOther
	},
	Paladin1stOther = {
	  Spells = paladinSpells1stOther,
	  SpellListID = othersList5ES.Paladin1stOther
	},
	Paladin3rdOther = {
	  Spells = paladinSpells3rdOther,
	  SpellListID = othersList5ES.Paladin3rdOther
	},
	Ranger1stOther = {
	  Spells = rangerSpells1stOther,
	  SpellListID = othersList5ES.Ranger1stOther
	},
	Ranger2ndOther = {
	  Spells = rangerSpells2ndOther,
	  SpellListID = othersList5ES.Ranger2ndOther
	},
	Ranger3rdOther = {
	  Spells = rangerSpells3rdOther,
	  SpellListID = othersList5ES.Ranger3rdOther
	},
	RogueAT2ndOther = {
	  Spells = rogueATSpells2ndOther,
	  SpellListID = othersList5ES.RogueAT2ndOther
	},
	Sorcerer1stOther = {
	  Spells = sorcererSpells1stOther,
	  SpellListID = othersList5ES.Sorcerer1stOther
	},
	Sorcerer2ndOther = {
	  Spells = sorcererSpells2ndOther,
	  SpellListID = othersList5ES.Sorcerer2ndOther
	},
	Sorcerer3rdOther = {
	  Spells = sorcererSpells3rdOther,
	  SpellListID = othersList5ES.Sorcerer3rdOther
	},
	Sorcerer4thOther = {
	  Spells = sorcererSpells4thOther,
	  SpellListID = othersList5ES.Sorcerer4thOther
	},
	Sorcerer5thOther = {
	  Spells = sorcererSpells5thOther,
	  SpellListID = othersList5ES.Sorcerer5thOther
	},
	Sorcerer6thOther = {
	  Spells = sorcererSpells6thOther,
	  SpellListID = othersList5ES.Sorcerer6thOther
	},
	Fiend1stOther = {
	  Spells = warlockSpells1stOther,
	  SpellListID = othersList5ES.WFiend1stOther
	},
	Fiend2ndOther = {
	  Spells = warlockSpells2ndOther,
	  SpellListID = othersList5ES.WFiend2ndOther
	},
	Fiend3rdOther = {
	  Spells = warlockSpells3rdOther,
	  SpellListID = othersList5ES.WFiend3rdOther
	},
	Fiend4thOther = {
	  Spells = warlockSpells4thOther,
	  SpellListID = othersList5ES.WFiend4thOther
	},
	Fiend5thOther = {
	  Spells = warlockSpells5thOther,
	  SpellListID = othersList5ES.WFiend5thOther
	},
	GoO1stOther = {
	  Spells = warlockSpells1stOther,
	  SpellListID = othersList5ES.WGoO1stOther
	},
	GoO2ndOther = {
	  Spells = warlockSpells2ndOther,
	  SpellListID = othersList5ES.WGoO2ndOther
	},
	GoO3rdOther = {
	  Spells = warlockSpells3rdOther,
	  SpellListID = othersList5ES.WGoO3rdOther
	},
	GoO4thOther = {
	  Spells = warlockSpells4thOther,
	  SpellListID = othersList5ES.WGoO4thOther
	},
	GoO5thOther = {
	  Spells = warlockSpells5thOther,
	  SpellListID = othersList5ES.WGoO5thOther
	},
	Archfey1stOther = {
	  Spells = warlockSpells1stOther,
	  SpellListID = othersList5ES.WArchfey1stOther
	},
	Archfey2ndOther = {
	  Spells = warlockSpells2ndOther,
	  SpellListID = othersList5ES.WArchfey2ndOther
	},
	Archfey3rdOther = {
	  Spells = warlockSpells3rdOther,
	  SpellListID = othersList5ES.WArchfey3rdOther
	},
	Archfey4thOther = {
	  Spells = warlockSpells4thOther,
	  SpellListID = othersList5ES.WArchfey4thOther
	},
	Archfey5thOther = {
	  Spells = warlockSpells5thOther,
	  SpellListID = othersList5ES.WArchfey5thOther
	},
	Warlock6thOther = {
	  Spells = warlockSpells6thOther,
	  SpellListID = othersList5ES.Warlock6thOther
	},
	Wizard1stOther = {
	  Spells = wizardSpells1stOther,
	  SpellListID = othersList5ES.Wizard1stOther
	},
	Wizard2ndOther = {
	  Spells = wizardSpells2ndOther,
	  SpellListID = othersList5ES.Wizard2ndOther
	},
	Wizard3rdOther = {
	  Spells = wizardSpells3rdOther,
	  SpellListID = othersList5ES.Wizard3rdOther
	},
	Wizard4thOther = {
	  Spells = wizardSpells4thOther,
	  SpellListID = othersList5ES.Wizard4thOther
	},
	Wizard5thOther = {
	  Spells = wizardSpells5thOther,
	  SpellListID = othersList5ES.Wizard5thOther
	},
	Wizard6thOther = {
	  Spells = wizardSpells6thOther,
	  SpellListID = othersList5ES.Wizard6thOther
	},
}

function formatting(file)
	local result = ""
	local space = 0
	local str = false
	local character = ""
	for i = 1, #file do
		character = file:sub(i, i)
		if character == '"' and file:sub(i - 1, i - 1) ~= "\\" then
			str = not str
		end

		if str then
			result = result .. character
		else
			if character == "{" or character == "[" then
				space = space + 2
				result = result .. character .. "\n" .. string.rep(" ", space)
			elseif character == "}" or character == "]" then
				space = space - 2
				result = result .. "\n" .. string.rep(" ", space) .. character
			elseif character == "," then
				result = result .. character .. "\n" .. string.rep(" ", space)
			else
				result = result .. character
			end
		end
	end
	return result
end

function writing()
	local default = '{"Spells":{"Cantrips":{"Enabled":true},"TCoE":{"Enabled":true},"AllOthers":{"Enabled":true}}}'
	local defaultJson = formatting(default)
	Ext.IO.SaveFile("5eSpells.json", defaultJson)
end

function reading()
	local status, file = pcall(Ext.IO.LoadFile, "5eSpells.json")
	if not status or not file then
		print(string.format("5eSpells: Creating configuration at %%LOCALAPPDATA%%\\Larian Studios\\Baldur's Gate 3\\Script Extender\\5eSpells.json"))
		writing()
		status, file = pcall(Ext.IO.LoadFile, "5eSpells.json")
		if not status or not file then
			print("ERROR: Failed to load config file after writing default config")
			return nil
		end
	end

	local status, result = pcall(Ext.Json.Parse, file)
	if not status then
		return nil
	end
	Table = result
end

reading()

	local tcoeconfig = Table["Spells"]["TCoE"]
	local cantripsconfig = Table["Spells"]["Cantrips"]
	local otherspellsconfig = Table["Spells"]["AllOthers"]
	local tcoeenabled = tcoeconfig["Enabled"]
	local cantripsenabled = cantripsconfig["Enabled"]
	local otherspellsenabled = otherspellsconfig["Enabled"]
	if	tcoeenabled == true then
		print(string.format("5eSpells: Tasha's Calduron of Everything (TCoE) spells config is enabled."))
		S5E_SpellLists(tcoeadditions)
	end

	if	cantripsenabled == true then
		print(string.format("5eSpells: Cantrips from 5eSpells config is enabled."))
		S5E_SpellLists(cantripadditions)
	end

	if	otherspellsenabled == true then
		print(string.format("5eSpells: Non-cantrip and non-TCoE spells from 5eSpells config is enabled."))
		S5E_SpellLists(othersadditions)
	end
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