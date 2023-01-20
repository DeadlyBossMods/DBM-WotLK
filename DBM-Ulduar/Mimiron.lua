local mod	= DBM:NewMod("Mimiron", "DBM-Ulduar")
local L		= mod:GetLocalizedStrings()

mod:SetRevision("@file-date-integer@")
mod:SetCreatureID(33432)
if not mod:IsClassic() then
	mod:SetEncounterID(1138)
else
	mod:SetEncounterID(754)
end
mod:DisableESCombatDetection()--fires for RP, and we need yells to identify hard mode anyways
mod:SetModelID(28578)
mod:SetUsedIcons(1, 2, 3, 4, 5, 6, 7, 8)
mod:SetHotfixNoticeRev(20230113000000)
mod:SetMinSyncRevision(20230113000000)

mod:RegisterCombat("combat_yell", L.YellPull)

mod:RegisterEvents(
	"CHAT_MSG_MONSTER_YELL"
)

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 63631 64529 62997 64570 64623",
	"SPELL_CAST_SUCCESS 63027 63414",
	"SPELL_AURA_APPLIED 63666 65026 64529 62997",
	"SPELL_AURA_REMOVED 63666 65026 64529 62997",
	"SPELL_SUMMON 63811",
	"UNIT_SPELLCAST_CHANNEL_STOP",
	"UNIT_SPELLCAST_SUCCEEDED",--BOSS ids still left out because classic is still using it for rocket strike
	"CHAT_MSG_LOOT"
)

local blastWarn						= mod:NewTargetNoFilterAnnounce(64529, 4, nil, "Tank|Healer")
local shellWarn						= mod:NewTargetNoFilterAnnounce(63666, 2, nil, "Healer")
local lootannounce					= mod:NewAnnounce("MagneticCore", 1, 64444, nil, nil, nil, 64444)
local warnBombSpawn					= mod:NewAnnounce("WarnBombSpawn", 3, 63811, nil, nil, nil, 63811)
local warnFrostBomb					= mod:NewSpellAnnounce(64623, 3)

local warnShockBlast				= mod:NewSpecialWarningRun(63631, "Melee", nil, nil, 4, 2)
local warnRocketStrike				= mod:NewSpecialWarningDodge(64402, nil, nil, nil, 2, 2)
local warnP3Wx2LaserBarrage			= mod:NewSpecialWarningDodge(63274, nil, nil, nil, 3, 2)
local warnPlasmaBlast				= mod:NewSpecialWarningDefensive(64529, nil, nil, nil, 1, 2)

local enrage 						= mod:NewBerserkTimer(900)
local timerHardmode					= mod:NewTimer(610, "TimerHardmode", 64582)
local timerP1toP2					= mod:NewTimer(41.5, "TimeToPhase2", "136116", nil, nil, 6)
local timerP2toP3					= mod:NewTimer(29, "TimeToPhase3", "136116", nil, nil, 6)
local timerP3toP4					= mod:NewTimer(29, "TimeToPhase4", "136116", nil, nil, 6)
local timerProximityMines			= mod:NewCDTimer(30.2, 63027, nil, nil, nil, 3)
local timerShockBlast				= mod:NewCastTimer(4, 63631, nil, nil, nil, 2)
local timerShockBlastCD				= mod:NewCDTimer(35, 63631, nil, nil, nil, 2)
local timerRocketStrikeCD			= mod:NewCDTimer(20, 64402, nil, nil, nil, 3)--20-25
local timerSpinUp					= mod:NewCastTimer(4, 63414, nil, nil, nil, 3, nil, DBM_COMMON_L.DEADLY_ICON)--precast
local timerP3Wx2LaserBarrageCast	= mod:NewCastTimer(10, 63274, nil, nil, nil, 3, nil, DBM_COMMON_L.DEADLY_ICON)--channel
local timerNextP3Wx2LaserBarrage	= mod:NewNextTimer(48, 63414, nil, nil, nil, 3, nil, DBM_COMMON_L.DEADLY_ICON)--next cast
local timerNextShockblast			= mod:NewNextTimer(34, 63631, nil, nil, nil, 2)
local timerPlasmaBlastCD			= mod:NewCDTimer(30, 64529, nil, "Tank", 2, 5)
local timerShell					= mod:NewBuffActiveTimer(6, 63666, nil, "Healer", 2, 5, nil, DBM_COMMON_L.HEALER_ICON)
--local timerNextFlameSuppressant	= mod:NewNextTimer(60, 64570, nil, nil, nil, 3)
local timerFlameSuppressant			= mod:NewBuffActiveTimer(10, 65192, nil, nil, nil, 3)
local timerNextFrostBomb			= mod:NewNextTimer(80, 64623, nil, nil, nil, 3, nil, DBM_COMMON_L.HEROIC_ICON)
local timerBombExplosion			= mod:NewCastTimer(15, 65333, nil, nil, nil, 3)

