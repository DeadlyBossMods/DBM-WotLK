local mod	= DBM:NewMod(609, "DBM-Party-WotLK", 15, 278)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(36476)
mod:SetEncounterID(835, 836)
mod:SetUsedIcons(8)
mod:SetMinSyncRevision(7)--Could break if someone is running out of date version with higher revision

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 68987 68989",
	"SPELL_AURA_APPLIED 69029",
	"SPELL_PERIODIC_DAMAGE 69024",
	"SPELL_PERIODIC_MISSED 69024",
	"RAID_BOSS_EMOTE",
	"RAID_BOSS_WHISPER",
	"CHAT_MSG_ADDON"
)

local warnPursuitCast			= mod:NewCastAnnounce(68987, 3)
local warnPursuit				= mod:NewTargetAnnounce(68987, 4)--TODO, just switch to UNIT_AURA, syncing not reliable especially with older zones.

local specWarnToxic				= mod:NewSpecialWarningMove(69024)
local specWarnMines				= mod:NewSpecialWarningSpell(69015, nil, nil, nil, 2)
local specWarnPursuit			= mod:NewSpecialWarningRun(68987, nil, nil, 2, 4)
local specWarnPoisonNova		= mod:NewSpecialWarningRun(68989, "Melee", nil, 2, 4)

local timerPursuitCast			= mod:NewCastTimer(5, 68987)
local timerPursuitConfusion		= mod:NewBuffActiveTimer(12, 69029)
local timerPoisonNova			= mod:NewCastTimer(5, 68989, nil, "Melee", 2, 2)

mod:AddBoolOption("SetIconOnPursuitTarget", true)

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 68987 then							-- Pursuit
		warnPursuitCast:Show()
		timerPursuitCast:Start()
	elseif spellId == 68989 then				-- Poison Nova
		timerPoisonNova:Start()
		specWarnPoisonNova:Show()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if args.spellId == 69029 then							-- Pursuit Confusion
		timerPursuitConfusion:Show(args.destName)
	end
end

function mod:SPELL_PERIODIC_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId)
	if spellId == 69024 and destGUID == UnitGUID("player") and self:AntiSpam() then
		specWarnToxic:Show()
	end
end
mod.SPELL_PERIODIC_MISSED = mod.SPELL_PERIODIC_DAMAGE

function mod:RAID_BOSS_EMOTE(msg)
	if msg == L.Barrage or msg:find(L.IckPursuit) then
		specWarnMines:Show()
	end
end

function mod:RAID_BOSS_WHISPER(msg) 
--	if msg == L.IckPursuit or msg:find(L.IckPursuit) then 
		specWarnPursuit:Show() 
--	end 
end

--per usual, use transcriptor message to get messages from both bigwigs and DBM, all without adding comms to this mod at all
function mod:CHAT_MSG_ADDON(prefix, msg, channel, targetName)
	if prefix ~= "Transcriptor" then return end
	--See if this can be done with an icon string or spellid string in sync message
	if msg == L.IckPursuit or msg:find(L.IckPursuit) then
		targetName = Ambiguate(targetName, "none")
		if self:AntiSpam(5, targetName) then--Antispam sync by target name, since this doesn't use dbms built in onsync handler.
			warnPursuit:Show(targetName)
			if self.Options.SetIconOnPursuitTarget then 
				self:SetIcon(target, 8, 12) 
			end
		end
	end
end
