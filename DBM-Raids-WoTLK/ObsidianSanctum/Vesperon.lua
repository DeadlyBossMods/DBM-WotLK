local mod	= DBM:NewMod("Vesperon", "DBM-Raids-WoTLK", 7)
local L		= mod:GetLocalizedStrings()

mod.statTypes = "normal,normal25"

mod:SetRevision("@file-date-integer@")
mod:SetCreatureID(30449)
mod:SetEncounterID(1093)
mod:SetModelID(27039)
mod:SetHotfixNoticeRev(20221009000000)
mod:SetMinSyncRevision(20221009000000)
mod:DisableMultiBossPulls()
mod:SetZone(615)

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
    "SPELL_CAST_SUCCESS 57579 59127"
)

local warnShadowFissure		= mod:NewSpellAnnounce(59127, 4, nil, nil, nil, nil, 2)
local timerShadowFissure	= mod:NewCastTimer(5, 59128, nil, nil, nil, 3)--Cast timer until Void Blast. it's what happens when shadow fissure explodes.

mod:GroupSpells(59127, 59128)--Shadow fissure with void blast

function mod:SPELL_CAST_SUCCESS(args)
    if args:IsSpellID(57579, 59127) then
        warnShadowFissure:Show()
        warnShadowFissure:Play("watchstep")
        timerShadowFissure:Start()
    end
end
