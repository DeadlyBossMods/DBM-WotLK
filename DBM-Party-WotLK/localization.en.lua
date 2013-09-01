local L

local spell				= "%s"				
local debuff			= "%s: >%s<"			
local spellCD			= "%s cooldown"					-- translate
local spellSoon			= "%s soon"						-- translate
local optionWarning		= "Show warning for %s"			-- translate
local optionPreWarning	= "Show pre-warning for %s"		-- translate
local optionSpecWarning	= "Show special warning for %s"	-- translate
local optionTimerCD		= "Show timer for %s cooldown"	-- translate
local optionTimerDur	= "Show timer for %s duration"	-- translate
local optionTimerCast	= "Show timer for %s cast"		-- translate

----------------------------------
--  Ahn'Kahet: The Old Kingdom  --
----------------------------------
--  Prince Taldaram  --
-----------------------
L = DBM:GetModLocalization(581)

-------------------
--  Elder Nadox  --
-------------------
L = DBM:GetModLocalization(580)

---------------------------
--  Jedoga Shadowseeker  --
---------------------------
L = DBM:GetModLocalization(582)

---------------------
--  Herald Volazj  --
---------------------
L = DBM:GetModLocalization(584)

----------------
--  Amanitar  --
----------------
L = DBM:GetModLocalization(583)

-------------------
--  Azjol-Nerub  --
---------------------------------
--  Krik'thir the Gatewatcher  --
---------------------------------
L = DBM:GetModLocalization(585)

----------------
--  Hadronox  --
----------------
L = DBM:GetModLocalization(586)

-------------------------
--  Anub'arak (Party)  --
-------------------------
L = DBM:GetModLocalization(587)

L:SetGeneralLocalization({
	name = "Anub'arak (Party)"--Probably still needed
})

---------------------------------------
--  Caverns of Time: Old Stratholme  --
---------------------------------------
--  Meathook  --
----------------
L = DBM:GetModLocalization(611)

--------------------------------
--  Salramm the Fleshcrafter  --
--------------------------------
L = DBM:GetModLocalization(612)

-------------------------
--  Chrono-Lord Epoch  --
-------------------------
L = DBM:GetModLocalization(613)

-----------------
--  Mal'Ganis  --
-----------------
L = DBM:GetModLocalization(614)

L:SetMiscLocalization({
	Outro	= "Your journey has just begun, young prince. Gather your forces and meet me in the arctic land of Northrend. It is there that we shall settle the score between us. It is there that your true destiny will unfold."
})

-------------------
--  Wave Timers  --
-------------------
L = DBM:GetModLocalization("StratWaves")

L:SetGeneralLocalization({
	name = "Stratholme Waves"
})

L:SetWarningLocalization({
	WarningWaveNow = "Wave %d: %s spawned"
})

L:SetTimerLocalization({
	TimerWaveIn		= "Next wave (6)",
	TimerRoleplay	= "Arthas roleplay"
})

L:SetOptionLocalization({
	WarningWaveNow	= optionWarning:format("new wave"),
	TimerWaveIn		= "Show timer for next set of waves (after wave 5 boss)",
	TimerRoleplay	= "Show timer for opening roleplay event."
})

L:SetMiscLocalization({
	Meathook	= "Meathook",
	Salramm		= "Salramm the Fleshcrafter",
	Devouring	= "Devouring Ghoul",
	Enraged		= "Enraging Ghoul",
	Necro		= "Necromancer",
	Fiend		= "Crypt Fiend",
	Stalker		= "Tomb Stalker",
	Abom		= "Patchwork Construct",
	Acolyte		= "Acolyte",
	Wave1		= "%d %s",
	Wave2		= "%d %s and %d %s",
	Wave3		= "%d %s, %d %s and %d %s",
	Wave4		= "%d %s, %d %s, %d %s and %d %s",
	WaveBoss	= "%s",
	WaveCheck	= "Scourge Wave = (%d+)/10",
	Roleplay	= "Glad you could make it, Uther.",
	Roleplay2	= "Everyone looks ready. Remember, these people are all infected with the plague and will die soon. We must purge Stratholme to protect the remainder of Lordaeron from the Scourge. Let's go."
})

