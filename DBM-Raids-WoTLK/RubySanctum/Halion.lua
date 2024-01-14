local mod	= DBM:NewMod("Halion", "DBM-Raids-WoTLK", 1)
local L		= mod:GetLocalizedStrings()

mod.statTypes = "normal,normal25,heroic,heroic25"

mod:SetRevision("@file-date-integer@")
mod:SetCreatureID(39863)--40142 (twilight form)
mod:SetEncounterID(mod:IsClassic() and 887 or 1150)
mod:SetModelID(31952)
mod:SetUsedIcons(7, 3)
mod:SetHotfixNoticeRev(20240113000000)
mod:SetMinSyncRevision(20240112000000)

mod:RegisterCombat("combat")
--mod:RegisterKill("yell", L.Kill)

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 74806 74525 75063",
	"SPELL_CAST_SUCCESS 74792 74562 75476",
	"SPELL_AURA_APPLIED 74792 74562",
	"SPELL_AURA_REMOVED 74792 74562",
	"SPELL_DAMAGE 74712 74717",
	"SPELL_MISSED 74712 74717",
	"CHAT_MSG_MONSTER_YELL",
	"RAID_BOSS_EMOTE",
	"UNIT_SPELLCAST_SUCCEEDED boss1 boss2",--Halion reports as two different bosses
	"UNIT_HEALTH boss1 boss2",
	"UNIT_AURA player"
)

--TODO, current code with AnnounceAlternatePhase will break mod if combat log is synced between phases
local warnPhase2Soon				= mod:NewPrePhaseAnnounce(2)
local warnPhase3Soon				= mod:NewPrePhaseAnnounce(3)
local warnPhase2					= mod:NewPhaseAnnounce(2)
local warnPhase3					= mod:NewPhaseAnnounce(3)
local warningShadowConsumption		= mod:NewTargetNoFilterAnnounce(74792, 4)
local warningFieryCombustion		= mod:NewTargetNoFilterAnnounce(74562, 4)
local warningMeteor					= mod:NewSpellAnnounce(74648, 3)
local warningShadowBreath			= mod:NewSpellAnnounce(74806, 2, nil, "Tank|Healer")
local warningFieryBreath			= mod:NewSpellAnnounce(74525, 2, nil, "Tank|Healer")
local warningTwilightCutter			= mod:NewAnnounce("TwilightCutterCast", 4, 74769, nil, nil, nil, 74769)

local specWarnShadowConsumption		= mod:NewSpecialWarningRun(74792, nil, nil, nil, 4, 2)
local yellShadowconsumption			= mod:NewYell(74792)
local specWarnFieryCombustion		= mod:NewSpecialWarningRun(74562, nil, nil, nil, 4, 2)
local yellFieryCombustion			= mod:NewYell(74562)
local specWarnMeteor				= mod:NewSpecialWarningSoon(74648, nil, nil, nil, 2, 2)
local specWarnTwilightCutter		= mod:NewSpecialWarningSpell(74769, nil, nil, nil, 3, 2)
local specWarnMeteorStrike			= mod:NewSpecialWarningGTFO(74648, nil, nil, nil, 1, 8)

local timerShadowConsumptionCD		= mod:NewCDTimer(25, 74792, nil, nil, nil, 3)--TODO, timer accuracy of normal
local timerFieryConsumptionCD		= mod:NewCDTimer(30.3, 74562, nil, nil, nil, 3)
local timerMeteorCD					= mod:NewNextTimer(40, 74648, nil, nil, nil, 3)--Target or aoe? tough call. It's a targeted aoe!
local timerMeteorCast				= mod:NewCastTimer(7, 74648, nil, nil, nil, 3)--7-8 seconds from boss yell the meteor impacts.
local timerTwilightCutterCast		= mod:NewCastTimer(4.5, 74769, nil, nil, nil, 3, nil, DBM_COMMON_L.DEADLY_ICON)
local timerTwilightCutter			= mod:NewBuffActiveTimer(10, 74769, nil, nil, nil, 6)
local timerTwilightCutterCD			= mod:NewNextTimer(15, 74769, nil, nil, nil, 6)
local timerShadowBreathCD			= mod:NewCDTimer(12.1, 74806, nil, "Tank|Healer", nil, 5, nil, DBM_COMMON_L.TANK_ICON)--12.1-19.4
local timerFieryBreathCD			= mod:NewCDTimer(12.1, 74525, nil, "Tank|Healer", nil, 5, nil, DBM_COMMON_L.TANK_ICON)--12.1-19.4

