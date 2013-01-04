if GetLocale() ~= "koKR" then return end

local L

---------------------------
--  Trash - Lower Spire  --
---------------------------
L = DBM:GetModLocalization("LowerSpireTrash")

L:SetGeneralLocalization{
	name = "성채 하층부 일반구간"
}

L:SetWarningLocalization{
	SpecWarnTrap				= "함정 활성화! - 죽음에 속박된 감시자!"
}

L:SetOptionLocalization{
	SpecWarnTrap				= "함정 활성화 특수 경고 보기",
	SetIconOnDarkReckoning		= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(69483),
	SetIconOnDeathPlague		= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(72865)
}

L:SetMiscLocalization{
	WarderTrap1					= "거기... 누구냐?",
	WarderTrap2					= "내가... 깨어난다!",
	WarderTrap3					= "주인님의 성소를 어지럽혔구나!"
}

---------------------------
--  Trash - Plagueworks  --
---------------------------
L = DBM:GetModLocalization("PlagueworksTrash")

L:SetGeneralLocalization{
	name = "역병작업장 일반구간"
}

L:SetWarningLocalization{
	WarnMortalWound				= "%s : >%s< (%d)",
	SpecWarnTrap				= "함정 활성화! - 복수의 육신해체자!"
}

L:SetOptionLocalization{
	SpecWarnTrap 				= "함정 활성화 특수 경고 보기",
	WarnMortalWound				= DBM_CORE_AUTO_ANNOUNCE_OPTIONS.spell:format(71127)
}

L:SetMiscLocalization{
	FleshreaperTrap1			= "서둘러! 저놈들 뒤에서 습격하자!",
	FleshreaperTrap2			= "우리에게서... 벗어날 수 없다!",
	FleshreaperTrap3			= "살아있는 놈이... 여기에?!"
}

---------------------------
--  Trash - Crimson Hall  --
---------------------------
L = DBM:GetModLocalization("CrimsonHallTrash")

L:SetGeneralLocalization{
	name = "진홍빛 전당 일반구간"
}

L:SetWarningLocalization{
}

L:SetOptionLocalization{
	BloodMirrorIcon		= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(70451)
}

L:SetMiscLocalization{
}

---------------------------
--  Trash - Frostwing Hall  --
---------------------------
L = DBM:GetModLocalization("FrostwingHallTrash")

L:SetGeneralLocalization{
	name = "서리날개 전당 일반구간"
}

L:SetWarningLocalization{
	SpecWarnGosaEvent	= "신드라고사 수호병"
}

L:SetTimerLocalization{
	GosaTimer			= "신비한 강타"
}

L:SetOptionLocalization{
	SpecWarnGosaEvent	= "신드라고사 수호병 특수 경고 보기",
	GosaTimer			= "신비한 강타 유지시간 바 표시"
}

L:SetMiscLocalization{
	SindragosaEvent		= "서리 여왕께 다가가도록 두지 않겠다. 서둘러라! 저들을 막아라!"
}

----------------------
--  Lord Marrowgar  --
----------------------
L = DBM:GetModLocalization("LordMarrowgar")

L:SetGeneralLocalization{
	name = "군주 매로우가르"
}

L:SetWarningLocalization{
	WarnImpale				= "꿰뚫기 : >%s<"
}

L:SetTimerLocalization{
	AchievementBoned		= "뼈도 못 추릴라 업적 가능"
}

L:SetOptionLocalization{
	WarnImpale				= "$spell:69062 대상 알림 보기",
	AchievementBoned		= "뼈도 못 추릴라 업적 바 표시",
	SetIconOnImpale			= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(69062)
}

-------------------------
--  Lady Deathwhisper  --
-------------------------
L = DBM:GetModLocalization("Deathwhisper")

L:SetGeneralLocalization{
	name = "여교주 데스위스퍼"
}

L:SetWarningLocalization{
	WarnReanimating					= "이교도 부활",
	WarnTouchInsignificance			= "%s : >%s< (%d)",
	WarnAddsSoon					= "곧 새로운 이교도 추가"
}

L:SetTimerLocalization{
	TimerAdds						= "이교도 추가"
}

