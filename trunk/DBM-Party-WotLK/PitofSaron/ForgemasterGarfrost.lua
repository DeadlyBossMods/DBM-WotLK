local mod	= DBM:NewMod(608, "DBM-Party-WotLK", 15, 278)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(36494)
mod:SetEncounterID(833, 834)
mod:SetUsedIcons(8)
mod:SetMinSyncRevision(7)--Could break if someone is running out of date version with higher revision

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_AURA_APPLIED 70381 68785",
	"SPELL_AURA_APPLIED_DOSE 68786",
	"RAID_BOSS_WHISPER",
	"CHAT_MSG_ADDON"
)

local warnForgeWeapon			= mod:NewSpellAnnounce(68785, 2)
local warnDeepFreeze			= mod:NewTargetAnnounce(70381, 2)
local warnSaroniteRock			= mod:NewTargetAnnounce(68789, 3)

local specWarnSaroniteRock		= mod:NewSpecialWarningYou(68789)
local yellRock					= mod:NewYell(68789)
local specWarnSaroniteRockNear	= mod:NewSpecialWarningClose(68789)
local specWarnPermafrost		= mod:NewSpecialWarningStack(68786, nil, 9)

local timerDeepFreeze			= mod:NewTargetTimer(14, 70381, nil, "Healer", 2)

mod:AddBoolOption("SetIconOnSaroniteRockTarget", true)
mod:AddBoolOption("AchievementCheck", false, "announce")

local warnedfailed = false

function mod:OnCombatStart(delay)
	warnedfailed = false
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 70381 then		-- Deep Freeze
		warnDeepFreeze:Show(args.destName)
		timerDeepFreeze:Start(args.destName)
	elseif spellId == 68785 then	-- Forge Frostborn Mace
		warnForgeWeapon:Show()
	end
end

function mod:SPELL_AURA_APPLIED_DOSE(args)
	if args.spellId == 68786 then
		local amount = args.amount or 1
		if amount >= 9 and args:IsPlayer() and self:AntiSpam(5) then --11 stacks is what's needed for achievement, 9 to give you time to clear/dispel
			specWarnPermafrost:Show(args.spellName, amount)
		end
		if self.Options.AchievementCheck and not warnedfailed then
			if amount == 9 or amount == 10 then
				SendChatMessage(L.AchievementWarning:format(args.destName, amount), "PARTY")
			elseif amount > 11 then
				SendChatMessage(L.AchievementFailed:format(args.destName, amount), "PARTY")
				warnedfailed = true
			end
		end
	end
end

function mod:RAID_BOSS_WHISPER(msg)
	--Commented out string check for now, since it should be the only thing on fight sending RAID_BOSS_WHISPER
--	if msg == L.SaroniteRockThrow or msg:match(L.SaroniteRockThrow) then
		specWarnSaroniteRock:Show()
		yellRock:Yell()
--	end 
end

--per usual, use transcriptor message to get messages from both bigwigs and DBM, all without adding comms to this mod at all
function mod:CHAT_MSG_ADDON(prefix, msg, channel, targetName)
	if prefix ~= "Transcriptor" then return end
	--See if this can be done with an icon string or spellid string in sync message
	if msg == L.SaroniteRockThrow or msg:find(L.SaroniteRockThrow) then
		targetName = Ambiguate(targetName, "none")
		if self:AntiSpam(5, targetName) then--Antispam sync by target name, since this doesn't use dbms built in onsync handler.
			warnSaroniteRock:Show(targetName)
			local uId = DBM:GetRaidUnitId(targetName)
			if uId then
				local inRange = CheckInteractDistance(uId, 2)
				if inRange then
					specWarnSaroniteRockNear:Show(targetName)
				end
			end
			if self.Options.SetIconOnSaroniteRockTarget then
				self:SetIcon(target, 8, 5)
			end
		end
	end
end
