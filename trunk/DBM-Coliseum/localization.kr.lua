if GetLocale() ~= "koKR" then return end
local L

------------------------
--  Northrend Beasts  --
------------------------
L = DBM:GetModLocalization("NorthrendBeasts")

L:SetGeneralLocalization{
	name = "노스렌드의 야수"
}

L:SetWarningLocalization{
	WarningSnobold				= "스노볼트 부하 생성",
	SpecialWarningImpale3		= "꿰뚫기 (%d)",
	SpecialWarningAnger3		= "솟구치는 분노 (%d)",	
	SpecialWarningSilence		= "1.5 초이내 진동의 발구르기!!!",
	SpecialWarningCharge		= "당신에게 사나운 돌진! 도망치세요!",
	SpecialWarningChargeNear	= "당신 주변에 사나운 돌진! 도망치세요!",
	SpecialWarningTranq			= "거품 이는 분노! - 지금 평정!"
}

L:SetTimerLocalization{
	TimerNextBoss				= "곧 다음 우두머리",
	TimerCombatStart			= "곧 전투 시작",
	TimerEmerge					= "출현",
	TimerSubmerge				= "숨기"
}

L:SetOptionLocalization{
	WarningSnobold				= "스노볼트 부하 생성 알림 보기",
	SpecialWarningImpale3		= "꿰뚫기 주문이 3 중첩 이상시 특수 경고 보기",
	SpecialWarningAnger3		= "솟구치는 분노 주문이 3 중첩 이상시 특수 경고 보기",
	SpecialWarningSilence		= "진동의 발구르기 특수 경고 보기",
	SpecialWarningCharge		= "얼음울음이 당신에게 사나운 돌진을 할 경우 특수 경고 보기",
	SpecialWarningChargeNear	= "얼음울음이 당신 주변에 사나운 돌진을 할 경우 특수 경고 보기",
	SpecialWarningTranq			= "얼음울음이 거품 이는 분노를 얻었을 경우 특수 경고 보기(해제 가능 클래스)",
	SetIconOnChargeTarget		= "사나운 돌진 대상에게 전술 목표 아이콘 설정(해골)",
	SetIconOnBileTarget			= "타오르는 담즙 대상에게 전술 목표 아이콘 설정",
	ClearIconsOnIceHowl			= "사나운 돌진 시전 전에 모든 전술 목표 아이콘 지움",
	PingCharge					= "사나운 돌진 대상이 있는 위치를 미니맵에 표시",
	TimerNextBoss				= "다음 우두머리 등장 바 표시",
	TimerCombatStart			= "전투 시작 바 표시",
	TimerEmerge					= "출현 바 표시",
	TimerSubmerge				= "숨기 바 표시",
	RangeFrame					= "2 단계에서 거리 창 보기",
	IcehowlArrow				= "얼음울음이 당신 주변으로 돌진할 경우 DBM 화살표 보기"
}

L:SetMiscLocalization{
	Charge			= "노려보며 큰 소리로 울부짖습니다.",
	CombatStart		= "폭풍우 봉우리의 가장 깊고 어두운 동굴에서 온, 꿰뚫는 자 고르목일세! 영웅들이여, 전투에 임하게!",
	Phase2			= "마음을 단단히 먹게, 영웅들이여. 두 배의 공포, 산성아귀와 공포비늘이 투기장으로 들어온다네!",
	Phase3			= "다음은, 소개하는 순간 공기마저 얼어붙게 하는 얼음울음일세! 죽이지 않으면 죽을 걸세, 용사들이여!",
	Gormok			= "꿰뚫는 자 고르목",
	Acidmaw			= "산성아귀",
	Dreadscale		= "공포비늘",
	Icehowl			= "얼음울음"
}

-------------------
-- Lord Jaraxxus --
-------------------
L = DBM:GetModLocalization("Jaraxxus")

L:SetGeneralLocalization{
	name = "군주 자락서스"
}

L:SetWarningLocalization{
	WarnNetherPower				= "황천의 힘 : 군주 자락서스",
	SpecWarnTouch				= "당신에게 자락서스의 손길!",
	SpecWarnTouchNear			= "당신 주변에 자락서스의 손길 : >%s<",
	SpecWarnNetherPower			= "지금 해제!",
	SpecWarnFelFireball			= "지옥 화염구 - 차단!",
}

L:SetTimerLocalization{
	TimerCombatStart			= "전투 시작"
}