L:SetOptionLocalization{
	WarnAddsSoon					= "이교도 추가 사전 알림 보기",
	WarnReanimating					= "이교도 부활을 시전시 알림 보기",
	TimerAdds						= "새로운 이교도 추가 바 표시",
	ShieldHealthFrame				= "우두머리 체력 바 사용시 $spell:70842 바 함께 보기",
	WarnTouchInsignificance			= DBM_CORE_AUTO_ANNOUNCE_OPTIONS.spell:format(71204),
	SetIconOnDominateMind			= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(71289),
	SetIconOnDeformedFanatic		= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(70900),
	SetIconOnEmpoweredAdherent		= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(70901)
}

L:SetMiscLocalization{
	YellPull						= "이게 무슨 소란이지? 감히 이 신성한 땅을 지나가려 해? 여기가 마지막 숨을 거둘 곳이 되리라!",
	YellReanimatedFanatic			= "일어나라, 순수한 모습을 기뻐하라!",
	ShieldPercent					= "마나 방벽",
	Fanatic1						= "교단 광신자",
	Fanatic2						= "변형된 광신자",
	Fanatic3						= "되살아난 광신자"
}

----------------------
--  Gunship Battle  --
----------------------
L = DBM:GetModLocalization("GunshipBattle")

L:SetGeneralLocalization{
	name = "얼음왕관 비행선 전투"
}

L:SetWarningLocalization{
	WarnBattleFury		= "%s (%d)",
	WarnAddsSoon		= "곧 추가 병력"
}

L:SetTimerLocalization{
	TimerCombatStart	= "전투 시작",
	TimerAdds			= "다음 추가 병력"
}

L:SetOptionLocalization{
	WarnBattleFury		= DBM_CORE_AUTO_ANNOUNCE_OPTIONS.spell:format(69638),
	TimerCombatStart	= "전투 시작 바 표시",
	WarnAddsSoon		= "추가 병력 사전 알림 보기",
	TimerAdds			= "다음 추가 병력 바 표시"
}

L:SetMiscLocalization{
	PullAlliance		= "속도를 올려라! 제군들, 곧 운명과 마주할 것이다!",
	KillAlliance		= "악당 놈들, 분명히 경고했다! 형제자매여, 전진!",
	PullHorde			= "호드의 아들딸이여, 일어나라! 오늘 우리는 증오하던 적과 전투를 벌이리라! 록타르 오가르!",
	KillHorde			= "얼라이언스는 기가 꺾였다. 리치 왕을 향해 전진하라!",
	AddsAlliance		= "Reavers, Sergeants, attack",--확인필요
	AddsHorde			= "해병, 하사관, 공격하라!",
	MageAlliance		= "We're taking hull damage, get a battle-mage out here to shut down those cannons!",--확인필요
	MageHorde			= "선체가 공격받고 있다. 마술사를 불러 저 대포를 막아버려라!"
}

-----------------------------
--  Deathbringer Saurfang  --
-----------------------------
L = DBM:GetModLocalization("Deathbringer")

L:SetGeneralLocalization{
	name = "죽음의 인도자 사울팽"
}

L:SetWarningLocalization{
	WarnFrenzySoon			= "곧 광기",
	warnMark 				= "타락한 용사의 징표 (%d) : >%s<"
}

L:SetTimerLocalization{
	TimerCombatStart		= "전투 시작"
}

L:SetOptionLocalization{
	warnMark				= "$spell:72293 대상 알림 보기",
	TimerCombatStart		= "전투 시작 바 표시",
	WarnFrenzySoon			= "광기 사전 알림 보기(33% 이하)",
	BoilingBloodIcons		= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(72385),
	RangeFrame				= "거리 창 보기(12m)",
	RunePowerFrame			= "우두머리 체력 바 사용시 $spell:72371 바 함께 보기",
	BeastIcons				= "피의 괴물에 전술 목표 아이콘 설정"
}

L:SetMiscLocalization{
	RunePower				= "피 마력",
	PullHorde				= "코르크론, 출발하라! 용사들이여, 뒤를 조심하게. 스컬지는...",
	PullAlliance			= "그러면 이동하자! 이동...",
}

-----------------
--  Festergut  --
-----------------
L = DBM:GetModLocalization("Festergut")

L:SetGeneralLocalization{
	name = "구린속"
}

