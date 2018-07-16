-- 文件：程序主入口
-- 日期：2017-03-30
require "3rd/sproto/print_r"

require "3rd/pbc/protobuf"
local lpeg = require "lpeg"
local json = require "cjson"
local util = require "3rd/cjson/util"
local sproto = require "3rd/sproto/sproto"
local core = require "sproto.core"
local serpent = require "3rd/serpent"
Event = require 'events'
table.dump_t = serpent.dump
table.block_t = serpent.block

-- pb文件
require "3rd/pblua/ChessInfo_pb"
require "3rd/pblua/InitChesses_pb"
require "3rd/pblua/LoginGame_pb"
require "3rd/pblua/Announce_pb"
require "3rd/pblua/ApplyDisRoom_pb"
require "3rd/pblua/ApplyDisRoomOperate_pb"
require "3rd/pblua/Chat_pb"
require "3rd/pblua/CreateRoom_pb"
require "3rd/pblua/ErrorCode_pb"
require "3rd/pblua/IntTypeReturn_pb"
require "3rd/pblua/JoinRoom_pb"
require "3rd/pblua/LongTypeReturn_pb"
require "3rd/pblua/LookSumScore_pb"
require "3rd/pblua/MoChess_pb"
require "3rd/pblua/OneEndShow_pb"
require "3rd/pblua/PlayBack_pb"
--require "3rd/pblua/PlayChess_pb"
require "3rd/pblua/PushSign_pb"
require "3rd/pblua/PushSignOperate_pb"
require "3rd/pblua/ShowCode_pb"
require "3rd/pblua/Version_pb"
require "3rd/pblua/VersionNotice_pb"
require "3rd/pblua/ZhanJiDetailsInfo_pb"
require "3rd/pblua/ZhanJiInfo_pb"
require "3rd/pblua/QuitMateRoom_pb"
require "3rd/pblua/TingChess_pb"

require "3rd/pblua/StringPara_pb"
require "3rd/pblua/FriendGift_pb"
require "3rd/pblua/CurrencyChange_pb"
require "3rd/pblua/OfflinePush_pb"
require "3rd/pblua/Location_pb"
require "3rd/pblua/ShareFriendster_pb"

-- 签到和转盘
require "3rd/pblua/ShareSign_pb"

-- 闹钟相关协议
require "3rd/pblua/CountDown_pb"

-- 向服务端发送的修改个性签名协议
require "3rd/pblua/ChangeRoleInfo_pb"

-- 邮件相关协议
require "3rd/pblua/LoadMailList_pb" -- 获取邮件列表

-- 玩家用金币兑换元宝
require "3rd/pblua/ConvertCoin_pb"

-- 排行榜协议
require "3rd/pblua/RankingOrder_pb"
require "3rd/pblua/RankingRoleInfo_pb"

-- 十点半相关PB
require "3rd/pblua/CardInfo_pb"
require "3rd/pblua/CreateTenHalfRoom_pb"
require "3rd/pblua/TenHalfStartGame_pb"
require "3rd/pblua/TenHalfBet_pb"
require "3rd/pblua/TenHalfTurn_pb"
require "3rd/pblua/TenHalfBuCard_pb"
require "3rd/pblua/TenHalfVSCard_pb"
require "3rd/pblua/TenHalfSingleSettlement_pb"
require "3rd/pblua/TenHalfSettlementStartGame_pb"
require "3rd/pblua/TenHalfIsBanker_pb"
require "3rd/pblua/TenHalfIsQiangBanker_pb"
require "3rd/pblua/TenHalfTotalSettlement_pb"
-- 炸金花相关PB
require "3rd/pblua/CreateGoldFlowerRoom_pb"
require "3rd/pblua/GoldAddJifen_pb"
require "3rd/pblua/GoldLookCard_pb"
require "3rd/pblua/GoldVSCard_pb"
require "3rd/pblua/GoldSingleSettlement_pb"
require "3rd/pblua/GoldSettlementStartGame_pb"
require "3rd/pblua/GoldTotalSettlement_pb"
require "3rd/pblua/GoldLoseCard_pb"
-- 比赛场相关PB
require "3rd/pblua/VsJoin_pb"
require "3rd/pblua/VsCacheData_pb"
require "3rd/pblua/VsWait_pb"
require "3rd/pblua/VsEnd_pb"
require "3rd/pblua/VsLog_pb"
require "3rd/pblua/VsGetJoinCount_pb"
require "3rd/pblua/VsTrusteeship_pb"

-- 捉麻子
require "3rd/pblua/CreateCatchPockRoom_pb"
require "3rd/pblua/CatchPockDeal_pb"
require "3rd/pblua/CatchPopCard_pb"
require "3rd/pblua/CatchSingleSettlement_pb"
require "3rd/pblua/CatchSettlementStartGame_pb"
require "3rd/pblua/CatchTotalSettlement_pb"
require "3rd/pblua/CatchPockTips_pb"

-- 牛牛
require "3rd/pblua/CreateNiuNiuRoom_pb"
require "3rd/pblua/NiuNiuDeal_pb"
require "3rd/pblua/NiuNiuBet_pb"
require "3rd/pblua/NiuNiuTurn_pb"
require "3rd/pblua/NiuNiuSingleSettlement_pb"
require "3rd/pblua/NiuNiuSettlementStartGame_pb"
require "3rd/pblua/NiuNiuTotalSettlement_pb"
require "3rd/pblua/NiuNiuIsBanker_pb"
require "3rd/pblua/NiuNiuIsQiangBanker_pb"
require "3rd/pblua/NiuNiuChange_pb"
require "3rd/pblua/NiuNiuStatusChange_pb"
require "3rd/pblua/NiuNiuShowCard_pb"
require "3rd/pblua/NiuniuBuCard_pb"

