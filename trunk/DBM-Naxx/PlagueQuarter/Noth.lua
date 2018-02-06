local mod	= DBM:NewMod("Noth", "DBM-Naxx", 3)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(15954)
mod:SetEncounterID(1117)
mod:SetModelID(16590)
mod:RegisterCombat("combat")

mod:RegisterEvents(
	"CHAT_MSG_MONSTER_YELL"
)

mod:RegisterEventsInCombat(
	"SPELL_CAST_SUCCESS 29213 54835"
)

local warnTeleportNow	= mod:NewAnnounce("WarningTeleportNow", 3, 46573)
local warnTeleportSoon	= mod:NewAnnounce("WarningTeleportSoon", 1, 46573)
local warnCurse			= mod:NewSpellAnnounce(29213, 2)

local timerTeleport		= mod:NewTimer(90, "TimerTeleport", 46573, nil, nil, 6)
local timerTeleportBack	= mod:NewTimer(70, "TimerTeleportBack", 46573, nil, nil, 6)

mod.vb.teleCount = 0

function mod:OnCombatStart(delay)
	self.vb.teleCount = 0
	self:BackInRoom(delay)
end

function mod:Balcony()
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
	local timer
	if self.vb.teleCount == 1 then timer = 90 - delay
	elseif self.vb.teleCount == 2 then timer = 110 - delay
	elseif self.vb.teleCount == 3 then timer = 180 - delay
	else return end
	timerTeleport:Show(timer)
	warnTeleportSoon:Schedule(timer - 20)
	warnTeleportNow:Schedule(timer)
	self:ScheduleMethod(timer, "Balcony")
end

function mod:SPELL_CAST_SUCCESS(args)
	if args:IsSpellID(29213, 54835) then	-- Curse of the Plaguebringer
		warnCurse:Show()
	end
end

--Secondary pull trigger, so we can detect combat when he's pulled while already in combat (which is about 99% of time)
function mod:CHAT_MSG_MONSTER_YELL(msg)
	if msg == L.Pull and not self:IsInCombat() then
		DBM:StartCombat(self, 0)
	end
end