L:SetWarningLocalization{
	InhaledBlight			= "파멸의 역병 들이마심 : >%d<",
	WarnGastricBloat		= "%s : >%s< (%d)",		-- Gastric Bloat on >args.destName< (args.amount)
}

L:SetOptionLocalization{
	InhaledBlight			= "$spell:69166 경고 보기",
	RangeFrame				= "거리 창 보기(8m)",
	WarnGastricBloat		= DBM_CORE_AUTO_ANNOUNCE_OPTIONS.spell:format(72219),
	SetIconOnGasSpore		= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(69279),
	AnnounceSporeIcons		= "$spell:69279 전술 목표 아이콘 설정 내역을 공격대 대화로 알리기\n(공격대장 권한 필요)",
	AchievementCheck		= "역병 예방 접종 업적 실패시 실패 내용을 공격대 대화로 알리기\n(공격대장 권한 필요)"
}

L:SetMiscLocalization{
	SporeSet				= "가스 포자 징표{rt%d} : %s",
	AchievementFailed		= ">> 업적 실패 - 역병 저항 : %s (%d 중첩) <<"
}

---------------
--  Rotface  --
---------------
L = DBM:GetModLocalization("Rotface")

L:SetGeneralLocalization{
	name = "썩은얼굴"
}

L:SetWarningLocalization{
	WarnOozeSpawn				= "작은 수액괴물 생성",
	WarnUnstableOoze			= "%s : >%s< (%d)",
	SpecWarnLittleOoze			= "작은 수액괴물의 공격! - 뛰세요!"
}

L:SetTimerLocalization{
	NextPoisonSlimePipes		= "다음 수액 홍수"
}

L:SetOptionLocalization{
	NextPoisonSlimePipes		= "다음 수액 홍수 바 표시",
	WarnOozeSpawn				= "작은 수액괴물 생성 알림 보기",
	SpecWarnLittleOoze			= "작은 수액괴물에게 공격을 받을 경우 특수 경고 보기",
	RangeFrame					= "거리 창 보기(8m)",
	WarnUnstableOoze			= DBM_CORE_AUTO_ANNOUNCE_OPTIONS.spell:format(69558),
	InfectionIcon				= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(69674),
	TankArrow					= "큰 수액괴물 탱커 방향 으로 DBM 화살표 보기(부정확함)"
}

L:SetMiscLocalization{
	YellSlimePipes1				= "좋은 소식이에요, 여러분! 독성 수액 배출관을 고쳤어요!",
	YellSlimePipes2				= "끝내 주는 소식이에요, 여러분! 수액이 다시 나오는군요!"
}

---------------------------
--  Professor Putricide  --
---------------------------
L = DBM:GetModLocalization("Putricide")

L:SetGeneralLocalization{
	name = "교수 퓨트리사이드"
}

L:SetWarningLocalization{
	WarnPhase2Soon				= "곧 2 단계",
	WarnPhase3Soon				= "곧 3 단계",
	WarnMutatedPlague			= "%s : >%s< (%d)",
	SpecWarnMalleableGoo		= "당신에게 유연한 끈적이 - 이동하세요!",
	SpecWarnMalleableGooNear	= "당신 주변에 유연한 끈적이 - 벗어나세요!"
}

L:SetOptionLocalization{
	WarnPhase2Soon				= "2 단계 사전 알림 보기(83% 이하)",
	WarnPhase3Soon				= "3 단계 사전 알림 보기(38% 이하)",
	SpecWarnMalleableGoo		= "$spell:72295 첫번째 대상이 당신일 경우 특수 경고 보기",
	SpecWarnMalleableGooNear	= "$spell:72295 첫번째 대상이 근처에 있을 경우 특수 경고 보기",
	WarnMutatedPlague			= DBM_CORE_AUTO_ANNOUNCE_OPTIONS.spell:format(72451),
	OozeAdhesiveIcon			= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(70447),
	GaseousBloatIcon			= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(70672),
	UnboundPlagueIcon			= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(70911),
	MalleableGooIcon			= "$spell:72295 대상에게 전술 목표 아이콘 설정",
	YellOnMalleableGoo			= "$spell:72295 주문의 영향을 받은 경우 대화로 알리기",
	YellOnUnbound				= "$spell:70911 주문의 영향을 받은 경우 대화로 알리기",
	GooArrow					= "$spell:72295 첫번째 대상이 당신 주변에 있을 경우 DBM 화살표 보기"
}