mod:AddSetIconOption("SetIconOnNapalm", 63666, false, false, {1, 2, 3, 4, 5, 6, 7})
mod:AddSetIconOption("SetIconOnPlasmaBlast", 64529, false, false, {8})
mod:AddRangeFrameOption("6")

mod:GroupSpells(63274, 63414)--Spinning Up and P3Wx2

mod.vb.hardmode = false
mod.vb.napalmShellIcon = 7
local spinningUp = DBM:GetSpellInfo(63414)
local lastSpinUp = 0
mod.vb.is_spinningUp = false
local napalmShellTargets = {}

local function warnNapalmShellTargets(self)
	shellWarn:Show(table.concat(napalmShellTargets, "<, >"))
	table.wipe(napalmShellTargets)
	self.vb.napalmShellIcon = 7
end

local function show_warning_for_spinup(self)
	if self.vb.is_spinningUp then
		warnP3Wx2LaserBarrage:Show()
		warnP3Wx2LaserBarrage:Play("watchstep")
		warnP3Wx2LaserBarrage:ScheduleVoice(1, "keepmove")
	end
end

function mod:OnCombatStart(delay)
	self.vb.hardmode = false
	enrage:Start(-delay)
	self:SetStage(1)
	self.vb.is_spinningUp = false
	self.vb.napalmShellIcon = 7
	table.wipe(napalmShellTargets)
	timerPlasmaBlastCD:Start(18-delay)
	timerShockBlastCD:Start(20.7-delay)
	if self.Options.RangeFrame then
		DBM.RangeCheck:Show(6)
	end
	if self:IsClassic() then
		DBM:AddMsg("All the staging on this mod had to be rolled back to legacy code that's less reliable, most stage change timers will be incorret or missing for a while until code is downgraded or until blizzard enables boss frames")
	end
end

function mod:OnCombatEnd()
	if self.Options.RangeFrame then
		DBM.RangeCheck:Hide()
	end
end

function mod:SPELL_CAST_START(args)
	if args.spellId == 63631 then
		warnShockBlast:Show()
		warnShockBlast:Play("runout")
		timerShockBlast:Start()
		timerNextShockblast:Start()
	end
	if args:IsSpellID(64529, 62997) then -- plasma blast
		local tanking, status = UnitDetailedThreatSituation("player", "boss1")--Change boss unitID if it's not boss 1
		if tanking or (status == 3) then
			warnPlasmaBlast:Show()
			warnPlasmaBlast:Play("defensive")
		end
		timerPlasmaBlastCD:Start()
	end
	if args.spellId == 64570 then
		timerFlameSuppressant:Start()
	end
	if args.spellId == 64623 then
		warnFrostBomb:Show()
		timerBombExplosion:Start()
		timerNextFrostBomb:Start()
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	if args.spellId == 63027 then				-- mines
		timerProximityMines:Start()
	elseif args.spellId == 63414 then			-- Spinning UP (before Dark Glare)
		self.vb.is_spinningUp = true
		timerSpinUp:Start()
		timerP3Wx2LaserBarrageCast:Schedule(4)
		timerNextP3Wx2LaserBarrage:Schedule(14)			-- 4 (cast spinup) + 10 sec (channel)
		DBM:Schedule(0.15, show_warning_for_spinup, self)	-- wait 0.15 and then announce it, otherwise it will sometimes fail
		lastSpinUp = GetTime()
