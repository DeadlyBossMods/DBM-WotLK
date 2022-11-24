-- this file uses the texture Textures/arrow.tga. This image was created by Everaldo Coelho and is licensed under the GNU Lesser General Public License. See Textures/lgpl.txt.
local mod	= DBM:NewMod("Thaddius", "DBM-Naxx", 2)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("@file-date-integer@")
mod:SetCreatureID(15928)
mod:SetEncounterID(1120)
mod:SetModelID(16137)
mod:RegisterCombat("combat_yell", L.Yell)

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 28089",
	"RAID_BOSS_EMOTE",
	"UNIT_AURA player"
)

local warnShiftSoon			= mod:NewPreWarnAnnounce(28089, 5, 3)
local warnShiftCasting		= mod:NewCastAnnounce(28089, 4)
local warnThrow				= mod:NewSpellAnnounce(28338, 2)
local warnThrowSoon			= mod:NewSoonAnnounce(28338, 1)

local warnChargeChanged		= mod:NewSpecialWarning("WarningChargeChanged", nil, nil, nil, 3, 2, nil, nil, 28089)
local warnChargeNotChanged	= mod:NewSpecialWarning("WarningChargeNotChanged", false, nil, nil, 1, 12, nil, nil, 28089)
local yellShift				= mod:NewShortPosYell(28089, DBM_CORE_L.AUTO_YELL_CUSTOM_POSITION)

local enrageTimer			= mod:NewBerserkTimer(365)
local timerNextShift		= mod:NewNextTimer(30, 28089, nil, nil, nil, 2, nil, DBM_COMMON_L.DEADLY_ICON)
local timerShiftCast		= mod:NewCastTimer(3, 28089, nil, nil, nil, 2)
local timerThrow			= mod:NewNextTimer(20.6, 28338, nil, nil, nil, 5, nil, DBM_COMMON_L.TANK_ICON)

if not DBM.Options.GroupOptionsBySpell then
	mod:AddMiscLine(DBM_CORE_L.OPTION_CATEGORY_DROPDOWNS)
end
mod:AddDropdownOption("AirowEnabled", {"Never", "TwoCamp", "ArrowsRightLeft", "ArrowsInverse"}, "Never", "misc", nil, 28089)

local currentCharge
local raidCharges = {}
local down = 0

local function TankThrow(self)
	if not self:IsInCombat() or self.vb.phase == 2 then
		return
	end
	timerThrow:Start()
	warnThrowSoon:Schedule(17.6)
	self:Schedule(20.6, TankThrow, self)
end

function mod:OnCombatStart(delay)
	self:SetStage(1)
	currentCharge = nil
	raidCharges = {}
	down = 0
	self:Schedule(20.6 - delay, TankThrow, self)
	timerThrow:Start(-delay)
	warnThrowSoon:Schedule(17.6 - delay)
end

function mod:OnCombatEnd()
	if self.Options.RangeFrame then
		DBM.RangeCheck:Hide()
	end
end

do
	local function DebuffFilter(uId)
		local name = UnitName(uId)
		return name and raidCharges[name] ~= currentCharge
	end

	local enableOneTime = false
	local function EnableRangeFrame(self)
		if enableOneTime then return end
		enableOneTime = true
		if not self.Options.RangeFrame then return end
		DBM.RangeCheck:Show(13, DebuffFilter) -- Only show players affected with opposite charge
	end

	local lastShift
	function mod:SPELL_CAST_START(args)
		if args.spellId == 28089 then
			self:SetStage(2)
			EnableRangeFrame(self)
			timerNextShift:Start()
			timerShiftCast:Start()
			warnShiftCasting:Show()
			warnShiftSoon:Schedule(25)
			lastShift = GetTime()
		end
	end

	local function GetCharge(unit)
		local i = 1
		while UnitDebuff(unit, i) do
			local _, icon, count, _, _, _, _, _, _, _, _, _, _, _, _, count2 = UnitDebuff(unit, i)
			if icon == 135768 or icon == "Interface\\Icons\\Spell_ChargeNegative" then--Not sure if classic will return data ID or path, so include both
				if (count2 or count) > 1 then return end--Incorrect aura, it's stacking damage one
				return L.Charge1
			elseif icon == 135769 or icon == "Interface\\Icons\\Spell_ChargePositive" then--Not sure if classic will return data ID or path, so include both
				if (count2 or count) > 1 then return end--Incorrect aura, it's stacking damage one
				return L.Charge2
			end
			i = i + 1
		end
	end

	local function HandlePlayerCharge(self, charge)
		if charge == L.Charge1 then
			yellShift:Yell(7, "- -")
		elseif charge == L.Charge2 then
			yellShift:Yell(6, "+ +")
		end

		if charge then
			lastShift = nil
			if charge == currentCharge then
				warnChargeNotChanged:Show()
				warnChargeNotChanged:Play("dontmove")
				if self.Options.ArrowsEnabled == "ArrowsInverse" then
					self:ShowLeftArrow()
				elseif self.Options.ArrowsEnabled == "ArrowsRightLeft" then
					self:ShowRightArrow()
				end
			else
				warnChargeChanged:Show(charge)
				warnChargeChanged:Play("stilldanger")
				if self.Options.ArrowsEnabled == "ArrowsInverse" then
					self:ShowRightArrow()
				elseif self.Options.ArrowsEnabled == "ArrowsRightLeft" then
					self:ShowLeftArrow()
				elseif self.Options.ArrowsEnabled == "TwoCamp" then
					self:ShowUpArrow()
				end
			end
			currentCharge = charge
		end
	end

	local function HandleRaidCharges(self)
		for uId in DBM:GetGroupMembers() do
			local name = UnitName(uId)
			if name then
				raidCharges[name] = GetCharge(uId)
				if UnitIsUnit("player", uId) then
					HandlePlayerCharge(self, raidCharges[name]) -- depends on the raid charges
				end
			end
		end
	end

	function mod:UNIT_AURA()
		if self.vb.phase ~= 2 or not lastShift or (GetTime() - lastShift) < 3 then return end
		HandleRaidCharges(self)
	end
