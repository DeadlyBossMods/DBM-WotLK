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
	WarningSnobold				= "스노볼트 부하 생성"
}

L:SetTimerLocalization{
	TimerNextBoss				= "곧 다음 우두머리",
	TimerEmerge					= "출현",
	TimerSubmerge				= "숨기"
}

L:SetOptionLocalization{
	WarningSnobold				= "스노볼트 부하 생성 알림 보기",
	ClearIconsOnIceHowl			= "사나운 돌진 전에 모든 전술 목표 아이콘 지움",
	PingCharge					= "사나운 돌진 대상이 있는 위치를 미니맵에 보기",
	TimerNextBoss				= "다음 우두머리 등장 바 보기",
	TimerEmerge					= "출현 바 보기",
	TimerSubmerge				= "숨기 바 보기",
	IcehowlArrow				= "사나운 돌진 대상이 가까이 있을 경우 DBM 화살표 보기"
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

L:SetOptionLocalization{
	IncinerateShieldFrame		= "우두머리 체력 바 사용시 살점 소각 치유량 바 함께 보기"
}

L:SetMiscLocalization{
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
	YellKill			= "상처뿐인 승리로군. 오늘 받은 손해로 우리 전력은 약해졌네. 이런 어리석은 짓으로 리치 왕 말고 또 누가 이득을 보겠나? 위대한 용사들이 목숨을 잃었네. 무엇을 위해서였나? 진짜 위협은 저 앞에 있네. 리치 왕이 우리 모두를 죽음 안에서 기다린다네."
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
	SpecWarnSpecial				= "차원문 클릭하여 반대 속성으로 변경!",
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
	TimerSpecialSpell			= "다음 속성의 소용돌이 또는 쌍둥이의 서약 바 보기",
	WarnSpecialSpellSoon		= "속성의 소용돌이 또는 쌍둥이의 서약 이전에 일림 보기",
	SpecWarnSpecial				= "속성(색) 변경을 해야할 때 특수 경고 보기",
	SpecWarnSwitchTarget		= "쌍둥이의 서약 대상 전환 특수 경고 보기",
	SpecWarnKickNow				= "쌍둥이의 서약 차단 특수 경고 보기",
	SpecialWarnOnDebuff			= "빛/어둠의 손길 대상이 된 경우 특수 경고 보기",
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
	warnAdds				= "네루비안 땅무지"
}

L:SetTimerLocalization{
	TimerEmerge			= "다음 출현",
	TimerSubmerge		= "다음 잠수",
	timerAdds			= "다음 네루비안 땅무지"
}

L:SetOptionLocalization{
	WarnEmerge					= "출현 알림 보기",
	WarnEmergeSoon				= "출현 이전에 알림 보기",
	WarnSubmerge				= "잠수 알림 보기",
	WarnSubmergeSoon			= "잠수 이전에 알림 보기",
	specWarnSubmergeSoon		= "잠수 10초 전 특수 경고 보기",
	warnAdds					= "네루비안 땅무지 알림 보기",
	timerAdds					= "다음 네루비안 땅무지 바 보기",
	TimerEmerge					= "다음 출현 바 보기",
	TimerSubmerge				= "다음 잠수 바 보기",
	AnnouncePColdIcons			= "$spell:66013 전술 목표 아이콘 설정시 공격대 대화로 알리기(공격대장 권한 필요)",
	AnnouncePColdIconsRemoved	= "$spell:66013 전술 목표 아이콘 제거시 공격대 대화로 알리기(위 설정 필요)"
}

L:SetMiscLocalization{
	YellPull				= "여기가 네 무덤이 되리라!",
--	Swarm					= "착취의 무리가 너희를 덮치리라!",
	Emerge					= "땅속에서 모습을 드러냅니다!",
	Burrow					= "땅속으로 숨어버립니다!",
	PcoldIconSet			= "냉기 관통 아이콘{rt%d} : %s",
	PcoldIconRemoved		= "냉기 관통 아이콘 제거 : %s"
}