L:SetMiscLocalization{
	YellPull					= "좋은 소식이에요, 여러분! 아제로스의 모든 생명체를 파괴할 역병을 완성했어요!",
	YellMalleable				= "나에게 통통이~!",
	YellUnbound					= "나에게 역병~! 이리오삼~!"
}

----------------------------
--  Blood Prince Council  --
----------------------------
L = DBM:GetModLocalization("BPCouncil")

L:SetGeneralLocalization{
	name = "피의 공작 의회"
}

L:SetWarningLocalization{
	WarnTargetSwitch			= "대상 전환 : %s",
	WarnTargetSwitchSoon		= "곧 대상 전환",
	SpecWarnVortex				= "당신에게 충격의 소용돌이 - 이동!",
	SpecWarnVortexNear			= "당신 주변에 충격의 소용돌이 - 확인!"	
}

L:SetTimerLocalization{
	TimerTargetSwitch			= "대상 전환"
}

L:SetOptionLocalization{
	WarnTargetSwitch			= "대상 전환 알림 보기",
	WarnTargetSwitchSoon		= "대상 전환 사전 알림 보기",
	TimerTargetSwitch			= "다음 대상 전환 바 표시",
	SpecWarnVortex				= "$spell:72037 대상이 자신일 경우 특수 경고 보기",
	SpecWarnVortexNear			= "$spell:72037 대상이 근처에 있을 경우 특수 경고 보기",
	EmpoweredFlameIcon			= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(72040),
	ActivePrinceIcon			= "활성화 된 공작에게 전술 목표 아이콘 설정(해골)",
	RangeFrame					= "거리 창 보기(12m)",
	VortexArrow					= "$spell:72037 대상이 근처에 있을 경우 DBM 화살표 보기"
}


L:SetMiscLocalization{
	Keleseth					= "공작 켈레세스",
	Taldaram					= "공작 탈다람",
	Valanar						= "공작 발라나르",
	EmpoweredFlames				= "강력한 불꽃이"
}

-----------------------
--  Queen Lana'thel  --
-----------------------
L = DBM:GetModLocalization("Lanathel")

L:SetGeneralLocalization{
	name = "피의 여왕 라나텔"
}

L:SetOptionLocalization{
	SetIconOnDarkFallen		= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(71340),
	SwarmingShadowsIcon		= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(71266),
	BloodMirrorIcon			= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(70838),
	RangeFrame				= "거리 창 보기(8m)",
	YellOnFrenzy			= "$spell:70877 주문의 영향을 받은 경우 대화로 알리기"
}

L:SetMiscLocalization{
	SwarmingShadows			= "어둠이 쌓이더니",
	YellFrenzy				= "피가 모잘라~! 앙~"
}

-----------------------------
--  Valithria Dreamwalker  --
-----------------------------
L = DBM:GetModLocalization("Valithria")

L:SetGeneralLocalization{
	name = "발리스리아 드림워커"
}

L:SetWarningLocalization{
	WarnCorrosion				= "%s : >%s< (%d)",
	WarnPortalOpen				= "차원문 열림"
}

L:SetTimerLocalization{
	TimerPortalsOpen			= "차원문 열림",
	TimerBlazingSkeleton		= "다음 타오르는 해골",
	TimerAbom					= "다음 누더기골렘"
}

L:SetOptionLocalization{
	SetIconOnBlazingSkeleton	= "타오르는 해골에게 전술 목표 아이콘 설정(해골)",
	WarnPortalOpen				= "$spell:72483 열림 알림 보기",
	TimerPortalsOpen			= "악몽의 차원문 생성 바 표시",
	TimerBlazingSkeleton		= "다음 타오르는 해골 바 표시",
	TimerAbom					= "다음 걸신들린 누더기골렘 바 표시(부정확할 수 있음)",
	WarnCorrosion				= DBM_CORE_AUTO_ANNOUNCE_OPTIONS.spell:format(70751)
}