-- 五子棋协议
require "3rd/pblua/CreateWuziqiRoot_pb"
require "3rd/pblua/WuziqiBet_pb"
require "3rd/pblua/WuziqiPlayChess_pb"
require "3rd/pblua/RoleReady_pb"
require "3rd/pblua/GameStart_pb"
require "3rd/pblua/RoleLose_pb"

-- 红中麻将
require "3rd/pblua/CreateHongRoom_pb"

-- 斗地主
require "3rd/pblua/CreateDouDiZhuRoom_pb"
require "3rd/pblua/DouDiZhuPlayRead_pb"
require "3rd/pblua/OpenCard_pb"
require "3rd/pblua/DouDiZhuPockDeal_pb"
require "3rd/pblua/CallLandlord_pb"
require "3rd/pblua/SnatchLandlord_pb"
require "3rd/pblua/AddMultiple_pb"

-- 重连
require "3rd/pblua/ReLoad_pb"

-- 房卡夺宝
require "3rd/pblua/CardIndiana_pb"

-- 大厅
require "3rd/pblua/AutoMateRoom_pb"
require "3rd/pblua/GoldcoinChange_pb"
require "3rd/pblua/WingChange_pb"

-- 血战麻将
require "3rd/pblua/CreateBloodFightRoom_pb"

require "3rd/pblua/BloodFightAllEndShow_pb"
require "3rd/pblua/BloodFightDingQue_pb"
require "3rd/pblua/BloodFightOneEndShow_pb"
require "3rd/pblua/BloodFightPushSign_pb"
require "3rd/pblua/BloodFightPushSignOperate_pb"
require "3rd/pblua/BloodFightReferCard_pb"
require "3rd/pblua/MoChess_pb"
require "3rd/pblua/PlayChess_pb"




-- 获取底注等协议
require "3rd/pblua/SecondLevel_pb"

-- 实名认证
require "3rd/pblua/RealName_pb"

require "Common/define"
require "Common/functions"
require "Util/Invoker"
require "View/BasePanel"
require "Controller/BaseCtrl"
require "Logic/CtrlManager"
require "3rd/sproto/print_r"


require "Logic/Room/OverBeard/GameRoom"
require "Util/Queue"
require "Util/EventManager"
require "Logic/Login"
require "Logic/Main"
require "Logic/Mahjong"
require "Logic/Room/CardObject"
require "Logic/Room/PlayerObject"
require "Logic/Room/RoomObject"
require "Logic/Room/Card/CHCard"
require "Logic/Room/Tenharf/TenharfRoom"
require "Logic/Room/Tenharf/TenharfPlayer"
require "Logic/Room/GoldFlower/GoldFlowerRoom"
require "Logic/Room/GoldFlower/GoldFlowerPlayer"
require "Logic/Room/CatchPock/CatchPockRoom"
require "Logic/Room/CatchPock/CatchPockPlayer"
require "Logic/Room/NiuNiu/NiuNiuPlayer"
require "Logic/Room/NiuNiu/NiuNiuRoom"
require "Logic/Room/Landlords/LandlordsPlayer"
require "Logic/Room/Landlords/LandlordsRoom"
require "Logic/Room/Mahjong/MahjongRoom"
require "Logic/Room/Room"
require "Controller/UI_WuZiQiCtrl"

Game = {
	CardList = { },
	Effect = { },
	Music = { },
	Talk = { },
	cardName = { },
	cardUI = { },
	cardObj = { },
	putongText = { },
	fangyanText = { },
	singText = { },
}
local this = Game

local game
local transform
local gameObject
local WWW = UnityEngine.WWW
local lastEffect = ""
-- 注册面板
function Game.InitViewPanels()
	for k, v in pairs(CtrlNames) do
		dofile("View/" .. k .. "Panel")
	end
end

-- 初始化完成，发送链接服务器信息--
function Game.OnInitOK(isReload)
	this.isReload = isReload

	AppConst.SocketPort = 8600
	--AppConst.SocketAddress = "59.110.219.14"
	--AppConst.SocketAddress = "47.98.119.82"
	AppConst.SocketAddress = "39.105.113.193"
	
	--AppConst.SocketPort = 28888
	--AppConst.SocketAddress = "gamedis.server.hzjiuyou.com"	

	print("=====Game.OnInitOK=====AppConst.SocketAddress=======", AppConst.SocketAddress)

	--print(response_body)

	-- 注册LuaView-
	this.InitViewPanels()
	CtrlManager.Init()
	this.RegistProtocal()
	this.AudioObject()
	-- LoginCtrl:Open("Login")
	SceneManager.LoadScene("login")
	AppConst.uuuIdKeyBytes = nil
	networkMgr:SendConnect()
	-- gameRoom = GameRoom.New()
end

-- 发送消息
function Game.SendProtocal(prot, msg)
	if networkMgr.isConnect then
		local buffer = ByteBuffer.New()
		buffer:WriteInt(tonumber(prot))
		print("Game.SendProtocal", prot)
		if prot ~= "10004" then
			if AppConst.uuuIdKeyBytes == nil then
				print("====AppConst.uuuIdKeyBytes == nil", prot)
				return
			end
			if msg then
				buffer:WriteEnCodeBuffer(msg)
			end
		else
			Network.curTime = Util.GetTime()
		end
		networkMgr:SendMessage(buffer)
	else
		Network.NotConnect()
	end