local berserkTimer					= mod:NewBerserkTimer(480)

mod:AddBoolOption("AnnounceAlternatePhase", true, "announce")
mod:AddSetIconOption("SetIconOnShadowConsumption", 74792, true, false, {3})--Purple diamond for shadow
mod:AddSetIconOption("SetIconOnFireConsumption", 74562, true, false, {7})--Red x for Fire

mod.vb.warned_preP2 = false
mod.vb.warned_preP3 = false
local playerInTwilight = false

local function updateBossDistance()
	if playerInTwilight then
		--Set twilight timers normal
		timerShadowConsumptionCD:SetFade(false)
		timerTwilightCutterCast:SetFade(false)
		timerTwilightCutter:SetFade(false)
		timerTwilightCutterCD:SetFade(false)
		timerShadowBreathCD:SetFade(false)
		--Set Fire timers faded
		timerFieryConsumptionCD:SetFade(true)
		timerMeteorCD:SetFade(true)
		timerMeteorCast:SetFade(true)
		timerFieryBreathCD:SetFade(true)
	else
		--Set twilight timers faded
		timerShadowConsumptionCD:SetFade(true)
		timerTwilightCutterCast:SetFade(true)
		timerTwilightCutter:SetFade(true)
		timerTwilightCutterCD:SetFade(true)
		timerShadowBreathCD:SetFade(true)
		--Set Fire timers normal
		timerFieryConsumptionCD:SetFade(false)
		timerMeteorCD:SetFade(false)
		timerMeteorCast:SetFade(false)
		timerFieryBreathCD:SetFade(false)
	end
end

function mod:OnCombatStart(delay)--These may still need retuning too, log i had didn't have pull time though.
	self.vb.warned_preP2 = false
	self.vb.warned_preP3 = false
	playerInTwilight = false
	updateBossDistance()
	self:SetStage(1)
	berserkTimer:Start(-delay)
	timerFieryBreathCD:Start(10-delay)
	timerFieryConsumptionCD:Start(15-delay)
	timerMeteorCD:Start(20-delay)
end

function mod:OnTimerRecovery()
	if DBM:UnitBuff("player", 136223) then
		playerInTwilight = true
		updateBossDistance()
	end
end

function mod:SPELL_CAST_START(args)
	if args.spellId == 74806 then
		if playerInTwilight or self.Options.AnnounceAlternatePhase then
			warningShadowBreath:Show()
		end
		timerShadowBreathCD:Start()
	elseif args.spellId == 74525 then
		if not playerInTwilight or self.Options.AnnounceAlternatePhase then
			warningFieryBreath:Show()
		end
		timerFieryBreathCD:Start()
	--"<240.45 02:11:23> [CLEU] SPELL_CAST_START#Creature-0-4401-724-10055-40142-000020C89D#Halion##nil#75063#Twilight Division#nil#nil", -- [40368]
	--"<240.66 02:11:23> [CHAT_MSG_MONSTER_YELL] I am the light and the darkness! Cower, mortals, before the herald of Deathwing!#Halion#####0#0##0#456#nil#0#false#false#false#false", -- [40414]
	elseif args.spellId == 75063 then
		self:SetStage(3)
		warnPhase3:Show()
		timerFieryConsumptionCD:Restart(20)--restart is used purely to avoid false debug on retail when boss is instantly phased into phase 3 in one attack (thus clipping P1 timer)
	end
end