L:SetMiscLocalization{
	YellPull		= "침입자들이 내부 성소로 들어왔다. 서둘러 녹색용을 파멸시켜라! 되살려 낼 때 쓸 뼈와 힘줄만 남겨라!",
	YellKill		= "다시 힘을 얻었다! 이세라여, 더러운 생명들에 안식을 내릴 수 있도록 은혜를 베푸소서!",
	YellPortals		= "에메랄드의 꿈으로 가는 차원문을 열어두었다. 너희의 구원은 그 안에 있다...",
	YellPhase2		= "힘이 돌아오고 있다. 영웅들이여, 계속 싸워라!"
}

------------------
--  Sindragosa  --
------------------
L = DBM:GetModLocalization("Sindragosa")

L:SetGeneralLocalization{
	name = "신드라고사"
}

L:SetWarningLocalization{
	WarnPhase2soon			= "곧 2 단계",
	WarnAirphase			= "공중 단계",
	WarnGroundphaseSoon		= "곧 신드라고사 착륙",
	WarnInstability			= "불안정 : >%d<",
	WarnChilledtotheBone	= "사무치는 한기 : >%d<",
	WarnMysticBuffet		= "신비한 강타 : >%d<"
}

L:SetTimerLocalization{
	TimerNextAirphase		= "다음 공중 단계",
	TimerNextGroundphase	= "다음 지상 단계",
	AchievementMystic		= "신비한 아픔 업적 가능"
}

L:SetOptionLocalization{
	WarnAirphase				= "공중 단계 알림 보기",
	WarnGroundphaseSoon			= "지상 단계 사전 알림 보기",
	WarnPhase2soon				= "2 단계 사전 알림 보기(38% 이하)",
	TimerNextAirphase			= "다음 공중 단계 바 표시",
	TimerNextGroundphase		= "다음 지상 단계 바 표시",
	WarnInstability				= "$spell:69766 중첩 알림 보기",
	WarnChilledtotheBone		= "$spell:70106 중첩 알림 보기",
	WarnMysticBuffet			= "$spell:70128 중첩 알림 보기",
	AnnounceFrostBeaconIcons	= "$spell:70126 전술 목표 아이콘 설정 내역을 공격대 대화로 알리기\n(공격대장 권한 필요)",
	SetIconOnFrostBeacon		= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(70126),
	SetIconOnUnchainedMagic		= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(69762),
	ClearIconsOnAirphase		= "공중 단계에서 모든 전술 목표 아이콘 제거",
	AchievementCheck			= "신비한 아픔 업적 실패시 실패 내용을 공격대 대화로 알리기\n(공격대장 권한 필요)",
	RangeFrame					= "강화 또는 약화 효과 상태에 맞추어 거리 창 보기(10/20m)"
}

L:SetMiscLocalization{
	YellAirphase			= "여기가 끝이다! 아무도 살아남지 못하리라!",
	YellAirphaseDem			= "Rikk zilthuras rikk zila Aman adare tiriosh",
	YellPhase2				= "자, 주인님의 무한한 힘을 느끼고 절망에 빠져보아라!",
	YellPhase2Dem			= "Zar kiel xi romathIs zilthuras revos ruk toralar",
	BeaconIconSet			= "냉기 봉화 아이콘{rt%d} : %s",
	AchievementWarning		= "경고 : %s님의 신비한 강타가 5 중첩입니다.",
	AchievementFailed		= ">> 업적 실패 - 신비한 아픔 : %s (%d 중첩) <<",
	YellPull				= "여기까지 오다니 너무나 어리석구나. 노스렌드의 얼음 바람이 영혼까지 삼키리라!"
}

---------------------
--  The Lich King  --
---------------------
L = DBM:GetModLocalization("LichKing")

L:SetGeneralLocalization{
	name = "리치 왕"
}

L:SetWarningLocalization{
	WarnPhase2Soon				= "곧 2 단계",
	WarnPhase3Soon				= "곧 3 단계",
	ValkyrWarning				= "발키리 : >%s<",
	SpecWarnYouAreValkd			= "발키리가 납치 중!",
	SpecWarnDefileCast			= "당신에게 파멸! - 이동!",
	SpecWarnDefileNear			= "당신 주변에 파멸! - 이동!",
	SpecWarnTrapNear			= "당신 주변에 암흑의 덫 - 확인!",
	WarnNecroticPlagueJump		= "괴저 역병 전이 : >%s<",
	SpecWarnPALGrabbed			= "발키리가 신기 납치 : %s",
	SpecWarnPRIGrabbed			= "발키리가 사제 납치 : %s",
	SpecWarnValkyrLow			= "발키리 HP 55% 이하!!"
}