end

-- 注册网络监听事件
function Game.RegistProtocal()
	EventManager.AddEventListener(Protocal.Login, LoginCtrl.OnLoginRes)
	EventManager.AddEventListener(Protocal.Connect, Network.OnConnect)
	EventManager.AddEventListener(Protocal.Exception, Network.OnException)
	EventManager.AddEventListener(Protocal.Disconnect, Network.OnDisconnect)
	EventManager.AddEventListener(Protocal.ServerError, Network.OnErrorRes)
	EventManager.AddEventListener(Protocal.Version, Network.OnVersion)
	EventManager.AddEventListener(Protocal.CreateRoom, CreateRoomCtrl.OnCreateRoomRes)
	EventManager.AddEventListener(Protocal.JoninRoom, JoinRoomCtrl.OnJoinRoomRes)
	EventManager.AddEventListener(Protocal.DissolutionRoom, DissolutionRoomTipsCtrl.OnDissolutionRoomRes)
	EventManager.AddEventListener(Protocal.HeartBeat, Network.OnHeartBeatRes)
	EventManager.AddEventListener(Protocal.GetNoitceInfo, NoticeTipsCtrl.OnGetNoticeInfoRes)
	EventManager.AddEventListener(Protocal.AddNoitceInfo, NoticeTipsCtrl.OnAddNoticeInfoRes)
	EventManager.AddEventListener(Protocal.DelNoitceInfo, NoticeTipsCtrl.OnDelNoticeInfoRes)
	EventManager.AddEventListener(Protocal.GetVersionNoitceInfo, NoticeTipsCtrl.OnGetVersionNoitceInfoRes)
	EventManager.AddEventListener(Protocal.ApplyDisRoomOperation, DissolutionRoomCtrl.OnDissolutionRoomRes)
	EventManager.AddEventListener(Protocal.ZhanJiInfo, GradeCtrl.OnZhanJiInfoRes)
	EventManager.AddEventListener(Protocal.ZhanJiDetailInfo, GradeDetailCtrl.ZhanJiDetailInfoRes)
	--EventManager.AddEventListener(Protocal.LookSumScore, TotalSettlementCtrl.OnTotalSettlementRes)
	EventManager.AddEventListener(Protocal.ChatInfo, GameChatCtrl.OnChatInfoRes)
	--EventManager.AddEventListener(Protocal.OneEndShow, SingleSettlementCtrl.OnOneEndShowRes)
	EventManager.AddEventListener(Protocal.ReLoad, Network.OnReLoadRes)
	--EventManager.AddEventListener(Protocal.StartGame, OB_GameMainCtrl.StartGameRes)
	EventManager.AddEventListener(Protocal.DiamondChange, MainSenceCtrl.CurrencyChangeRes)
	EventManager.AddEventListener(Protocal.StringPara, OB_GameMainCtrl.StringParaRes)
	EventManager.AddEventListener(Protocal.FriendGift, MainSenceCtrl.DiamondRes)


	EventManager.AddEventListener(Protocal.LouHu, OB_GameMainCtrl.LouHuRes)
	EventManager.AddEventListener(Protocal.GenZhuang, OB_GameMainCtrl.GenZhuangRes)
	--EventManager.AddEventListener(Protocal.Card_Init, GameRoom.OnInitRes);
	--EventManager.AddEventListener(Protocal.Card_Get, GameRoom.OnCardGet);
	--EventManager.AddEventListener(Protocal.Card_Play, RoomRunStatic.OnCardPlay);
	--EventManager.AddEventListener(Protocal.Card_PushSign, RoomRunStatic.OnCardPushSign);
	--EventManager.AddEventListener(Protocal.Card_PushSignOperate, RoomRunStatic.OnCardPushSignOperate);

	EventManager.AddEventListener(Protocal.Card_Ting, RoomRunStatic.OnCardTingOperate);

	EventManager.AddEventListener(Protocal.Card_Init_GM, RoomRunStatic.OnInitGMRes);
	EventManager.AddEventListener(Protocal.ChatInfo, PlayCardRoleCtrl.OnChatInfoRes);

	EventManager.AddEventListener(Protocal.PlayBack, GradeDetailCtrl.OnZhanJiPlayBackRes);

	EventManager.AddEventListener(Protocal.Location, Room.LocationRes);
	EventManager.AddEventListener(Protocal.QuitRoom, Room.OnQuitRoomRes)
	EventManager.AddEventListener(Protocal.ApplyDisRoom, Room.ApplyDisRoomRes)
	EventManager.AddEventListener(Protocal.OfflinePush, Room.OfflinePushRes)

	EventManager.AddEventListener(Protocal.ShareFriendster, ShareCtrl.ShareStateRes)
	EventManager.AddEventListener(Protocal.GetShareState, MainSenceCtrl.GetShareStateRes)

	
	-- 十点半相关协议
	EventManager.AddEventListener(Protocal.CreateTenHalfRoom, CreateShiDianRoomCtrl.OnCreateTenHalfRoomRes)
	EventManager.AddEventListener(Protocal.TenHalfStartGame, TenharfRoom.OnTenHalfStartGameRes)
	EventManager.AddEventListener(Protocal.TenHalfBet, TenharfRoom.OnTenHalfBetRes)
	EventManager.AddEventListener(Protocal.TenHalfTurn, TenharfRoom.OnTenHalfTurnRes)
	EventManager.AddEventListener(Protocal.TenHalfBuCard, TenharfRoom.OnTenHalfBuCardRes)
	EventManager.AddEventListener(Protocal.TenHalfVSCard, TenharfRoom.OnTenHalfVSCardRes)
	EventManager.AddEventListener(Protocal.TenHalfSingleSettlement, TenharfRoom.OnTenHalfSingleSettlementRes)
	EventManager.AddEventListener(Protocal.TenHalfSettlementStartGame, TenharfRoom.OnTenHalfSettlementStartGameRes)
	EventManager.AddEventListener(Protocal.TenHalfIsBanker, TenharfRoom.OnTenHalfIsBankerRes)
	EventManager.AddEventListener(Protocal.TenHalfIsQiangBanker, TenharfRoom.OnTenHalfIsQiangBankerRes)
	EventManager.AddEventListener(Protocal.TenHalfTotalSettlement, TenharfRoom.OnTenHalfTotalSettlementRes)
	EventManager.AddEventListener(Protocal.TenHalfReady, TenharfRoom.TenharfSureRes)
	--

	-- 炸金花相关协议
	EventManager.AddEventListener(Protocal.CreateGoldFlowerRoom, CreateJinHuaRoomCtrl.OnCreateJinHuaRoomRes)
	EventManager.AddEventListener(Protocal.GoldStartGame, GoldFlowerRoom.OnStartGameRes)
	EventManager.AddEventListener(Protocal.GoldDisCards, GoldFlowerRoom.OnQiPaiRes)
	EventManager.AddEventListener(Protocal.GoldAddBet, GoldFlowerRoom.GoldAddJifenRes)
	EventManager.AddEventListener(Protocal.GoldLookCard, GoldFlowerRoom.GoldLookCardRes)
	EventManager.AddEventListener(Protocal.GoldVSCard, GoldFlowerRoom.GoldVSCardRes)
	EventManager.AddEventListener(Protocal.GoldSingleSettlement, GoldFlowerRoom.GoldSingleSettlementRes)
	EventManager.AddEventListener(Protocal.GoldSettlementStartGame, GoldFlowerRoom.GoldSettlementStartGameRes)
	EventManager.AddEventListener(Protocal.GoldTotalSettlement, GoldFlowerRoom.GoldTotalSettlementRes)
	EventManager.AddEventListener(Protocal.GoldFlowerReady, GoldFlowerRoom.GoldFlowerSureRes)
	-- "*************************"
	-- 比赛场相关协议
	EventManager.AddEventListener(Protocal.VsJoin, GameRoomCardMatchCtrl.VsJoinRes)
	EventManager.AddEventListener(Protocal.VsQuit, GameRoomCardMatchCtrl.VsQuitRes)
	EventManager.AddEventListener(Protocal.VsStart, GameRoomCardMatchCtrl.VsStartRes)
	EventManager.AddEventListener(Protocal.VsWait, GameRoom.VsWaitRes)
	EventManager.AddEventListener(Protocal.VsEnd, GameRoom.VsEndRes)
	EventManager.AddEventListener(Protocal.VsLog, GameMatchRecordCtrl.VsLogRes)
	EventManager.AddEventListener(Protocal.VsGetJoinCount, GameRoomCardMatchCtrl.VsGetJoinCountRes)
	EventManager.AddEventListener(Protocal.VsTrusteeship, GameRoom.VsTrusteeshipRes)
	-- 捉麻子相关协议
	EventManager.AddEventListener(Protocal.CreateCatchPockRoom, CreateCatchRoomCtrl.OnCreateCatchRoomRes)
	EventManager.AddEventListener(Protocal.CatchPockRoomReady, CatchPockRoom.ReadyGameRes)
	EventManager.AddEventListener(Protocal.CatchPockDeal, CatchPockRoom.CatchPockDealRes)
	EventManager.AddEventListener(Protocal.CatchPopCard, CatchPockRoom.CatchPopCardRes)
	EventManager.AddEventListener(Protocal.CatchSingleSettlement, CatchPockRoom.CatchSingleSettlementRes)
	-- EventManager.AddEventListener(Protocal.CatchSettlementStartGame, CatchPockRoom.CatchSettlementStartGameRes)
	EventManager.AddEventListener(Protocal.CatchTotalSettlement, CatchPockRoom.CatchTotalSettlementRes)
	EventManager.AddEventListener(Protocal.CatchPockTips, CatchPockRoom.CatchPockTipsRes)

	-- 牛牛
	EventManager.AddEventListener(Protocal.CreateNiuRoom, CreateNiuRoomCtrl.OnCreateNiuRoomRes)
	EventManager.AddEventListener(Protocal.NiuRoomReady, NiuNiuRoom.OnNiuNiuNotRoomCatPrepareRes)
	EventManager.AddEventListener(Protocal.NiuDeal, NiuNiuRoom.OnNiuStartGameRes)
	EventManager.AddEventListener(Protocal.NiuHuan, NiuNiuRoom.NiuNiuChangeRes)
	EventManager.AddEventListener(Protocal.NiuIsQiangBanker, NiuNiuRoom.OnNiuNiuIsQiangBankerRes)
	EventManager.AddEventListener(Protocal.NiuBet, NiuNiuRoom.OnNiuNiuBetRes)
	EventManager.AddEventListener(Protocal.NiuTurn, NiuNiuRoom.OnNiuNiuTurnRes)
	EventManager.AddEventListener(Protocal.NiuShow, NiuNiuRoom.OnNiuNiuShowCardRes)
	EventManager.AddEventListener(Protocal.NiuSingleSettlement, NiuNiuRoom.OnNiuNiuSingleSettlementRes)
	EventManager.AddEventListener(Protocal.NiuSettlementStartGame, NiuNiuRoom.OnNiuNiuSettlementStartGameRes)
	EventManager.AddEventListener(Protocal.NiuTotalSettlement, NiuNiuRoom.OnNiuNiuTotalSettlementRes)
	EventManager.AddEventListener(Protocal.NiuTimeClock, NiuNiuRoom.OnNiuNiuClockRes)
	EventManager.AddEventListener(Protocal.NiuBuCards, NiuNiuRoom.OnNiuNiuBuCardsRes)

	-- 五子棋
	EventManager.AddEventListener(Protocal.CreateWuziqiRoom, MainSenceCtrl.UI_WuZiQiRoomRes)
	EventManager.AddEventListener(Protocal.WuZiQiBet, UI_WuZiQiCtrl.OnWuziqiBetRes)
	EventManager.AddEventListener(Protocal.WuZiQiReday, UI_WuZiQiCtrl.OnWuziqiPrepareRes)
	EventManager.AddEventListener(Protocal.WuZiQiStay, UI_WuZiQiCtrl.OnWuZiQiStartGameRes)
	EventManager.AddEventListener(Protocal.WuZiQiPlayLose, UI_WuZiQiCtrl.PlayLoseRes)

	-- 红中麻将
	EventManager.AddEventListener(Protocal.CreateRedDragonRoom, CreateRedDragonRoomCtrl.OnCreateHongRoomRes)


	-- 斗地主
	EventManager.AddEventListener(Protocal.CreateLandRoom, CreateLandlordsRoomCtrl.OnCreateLandlandsRoomRes)
	EventManager.AddEventListener(Protocal.DouDiZhuPlayRead, LandlordsRoom.ReadyGameRes)
	EventManager.AddEventListener(Protocal.OpenCard, LandlordsRoom.LandlordsOpenCarRes)
	EventManager.AddEventListener(Protocal.DouDiZhuPockDeal, LandlordsRoom.LandlordsDealRes)

	-- 房卡夺宝相关协议
	EventManager.AddEventListener(Protocal.CardIndianaInfo, ActivityCtrl.CardIndianaInfoRes)
	EventManager.AddEventListener(Protocal.StartIndiana, ActivityCtrl.StartIndianaRes)
	EventManager.AddEventListener(Protocal.JoinRoleNotice, ActivityCtrl.JoinRoleNoticeRes)
	EventManager.AddEventListener(Protocal.CloseCardIndiana, ActivityCtrl.CloseCardIndianaRes)

	-- 大厅相关协议
	EventManager.AddEventListener(Protocal.GoldcoinChange, MainSenceCtrl.GoldcoinChangeRes)
	EventManager.AddEventListener(Protocal.WingChange, MainSenceCtrl.WingChangeRes)

	-- 开始倒计时通用
	EventManager.AddEventListener(Protocal.CurStartGameTime, TH_GameMainCtrl.GetNaoZhongRes)

	-- 每日签到
	EventManager.AddEventListener(Protocal.DalyCheck, DalyCheckCtrl.OnCheckRes)
	-- 转盘
	EventManager.AddEventListener(Protocal.RotaryTable, RotaryTableCtrl.OnRewardRes)
	-- 邮件相关协议
	EventManager.AddEventListener(Protocal.MailInfo, MailCtrl.MailInfoRes)

	-- 请求修改的个性签名
	EventManager.AddEventListener(Protocal.ChangeRoleInfo)
	-- 请求结算界面显示对方牌型
	EventManager.AddEventListener(Protocal.EndGameShowPai)
	-- 玩家用元宝兑换金币
	EventManager.AddEventListener(Protocal.ConvertCoin, ShopMallCtrl.OnConvertCoinRes)
	-- 排行榜协议
	EventManager.AddEventListener(Protocal.RankList, RankListCtrl.RankInfoRes)
	EventManager.AddEventListener(Protocal.RankRoleInfo, RankListCtrl.RankingRoleInfoRes)
	-- 非房卡退出房间广播
	EventManager.AddEventListener(Protocal.QuitMateRoom, Room.QuitMateRoomRes)
	-- 观战玩家加入游戏房间，通知游戏中玩家
	EventManager.AddEventListener(Protocal.WatchPlayer, Room.WatchPlayerRes)

	-- 血战麻将相关协议

    --创建血战麻将房间
	EventManager.AddEventListener(Protocal.CreateBloodFightRoom, CreateBattleMahjongRoomCtrl.OnCreateBloodFightRoomRes)    
	--初始化面板    
    EventManager.AddEventListener(Protocal.BloodFightCardInit, GameRoom.OnInitRes)   
    --开始游戏
   	EventManager.AddEventListener(Protocal.BloodFightStartGame, XZ_GameMainCtrl.StartGameRes)
   	--摸牌  
    EventManager.AddEventListener(Protocal.BloodFightCardGet, GameRoom.OnCardGet)                
    --打牌
    EventManager.AddEventListener(Protocal.BloodFightCardPlay, RoomRunStatic.OnCardPlay)             
    --总结算 
    EventManager.AddEventListener(Protocal.BloodFightAllEndShow,TotalSettlementCtrl.OnTotalSettlementRes)             
    -- 提示碰杠胡标签             
    EventManager.AddEventListener(Protocal.BloodFightCardPushSign,RoomRunStatic.OnCardPushSign) 
    --麻将标签操作  
    EventManager.AddEventListener(Protocal.BloodFightCardPushSignOperate,RoomRunStatic.OnCardPushSignOperate) 
    --不能胡的牌、定缺牌  BloodFightReferCard
    EventManager.AddEventListener(Protocal.BloodFightRejectCard,GameRoom.OnBloodFightReferCardRes) 
    --血战麻将定缺  BloodFightDingQue
    EventManager.AddEventListener(Protocal.BloodFightDingQue,XZ_GameMainCtrl.OnBloodFightDingQueRes) 
    --血战麻将定缺显示
    EventManager.AddEventListener(Protocal.BloodFightDealOver,XZ_GameMainCtrl.OnBloodFightDealOver) 
    --血战麻将每局结算BloodFightOneEndShow
    EventManager.AddEventListener(Protocal.BloodFightOneEndShow,SingleSettlementCtrl.OnOneEndShowRes) 


	-- 获取底注等相关协议
	EventManager.AddEventListener(Protocal.SecondLevel, MainSenceCtrl.SecondLevelRes)

	-- 匹配房间监听协议(试试)r
	EventManager.AddEventListener(Protocal.AutoMateRoom)

	-- 实名认证
	EventManager.AddEventListener(Protocal.RealName, MainSenceCtrl.RealNameRes)
