if GetLocale() ~= "deDE" then return end
local L

------------------------
--  Northrend Beasts  --
------------------------
L = DBM:GetModLocalization("NorthrendBeasts")

L:SetGeneralLocalization{
	name = "Bestien von Nordend"
}

L:SetMiscLocalization{
	Charge		= "^%%s sieht (%S+) zornig an und lässt einen gewaltigen Schrei ertönen!",
	CombatStart	= "Er kommt aus den tiefsten, dunkelsten Höhlen der Sturmgipfel - Gormok der Pfähler! Voran, Helden!",
	Phase2		= "Stählt Euch, Helden, denn die Zwillingsschrecken Ätzschlund und Schreckensmaul erscheinen in der Arena!",
	Phase3		= "Mit der Ankündigung unseres nächsten Kämpfers gefriert die Luft selbst: Eisheuler! Tötet oder werdet getötet, Champions!",
	Gormok		= "Gormok der Pfähler",
	Acidmaw		= "Ätzschlund",
	Dreadscale	= "Schreckensmaul",
	Icehowl		= "Eisheuler"
}

L:SetOptionLocalization{
	WarningSnobold				= "Zeige Warnung, wenn ein Schneeboldvasall erscheint",
	PingCharge					= "Pingt die Minimap, wenn Eisheuler dich niedertrampeln will",
	ClearIconsOnIceHowl			= "Entferne alle Zeichen vor dem Trampeln",
	TimerNextBoss				= "Zeige Zeit bis zum Erscheinen des nächsten Bosses",
	TimerEmerge					= "Zeige Zeit bis Auftauchen",
	TimerSubmerge				= "Zeige Zeit bis Abtauchen",
	IcehowlArrow				= "Zeige DBM-Pfeil, wenn Eisheuler jemand in deiner Nähe niedertrampeln will"
}

L:SetTimerLocalization{
	TimerNextBoss		= "Nächster Boss",
	TimerEmerge			= "Auftauchen",
	TimerSubmerge		= "Abtauchen"
}

L:SetWarningLocalization{
	WarningSnobold				= "Schneeboldvasall erschienen"
}

---------------------
--  Lord Jaraxxus  --
---------------------
L = DBM:GetModLocalization("Jaraxxus")

L:SetGeneralLocalization{
	name = "Lord Jaraxxus"
}

L:SetOptionLocalization{
	IncinerateShieldFrame		= "Zeige Lebensanzeige mit einem Balken für Fleisch einäschern"
}

L:SetMiscLocalization{
	IncinerateTarget	= "Fleisch einäschern: %s",
	FirstPull	= "Großhexenmeister Wilfred Zischknall wird Eure nächste Herausforderung beschwören. Harrt seiner Ankunft."
}

-------------------------
--  Faction Champions  --
-------------------------
L = DBM:GetModLocalization("Champions")

L:SetGeneralLocalization{
	name = "Fraktionschampions"
}

L:SetMiscLocalization{
	--Horde NPCS
	Gorgrim				= "Tod - Gorgrim Schattenspalter",	-- 34458
	Birana				= "Dru - Birana Sturmhuf",			-- 34451
	Erin				= "Dru - Erin Nebelhuf",			-- 34459
	Rujkah				= "Jäg - Ruj'kah",					-- 34448
	Ginselle			= "Mag - Ginselle Seuchenwerfer",	-- 34449
	Liandra				= "Pal - Liandra Sonnenrufer",		-- 34445
	Malithas			= "Pal - Malithas Glanzklinge",		-- 34456
	Caiphus				= "Pri - Caiphus der Ernste",		-- 34447
	Vivienne			= "Pri - Vivienne Schwarzraunen",	-- 34441
	Mazdinah			= "Schu - Maz'dinah",				-- 34454
	Thrakgar			= "Scha - Thrakgar",				-- 34444
	Broln				= "Scha - Broln Starkhorn",			-- 34455
	Harkzog				= "Hex - Harkzog",					-- 34450
	Narrhok				= "Kri - Narrhok Stahlbrecher",		-- 34453
	--Alliance NPCS
	Tyrius				= "Tod - Tyrius Dämmerklinge",		-- 34461
	Kavina				= "Dru - Kavina Haineslied",		-- 34460
	Melador				= "Dru - Melador Talwanderer",		-- 34469
	Alyssia             = "Jäg - Alyssia Mondpirscher",		-- 34467
	Noozle				= "Mag - Noozle Zischelstock",		-- 34468
	Baelnor				= "Pal - Baelnor Lichtträger",		-- 34471
	Velanaa				= "Pal - Velanaa",					-- 34465
	Anthar				= "Pri - Anthar Schmiedenformer",	-- 34466
	Brienna				= "Pri - Brienna Tiefnacht",		-- 34473
	Irieth				= "Schu - Irieth Schattenschritt",	-- 34472
	Saamul				= "Scha - Saamul",					-- 34470
	Shaabad				= "Scha - Shaabad",					-- 34463
	Serissa				= "Hex - Serissa Düsterhauch",		-- 34474
	Shocuul				= "Kri - Shocuul",					-- 34475

	AllianceVictory    = "EHRE DER ALLIANZ!",
	HordeVictory       = "Das ist nur ein Vorgeschmack auf die Zukunft. FÜR DIE HORDE!",
	YellKill           = "Ein tragischer Sieg. Wir wurden schwächer durch die heutigen Verluste. Wer außer dem Lichkönig profitiert von solchen Torheiten? Große Krieger gaben ihr Leben. Und wofür? Die wahre Bedrohung erwartet uns noch - der Lichkönig erwartet uns alle im Tod."
}

