local mod	= DBM:NewMod("Noth", "DBM-Naxx", 3)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(15954)
mod:SetEncounterID(1117)
mod:SetModelID(16590)
mod:RegisterCombat("combat_yell", L.Pull)

mod:RegisterEventsInCombat(
	"SPELL_CAST_SUCCESS 29213 54835",
	"CHAT_MSG_MONSTER_YELL"
)

--TODO, proper curse bar
--TODO, propper adds bars for balcony phase and finish timers for on ground phase for adds
local warnTeleportNow	= mod:NewAnnounce("WarningTeleportNow", 3, 46573)
local warnTeleportSoon	= mod:NewAnnounce("WarningTeleportSoon", 1, 46573)
local warnCurse			= mod:NewSpellAnnounce(29213, 2)

local specWarnAdds		= mod:NewSpecialWarningAdds(216726, "-Healer", nil, nil, 1, 2)

local timerTeleport		= mod:NewTimer(90, "TimerTeleport", 46573, nil, nil, 6)
local timerTeleportBack	= mod:NewTimer(70, "TimerTeleportBack", 46573, nil, nil, 6)
local timerCurseCD		= mod:NewAITimer(55, 29213, nil, nil, nil, 5, nil, DBM_CORE_CURSE_ICON)
local timerAddsCD		= mod:NewAddsTimer(25, 216726, nil, "-Healer")

mod.vb.teleCount = 0
mod.vb.addsCount = 0

function mod:OnCombatStart(delay)
	self.vb.teleCount = 0
	self:BackInRoom(delay)
end

function mod:Balcony()
	timerCurseCD:Stop()
	local timer
	if self.vb.teleCount == 1 then timer = 70
	elseif self.vb.teleCount == 2 then timer = 97
	elseif self.vb.teleCount == 3 then timer = 120
	else return	end
	timerTeleportBack:Show(timer)
	warnTeleportSoon:Schedule(timer - 20)
	warnTeleportNow:Schedule(timer)
	self:ScheduleMethod(timer, "BackInRoom")
end

function mod:BackInRoom(delay)
	delay = delay or 0
	self.vb.teleCount = self.vb.teleCount + 1
	self.vb.addsCount = 0
	local timer
	if self.vb.teleCount == 1 then timer = 90 - delay
	elseif self.vb.teleCount == 2 then timer = 110 - delay
	elseif self.vb.teleCount == 3 then timer = 180 - delay
	else return end
	timerTeleport:Show(timer)
	warnTeleportSoon:Schedule(timer - 20)
	warnTeleportNow:Schedule(timer)
	self:ScheduleMethod(timer, "Balcony")
	timerCurseCD:Start(1)
	timerAddsCD:Start(10)
end

function mod:SPELL_CAST_SUCCESS(args)
	if args:IsSpellID(29213, 54835) then	-- Curse of the Plaguebringer
		warnCurse:Show()
		timerCurseCD:Start()
	end
end

function mod:CHAT_MSG_MONSTER_YELL(msg, npc, _, _, target)
	if msg == L.Adds or msg:find(L.Adds) then
		self:SendSync("Adds")--Syncing to help unlocalized clients
	end
end

function mod:OnSync(msg, targetname)
	if not self:IsInCombat() then return end
	if msg == "Adds" then
		self.vb.addsCount = self.vb.addsCount + 1
		specWarnAdds:Show()
		specWarnAdds:Play("killmob")
		if self.vb.addsCount == 1 then
		--	timerAddsCD:Start()
		end
	end
end
