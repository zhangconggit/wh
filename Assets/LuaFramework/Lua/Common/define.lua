-- 文件：公共定义类

require "Model/Global"

network_delay = 100
IS_APP_STORE_CHECK = false
IS_COMPLETE_FUNCTION = false

-- 控制器定义--
CtrlNames = {
	Login = "LoginCtrl",
	MainSence = "MainSenceCtrl",
	CreateRoom = "CreateRoomCtrl",
	JoinRoom = "JoinRoomCtrl",
	Activity = "ActivityCtrl",
	PlayMethod = "PlayMethodCtrl",
	Share = "ShareCtrl",
	SetSystem = "SetSystemCtrl",
	DissolutionRoomTips = "DissolutionRoomTipsCtrl",
	OB_GameMain = "OB_GameMainCtrl",
	XZ_GameMain="XZ_GameMainCtrl",
	RM_GameMain = "RM_GameMainCtrl",
	GameChat = "GameChatCtrl",
	MessageTips = "MessageTipsCtrl",
	TotalSettlement = "TotalSettlementCtrl",
	NoticeTips = "NoticeTipsCtrl",
	DissolutionRoom = "DissolutionRoomCtrl",
	RoleInfo = "RoleInfoCtrl",
	Grade = "GradeCtrl",
	GradeDetail = "GradeDetailCtrl",
	DissolutionSuccess = "DissolutionSuccessCtrl",
	SingleSettlement = "SingleSettlementCtrl",
	DiamondPay = "DiamondPayCtrl",
	BlockLayer = "BlockLayerCtrl",
	PlayCardRole = "PlayCardRoleCtrl",
	Talk = "TalkCtrl",
	Tip = "TipCtrl",
	TH_GameMain = "TH_GameMainCtrl",
	TH_RoleInfo = "TH_RoleInfoCtrl",
	TH_TotalSettlement = "TH_TotalSettlementCtrl",
	GameMatch = "GameMatchCtrl",
	GameRoomCardMatch = "GameRoomCardMatchCtrl",
	GameMatchDetail = "GameMatchDetailCtrl",
	GameMatchRecord = "GameMatchRecordCtrl",
	GameMatchRankList = "GameMatchRankListCtrl",
	GameQuitMatchHint = "GameQuitMatchHintCtrl",
	GameMatchSettle = "GameMatchSettleCtrl",
	CH_GameMain = "CH_GameMainCtrl",
	Ll_GameMain = "Ll_GameMainCtrl",
	ShopMall = "ShopMallCtrl",
	-- 商城
	GPSInfo = "GPSInfoCtrl",
	-- SystemNotice = "SystemNoticeCtrl",
	DalyCheck = "DalyCheckCtrl",
	-- 签到
	RotaryTable = "RotaryTableCtrl",
	-- 转盘
	RankList = "RankListCtrl",
	-- 排行榜
	UI_WuZiQi = "UI_WuZiQiCtrl",
	-- 五子棋
	Mail = "MailCtrl",
	-- 邮件
	GameSetting = "GameSettingCtrl",-- 侧边框
	MyClub = "MyClubCtrl", 			--俱乐部
}
	
-- 1 代表筒，2 代表条， 3 代表 万  4代表风 5代表赖子
ColorType = {

	MAHJONG_TONG = 1,
	MAHJONG_TIAO = 2,
	MAHJONG_WAN = 3,
	MAHJONG_FENG = 4,
	MAHJONG_LZ = 5,

	FENG_TYPE_DONG = 10,
	-- 依次代表 东西南北中发白*/
	FENG_TYPE_XI = 11,
	FENG_TYPE_NAN = 12,
	FENG_TYPE_BEI = 13,
	FENG_TYPE_ZHONG = 14,
	FENG_TYPE_FA = 15,
	FENG_TYPE_BAI = 16,
	FENG_TYPE_LZ = 17,
}

-- 1代表碰,2代表暗杠，3代表明杠，4代表过路杠，5代表胡，6代表自摸，7代表过
SingType = {
	SING_PENG = 1,
	SING_ANGANG = 2,
	SING_MINGGANG = 3,
	SING_GUOLUGANG = 4,
	SING_HU = 5,
	SING_ZIMO = 6,
	SING_GUO = 7,
	SING_DUOXIANG = 8,
	SING_GANGHUA = 9,
}


