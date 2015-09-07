local mod	= DBM:NewMod(584, "DBM-Party-WotLK", 1, 271)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(29311)
mod:SetEncounterID(215, 263)
mod:SetZone()

mod:RegisterCombat("combat")

mod:RegisterEvents(
	"SPELL_CAST_START 60848"
)

mod:RegisterEventsInCombat(
	"UNIT_SPELLCAST_START target focus"
)

local warnShadowCrash			= mod:NewTargetAnnounce(60848, 4)
local warningInsanity			= mod:NewCastAnnounce(57496, 3)--Not currently working, no CLEU for it

local specWarnShadowCrash		= mod:NewSpecialWarningDodge(60848)
local specWarnShadowCrashNear	= mod:NewSpecialWarningClose(60848)
local yellShadowCrash			= mod:NewYell(62660)

local timerInsanity				= mod:NewCastTimer(5, 57496, nil, nil, nil, 6)--Not currently working, no CLEU for it
local timerAchieve				= mod:NewAchievementTimer(120, 1862, "TimerSpeedKill") 

function mod:OnCombatStart(delay)
	if not self:IsDifficulty("normal5") then
		timerAchieve:Start(-delay)
	end
end

function mod:ShadowCrashTarget(targetname, uId)
	if not targetname then
		if DBM.Options.DebugMode then
			warnShadowCrash:Show(DBM_CORE_UNKNOWN)
		end
		return
	end
	if self:AntiSpam(2, targetname) then--In case more than 1 pulled and target same person, avoid double/tripple warn
		if targetname == UnitName("player") then
			specWarnShadowCrash:Show()
			yellShadowCrash:Yell()
		elseif self:CheckNearby(5, targetname) then
			specWarnShadowCrashNear:Show(targetname)
		else
			warnShadowCrash:Show(targetname)
		end
	end
end

function mod:SPELL_CAST_START(args)
	if args.spellId == 60848 then
		self:BossTargetScanner(args.sourceGUID, "ShadowCrashTarget", 0.1, 12, nil, nil, nil, nil, true)
	end
end

function mod:UNIT_SPELLCAST_START(uId, spellName)
   if spellName == GetSpellInfo(57496) then -- Insanity
   		self:SendSync("Insanity")
   end
end

function mod:OnSync(event, arg)
	if event == "Insanity" then
		warningInsanity:Show()
		timerInsanity:Start()
	end
end