function mod:SPELL_CAST_SUCCESS(args)--We use spell cast success for debuff timers in case it gets resisted by a player we still get CD timer for next one
	if args.spellId == 74792 then
		if self:IsDifficulty("heroic10", "heroic25") then
			timerShadowConsumptionCD:Start(20.6)
		else
			timerShadowConsumptionCD:Start()
		end
	elseif args.spellId == 74562 then
		if self:IsClassic() and self:IsDifficulty("heroic10", "heroic25") then
			timerFieryConsumptionCD:Start(20)
		else--On retail, even heroic is always every 30?
			timerFieryConsumptionCD:Start()--30
		end
	elseif args.spellId == 75476 then--Dusk Shroud (When stage 2 dragon is engaged. ie attacked by twilight realm tank)
		--Starting timers here is way more accurate than stage 2 trigger
		timerShadowConsumptionCD:Start(16.2)
		timerShadowBreathCD:Start(17.8)
		timerTwilightCutterCD:Start(30.9)
	end
end

function mod:SPELL_AURA_APPLIED(args)--We don't use spell cast success for actual debuff on >player< warnings since it has a chance to be resisted.
	if args.spellId == 74792 then
		if args:IsPlayer() then
			specWarnShadowConsumption:Show()
			specWarnShadowConsumption:Play("runout")
			yellShadowconsumption:Yell()
		elseif playerInTwilight or self.Options.AnnounceAlternatePhase then
			warningShadowConsumption:Show(args.destName)
		end
		if self.Options.SetIconOnShadowConsumption then
			self:SetIcon(args.destName, 3)
		end
	elseif args.spellId == 74562 then
		if args:IsPlayer() then
			specWarnFieryCombustion:Show()
			specWarnFieryCombustion:Play("runout")
			yellFieryCombustion:Yell()
		elseif not playerInTwilight or self.Options.AnnounceAlternatePhase then
			warningFieryCombustion:Show(args.destName)
		end
		if self.Options.SetIconOnFireConsumption then
			self:SetIcon(args.destName, 7)
		end
	end
end

function mod:SPELL_AURA_REMOVED(args)
	if args.spellId == 74792 then
		if self.Options.SetIconOnShadowConsumption then
			self:SetIcon(args.destName, 0)
		end
	elseif args.spellId == 74562 then
		if self.Options.SetIconOnFireConsumption then
			self:SetIcon(args.destName, 0)
		end
	end
end

function mod:SPELL_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId, spellName)
	if (spellId == 74712 or spellId == 74717) and destGUID == UnitGUID("player") and self:AntiSpam() then
		specWarnMeteorStrike:Show(spellName)
		specWarnMeteorStrike:Play("watchfeet")
	end
end
mod.SPELL_MISSED = mod.SPELL_DAMAGE

function mod:UNIT_HEALTH(uId)
	if not self.vb.warned_preP2 and self:GetUnitCreatureId(uId) == 39863 and UnitHealth(uId) / UnitHealthMax(uId) <= 0.79 then
		self.vb.warned_preP2 = true
		warnPhase2Soon:Show()
	elseif not self.vb.warned_preP3 and self:GetUnitCreatureId(uId) == 40142 and UnitHealth(uId) / UnitHealthMax(uId) <= 0.54 then
		self.vb.warned_preP3 = true
		warnPhase3Soon:Show()
	end
end