------------------------
--  Drak'Tharon Keep  --
------------------------
--  Trollgore  --
-----------------
L = DBM:GetModLocalization(588)

--------------------------
--  Novos the Summoner  --
--------------------------
L = DBM:GetModLocalization(589)

L:SetWarningLocalization({
	WarnCrystalHandler	= "Crystal Handler spawned (%d remaining)"
})

L:SetTimerLocalization({
	timerCrystalHandler	= "Crystal Handler spawns"
})

L:SetOptionLocalization({
	WarnCrystalHandler	= "Show warning when Crystal Handler spawns",
	timerCrystalHandler	= "Show timer for next Crystal Handler spawn"
})

L:SetMiscLocalization({
	YellPull		= "The chill you feel is the herald of your doom!",
	HandlerYell		= "Bolster my defenses! Hurry, curse you!",
	Phase2			= "Surely you can see the futility of it all!",
	YellKill		= "Your efforts... are in vain."
})

-----------------
--  King Dred  --
-----------------
L = DBM:GetModLocalization(590)

-----------------------------
--  The Prophet Tharon'ja  --
-----------------------------
L = DBM:GetModLocalization(591)

---------------
--  Gundrak  --
----------------
--  Slad'ran  --
----------------
L = DBM:GetModLocalization(592)

---------------
--  Moorabi  --
---------------
L = DBM:GetModLocalization(594)

-------------------------
--  Drakkari Colossus  --		
-------------------------
L = DBM:GetModLocalization(593)

L:SetWarningLocalization({
	WarningElemental	= "Elemental phase",	-- translate
	WarningStone		= "Colossus phase"		-- translate
})

L:SetOptionLocalization({
	WarningElemental	= "Show warning for Elemental phase",	-- translate
	WarningStone		= "Show warning for Colossus phase"		-- translate
})

-----------------
--  Gal'darah  --
-----------------
L = DBM:GetModLocalization(596)

-------------------------
--  Eck the Ferocious  --
-------------------------
L = DBM:GetModLocalization(595)

--------------------------
--  Halls of Lightning  --
--------------------------
--  General Bjarngrim  --
-------------------------
L = DBM:GetModLocalization(597)

-------------
--  Ionar  --
-------------
L = DBM:GetModLocalization(599)

L:SetOptionLocalization({
	SetIconOnOverloadTarget	= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(52658)
})

---------------
--  Volkhan  --
---------------
L = DBM:GetModLocalization(598)

L:SetWarningLocalization({
	WarningStomp	= spell
})

L:SetTimerLocalization({
	TimerStompCD	= spellCD
})

L:SetOptionLocalization({
	WarningStomp	= optionWarning:format(GetSpellInfo(52237)),
	TimerStompCD	= optionTimerCD:format(GetSpellInfo(52237))
})

-------------
--  Loken  --
-------------
L = DBM:GetModLocalization(600)

----------------------
--  Halls of Stone  --
-----------------------
--  Maiden of Grief  --
-----------------------
L = DBM:GetModLocalization(605)

------------------
--  Krystallus  --
------------------
L = DBM:GetModLocalization(604)

L:SetWarningLocalization({
	WarningShatter	= spell
})

L:SetTimerLocalization({
	TimerShatterCD	= spellCD
})

L:SetOptionLocalization({
	WarningShatter	= optionWarning:format(GetSpellInfo(50810)),
	TimerShatterCD	= optionTimerCD:format(GetSpellInfo(50810))
})

------------------------------
--  Sjonnir the Ironshaper  --
------------------------------
L = DBM:GetModLocalization(607)

--------------------------------------
--  Brann Bronzebeard Escort Event  --
--------------------------------------
L = DBM:GetModLocalization(606)

L:SetWarningLocalization({
	WarningPhase	= "Phase %d"
})

L:SetTimerLocalization({
	timerEvent	= "Time remaining"
})

L:SetOptionLocalization({
	WarningPhase	= optionWarning:format("phase number"),
	timerEvent		= "Show timer for event duration"
})

