local mod	= DBM:NewMod("Ick", "DBM-Party-WotLK", 15)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(36476)
mod:SetModelID(30347)
mod:SetUsedIcons(8)
--mod:SetMinSyncRevision(4343)
mod:SetMinSyncRevision(7)--Could break if someone is running out of date version with higher revision

mod:RegisterCombat("combat")

mod:RegisterEvents(
	"SPELL_CAST_START",
	"SPELL_AURA_APPLIED",
	"RAID_BOSS_EMOTE",
	"RAID_BOSS_WHISPER",
	"SPELL_PERIODIC_DAMAGE",
	"SPELL_PERIODIC_MISSED"
)

local warnPursuitCast			= mod:NewCastAnnounce(68987, 3)
local warnPoisonNova			= mod:NewCastAnnounce(68989, 3)
local warnPursuit				= mod:NewAnnounce("warnPursuit", 4, 68987)

local specWarnToxic				= mod:NewSpecialWarningMove(69024)
local specWarnMines				= mod:NewSpecialWarningRun(69015)
local specWarnPursuit			= mod:NewSpecialWarning("specWarnPursuit")
local specWarnPoisonNova		= mod:NewSpecialWarningRun(68989, mod:IsMelee())

local timerPursuitCast			= mod:NewCastTimer(5, 68987)
local timerPursuitConfusion		= mod:NewBuffActiveTimer(12, 69029)
local timerPoisonNova			= mod:NewCastTimer(5, 68989)

local soundPoisonNova			= mod:NewSound(68989, nil, mod:IsMelee())
local soundPursuit				= mod:NewSound(68987)
mod:AddBoolOption("SetIconOnPursuitTarget", true)

local guids = {}
local function buildGuidTable()
	table.wipe(guids)
	guids[UnitGUID("player")] = DBM:GetUnitFullName("player")
	for i = 1, DBM:GetNumGroupMembers() do
		guids[UnitGUID("party"..i) or "none"] = DBM:GetUnitFullName("party"..i)
	end
end

function mod:OnCombatStart(delay)
	buildGuidTable()
end

function mod:SPELL_CAST_START(args)
	if args.spellId == 68987 then							-- Pursuit
		warnPursuitCast:Show()
		timerPursuitCast:Start()
	elseif args.spellId == 68989 then				-- Poison Nova
		warnPoisonNova:Show()
		timerPoisonNova:Start()
		specWarnPoisonNova:Show()
		soundPoisonNova:Play()
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
	if msg == L.IckPursuit or msg:find(L.IckPursuit) then 
		specWarnPursuit:Show() 
		soundPursuit:Play()
		self:SendSync("Pursuit", UnitGUID("player"))
	end 
end 

function mod:OnSync(msg, guid) 
	if msg == "Pursuit" and guid then 
		local target = guids[guid]
		if target then
			warnPursuit:Show(target)
			if self.Options.SetIconOnPursuitTarget then 
				self:SetIcon(target, 8, 12) 
			end
		end
	end 
end 