--Yells no longer required, but still faster, so kept since mostly translated already anyways. USCS will be used as backup
function mod:CHAT_MSG_MONSTER_YELL(msg)
	--"<153.64 02:09:56> [CHAT_MSG_MONSTER_YELL] You will find only suffering within the realm of twilight! Enter if you dare!#Halion#####0#0##0#441#nil#0#false#false#false#false", -- [20011]
	--"<155.94 02:09:59> [UNIT_SPELLCAST_SUCCEEDED] Halion(74.4%-0.0%){Target:??} -Twilight Phasing- [[boss1:Cast-3-4401-724-10055-74808-002B20C9A5:74808]]", -- [20547]
	--"<157.88 02:10:00> [CLEU] SPELL_CAST_SUCCESS#Creature-0-4401-724-10055-40142-000020C89D#Halion##nil#75476#Dusk Shroud#nil#nil", -- [20787]
	if msg == L.Phase2 or msg:find(L.Phase2) then
		self:SendSync("Phase2", "yell")
	--"<109.92 02:09:13> [CHAT_MSG_MONSTER_YELL] The heavens burn!#Halion#####0#0##0#436#nil#0#false#false#false#false", -- [6537]
	--"<110.79 02:09:13> [UNIT_SPELLCAST_SUCCEEDED] Halion(89.8%-0.0%){Target:Atlee} -Meteor Strike- [[boss1:Cast-3-4401-724-10055-74637-004CA0C979:74637]]", -- [6819]
	--"<117.06 02:09:20> [CLEU] SPELL_CAST_SUCCESS#Creature-0-4401-724-10055-40029-000020C97A#Meteor Strike##nil#74648#Meteor Strike#nil#nil", -- [8289]
	elseif msg == L.MeteorCast or msg:find(L.MeteorCast) then--There is no CLEU cast trigger for meteor, only yell and USCS. yell slightly faster
		if self:LatencyCheck() then
			self:SendSync("Meteor", "yell")
		end
	end
end

function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, spellId)
	if spellId == 74637 then--Meteor Strike
		if self:LatencyCheck() then
			self:SendSync("Meteor", "uscs")
		end
	elseif spellId == 74809 then--Classic can also use Twilight Phasing (74808) but retial cannot
		self:SendSync("Phase2", "uscs")
	end
end

function mod:RAID_BOSS_EMOTE(msg)
	if msg == L.twilightcutter or msg:find(L.twilightcutter) then
		if self:LatencyCheck() then
			self:SendSync("TwilightCutter")
		end
	end
end

function mod:UNIT_AURA(uId)
	local isTwilight = DBM:UnitBuff("player", 74807)
	if isTwilight and not playerInTwilight then
		playerInTwilight = true
		updateBossDistance()
	elseif not isTwilight and playerInTwilight then
		playerInTwilight = false
		updateBossDistance()
	end
end

function mod:OnSync(msg, target)
	if msg == "TwilightCutter" and self:AntiSpam(5, 1) then
		if playerInTwilight or self.Options.AnnounceAlternatePhase then
			warningTwilightCutter:Show()
		end
		if playerInTwilight then
			specWarnTwilightCutter:Schedule(5)
			specWarnTwilightCutter:ScheduleVoice(5, "farfromline")
		end
		timerTwilightCutterCD:Cancel()
		timerTwilightCutterCast:Start()
		timerTwilightCutter:Schedule(5)--Delay it since it happens 5 seconds after the emote
		timerTwilightCutterCD:Schedule(15)--It's every 30 sec, lasts 15, we schedule a 15 second timer to start in 15 seconds
	elseif msg == "Meteor" and self:AntiSpam(5, 2) then--Needs own antispam since core antispam won't filter yell and uscs at same event
		if not playerInTwilight then
			specWarnMeteor:Show()
			specWarnMeteor:Play("watchstep")
		elseif self.Options.AnnounceAlternatePhase then
			warningMeteor:Show()
		end
		if target and target == "uscs" then--Non yell phasing, ~1 seconds later
			timerMeteorCast:Start(6)--7 seconds from boss yell the meteor impacts.
			timerMeteorCD:Start(39)--40
		else
			timerMeteorCast:Start()--7 seconds from boss yell the meteor impacts.
			timerMeteorCD:Start()--40
		end
	elseif msg == "Phase2" and self:GetStage(2, 1) then--Syncing is still used because retail still requires yell
		self:SetStage(2)
		timerFieryConsumptionCD:Cancel()--Only one that stops, whoever stays tanking Fire haleion still deals with breaths and meteors
		warnPhase2:Show()
	end
end