L:SetMiscLocalization({
	Pull	= "Now keep an eye out! I'll have this licked in two shakes of a--",
	Phase1	= "Security breach in progress. Analysis of historical archives transferred to lower-priority queue. Countermeasures engaged.",
	Phase2	= "Threat index threshold exceeded.  Celestial archive aborted. Security level heightened.",
	Phase3	= "Critical threat index. Void analysis diverted. Initiating sanitization protocol.",
	Kill	= "Alert: security fail-safes deactivated. Beginning memory purge and... "
})

-----------------
--  The Nexus  --
-----------------
--  Anomalus  --
----------------
L = DBM:GetModLocalization(619)

-------------------------------
--  Ormorok the Tree-Shaper  --
-------------------------------
L = DBM:GetModLocalization(620)

----------------------------
--  Grand Magus Telestra  --
----------------------------
L = DBM:GetModLocalization(618)

L:SetWarningLocalization({
	WarningSplitSoon	= "Split soon",	-- translate
	WarningSplitNow		= "Split",		-- translate
	WarningMerge		= "Merge"		-- translate
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
	WarningSplitSoon	= "Show warning for Split soon",	-- translate
	WarningSplitNow		= "Show warning for Split",			-- translate
	WarningMerge		= "Show warning for Merge"			-- translate
})

L:SetMiscLocalization({
	SplitTrigger1		= "There's plenty of me to go around.",			-- translate
	SplitTrigger2		= "I'll give you more than you can handle.",	-- translate
	MergeTrigger		= "Now to finish the job!"						-- translate
})

-------------------
--  Keristrasza  --
-------------------
L = DBM:GetModLocalization(621)

-----------------------------------
--  Commander Kolurg/Stoutbeard  --
-----------------------------------
L = DBM:GetModLocalization("Commander")

local commander = "Unknown"
if UnitFactionGroup("player") == "Alliance" then
	commander = "Commander Kolurg"
elseif UnitFactionGroup("player") == "Horde" then
	commander = "Commander Stoutbeard"
end

L:SetGeneralLocalization({
	name = commander
})

------------------
--  The Oculus  --
-------------------------------
--  Drakos the Interrogator  --
-------------------------------
L = DBM:GetModLocalization(622)

L:SetOptionLocalization({
	MakeitCountTimer	= "Show timer for Make It Count (achievement)"
})

L:SetMiscLocalization({
	MakeitCountTimer	= "Make It Count"
})

----------------------
--  Mage-Lord Urom  --
----------------------
L = DBM:GetModLocalization(624)

L:SetMiscLocalization({
	CombatStart		= "Poor blind fools!"
})

--------------------------
--  Varos Cloudstrider  --
--------------------------
L = DBM:GetModLocalization(623)

---------------------------
--  Ley-Guardian Eregos  --
---------------------------
L = DBM:GetModLocalization(625)

L:SetWarningLocalization({
	WarningShiftEnd	= "Planar Shift ending"		-- translate
})

L:SetOptionLocalization({
	WarningShiftEnd	= optionWarning:format(GetSpellInfo(51162).." ending") 	-- translate the word 'ending'
})

L:SetMiscLocalization({
	MakeitCountTimer	= "Make It Count"
})

--------------------
--  Utgarde Keep  --
-----------------------
--  Prince Keleseth  --
-----------------------
L = DBM:GetModLocalization(638)

--------------------------------
--  Skarvald the Constructor  --
--  & Dalronn the Controller  --
--------------------------------
L = DBM:GetModLocalization(639)

----------------------------
--  Ingvar the Plunderer  --
----------------------------
L = DBM:GetModLocalization(640)

L:SetGeneralLocalization({
	name = "Ingvar the Plunderer"
})

L:SetMiscLocalization({
	YellCombatEnd	= "No! I can do... better! I can..."
})

------------------------
--  Utgarde Pinnacle  --
--------------------------
--  Skadi the Ruthless  --
--------------------------
L = DBM:GetModLocalization(643)

L:SetMiscLocalization({
	CombatStart		= "What mongrels dare intrude here? Look alive, my brothers!  A feast for the one that brings me their heads!",
	Phase2			= "You motherless knaves! Your corpses will make fine morsels for my new drake!"
})