end

function Game.LoadScene(scene)
	if Game.GetSceneName() ~= scene then
		CtrlManager.RemoveAll()
		SceneManager.LoadScene(scene)
	end
end

function Game.GetSceneName()
	local scene = SceneManager.GetActiveScene()
	return scene.name
end

function Game.OnApplicationFocus(state)
	if state then
		Network.reconnectCount = 0
		this.SendProtocal("10004")
	end
end

-- 初始化音频--
function Game.AudioObject()
	SystemVo:New()
	SystemVo.BGSource = find("GameManager/audioBG"):GetComponent("AudioSource")
	SystemVo.EffectSource = find("GameManager/audioEffect"):GetComponent("AudioSource")
	SystemVo.TalkSource = find("GameManager/audioTalk"):GetComponent("AudioSource")
	SystemVo.CardSource = find("GameManager/audioCard"):GetComponent("AudioSource")
	SystemVo.isMusicEffectOn = AppConst.getPlayerPrefs("isMusicEffectOn")
	SystemVo.isMusicOn = AppConst.getPlayerPrefs("isMusicOn")
	SystemVo.isNXFYOn = AppConst.getPlayerPrefs("isNXFYOn")
	global.systemVo = SystemVo
	this.MusicList()
end

-- 销毁--
function Game.OnDestroy()
	-- logWarn("OnDestroy--->>>")
