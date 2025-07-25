local mod	= DBM:NewMod("Thorim", "DBM-Raids-WoTLK", 5)
local L		= mod:GetLocalizedStrings()

if not mod:IsClassic() then--on classic, it's normal10,normal25, defined in toc, only retail overrides to flex/timewalking
	mod.statTypes = "normal,timewalker"
end

mod:SetRevision("@file-date-integer@")
mod:SetCreatureID(32865)
if mod:IsPostCata() then
	mod:SetEncounterID(1141)
else
	mod:SetEncounterID(752)
end
mod:SetModelID(28977)
mod:SetUsedIcons(7)
mod:SetZone(603)

mod:RegisterCombat("combat_yell", L.YellPhase1)
mod:RegisterKill("yell", L.YellKill)

mod:RegisterEventsInCombat(
	"SPELL_AURA_APPLIED 62042 62130 62526 62527",
	"SPELL_CAST_SUCCESS 62042 62466 62130",
	"SPELL_DAMAGE 62017",
	"CHAT_MSG_MONSTER_YELL"
)

--TODO, add chain lightning timer, 8 seconds on classic and 12 on retail. Thanks blizzard for the details.
local warnPhase2					= mod:NewPhaseAnnounce(2, 1)
local warnStormhammer				= mod:NewTargetNoFilterAnnounce(62470, 2)
local warnLightningCharge			= mod:NewSpellAnnounce(62466, 2)
local warningBomb					= mod:NewTargetNoFilterAnnounce(62526, 4)

local yellBomb						= mod:NewYell(62526)
local specWarnLightningShock		= mod:NewSpecialWarningMove(62017, nil, nil, nil, 1, 2)
local specWarnUnbalancingStrikeSelf	= mod:NewSpecialWarningDefensive(62130, nil, nil, nil, 1, 2)
local specWarnUnbalancingStrike		= mod:NewSpecialWarningTaunt(62130, nil, nil, nil, 1, 2)

mod:AddBoolOption("AnnounceFails", false, "announce", nil, nil, nil, 62017)

local enrageTimer					= mod:NewBerserkTimer(369)
local timerStormhammer				= mod:NewBuffActiveTimer(16, 62042, nil, nil, nil, 3)--Cast timer? Review if i ever do this boss again.
local timerLightningCharge	 		= mod:NewCDTimer(16, 62466, nil, nil, nil, 3)
--local timerChainLightning	 		= mod:NewCDTimer(16, 62466, nil, nil, nil, 3)
local timerUnbalancingStrike		= mod:NewCDTimer(25.6, 62130, nil, "Tank", nil, 5, nil, DBM_COMMON_L.TANK_ICON)
local timerHardmode					= mod:NewTimer(175, "TimerHardmode", 62042)

mod:AddRangeFrameOption("8")
mod:AddSetIconOption("SetIconOnBomb", 62526, false, 0, {7})

local lastcharge = {}

function mod:OnCombatStart(delay)
	self:SetStage(1)
	enrageTimer:Start()
	timerHardmode:Start()
	if self.Options.RangeFrame then
		DBM.RangeCheck:Show(8)
	end
	table.wipe(lastcharge)
end

function mod:OnCombatEnd()
	if self.Options.RangeFrame then
		DBM.RangeCheck:Hide()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if args.spellId == 62042 and self:CheckBossDistance(args.sourceGUID, true, 34471) then--Within range of Vial of the Sunwell (43)
		warnStormhammer:Show(args.destName)
	elseif args.spellId == 62130 then
		if args:IsPlayer() then
			specWarnUnbalancingStrikeSelf:Show()
			specWarnUnbalancingStrikeSelf:Play("defensive")
		else
			specWarnUnbalancingStrike:Show(args.destName)
			specWarnUnbalancingStrike:Play("tauntboss")
		end
	elseif args:IsSpellID(62526, 62527) then
		warningBomb:Show(args.destName)
		if args:IsPlayer() then
			yellBomb:Yell()
		end
		if self.Options.SetIconOnBomb then
			self:SetIcon(args.destName, 7, 5)
		end
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	if args.spellId == 62042 then
		timerStormhammer:Schedule(2)
	elseif args.spellId == 62466 then
		warnLightningCharge:Show()
		timerLightningCharge:Start()
	elseif args.spellId == 62130 then
		timerUnbalancingStrike:Start(self:IsClassic() and 15 or 25)
	end
end

function mod:SPELL_DAMAGE(_, _, _, _, _, destName, destFlags, _, spellId)
	if spellId == 62017 then -- Lightning Shock
		if bit.band(destFlags, COMBATLOG_OBJECT_AFFILIATION_MINE) ~= 0
		and bit.band(destFlags, COMBATLOG_OBJECT_TYPE_PLAYER) ~= 0
		and self:AntiSpam(5) then
			specWarnLightningShock:Show()
			specWarnLightningShock:Play("runaway")
		end
	end
end

function mod:CHAT_MSG_MONSTER_YELL(msg)
	if msg == L.YellPhase2 then		-- Bossfight (tank and spank)
		self:SendSync("Phase2")
	end
end

function mod:OnSync(event, arg)
	if event == "Phase2" and self:GetStage(2, 1) then
		self:SetStage(2)
		warnPhase2:Show()
		enrageTimer:Stop()
		timerHardmode:Stop()
		timerUnbalancingStrike:Start(self:IsClassic() and 10 or 15)
		enrageTimer:Start(300)
	end
end