--	elseif args.spellId == 65192 then
--		timerNextFlameSuppressant:Start()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if args:IsSpellID(63666, 65026) and args:IsDestTypePlayer() then -- Napalm Shell
		napalmShellTargets[#napalmShellTargets + 1] = args.destName
		timerShell:Start()
		if self.Options.SetIconOnNapalm and self.vb.napalmShellIcon > 0 then
			self:SetIcon(args.destName, self.vb.napalmShellIcon, 6)
		end
		self.vb.napalmShellIcon = self.vb.napalmShellIcon - 1
		self:Unschedule(warnNapalmShellTargets)
		self:Schedule(0.3, warnNapalmShellTargets, self)
	elseif args:IsSpellID(64529, 62997) then -- Plasma Blast
		blastWarn:Show(args.destName)
		if self.Options.SetIconOnPlasmaBlast then
			self:SetIcon(args.destName, 8, 6)
		end
	end
end

function mod:SPELL_AURA_REMOVED(args)
	if args:IsSpellID(63666, 65026) then -- Napalm Shell
		if self.Options.SetIconOnNapalm then
			self:SetIcon(args.destName, 0)
		end
	end
end

function mod:SPELL_SUMMON(args)
	if args.spellId == 63811 then -- Bomb Bot
		warnBombSpawn:Show()
	end
end

function mod:UNIT_SPELLCAST_CHANNEL_STOP(unit, _, spellId)
	local spell = DBM:GetSpellInfo(spellId)--DO BETTER with log
	if spell == spinningUp and GetTime() - lastSpinUp < 3.9 then
		self.vb.is_spinningUp = false
		self:SendSync("SpinUpFail")
	end
end

function mod:CHAT_MSG_LOOT(msg, _, _, _, player)
	if msg:find("Hitem:46029") and player then
		player = DBM:GetUnitFullName(player) or player
		lootannounce:Show(player)
	end
end

function mod:CHAT_MSG_MONSTER_YELL(msg)
	if msg == L.YellHardPull or msg:find(L.YellHardPull) then
		timerHardmode:Start()
		--timerNextFlameSuppressant:Start()
		enrage:Stop()
		self.vb.hardmode = true
	elseif self:IsClassic() then--Legacy code
		if (msg == L.YellPhase2 or msg:find(L.YellPhase2)) then
			self:SendSync("Phase2")
		elseif (msg == L.YellPhase3 or msg:find(L.YellPhase3)) then
			self:SendSync("Phase3")
		elseif (msg == L.YellPhase4 or msg:find(L.YellPhase4)) then
			self:SendSync("Phase4")
		end
	end
end

--Classic can't use this for phase changes because boss isn't an active unit ID on stage changes without boss frames
--Classic can use it for rocket strike since that's cast while boss is actually active
--Filter exists in case boss unit Ids do get added at some point, wouldn't want double stage changes and would need time to review it before removing yells again
function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, spellId)
	--Modern phasing path, where boss unit Ids exist.
	if spellId == 34098 and self:AntiSpam(5, 1) and not self:IsClassic() then--ClearAllDebuffs
		self:SetStage(0)
		if self.vb.phase == 2 then
			timerNextShockblast:Stop()
			timerProximityMines:Stop()
			timerFlameSuppressant:Stop()
			--timerNextFlameSuppressant:Stop()
			timerPlasmaBlastCD:Stop()
			timerP1toP2:Start()
			if self.Options.RangeFrame then
				DBM.RangeCheck:Hide()
			end
			timerRocketStrikeCD:Start(63)
			timerNextP3Wx2LaserBarrage:Start(78)
			if self.vb.hardmode then
				timerNextFrostBomb:Start(94)
			end
		elseif self.vb.phase == 3 then
			timerP3Wx2LaserBarrageCast:Stop()
			timerNextP3Wx2LaserBarrage:Stop()
			timerNextFrostBomb:Stop()
			timerRocketStrikeCD:Stop()
			timerP2toP3:Start()
		elseif self.vb.phase == 4 then
			timerP3toP4:Start()--29
			if self.vb.hardmode then
				timerNextFrostBomb:Start(32)
			end
			timerRocketStrikeCD:Start(50)
			timerNextP3Wx2LaserBarrage:Start(59.8)
			timerNextShockblast:Start(81)
		end
	elseif (spellId == 64402 or spellId == 65034) then--P2, P4 Rocket Strike
		self:SendSync("RocketStrike")
	end
end

function mod:OnSync(event, args)
	if not self:IsInCombat() then return end
	if event == "SpinUpFail" then
		self.vb.is_spinningUp = false
		timerSpinUp:Cancel()
		timerP3Wx2LaserBarrageCast:Cancel()
		timerNextP3Wx2LaserBarrage:Cancel()
		warnP3Wx2LaserBarrage:Cancel()
	elseif event == "Phase2" and self.vb.phase == 1 then -- alternate localized-dependent detection
		timerNextShockblast:Stop()
		timerProximityMines:Stop()
		timerFlameSuppressant:Stop()
		--timerNextFlameSuppressant:Stop()
		timerPlasmaBlastCD:Stop()
		timerP1toP2:Start(41.5)--Old data from ages ago, needs rechecking
		if self.Options.RangeFrame then
			DBM.RangeCheck:Hide()
		end
		timerRocketStrikeCD:Start(11)--Guessed by math
		timerNextP3Wx2LaserBarrage:Start(26)--Guessed by math
		if self.vb.hardmode then
			timerNextFrostBomb:Start(42)--Old data from ages ago, needs rechecking
		end
	elseif event == "Phase3" and self.vb.phase == 2 then
		timerP3Wx2LaserBarrageCast:Stop()
		timerNextP3Wx2LaserBarrage:Stop()
		timerNextFrostBomb:Stop()
		timerRocketStrikeCD:Stop()
		timerP2toP3:Start(25)
	elseif event == "Phase4" and self.vb.phase == 3 then
		--All these timers might be wrong because they are mashed between retail and legacy using math guesses
		timerP3toP4:Start(26.5)
--		if self.vb.hardmode then
--			timerNextFrostBomb:Start(28.5)
--		end
--		timerRocketStrikeCD:Start(46.5)
--		timerNextP3Wx2LaserBarrage:Start(56.3)
--		timerNextShockblast:Start(77.5)
	elseif event == "RocketStrike" then
		warnRocketStrike:Show()
		warnRocketStrike:Play("watchstep")
		timerRocketStrikeCD:Start()
	end
end