end

-- 播放背景音乐--
function Game.MusicBG(clipName)
	--soundMgr:PlayBackSound(global.systemVo.BGSource, "audioplaymusic", clipName)
end

-- 播放音效--
function Game.MusicEffect(clipName)
--[[	if not GameRoom.lockHand then
		print("Game.MusicEffect------------------1", clipName)
		if lastEffect == "angang" or lastEffect == "minggang" then
			if clipName == "mopai" then return end
			soundMgr:PlayEffectSound(global.systemVo.EffectSource, "audioeffect", clipName)
		else
			soundMgr:PlayEffectSound(global.systemVo.EffectSource, "audioeffect", clipName)
		end
		lastEffect = clipName
	end--]]
	soundMgr:PlayEffectSound(global.systemVo.EffectSource, "audioeffect", clipName)
	print("Game.MusicEffect------------------", clipName)
end

-- 播放语音--
function Game.Speak(clipName)
	if global.systemVo.isNXFYOn == "0" then
		soundMgr:PlayTalkSound(global.systemVo.TalkSource, "ptaudiotalk", clipName)
	else
		soundMgr:PlayTalkSound(global.systemVo.TalkSource, "audiotalk", clipName)
	end
end

-- 播放音乐--
function Game.Sing(clipName)
	if not GameRoom.lockHand then
		soundMgr:PlayTalkSound(global.systemVo.TalkSource, "audioplaymusic", clipName)
	end