L:SetOptionLocalization{
	TimerCombatStart			= "전투 시작 바 표시",
	WarnNetherPower				= "자락서스가 황천의 힘을 얻었을 경우 알림 보기",
	SpecWarnFelFireball			= "지옥 화염구 시전시 특수 경고 보기(차단)",
	SpecWarnTouch				= "자락서스의 손길 주문의 대상이 당신일 경우 특수 경고 보기",
	SpecWarnTouchNear			= "자락서스의 손길 대상이 근처에 있을 경우 특수 경고 보기",
	SpecWarnNetherPower			= "황천의 힘 특수 경고 보기(해제)",
	TouchJaraxxusIcon			= "자락서스의 손길 대상에게 전술 목표 아이콘 설정",
	IncinerateFleshIcon			= "살점 소각 대상에게 전술 목표 아이콘 설정",
	LegionFlameIcon				= "군단 불꽃 대상에게 전술 목표 아이콘 설정",
	LegionFlameWhisper			= "군단 불꽃 대상에게 귓속말 보내기",
	IncinerateShieldFrame		= "우두머리 체력 바 사용시 살점 소각 치유량 바 함께 보기"
}

L:SetMiscLocalization{
	WhisperFlame				= "당신에게 군단 불꽃!",
	IncinerateTarget			= "살점 소각: %s",
	FirstPull					= "대흑마법사 윌프레드 피즐뱅이 다음 상대를 소환할 걸세. 기다리고 있게나."
}

-----------------------
-- Faction Champions --
-----------------------
L = DBM:GetModLocalization("Champions")

L:SetGeneralLocalization{
	name = "진영 대표 용사"
}

L:SetTimerLocalization{
}

L:SetWarningLocalization{
}

L:SetOptionLocalization{
	PlaySoundOnBladestorm	= "칼날폭풍 주문을 시전한 경우 별도 경고음 듣기"
}

L:SetMiscLocalization{
	--Horde NPCS
	Gorgrim				= "죽기 - 고르그림 섀도클리브",			-- 34458
	Birana 				= "조드 - 비라나 스톰후프",				-- 34451
	Erin				= "회드 - 에린 미스트후프",				-- 34459
	Rujkah				= "사냥꾼 - 루즈카",					-- 34448
	Ginselle			= "마법사 - 진셀 블라이트슬링어",		-- 34449
	Liandra				= "신성 - 리안드라 선콜러",				-- 34445
	Malithas			= "징벌 - 말리타스 브라이트블레이드",	-- 34456
	Caiphus				= "수양 - 준엄한 카이푸스",				-- 34447
	Vivienne			= "암흑 - 비비안 블랙위스퍼",			-- 34441
	Mazdinah			= "도적 - 마즈디나",					-- 34454
	Thrakgar			= "정기 - 스락가르",					-- 34444
	Broln				= "고양 - 브롤른 스타우트혼",			-- 34455
	Harkzog				= "흑마법사 - 하크조그",				-- 34450
	Narrhok				= "전사 - 나르호크 스틸브레이커",		-- 34453
	--Alliance NPCS
	Tyrius				= "죽기 - 티리우스 더스크블레이드",		-- 34461
	Kavina				= "조드 - 카비나 그로브송",				-- 34460
	Melador				= "회드 - 멜라도르 베일스트라이더",		-- 34469
	Alyssia 			= "사냥꾼 - 알리시아 문스토커",			-- 34467
	Noozle				= "마법사 - 누즐 위즐스틱",				-- 34468
	Baelnor 			= "징벌 - 벨노르 라이트베이러",			-- 34471
	Velanaa				= "신성 - 벨라나", 						-- 34465
	Anthar				= "수양 - 안타르 포지멘더",				-- 34466
	Brienna				= "암흑 - 브리에나 나이트펠",			-- 34473
	Irieth				= "도적 - 이리에스 섀도스텝",			-- 34472
	Saamul				= "정기 - 사아물", 						-- 34470
	Shaabad				= "고양 - 샤베드", 						-- 34463
	Serissa				= "흑마법사 - 세리사 그림대블러",		-- 34474
	Shocuul				= "전사 - 쇼쿨",						-- 34475

	AllianceVictory 	= "얼라이언스의 영광을 위하여!",--확인필요
	HordeVictory		= "앞으로 일어날 일의 맛보기일 뿐이다. 호드를 위하여!",
	YellKill			= "상처뿐인 승리로군. 오늘 받은 손해로 우리 전력은 약해졌네. 이런 어리석은 짓으로 리치 왕 말고 또 누가 이득을 보겠나? 위대한 용사들이 목숨을 잃었네. 무엇을 위해서였나? 진짜 위협은 저 앞에 있네. 리치 왕이 우리 모두를 죽음 안에서 기다린다네.",
}

------------------
-- Valkyr Twins --
------------------
L = DBM:GetModLocalization("ValkTwins")

L:SetGeneralLocalization{
	name = "발키르 쌍둥이"
}