-- 房间相对位置定义；
RelativePosition = {
	Origin = 0,
	Left = 1,
	Right = 2,
	Opposite = 3;
}

RoomStatic = {
	NoneStatic = 0,
	InitStatic = 1,
	DealStatic = 2,
	RunStatic = 3,
	SettlementStatic = 4,
}

-- 麻将 牛牛等房间的枚举
RoomType = {
	None = 0,
	Mahjong = 1,
	Tenharf = 2,
	GoldFlower = 3,
	CatchPock = 4,
	NiuNiu = 5,
	WuZiQi = 6,
	RedDragon = 7,
	Landlords = 8,
	BattleMahjong = 9,
}

-- 初级中级高级房等类型的枚举
placeType = {
	Chuji = 1,
	Zhongji = 2,
	GaoJi = 3,
	HaoHua = 4,
	DaHaoHua = 5,
}

-- 金币房元宝房房卡房
RoomMode = {
	roomCardMode = 0,
	goldMode = 1,
	wingMode = 2,
}

TenHalfCardType = {
	BaoCard = 1,
	ShiDianBanYiXia = 2,
	ShiDianBan = 3,
	WuLei = 4,
	WuHuaLei = 5,
	ShiDianBanLei = 6,
}

TenHalfCardState = {
	KouCard = 1,
	FanKaiCard = 2,
	BaoCard = 3,
}

GameMatchType = {
	RoomCardMatch = 1,
	GoldMatch = 2,
}

CardNameList = {
	"color_1_02","color_1_05","color_1_08",
	"color_1_03","color_1_06","color_1_09",
	"color_1_04","color_1_07","color_1_10",
	"color_1_11","color_1_12","color_1_13",
	"color_1_14",

	"color_2_02","color_2_05","color_2_08",
	"color_2_03","color_2_06","color_2_09",
	"color_2_04","color_2_07","color_2_10",
	"color_2_11","color_2_12","color_2_13",
	"color_2_14",

	"color_3_02","color_3_05","color_3_08",
	"color_3_03","color_3_06","color_3_09",
	"color_3_04","color_3_07","color_3_10",
	"color_3_11","color_3_12","color_3_13",
	"color_3_14",

	"color_4_02","color_4_05","color_4_08",
	"color_4_03","color_4_06","color_4_09",
	"color_4_04","color_4_07","color_4_10",
	"color_4_11","color_4_12","color_4_13",
	"color_4_14",

	"color_5_15","color_5_16","tf_cardFG","tf_cardBG","tf_cardLose","jH_cardBG",
}

-- 协议类型--
ProtocalType = {
	BINARY = 0,
	PB_LUA = 1,
	PBC = 2,
	SPROTO = 3,
}
-- 当前使用的协议类型--
TestProtoType = ProtocalType.PB_LUA;

Util = LuaFramework.Util;
AppConst = LuaFramework.AppConst;
LuaHelper = LuaFramework.LuaHelper;
ByteBuffer = LuaFramework.ByteBuffer;

resMgr = LuaHelper.GetResManager();
panelMgr = LuaHelper.GetPanelManager();
objMgr = LuaHelper.GetObjectManager();
soundMgr = LuaHelper.GetSoundManager();
networkMgr = LuaHelper.GetNetManager();
objPoolManager = LuaHelper.GetObjectPoolManager();
-- spineMgr = LuaHelper.GetSpineManager();

WWW = UnityEngine.WWW;
GameObject = UnityEngine.GameObject;
ParticleSystem = UnityEngine.ParticleSystem;
Input = UnityEngine.Input;
Screen = UnityEngine.Screen;
LocationServiceStatus = UnityEngine.LocationServiceStatus;

Scene = UnityEngine.SceneManagement.Scene
SceneManager = UnityEngine.SceneManagement.SceneManager
Application = UnityEngine.Application
Color = UnityEngine.Color
Physics = UnityEngine.Physics

gameRoom = nil; Texture2D = UnityEngine.Texture2D;
Image = UnityEngine.UI.Image;
global = Global:New();

RoomListMsg = {
	total = 8;
	isSelf = 2;
	isFeng = 1;
	isRed = 2;
	isFishNum = 0;
	isPlayNum = 4;
	isRobot = 2;
}