end

function Game.MusicList()

	this.putongText = {
		p01 = "不好意思,我有事要先走一步了",
		p02 = "你的牌打得太好了",
		p03 = "大家好，很高兴见到各位",
		p04 = "青山不改，绿水长流，后会有期",
		p05 = "快点把,我等的花儿都谢啦",
		p06 = "你是妹妹，还是哥哥",
		p07 = "让我再想想",
		p08 = "不要走决战到天亮",
		p09 = "我有的可不只是美貌吆"
	}
	this.fangyanText = {
		f01 = "早，闹快丝子啥",
		f02 = "街这个牌，来的日谷子弯三的",
		f03 = "唉，上不打下不摸，小手你把动",
		f04 = "先赢得是纸，后特赢得才是钱呢",
		f05 = "要么精钩子，要么穿绸子",
		f06 = "皮夹子带刀，打的就是烧包",
		f07 = "我看你是背着桑叶上山，找蚕捏",
		f08 = "先打南不输钱，先打东钩子松",
		f09 = "一碰一停，急的不行",
		f10 = "有本司俺们往明天闹",
		f11 = "胡头把，输九把，你都把扎刺",
		f12 = "丫头子，那加个微信呢么",
		f13 = "杠的多输的多，回家买个电饭锅",
		f14 = "来，杠头开花，打的你回家",
		f15 = "牌七对，回家睡"
	}
	this.singText = {
		s01 = "假如时光倒流",
		s02 = "你是世上的奇女子呀",
		s03 = "爱拼才会赢",
		s04 = "我等的花儿都谢了",
		s05 = "无敌是多么寂寞",
		s06 = "就这样被你征服",
		s07 = "你牛什么牛",
		s08 = "恭喜发财",
		s09 = "来来来，快来杠上花开",
		s10 = "得不到的永远在骚动",
		s11 = "相信自己",
		s12 = "海阔天空",
		s13 = "愁白了头",
		s14 = "一四七三六九九九归一",
		s15 = "可惜不是你,陪我到最后"
	}
	this.cardName =
	{
		"color_1_01","color_1_04","color_1_07",
		"color_1_02","color_1_05","color_1_08",
		"color_1_03","color_1_06","color_1_09",

		"color_2_01","color_2_04","color_2_07",
		"color_2_02","color_2_05","color_2_08",
		"color_2_03","color_2_06","color_2_09",

		"color_3_01","color_3_04","color_3_07",
		"color_3_02","color_3_05","color_3_08",
		"color_3_03","color_3_06","color_3_09",

		"color_4_10","color_4_11","color_4_12",
		"color_4_13","color_4_14","color_4_15",
		"color_4_16","color_5_17"
	}

	-- 音乐音效列表--
	-- 音效
	this.Effect =
	{
		angang = "angang",
		dapai = "dapai",
		gameStart = "duijukaishi",
		buttonBack = "fanhui",
		hupai = "hupai",
		danju = "jiesuan",
		joinRoom = "jinru",
		minggang = "minggang",
		mopai = "mopai",
		countDown = "naozhong",
		xuanpai = "selectpai",
		shaizi = "shaizi",
		meihu = "liuju",
		eggfly = "jidanfei",
		eggdes = "jidanluo",
		feizaofly = "feizaofei",
		kissfly = "feiwenfei",
		kissdes = "feiwenluo",
		shengli = "ying",
		shibai = "shu",
		thfapai = "pukefapai",
		thfapai1 = "pukefapai1",
		chicken = "gongji",
		xihongshi = "mf_xihongshi",
		cheers = "ganbei",
		bet = "xiazhu",
		thboom = "baopai",
		thwulei = "wulei",
		bipai = "j_bipai",
		chouma = "j_chouma",
		jiazhu = "j_jiazhu",
		kanpai = "j_kanpai",
		qipai = "j_qipai",
		genzhu = "j_genzhu",
		air = "feiji",
		niuBet = "NNBet",
		niuLose = "NNLose",
		niuOpenCard = "NNOpenCard",
		niuWin = "NNWin",
		goldCoinSound = "goldCoinSound",
		qiangBanker = "qiangBankerSound"
	}

	this.Music =
	-- 音乐
	{
		bg1 = "bgm1",
		bgm2 = "bgm2",
		bgm3 = "bgm3",
		bgm4 = "bgm4",
		bgm6 = "bgm6",
		sing = { "01", "02", "03", "04", "05", "06", "07", "08", "09", "10", "11", "12", "13", "14", "15" }
	}

	this.Talk =
	-- 语音
	{
		gameOver = "prologue",
		woman = { "nv_001", "nv_002", "nv_004", "nv_005", "nv_006", "nv_007", "nv_009" },
		man = { "phrase_001", "phrase_002", "phrase_003", "phrase_005", "phrase_007", "phrase_008", "phrase_010", "phrase_017" },
		pt = { "g_buhaoyis", "g_dadehao", "g_dajiahao", "g_qingshanbugai", "g_kuaidian", "g_nishimeimei", "g_zaixiangxiang", "g_buyaozou", "g_buzhishimeimao" }
	}

	-- 语音列表--
	this.CardList =
	{
		PT = -- 普通话
		{
			color_1_01 = "g_1tong",
			color_1_04 = "g_4tong",
			color_1_07 = "g_7tong",
			color_1_02 = "g_2tong",
			color_1_05 = "g_5tong",
			color_1_08 = "g_8tong",
			color_1_03 = "g_3tong",
			color_1_06 = "g_6tong",
			color_1_09 = "g_9tong",

			color_2_01 = "g_1tiao",
			color_2_04 = "g_4tiao",
			color_2_07 = "g_7tiao",
			color_2_02 = "g_2tiao",
			color_2_05 = "g_5tiao",
			color_2_08 = "g_8tiao",
			color_2_03 = "g_3tiao",
			color_2_06 = "g_6tiao",
			color_2_09 = "g_9tiao",

			color_3_01 = "g_1wan",
			color_3_04 = "g_4wan",
			color_3_07 = "g_7wan",
			color_3_02 = "g_2wan",
			color_3_05 = "g_5wan",
			color_3_08 = "g_8wan",
			color_3_03 = "g_3wan",
			color_3_06 = "g_6wan",
			color_3_09 = "g_9wan",

			color_4_10 = "g_dongfeng",
			color_4_11 = "g_xifeng",
			color_4_12 = "g_nanfeng",
			color_4_13 = "g_beifeng",
			color_4_14 = "g_hongzhong",
			color_4_15 = "g_fa",
			color_4_16 = "g_bai",
			color_5_17 = "g_hongzhong",

			peng = "g_peng",
			gang = "g_gang",
			hu = "g_hu",
			zimo = "g_hu_zimo",
			guo = "g_guopai",

			-- 牛牛
			bull_1 = "womanbull1",
			bull_6 = "womanbull6",
			bull_10 = "womanbull10",
			bull_2 = "womanbull2",
			bull_7 = "womanbull7",
			bull_11 = "womanShunZi",
			bull_3 = "womanbull3",
			bull_8 = "womanbull8",
			bull_12 = "womanWuHua",
			bull_4 = "womanbull4",
			bull_9 = "womanbull9",
			bull_13 = "womanTongHua",
			bull_5 = "womanbull5",
			bull_0 = "womanbull0",
			bull_14 = "womanHulu",
			bull_15 = "womanZhaDan",
			bull_16 = "womanJinHua",
			bull_17 = "womanWuXiao",
		},

		FY = -- 方言
		{
			color_1_01 = { "b1_001", "b1_002", "b1_003", "b1_004" },
			color_1_04 = { "b4_001", "b4_002" },
			color_1_07 = { "b7_001", "b7_002", "b7_003" },
			color_1_02 = { "b2_001", "b2_002", "b2_003", "b2_004" },
			color_1_05 = { "b5_001", "b5_002", "b5_003" },
			color_1_08 = { "b8_001", "b8_002", "b8_003" },
			color_1_03 = { "b3_001", "b3_002", "b3_003", "b3_004" },
			color_1_06 = { "b6_001", "b6_002" },
			color_1_09 = { "b9_001", "b9_002", "b9_003" },

			color_2_01 = { "t1_001", "t1_002" },
			color_2_04 = { "t4_001", "t4_002", "t4_003" },
			color_2_07 = { "t7" },
			color_2_02 = { "t2_001", "t2_002" },
			color_2_05 = { "t5" },
			color_2_08 = { "t8_001", "t8_002" },
			color_2_03 = { "t3_001", "t3_002" },
			color_2_06 = { "t6" },
			color_2_09 = { "t9" },

			color_3_01 = { "w1" },
			color_3_04 = { "w4" },
			color_3_07 = { "w7" },
			color_3_02 = { "w2_001", "w2_002" },
			color_3_05 = { "w5" },
			color_3_08 = { "w8" },
			color_3_03 = { "w3" },
			color_3_06 = { "w6" },
			color_3_09 = { "w9" },

			color_4_10 = { "fd" },
			color_4_11 = { "fx" },
			color_4_12 = { "fn" },
			color_4_13 = { "fb_001", "fb_002" },
			color_4_14 = { "hz_001", "hz_002", "hz_003" },
			color_4_15 = { "fc_001", "fc_002" },
			color_4_16 = { "bb_001", "bb_002", "bb_003" },
			color_5_17 = { "hz_001", "hz_002", "hz_003" },

			peng = { "peng" },
			gang = { "gang_001", "gang_002" },
			hu = { "hule", "daozhanle" },
			zimo = { "zikou" }
		}
	}