L:SetTimerLocalization{
	TimerCombatStart			= "전투 시작",
	TimerRoleplay				= "이벤트 종료",
	PhaseTransition				= "다음 단계 전환",
	TimerNecroticPlagueCleanse 	= "괴저 역병 사라짐"
}

L:SetOptionLocalization{
	TimerCombatStart			= "전투 시작 바 표시",
	TimerRoleplay				= "이벤트 종료 바 표시",
	WarnNecroticPlagueJump		= "$spell:70337 전이 대상 알림",
	TimerNecroticPlagueCleanse	= "$spell:70337 사라짐 바 표시",
	PhaseTransition				= "다음 단계 전환 바 표시",
	WarnPhase2Soon				= "2 단계 사전 알림 보기(73% 이하)",
	WarnPhase3Soon				= "3 단계 사전 알림 보기(43% 이하)",
	ValkyrWarning				= "발키리 대상 알림 보기",
	SpecWarnYouAreValkd			= "발키리에게 붙잡혔을 때 특수 경고 보기",
	SpecWarnHealerGrabbed		= "성기사/사제(힐러) 가 발키리에게 붙잡힌 경우 특수 경고 보기\n(대상자가 DBM을 사용해야 합니다.)",
	SpecWarnDefileCast			= "$spell:72762 주문의 대상이 자신일 경우 특수 경고 보기",
	SpecWarnDefileNear			= "$spell:72762 대상이 근처에 있을 경우 특수 경고 보기",
	SpecWarnTrapNear			= "$spell:73539 대상이 근처에 있을 경우 특수 경고 보기",
	YellOnDefile				= "$spell:72762 주문의 영향을 받은 경우 대화로 알리기",
	YellOnTrap					= "$spell:73539 주문의 영향을 받은 경우 대화로 알리기",
	DefileIcon					= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(72762),
	HarvestSoulIcon				= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(68980),
	NecroticPlagueIcon			= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(70337),
	RagingSpiritIcon			= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(69200),
	TrapIcon					= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(73539),
	ValkyrIcon					= "발키리에 전술 목표 아이콘 설정",
	DefileArrow					= "$spell:72762 대상이 근처에 있을 경우 DBM 화살표 보기",
	TrapArrow					= "$spell:73539 대상이 근처에 있을 경우 DBM 화살표 보기",
	AnnounceValkGrabs			= "발키리 대상 및 전술 목표 아이콘 설정 내용을 공격대 대화로 알리기\n(공격대장 권한 필요)",
	SpecWarnValkyrLow			= "발키리의 HP가 55%이하가 될 경우 특수 경고 보기",
	AnnouncePlagueStack			= "$spell:70337 중첩 알림 보기(10중첩 이상일때, 5 중첩마다)\n(공격대장 권한 필요)"
}

L:SetMiscLocalization{
	LKPull					= "그러니까 성스러운 빛이 자랑하던 정의가 마침내 왔다 이건가? 폴드링, 서리한을 내려놓고 자비라도 애걸하라는 건가?",
	YellDefile				= "저에게 파멸!!!",
	YellTrap				= "나에게 암흑의 덫!!!",
	YellValk				= "끌려 가는 중! 살려주삼!",
	YellKill				= "어떤 의문도 남지 않았다. 어떤 의심도 없다. 너희는 아제로스의 가장 위대한 용사들이다. 너희 앞에 놓아둔 모든 도전을 극복해 내었다. 가장 강력한 종들이 너희의 무자비한 살육 앞에 쓰러졌지... 너희가 억눌렀던 분노 앞에 말이다...",
	LKRoleplay				= "진정으로 정의에 이끌렸단 말이냐? 궁금하구나...",
	ValkGrabbedIcon			= "발키리 납치 : {rt%d} %s",
	ValkGrabbed				= "발키리 납치 : %s",
	PlagueStackWarning		= "경고: 괴저역병 - %s (%d 중첩)",
	AchievementCompleted	= ">> 업적 성공 - 괴저역병 %s (%d 중첩) <<",
	PlagueWhisper			= "에 감염되었습니다!"
}