-------------------
--  King Ymiron  --
-------------------
L = DBM:GetModLocalization(644)

-------------------------
--  Svala Sorrowgrave  --
-------------------------
L = DBM:GetModLocalization(641)

L:SetTimerLocalization({
	timerRoleplay		= "Svala Sorrowgrave active"
})

L:SetOptionLocalization({
	timerRoleplay		= "Show timer for roleplay before Svala Sorrowgrave becomes active"
})

L:SetMiscLocalization({
	SvalaRoleplayStart	= "My liege! I have done as you asked, and now beseech you for your blessing!"
})

-----------------------
--  Gortok Palehoof  --
-----------------------
L = DBM:GetModLocalization(642)

-----------------------
--  The Violet Hold  --
-----------------------
--  Cyanigosa  --
-----------------
L = DBM:GetModLocalization(632)

L:SetTimerLocalization({
	TimerCombatStart		= "Combat starts"
})

L:SetOptionLocalization({
	TimerCombatStart		= "Show timer for start of combat"
})

L:SetMiscLocalization({
	CyanArrived	= "A valiant defense, but this city must be razed. I will fulfill Malygos's wishes myself!"
})

--------------
--  Erekem  --
--------------
L = DBM:GetModLocalization(626)

---------------
--  Ichoron  --
---------------
L = DBM:GetModLocalization(628)

-----------------
--  Lavanthor  --
-----------------
L = DBM:GetModLocalization(630)

--------------
--  Moragg  --
--------------
L = DBM:GetModLocalization(627)

--------------
--  Xevozz  --
--------------
L = DBM:GetModLocalization(629)

-------------------------------
--  Zuramat the Obliterator  --
-------------------------------
L = DBM:GetModLocalization(631)

L:SetWarningLocalization({
	SpecialWarningVoidShifted 	= spell:format(GetSpellInfo(54343)),
	SpecialShroudofDarkness 	= spell:format(GetSpellInfo(59745))
})

L:SetOptionLocalization({
	SpecialWarningVoidShifted	= optionSpecWarning:format(GetSpellInfo(54343)),
	SpecialShroudofDarkness		= optionSpecWarning:format(GetSpellInfo(59745))
})

---------------------
--  Portal Timers  --
---------------------
L = DBM:GetModLocalization("PortalTimers")

L:SetGeneralLocalization({
	name = "Portal Timers"
})

L:SetWarningLocalization({
	WarningPortalSoon	= "New portal soon",
	WarningPortalNow	= "Portal #%d",
	WarningBossNow		= "Boss incoming"
})

L:SetTimerLocalization({
	TimerPortalIn	= "Portal #%d", 
})

L:SetOptionLocalization({
	WarningPortalNow		= optionWarning:format("new portal"),
	WarningPortalSoon		= optionPreWarning:format("new portal"),
	WarningBossNow			= optionWarning:format("boss incoming"),
	TimerPortalIn			= "Show timer for next portal (after Boss)",
	ShowAllPortalTimers		= "Show timers for all portals (inaccurate)"
})

L:SetMiscLocalization({
	Sealbroken	= "We've broken through the prison gate! The way into Dalaran is clear! Now we finally put an end to the Nexus War!",
	WavePortal	= "Portals Opened: (%d+)/18"
})

-----------------------------
--  Trial of the Champion  --
-----------------------------
--  The Black Knight  --
------------------------
L = DBM:GetModLocalization(637)

L:SetWarningLocalization({
	warnExplode			= "Ghoul Explode - Run away"
})

L:SetTimerLocalization{
	TimerCombatStart	= "Combat starts"
}

L:SetOptionLocalization({
	TimerCombatStart		= "Show timer for start of combat",
	warnExplode				= "Show warning when Ghoul Minion is about to explode",
	AchievementCheck		= "Announce 'I've Had Worse' achievement failure to party",
	SetIconOnMarkedTarget	= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(67823)
})

