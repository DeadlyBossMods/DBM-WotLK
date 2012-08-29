local mod	= DBM:NewMod("FlameLeviathan", "DBM-Ulduar")
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 4182 $"):sub(12, -3))

mod:SetCreatureID(33113)
mod:SetModelID(28875)
mod:RegisterCombat("yell", L.YellPull)
mod:SetMinSyncRevision(4182)

mod:RegisterEvents(
	"SPELL_AURA_REMOVED",
	"SPELL_AURA_APPLIED",
	"SPELL_SUMMON"
)

local warnHodirsFury		= mod:NewTargetAnnounce(62297)
local pursueTargetWarn		= mod:NewAnnounce("PursueWarn", 2, 62374)
local warnNextPursueSoon	= mod:NewAnnounce("warnNextPursueSoon", 3, 62374)

local warnSystemOverload	= mod:NewSpecialWarningSpell(62475)
local pursueSpecWarn		= mod:NewSpecialWarning("SpecialPursueWarnYou")
local warnWardofLife		= mod:NewSpecialWarning("warnWardofLife")

local timerSystemOverload	= mod:NewBuffActiveTimer(20, 62475)
local timerFlameVents		= mod:NewCastTimer(10, 62396)
local timerPursued			= mod:NewBuffFadesTimer(30, 62374)

local soundPursued			= mod:NewSound(62374)

local guids = {}
local function buildGuidTable()
	table.wipe(guids)
	for i = 1, DBM:GetGroupMembers() do
		guids[UnitGUID("raid"..i.."pet") or "none"] = GetRaidRosterInfo(i)
	end
end

function mod:OnCombatStart(delay)
	buildGuidTable()
end

function mod:SPELL_SUMMON(args)
	if args:IsSpellID(62907) then		-- Ward of Life spawned (Creature id: 34275)
		warnWardofLife:Show()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if args:IsSpellID(62396) then		-- Flame Vents
		timerFlameVents:Start()
	elseif args:IsSpellID(62475) then	-- Systems Shutdown / Overload
		timerSystemOverload:Start()
		warnSystemOverload:Show()
	elseif args:IsSpellID(62374) then	-- Pursued
		local target = guids[args.destGUID]
		warnNextPursueSoon:Schedule(25)
		timerPursued:Start()
		if target then
			pursueTargetWarn:Show(target)
			if target == UnitName("player") then
				pursueSpecWarn:Show()
				soundPursued:Play()
			end
		end
	elseif args:IsSpellID(62297) then		-- Hodir's Fury (Person is frozen)
		local target = guids[args.destGUID]
		if target then
			warnHodirsFury:Show(target)
		end
	end
end

function mod:SPELL_AURA_REMOVED(args)
	if args:IsSpellID(62396) then
		timerFlameVents:Stop()
	end
end