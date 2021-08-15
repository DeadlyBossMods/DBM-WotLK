std = "lua51"
max_line_length = false
exclude_files = {
	".luacheckrc"
}
ignore = {
	"211", -- Unused local variable
	"211/L", -- Unused local variable "L"
	"211/CL", -- Unused local variable "CL"
	"212", -- Unused argument
	"213", -- Unused loop variable
	"231/_.*", -- unused variables starting with _
	"311", -- Value assigned to a local variable is unused
	"43.", -- Shadowing an upvalue, an upvalue argument, an upvalue loop variable.
	"542", -- An empty if branch
}
globals = {
	-- DBM
	"DBM",
	"DBM_CORE_L",
	"DBT",

	-- Lua
	"bit.band",
	"table.wipe",
	"time",

	-- WoW
	"COMBATLOG_OBJECT_AFFILIATION_MINE",
	"COMBATLOG_OBJECT_TYPE_PLAYER",
	"TANK",

	"UIParent",

	"Ambiguate",
	"CheckInteractDistance",
	"CreateFrame",
	"GetLocale",
	"GetTime",
	"GetUnitName",
	"IsInGroup",
	"IsInRaid",
	"SendChatMessage",
	"SetRaidTarget",
	"UnitAffectingCombat",
	"UnitClass",
	"UnitDetailedThreatSituation",
	"UnitExists",
	"UnitFactionGroup",
	"UnitGetTotalAbsorbs",
	"UnitGUID",
	"UnitHealth",
	"UnitHealthMax",
	"UnitIsDeadOrGhost",
	"UnitIsUnit",
	"UnitInVehicle",
	"UnitName",
}