L:SetMiscLocalization({
	Pull				= "Well done. You have proven yourself today-",
	AchievementFailed	= ">> ACHIEVEMENT FAILED: %s was hit by Ghoul Explode <<",
	YellCombatEnd		= "My congratulations, champions. Through trials both planned and unexpected, you have triumphed."	-- can also be "No! I must not fail... again ..."
})

-----------------------
--  Grand Champions  --
-----------------------
L = DBM:GetModLocalization(634)

L:SetMiscLocalization({
	YellCombatEnd	= "Well fought! Your next challenge comes from the Crusade's own ranks. You will be tested against their considerable prowess."
})

----------------------------------
--  Argent Confessor Paletress  --
----------------------------------
L = DBM:GetModLocalization(636)

L:SetMiscLocalization({
	YellCombatEnd	= "Excellent work!"
})

-----------------------
--  Eadric the Pure  --
-----------------------
L = DBM:GetModLocalization(635)

L:SetWarningLocalization({
	specwarnRadiance		= "Radiance - Look away"
})

L:SetOptionLocalization({
	specwarnRadiance		= "Show special warning for $spell:66935",
	SetIconOnHammerTarget	= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(66940)
})

L:SetMiscLocalization({
	YellCombatEnd	= "I yield! I submit. Excellent work. May I run away now?"
})

--------------------
--  Pit of Saron  --
---------------------
--  Ick and Krick  --
---------------------
L = DBM:GetModLocalization(609)

L:SetWarningLocalization({
	warnPursuit			= "Pursuit on >%s<",
	specWarnPursuit		= "You are being pursued - Run away"
})

L:SetOptionLocalization({
	warnPursuit				= "Announce Pursuit targets",
	specWarnPursuit			= "Show special warning when you are being pursued",
	SetIconOnPursuitTarget	= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(68987)
})

L:SetMiscLocalization({
	IckPursuit	= "%s is chasing you!",
	Barrage	= "%s begins rapidly conjuring explosive mines!"
})
----------------------------
--  Forgemaster Garfrost  --
----------------------------
L = DBM:GetModLocalization(608)

L:SetWarningLocalization({
	warnSaroniteRock			= "Saronite Rock on >%s<",
	specWarnSaroniteRock		= "Saronite Throw on you - Move",
	specWarnSaroniteRockNear	= "Saronite Throw near you - Move",
	specWarnPermafrost			= "%s: %s"
})

L:SetOptionLocalization({
	warnSaroniteRock			= "Announce $spell:68789 targets",
	specWarnSaroniteRock		= "Show special warning when you are targeted by <br/> $spell:68789",
	specWarnSaroniteRockNear	= "Show special warning when you are near <br/> $spell:68789 target",
	specWarnPermafrost			= "Show special warning when $spell:68786 stacks get too high",
	AchievementCheck			= "Announce 'Doesn't Go to Eleven' achievement warnings to party",
	SetIconOnSaroniteRockTarget	= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(68789)
})

L:SetMiscLocalization({
	SaroniteRockThrow	= "%s hurls a massive saronite boulder at you!",
	AchievementWarning	= "Warning: %s has %d stacks of Permafrost",
	AchievementFailed	= ">> ACHIEVEMENT FAILED: %s has %d stacks of Permafrost <<"
})

----------------------------
--  Scourgelord Tyrannus  --
----------------------------
L = DBM:GetModLocalization(610)

L:SetWarningLocalization({
	specWarnHoarfrost		= "Hoarfrost on you",
	specWarnHoarfrostNear	= "Hoarfrost near you - Move"
})

L:SetTimerLocalization{
	TimerCombatStart	= "Combat starts"
}

L:SetOptionLocalization({
	specWarnHoarfrost			= "Show special warning when you are affected by $spell:69246",
	specWarnHoarfrostNear		= "Show special warning for $spell:69246 near you",
	TimerCombatStart			= "Show timer for start of combat",
	SetIconOnHoarfrostTarget	= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(69246)
})

L:SetMiscLocalization({
	CombatStart	= "Alas, brave, brave adventurers, your meddling has reached its end. Do you hear the clatter of bone and steel coming up the tunnel behind you? That is the sound of your impending demise.",
	HoarfrostTarget	= "The frostwyrm Rimefang gazes at (%S+) and readies an icy attack!",
	YellCombatEnd	= "Impossible.... Rimefang.... warn...."
})

