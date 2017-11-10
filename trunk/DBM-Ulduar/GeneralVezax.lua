local mod	= DBM:NewMod("GeneralVezax", "DBM-Ulduar")
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(33271)
mod:SetEncounterID(1134)
mod:SetModelID(28548)
mod:SetUsedIcons(7, 8)

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 62661 62662",
	"SPELL_INTERRUPT 62661",
	"SPELL_AURA_APPLIED 62662",
	"SPELL_AURA_REMOVED 62662",
	"SPELL_CAST_SUCCESS 62660 63276",
	"RAID_BOSS_EMOTE"
)

local warnShadowCrash			= mod:NewTargetAnnounce(62660, 4)
local warnLeechLife				= mod:NewTargetAnnounce(63276, 3)

local specWarnShadowCrash		= mod:NewSpecialWarningDodge(62660, nil, nil, nil, 1, 2)
local specWarnShadowCrashNear	= mod:NewSpecialWarningClose(62660, nil, nil, nil, 1, 2)
local yellShadowCrash			= mod:NewYell(62660)
local specWarnSurgeDarkness		= mod:NewSpecialWarningDefensive(62662, "Tank", nil, nil, 1, 2)
local specWarnLifeLeechYou		= mod:NewSpecialWarningYou(63276, nil, nil, nil, 3, 2)
local specWarnLifeLeechNear 	= mod:NewSpecialWarningClose(63276, false, nil, nil, 1, 2)
local yellLifeLeech				= mod:NewYell(63276)

local timerEnrage				= mod:NewBerserkTimer(600)
local timerSearingFlamesCast	= mod:NewCastTimer(2, 62661, nil, nil, nil, 4)
local timerSurgeofDarkness		= mod:NewBuffActiveTimer(10, 62662, nil, "Tank")
local timerNextSurgeofDarkness	= mod:NewCDTimer(62, 62662, nil, "Tank", nil, 5)
local timerSaroniteVapors		= mod:NewNextTimer(30, 63322, nil, nil, nil, 5)
local timerLifeLeech			= mod:NewTargetTimer(10, 63276)
local timerHardmode				= mod:NewTimer(189, "hardmodeSpawn", nil, nil, nil, 1)

local voiceShadowCrash			= mod:NewVoice(62660)--runaway
local voiceSurgeDarkness		= mod:NewVoice(62662, "Tank")--defensive
local voiceLifeLeech			= mod:NewVoice(63276)--runout/runaway

mod:AddBoolOption("SetIconOnShadowCrash", true)
mod:AddBoolOption("SetIconOnLifeLeach", true)

function mod:ShadowCrashTarget(targetname, uId)
	if not targetname then return end
	if self.Options.SetIconOnShadowCrash then
		self:SetIcon(targetname, 8, 10)
	end
	if targetname == UnitName("player") then
		specWarnShadowCrash:Show()
		voiceShadowCrash:Play("runaway")
		yellShadowCrash:Yell()
	elseif targetname then
		if uId then
			local inRange = CheckInteractDistance(uId, 2)
			if inRange then
				specWarnShadowCrashNear:Show(targetname)
				voiceShadowCrash:Play("runaway")
			end
		end
	else
		warnShadowCrash:Show(targetname)
	end
end

function mod:OnCombatStart(delay)
	timerEnrage:Start(-delay)
	timerHardmode:Start(-delay)
	timerNextSurgeofDarkness:Start(-delay)
end

function mod:SPELL_CAST_START(args)
	if args.spellId == 62661 then	-- Searing Flames
		timerSearingFlamesCast:Start()
	elseif args.spellId == 62662 then 
		specWarnSurgeDarkness:Show()
		voiceSurgeDarkness:Play("defensive")
		timerNextSurgeofDarkness:Start()
	end
end

function mod:SPELL_INTERRUPT(args)
	if args.spellId == 62661 then
		timerSearingFlamesCast:Stop()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if args.spellId == 62662 then	-- Surge of Darkness
		timerSurgeofDarkness:Start()
	end
end

function mod:SPELL_AURA_REMOVED(args)
	if args.spellId == 62662 then	
		timerSurgeofDarkness:Stop()
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	if args.spellId == 62660 then		-- Shadow Crash
		self:BossTargetScanner(33271, "ShadowCrashTarget", 0.05, 20)
	elseif args.spellId == 63276 then	-- Mark of the Faceless
		if self.Options.SetIconOnLifeLeach then
			self:SetIcon(args.destName, 7, 10)
		end
		timerLifeLeech:Start(args.destName)
		if args:IsPlayer() then
			specWarnLifeLeechYou:Show()
			voiceLifeLeech:Play("runout")
			yellLifeLeech:Yell()
		else
			local uId = DBM:GetRaidUnitId(args.destName)
			if uId then
				local inRange = CheckInteractDistance(uId, 2)
				if inRange then
					specWarnLifeLeechNear:Show(args.destName)
					voiceLifeLeech:Play("runaway")
				else
					warnLeechLife:Show(args.destName)
				end
			end
		end
	end
end

function mod:RAID_BOSS_EMOTE(emote)
	if emote == L.EmoteSaroniteVapors or emote:find(L.EmoteSaroniteVapors) then
		timerSaroniteVapors:Start()
	end
end
