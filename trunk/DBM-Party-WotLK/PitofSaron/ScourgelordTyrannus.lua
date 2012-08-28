local mod	= DBM:NewMod("ScourgelordTyrannus", "DBM-Party-WotLK", 15)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 4373 $"):sub(12, -3))
mod:SetCreatureID(36658, 36661)
mod:SetModelID(30277)
mod:SetUsedIcons(8)

mod:RegisterCombat("yell", L.CombatStart)
mod:RegisterKill("yell", L.YellCombatEnd)
mod:SetMinCombatTime(40)

mod:RegisterEvents(
	"SPELL_CAST_START",
	"SPELL_CAST_SUCCESS",
	"SPELL_AURA_APPLIED",
	"CHAT_MSG_RAID_BOSS_EMOTE",
	"SPELL_PERIODIC_DAMAGE",
	"SPELL_PERIODIC_MISSED"
)

local warnUnholyPower			= mod:NewSpellAnnounce(69167, 3)
local warnForcefulSmash			= mod:NewSpellAnnounce(69155, 2)
local warnOverlordsBrand		= mod:NewTargetAnnounce(69172, 4)
local warnHoarfrost				= mod:NewTargetAnnounce(69246, 2)

local specWarnHoarfrost			= mod:NewSpecialWarning("specWarnHoarfrost")
local specWarnHoarfrostNear		= mod:NewSpecialWarning("specWarnHoarfrostNear")
local specWarnIcyBlast			= mod:NewSpecialWarningMove(69238)
local specWarnOverlordsBrand	= mod:NewSpecialWarningYou(69172)

local timerCombatStart			= mod:NewTimer(31, "TimerCombatStart", 2457)
local timerOverlordsBrand		= mod:NewTargetTimer(8, 69172)
local timerUnholyPower			= mod:NewBuffActiveTimer(10, 69167)
local timerForcefulSmash		= mod:NewCDTimer(50, 69155) --hotfixed? new combat logs show it every 50 seconds'ish.

mod:AddBoolOption("SetIconOnHoarfrostTarget", true)

function mod:OnCombatStart(delay)
	timerCombatStart:Start(-delay)
	timerForcefulSmash:Start(40-delay)
end

function mod:SPELL_CAST_START(args)
	if args:IsSpellID(69167, 69629) then					-- Unholy Power
        warnUnholyPower:Show()
		timerUnholyPower:Start()
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	if args:IsSpellID(69155, 69627) then					-- Forceful Smash
        warnForcefulSmash:Show()
        timerForcefulSmash:Start()
	end
end

function mod:SPELL_PERIODIC_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId)
	if (spellId == 69238 or spellId == 69628) and destGUID == UnitGUID("player") and self:AntiSpam() then		-- Icy Blast, MOVE!
		specWarnIcyBlast:Show()
	end
end
mod.SPELL_PERIODIC_MISSED = mod.SPELL_PERIODIC_DAMAGE

function mod:SPELL_AURA_APPLIED(args)
	if args:IsSpellID(69172) then							-- Overlord's Brand
		warnOverlordsBrand:Show(args.destName)
		timerOverlordsBrand:Start(args.destName)
		if args:IsPlayer() then
			specWarnOverlordsBrand:Show()
		end
	end
end

function mod:CHAT_MSG_RAID_BOSS_EMOTE(msg, _, _, _, target)
	if msg == L.HoarfrostTarget or msg:find(L.HoarfrostTarget) then
		if not target then return end
		warnHoarfrost:Show(target)
		if target == UnitName("player") then
			specWarnHoarfrost:Show()
		elseif target then
			local uId = DBM:GetRaidUnitId(target)
			if uId then
				local inRange = CheckInteractDistance(uId, 2)
				if inRange then
					specWarnHoarfrostNear:Show()
				end
			end
		end
		if self.Options.SetIconOnHoarfrostTarget then
			self:SetIcon(target, 8, 5)
		end
	end
end