end

function mod:RAID_BOSS_EMOTE(msg)
	if msg == L.Emote or msg == L.Emote2 then
		down = down + 1
		if down >= 2 then
			self:Unschedule(TankThrow)
			timerThrow:Cancel()
			warnThrowSoon:Cancel()
			enrageTimer:Start()
		end
	end
end

local function arrowOnUpdate(self, elapsed)
	self.elapsed = (self.elapsed or 0) + elapsed
	if self.elapsed >= 3.5 and self.elapsed < 4.5 then
		self:SetAlpha(4.5 - self.elapsed)
	elseif self.elapsed >= 4.5 then
		self:Hide()
	end
end

local function arrowOnShow(self)
	self.elapsed = 0
	self:SetAlpha(1)
end

local arrowLeft = CreateFrame("Frame", nil, UIParent)
arrowLeft:Hide()
local arrowLeftTexture = arrowLeft:CreateTexture(nil, "BACKGROUND")
arrowLeftTexture:SetTexture("Interface\\AddOns\\DBM-Naxx\\ConstructQuarter\\Textures\\arrow")
arrowLeftTexture:SetPoint("CENTER", arrowLeft, "CENTER")
arrowLeft:SetHeight(1)
arrowLeft:SetWidth(1)
arrowLeft:SetPoint("CENTER", UIParent, "CENTER", -150, -30)
arrowLeft:SetScript("OnShow", arrowOnShow)
arrowLeft:SetScript("OnUpdate", arrowOnUpdate)

local arrowRight = CreateFrame("Frame", nil, UIParent)
arrowRight:Hide()
local arrowRightTexture = arrowRight:CreateTexture(nil, "BACKGROUND")
arrowRightTexture:SetTexture("Interface\\AddOns\\DBM-Naxx\\ConstructQuarter\\Textures\\arrow")
arrowRightTexture:SetPoint("CENTER", arrowRight, "CENTER")
arrowRightTexture:SetTexCoord(1, 0, 0, 1)
arrowRight:SetHeight(1)
arrowRight:SetWidth(1)
arrowRight:SetPoint("CENTER", UIParent, "CENTER", 150, -30)
arrowRight:SetScript("OnShow", arrowOnShow)
arrowRight:SetScript("OnUpdate", arrowOnUpdate)

local arrowUp = CreateFrame("Frame", nil, UIParent)
arrowUp:Hide()
local arrowUpTexture = arrowUp:CreateTexture(nil, "BACKGROUND")
arrowUpTexture:SetTexture("Interface\\AddOns\\DBM-Naxx\\ConstructQuarter\\Textures\\arrow")
arrowUpTexture:SetRotation(math.pi * 3 / 2)
arrowUpTexture:SetPoint("CENTER", arrowUp, "CENTER")
arrowUp:SetHeight(1)
arrowUp:SetWidth(1)
arrowUp:SetPoint("CENTER", UIParent, "CENTER", 0, 40)
arrowUp:SetScript("OnShow", arrowOnShow)
arrowUp:SetScript("OnUpdate", arrowOnUpdate)

function mod:ShowRightArrow()
	arrowRight:Show()
end

function mod:ShowLeftArrow()
	arrowLeft:Show()
end

function mod:ShowUpArrow()
	arrowUp:Show()
end