end 

function Game.ChangeLanguage(clip)
	if not GameRoom.lockHand then
		-- 广电
		if global.systemVo.isNXFYOn == "0" then
			soundMgr:PlayCardSound(global.systemVo.CardSource, "ptaudiocard", Game.CardList.PT[clip])
		else
			math.randomseed(tostring(os.time()):reverse():sub(1, 6))
			local m = #Game.CardList.FY[clip]
			local n = math.random(1, m)
			soundMgr:PlayCardSound(global.systemVo.CardSource, "audiocard", Game.CardList.FY[clip][n])
		end
	end
end

function Game.PockCardTalk(clip)
	soundMgr:PlayCardSound(global.systemVo.CardSource, "pockaudiocard", clip)
end

-- 随机生成器--
function Game.Random(clipLenth)
	math.randomseed(tostring(os.time()):reverse():sub(1, 6))
	return math.random(1, clipLenth)
end

function Game.UICardList()
	for i = 1, #this.cardName do
		if not this.cardUI[this.cardName[i]] then
			resMgr:LoadPrefab('uimahjongprefabs', { this.cardName[i] },
			function(objs)
				this.OnCreateUICard(objs, this.cardName[i])
				if i == #this.cardName then
					GameRoom:ResourceCheckOver("uimahjongprefabs")
				end
			end )
		end
		if not this.cardObj[this.cardName[i]] then
			resMgr:LoadPrefab("mahjongcard", { this.cardName[i] },
			function(objs)
				this.OnCreateObjCard(objs, this.cardName[i])
				if i == #this.cardName then
					GameRoom:ResourceCheckOver("mahjongcard")
				end
			end )
		end
	end
end

function Game.OnCreateUICard(objs, cardName)
	if this.cardUI[cardName] then return end
	this.cardUI[cardName] = objs[0]
end
function Game.OnCreateObjCard(objs, cardName)
	if this.cardObj[cardName] then return end
	this.cardObj[cardName] = objs[0]
end
function Game.GetUICard(name)
	for k, v in pairs(this.cardUI) do
		if name == k then
			return v
		end
	end
end
function Game.GetObjCard(name)
	for k, v in pairs(this.cardObj) do
		if name == k then
			return v
		end
	end
end
