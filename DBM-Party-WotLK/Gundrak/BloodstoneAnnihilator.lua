local mod	= DBM:NewMod(593, "DBM-Party-WotLK", 5, 274)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(29307)
--mod:SetZone()

mod:RegisterCombat("combat")

mod:RegisterEvents(
	"SPELL_CAST_START"
)

local warningElemental	= mod:NewAnnounce("WarningElemental", 3, 54850)
local warningStone		= mod:NewAnnounce("WarningStone", 3, 54878)

function mod:SPELL_CAST_START(args)
	if args.spellId == 54850 then
		warningElemental:Show()
	elseif args.spellId == 54878 then
		warningStone:Show()
	end
end