---------------------
--  Val'kyr Twins  --
---------------------
L = DBM:GetModLocalization("ValkTwins")

L:SetGeneralLocalization{
	name = "Zwillingsval'kyr"
}

L:SetTimerLocalization{
	TimerSpecialSpell	= "Nächste Spezialfähigkeit"
}

L:SetWarningLocalization{
	WarnSpecialSpellSoon		= "Spezialfähigkeit bald",
	SpecWarnSpecial				= "Farbe wechseln",
	SpecWarnSwitchTarget		= "Ziel wechseln",
	SpecWarnKickNow				= "Jetzt unterbrechen",
	WarningTouchDebuff			= "Berührung auf >%s<",
	WarningPoweroftheTwins		= "Macht der Zwillinge - Mehr Heilung auf >%s<",
	SpecWarnPoweroftheTwins		= "Macht der Zwillinge"
}

L:SetMiscLocalization{
	YellPull	= "Im Namen unseres dunklen Meisters. Für den Lichkönig. Ihr. Werdet. Sterben.",
	Fjola		= "Fjola Lichtbann",
	Eydis		= "Eydis Nachtbann"
}

L:SetOptionLocalization{
	TimerSpecialSpell			= "Zeige Zeit bis nächste Spezialfähigkeit",
	WarnSpecialSpellSoon		= "Zeige Vorwarnung für nächste Spezialfähigkeit",
	SpecWarnSpecial				= "Spezialwarnung, wenn du die Farbe wechseln musst",
	SpecWarnSwitchTarget		= "Spezialwarnung, wenn der andere Zwilling zaubert",
	SpecWarnKickNow				= "Spezialwarnung zum Unterbrechen",
	SpecialWarnOnDebuff			= "Spezialwarnung bei Berührung (um Farbe zu wechseln)",
	SetIconOnDebuffTarget		= "Setze Zeichen auf Ziele von Berührung des Lichts/der Nacht (heroisch)",
	WarningTouchDebuff			= "Verkünde Ziele von Berührung des Lichts/der Nacht",
	WarningPoweroftheTwins		= "Verkünde Ziele von Macht der Zwillinge",
	SpecWarnPoweroftheTwins		= "Spezialwarnung, wenn du einen gestärkten Zwilling tankst"
}

-----------------
--  Anub'arak  --
-----------------
L = DBM:GetModLocalization("Anub'arak_Coliseum")

L:SetGeneralLocalization{
	name 					= "Anub'arak"
}

L:SetTimerLocalization{
	TimerEmerge				= "Auftauchen",
	TimerSubmerge			= "Abtauchen",
	timerAdds				= "Neue Adds"
}

L:SetWarningLocalization{
	WarnEmerge				= "Auftauchen",
	WarnEmergeSoon			= "Auftauchen in 10 Sekunden",
	WarnSubmerge			= "Abtauchen",
	WarnSubmergeSoon		= "Abtauchen in 10 Sekunden",
	specWarnSubmergeSoon	= "Abtauchen in 10 Sekunden!",
	warnAdds				= "Neue Adds"
}

L:SetMiscLocalization{
	YellPull			= "Dieser Ort wird Euch als Grab dienen!",
	Emerge				= "entsteigt dem Boden!",
	Burrow				= "gräbt sich in den Boden!",
	PcoldIconSet		= "DKälte-Zeichen {rt%d} auf %s gesetzt",
	PcoldIconRemoved	= "DKälte-Zeichen von %s entfernt"
}

L:SetOptionLocalization{
	WarnEmerge				= "Zeige Warnung für Auftauchen",
	WarnEmergeSoon			= "Zeige Vorwarnung für Auftauchen",
	WarnSubmerge			= "Zeige Warnung für Abtauchen",
	WarnSubmergeSoon		= "Zeige Vorwarnung für Abtauchen",
	specWarnSubmergeSoon	= "Spezialwarnung für baldiges Abtauchen",
	warnAdds				= "Verkünde neue Adds",
	timerAdds				= "Zeige Zeit bis neue Adds erscheinen",
	TimerEmerge				= "Zeige Zeit bis Auftauchen",
	TimerSubmerge			= "Zeige Zeit bis Abtauchen",
	AnnouncePColdIcons		= "Verkünde Zeichen für Ziele von $spell:66013 im Schlachtzugchat (nur als Leiter)",
	AnnouncePColdIconsRemoved	= "Verkünde auch das Entfernen von Zeichen für $spell:66013 (benötigt obige Einstellung)"
}

