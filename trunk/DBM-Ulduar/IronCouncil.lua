local mod	= DBM:NewMod("IronCouncil", "DBM-Ulduar")
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(32867, 32927, 32857)
mod:SetEncounterID(1140)
mod:DisableEEKillDetection()--Fires for first one dying not last
mod:SetModelID(28344)
mod:SetUsedIcons(1, 2, 3, 4, 5, 6, 7, 8)

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 61920 63479 61879 63483 61915 61903 63493 62274 63489 62273",
	"SPELL_CAST_SUCCESS 63490 62269 64321 61974 61869 63481",
	"SPELL_AURA_APPLIED 61903 63493 62269 63490 62277 63967 64637 61888 63486 61887 61912 63494",
	"UNIT_DIED"
)

mod:AddBoolOption("HealthFrame", true)

mod:SetBossHealthInfo(
	32867, L.Steelbreaker,
	32927, L.RunemasterMolgeim,
	32857, L.StormcallerBrundir
)

--TODO, needs some work to determing timers for timewalker mode, since don't know if TW based on 35 or 60 second fight design.
--For now, will assume TW will always lean oward easier so using 60 for timewalking
--TODO, see if EE is fixed for encounter
local warnSupercharge			= mod:NewSpellAnnounce(61920, 3)

-- Stormcaller Brundir
-- High Voltage ... 63498
local warnChainlight			= mod:NewSpellAnnounce(64215, 1)
local timerOverload				= mod:NewCastTimer(6, 63481)
local timerLightningWhirl		= mod:NewCastTimer(5, 63483)
local specwarnLightningTendrils	= mod:NewSpecialWarningRun(63486, nil, nil, nil, 4, 2)
local timerLightningTendrils	= mod:NewBuffActiveTimer(27, 63486, nil, nil, nil, 6)
local voiceLightningTendrils	= mod:NewVoice(63486)--justrun
local specwarnOverload			= mod:NewSpecialWarningRun(63481, nil, nil, nil, 4)
local voiceOverload				= mod:NewVoice(63481)--runout
mod:AddBoolOption("AlwaysWarnOnOverload", false, "announce")

-- Steelbreaker
-- High Voltage ... don't know what to show here - 63498
local warnFusionPunch			= mod:NewSpellAnnounce(61903, 4)
local timerFusionPunchCast		= mod:NewCastTimer(3, 61903)
local timerFusionPunchActive	= mod:NewTargetTimer(4, 61903)
local warnOverwhelmingPower		= mod:NewTargetAnnounce(61888, 2)
local timerOverwhelmingPower	= mod:NewTargetTimer(25, 61888)
local warnStaticDisruption		= mod:NewTargetAnnounce(61912, 3) 
mod:AddBoolOption("SetIconOnOverwhelmingPower", false)
mod:AddBoolOption("SetIconOnStaticDisruption", false)

-- Runemaster Molgeim
-- Lightning Blast ... don't know, maybe 63491
local timerRuneofShields		= mod:NewBuffActiveTimer(15, 63967)
local warnRuneofPower			= mod:NewTargetAnnounce(64320, 2)
local warnRuneofDeath			= mod:NewSpellAnnounce(63490, 2)
local warnShieldofRunes			= mod:NewSpellAnnounce(63489, 2)
local warnRuneofSummoning		= mod:NewSpellAnnounce(62273, 3)
local specwarnRuneofDeath		= mod:NewSpecialWarningMove(63490)
local voiceRuneofDeath			= mod:NewVoice(63490)--runaway
local specWarnRuneofShields		= mod:NewSpecialWarningDispel(63967, "MagicDispeller")
local voiceRuneofShields		= mod:NewVoice(63967, "MagicDispeller")--dispelboss
local timerRuneofDeath			= mod:NewCDTimer(30, 63490, nil, nil, nil, 3)
local timerRuneofPower			= mod:NewCDTimer(30, 61974, nil, nil, nil, 5)

local enrageTimer				= mod:NewBerserkTimer(900)

local disruptTargets = {}
mod.vb.disruptIcon = 7
--local bosskilled = 0
local scansDone = 0

function mod:OnCombatStart(delay)
	enrageTimer:Start(-delay)
	table.wipe(disruptTargets)
	self.vb.disruptIcon = 7
--	bosskilled = 0
	scansDone = 0
end

function mod:RuneTarget(targetname, uId)
	if not targetname then return end
	warnRuneofPower:Show(targetname)
end

