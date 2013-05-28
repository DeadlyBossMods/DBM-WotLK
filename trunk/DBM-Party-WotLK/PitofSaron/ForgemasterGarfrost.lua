local mod	= DBM:NewMod("ForgemasterGarfrost", "DBM-Party-WotLK", 15)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(36494)
mod:SetModelID(30843)
mod:SetUsedIcons(8)
--mod:SetMinSyncRevision(4499)
mod:SetMinSyncRevision(7)--Could break if someone is running out of date version with higher revision

mod:RegisterCombat("combat")

mod:RegisterEvents(
	"SPELL_AURA_APPLIED",
	"SPELL_AURA_APPLIED_DOSE",
	"RAID_BOSS_WHISPER"
)

local warnForgeWeapon			= mod:NewSpellAnnounce(68785, 2)
local warnDeepFreeze			= mod:NewTargetAnnounce(70381, 2)
local warnSaroniteRock			= mod:NewAnnounce("warnSaroniteRock", 3, 68789)
local specWarnSaroniteRock		= mod:NewSpecialWarning("specWarnSaroniteRock")
local specWarnSaroniteRockNear	= mod:NewSpecialWarning("specWarnSaroniteRockNear")
local specWarnPermafrost		= mod:NewSpecialWarning("specWarnPermafrost")
local timerDeepFreeze			= mod:NewTargetTimer(14, 70381)

mod:AddBoolOption("SetIconOnSaroniteRockTarget", true)
mod:AddBoolOption("AchievementCheck", false, "announce")

local warnedfailed = false

function mod:OnCombatStart(delay)
	warnedfailed = false
end

function mod:SPELL_AURA_APPLIED(args)
	if args.spellId == 70381 then		-- Deep Freeze
		warnDeepFreeze:Show(args.destName)
		timerDeepFreeze:Start(args.destName)
	elseif args.spellId == 68785 then	-- Forge Frostborn Mace
		warnForgeWeapon:Show()
	end
end

function mod:SPELL_AURA_APPLIED_DOSE(args)
	if args.spellId == 68786 then
		if args.amount >= 9 and args:IsPlayer() and self:AntiSpam(5) then --11 stacks is what's needed for achievement, 9 to give you time to clear/dispel
			specWarnPermafrost:Show(args.spellName, args.amount)
		end
		if self.Options.AchievementCheck and not warnedfailed then
			if (args.amount or 1) == 9 or (args.amount or 1) == 10 then
				SendChatMessage(L.AchievementWarning:format(args.destName, (args.amount or 1)), "PARTY")
			elseif (args.amount or 1) > 11 then
				SendChatMessage(L.AchievementFailed:format(args.destName, (args.amount or 1)), "PARTY")
				warnedfailed = true
			end
		end
	end
end

function mod:SPELL_CREATE(args)
	if args.spellId == 68789 then		-- Saronite Rock
		warnSaroniteRock:Show()
	end
end

function mod:RAID_BOSS_WHISPER(msg) 
	if msg == L.SaroniteRockThrow or msg:match(L.SaroniteRockThrow) then 
		specWarnSaroniteRock:Show()
		self:SendSync("SaroniteRock", UnitGUID("player"))
	end 
end 

function mod:OnSync(msg, guid)
	local target
	if guid then
		target = DBM:GetFullPlayerNameByGUID(guid)
	end
	if msg == "SaroniteRock" and guid then
		if target then
			warnSaroniteRock:Show(target)
			local uId = DBM:GetRaidUnitId(target)
			if uId then
				local inRange = CheckInteractDistance(uId, 2)
				if inRange then
					specWarnSaroniteRockNear:Show()
				end
			end
			if self.Options.SetIconOnSaroniteRockTarget then
				self:SetIcon(target, 8, 5)
			end
		end
	end
end