L:SetWarningLocalization{
	WarnSpecialSpellSoon		= "곧 소용돌이 또는 서약",
	SpecWarnSpecial				= "약화효과 속성(빛/어둠) 변경!",
	SpecWarnSwitchTarget		= "대상 전환!",
	SpecWarnKickNow				= "지금 차단!",
	WarningTouchDebuff			= "손길 : >%s<",
	WarningPoweroftheTwins		= "쌍둥이의 힘 : %s",
	SpecWarnPoweroftheTwins		= "쌍둥이의 힘!"
}

L:SetTimerLocalization{
	TimerSpecialSpell	= "다음 소용돌이/서약"
}

L:SetOptionLocalization{
	TimerSpecialSpell			= "다음 속성의 소용돌이 또는 쌍둥이의 서약 바 표시",
	WarnSpecialSpellSoon		= "속성의 소용돌이 또는 쌍둥이의 서약 사전 일림 보기",
	SpecWarnSpecial				= "속성(색) 변경을 해야할 때 특수 경고 보기",
	SpecWarnSwitchTarget		= "쌍둥이의 서약 도중 대상 전환이 필요할 경우 특수 경고 보기",
	SpecWarnKickNow				= "쌍둥이의 서약이 차단 가능할때 특수 경고 보기(차단)",
	SpecialWarnOnDebuff			= "빛/어둠의 손길 영향을 받은 경우 특수 경고 보기",
	SetIconOnDebuffTarget		= "빛/어둠의 손길 대상에게 전술 목표 아이콘 설정(영웅 난이도)",
	WarningTouchDebuff			= "빛/어둠의 손길 대상 알림 보기",
	WarningPoweroftheTwins		= "쌍둥이의 힘 대상 알림 보기",
	SpecWarnPoweroftheTwins		= "쌍둥이의 힘 특수 경고 보기"
}

L:SetMiscLocalization{
	YellPull 	= "어둠의 주인님을 받들어. 리치 왕을 위하여. 너희에게. 죽음을. 안기리라.",
	Fjola 		= "피욜라 라이트베인",
	Eydis		= "아이디스 다크베인"
}

------------------
-- Anub'arak --
------------------
L = DBM:GetModLocalization("Anub'arak_Coliseum")

L:SetGeneralLocalization{
	name 				= "아눕아락"
}

L:SetWarningLocalization{
	WarnEmerge				= "아눕아락 출현",
	WarnEmergeSoon			= "10초 이내 출현",
	WarnSubmerge			= "아눕아락 잠수",
	WarnSubmergeSoon		= "10초 이내 잠수",
	specWarnSubmergeSoon	= "잠수 10초 전!",
	SpecWarnPursue			= "당신을 추격 합니다!",
	warnAdds				= "네루비안 땅무지",
	SpecWarnShadowStrike	= "어둠의 일격! 지금 차단!"
}

L:SetTimerLocalization{
	TimerEmerge			= "다음 출현",
	TimerSubmerge		= "다음 잠수",
	timerAdds			= "다음 네루비안 땅무지"
}

L:SetOptionLocalization{
	WarnEmerge					= "출현 알림 보기",
	WarnEmergeSoon				= "출현 사전 알림 보기",
	WarnSubmerge				= "잠수 알림 보기",
	WarnSubmergeSoon			= "잠수 사전 알림 보기",
	specWarnSubmergeSoon		= "잠수 10초 전 특수 경고 보기",
	SpecWarnPursue				= "추격 대상이 당신일 경우 특수 경고 보기",
	warnAdds					= "네루비안 땅무지 알림 보기",
	timerAdds					= "다음 네루비안 땅무지 바 표시",
	TimerEmerge					= "다음 출현 바 표시",
	TimerSubmerge				= "다음 잠수 바 표시",
	PlaySoundOnPursue			= "추격 주문의 영향을 받은 경우 별도 경고음 듣기",
	PursueIcon					= "추격 대상에게 전술 목표 아이콘 설정",
	SetIconsOnPCold				= "$spell:66013 대상에게 전술 목표 아이콘 설정",
	SpecWarnShadowStrike		= "$spell:66134 시전시 특수 경고 보기(차단)",
	AnnouncePColdIcons			= "$spell:66013 전술 목표 아이콘 설정 내역을 공격대 대화로 알리기\n(공격대장 권한 필요)",
	AnnouncePColdIconsRemoved	= "$spell:66013 전술 목표 아이콘이 제거될때 공격대 대화로 알리기\n(위 설정이 선택되어 있어야함)"
}

L:SetMiscLocalization{
	YellPull				= "여기가 네 무덤이 되리라!",
--	Swarm					= "착취의 무리가 너희를 덮치리라!",
	Emerge					= "땅속에서 모습을 드러냅니다!",
	Burrow					= "땅속으로 숨어버립니다!",
	PcoldIconSet			= "냉기 관통 아이콘{rt%d} : %s",
	PcoldIconRemoved		= "냉기 관통 아이콘 제거 : %s"
}