local function warnStaticDisruptionTargets(self)
	warnStaticDisruption:Show(table.concat(disruptTargets, "<, >"))
	table.wipe(disruptTargets)
	self.vb.disruptIcon = 7
end

function mod:SPELL_CAST_START(args)
	if args.spellId == 61920 then -- Supercharge - Unleashes one last burst of energy as the caster dies, increasing all allies damage by 25% and granting them an additional ability.	
		warnSupercharge:Show()
	elseif args:IsSpellID(63479, 61879) then	-- Chain light
		warnChainlight:Show()
	elseif args:IsSpellID(63483, 61915) then	-- LightningWhirl
		timerLightningWhirl:Start()
	elseif args:IsSpellID(61903, 63493) then	-- Fusion Punch
		warnFusionPunch:Show()
		timerFusionPunchCast:Start()
	elseif args:IsSpellID(62274, 63489) then	-- Shield of Runes
		warnShieldofRunes:Show()
	elseif args.spellId == 62273 then			-- Rune of Summoning
		warnRuneofSummoning:Show()
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	if args:IsSpellID(63490, 62269) then		-- Rune of Death
		warnRuneofDeath:Show()
		voiceRuneofDeath:Play("runaway")
		timerRuneofDeath:Start()
	elseif args:IsSpellID(64321, 61974) then	-- Rune of Power
		scansDone = 0
		self:RuneTarget()
		self:BossTargetScanner(32927, "RuneTarget", 0.1, 16, true, true)--Scan only boss unitIDs, scan only hostile targets
		timerRuneofPower:Start()
	elseif args:IsSpellID(61869, 63481) then	-- Overload
		timerOverload:Start()
		if self.Options.AlwaysWarnOnOverload or UnitGUID("target") == args.sourceGUID then
			specwarnOverload:Show()
			voiceOverload:Play("runout")
		end
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if args:IsSpellID(61903, 63493) then		-- Fusion Punch
		timerFusionPunchActive:Start(args.destName)
	elseif args:IsSpellID(62269, 63490) then	-- Rune of Death - move away from it
		if args:IsPlayer() then
			specwarnRuneofDeath:Show()
		end
	elseif args:IsSpellID(62277, 63967) and not args:IsDestTypePlayer() then		-- Shield of Runes
		specWarnRuneofShields:Show(args.destName)
		voiceRuneofShields:Play("dispelboss")
		timerRuneofShields:Start()
	elseif args:IsSpellID(64637, 61888) then	-- Overwhelming Power
		warnOverwhelmingPower:Show(args.destName)
		if self:IsDifficulty("normal10", "timewalker") then
			timerOverwhelmingPower:Start(60, args.destName)
		else
			timerOverwhelmingPower:Start(35, args.destName)
		end
		if self.Options.SetIconOnOverwhelmingPower then
			if self:IsDifficulty("normal10", "timewalker") then
				self:SetIcon(args.destName, 8, 60) -- skull for 60 seconds (until meltdown)
			else
				self:SetIcon(args.destName, 8, 35) -- skull for 35 seconds (until meltdown)
			end
		end
	elseif args:IsSpellID(63486, 61887) then	-- Lightning Tendrils
		timerLightningTendrils:Start()
		specwarnLightningTendrils:Show()
		voiceLightningTendrils:Play("justrun")
	elseif args:IsSpellID(61912, 63494) then	-- Static Disruption (Hard Mode)
		disruptTargets[#disruptTargets + 1] = args.destName
		if self.Options.SetIconOnStaticDisruption then 
			self:SetIcon(args.destName, self.vb.disruptIcon, 20)
		end
		self.vb.disruptIcon = self.vb.disruptIcon - 1
		self:Unschedule(warnStaticDisruptionTargets)
		self:Schedule(0.3, warnStaticDisruptionTargets, self)
	end
end

function mod:UNIT_DIED(args)
	local cid = self:GetCIDFromGUID(args.destGUID)
	if cid == 32867 then		--Steelbreaker
		timerFusionPunchCast:Cancel()
--		bosskilled = bosskilled + 1
	elseif cid == 32927 then	--Runemaster
		timerRuneofDeath:Cancel()
		timerRuneofPower:Cancel()
--		bosskilled = bosskilled + 1
	elseif cid == 32857 then	--Stormcaller
		timerOverload:Cancel()
		timerLightningWhirl:Cancel()
--		bosskilled = bosskilled + 1
	end
--	if bosskilled == 3 then
--		DBM:EndCombat(self)
--	end
end