----------------------
--  Forge of Souls  --
----------------------
--  Bronjahm  --
----------------
L = DBM:GetModLocalization(615)

L:SetWarningLocalization({
	specwarnSoulstorm	= "Soulstorm - Move in"
})

L:SetOptionLocalization({
	specwarnSoulstorm	= "Show special warning when $spell:68872 is cast (to move in)"
})

-------------------------
--  Devourer of Souls  --
-------------------------
L = DBM:GetModLocalization(616)

L:SetWarningLocalization({
	specwarnMirroredSoul	= "Stop damage",
	specwarnWailingSouls	= "Wailing Souls - Get behind"
})

L:SetOptionLocalization({
	specwarnMirroredSoul	= "Show special warning to stop damage on $spell:69051",
	specwarnWailingSouls	= "Show special warning when $spell:68899 is cast",
	SetIconOnMirroredTarget	= "Set icons on $spell:69051 targets"
})


---------------------------
--  Halls of Reflection  --
---------------------------
--  Wave Timers  --
-------------------
L = DBM:GetModLocalization("HoRWaveTimer")

L:SetGeneralLocalization({
	name = "Wave Timers"
})

L:SetWarningLocalization({
	WarnNewWaveSoon	= "New wave soon",
	WarnNewWave		= "%s incoming"
})

L:SetTimerLocalization({
	TimerNextWave	= "Next wave"
})

L:SetOptionLocalization({
	WarnNewWave			= "Show warning for boss incoming",
	WarnNewWaveSoon		= "Show pre-warning for new wave (after wave 5 boss)",
	ShowAllWaveWarnings	= "Show warnings for all waves",
	TimerNextWave		= "Show timer for next set of waves (after wave 5 boss)",
	ShowAllWaveTimers	= "Show pre-warning and timers for all waves (Inaccurate)"
})

L:SetMiscLocalization({
	Falric		= "Falric",
	WaveCheck	= "Spirit Wave = (%d+)/10"
})

--------------
--  Falric  --
--------------
L = DBM:GetModLocalization(601)

--------------
--  Marwyn  --
--------------
L = DBM:GetModLocalization(602)

-----------------------
--  Lich King Event  --
-----------------------
L = DBM:GetModLocalization(603)

L:SetWarningLocalization({
	WarnWave1		= "6 Raging Ghoul, 1 Risen Witch Doctor incoming",--6 Ghoul, 1 WitchDocter
	WarnWave2		= "6 Raging Ghoul, 2 Risen Witch Doctor, 1 Lumbering Abomination incoming",--6 Ghoul, 2 WitchDocter, 1 Abom
	WarnWave3		= "6 Raging Ghoul, 2 Risen Witch Doctor, 2 Lumbering Abomination incoming",--6 Ghoul, 2 WitchDocter, 2 Abom
	WarnWave4		= "12 Raging Ghoul, 4 Risen Witch Doctor, 3 Lumbering Abomination incoming"--12 Ghoul, 3 WitchDocter, 3 Abom
})

L:SetTimerLocalization({
	achievementEscape	= "Time to escape"
})

L:SetOptionLocalization({
	ShowWaves	= "Show warning for incoming waves"
})

L:SetMiscLocalization({
	Ghoul			= "Raging Ghoul",--creature id 36940. Not sure how to use these in function above to simplify locals though. :\
	Abom			= "Lumbering Abomination",--creature id 37069
	WitchDoctor		= "Risen Witch Doctor",--creature id 36941
	ACombatStart	= "He is too powerful. We must leave this place at once! My magic can hold him in place for only a short time. Come quickly, heroes!",
	HCombatStart	= "He's... too powerful. Heroes, quickly... come to me! We must leave this place at once! I will do what I can to hold him in place while we flee.",
	Wave1			= "There is no escape!",
	Wave2			= "Succumb to the chill of the grave.",
	Wave3			= "Another dead end.",
	Wave4			= "How long can you fight it?",
	YellCombatEnd	= "FIRE! FIRE!"
})
