--Buildin Table
Protocal = {
	Connect					= '101';			--连接服务器
	Exception   			= '102';			--异常掉线
	Disconnect  			= '103';			--正常断线   
		
    ServerError 			= '10002';      	--服务器返回错误；
	Version     			= '10001';    		--握手
	Login       			= '10003';    		--登录
			
	CreateRoom  			= '10007';    		--创建房间；
	JoninRoom   			= '10008';    		--加入房间；
	DissolutionRoom 		= '10014'; 		 	--解散房间
	QuitRoom    			= '10015';     		--退出房间
	ApplyDisRoom 			= '10020';			--申请解散房间
	HeartBeat   			= '10004';     		--心跳
		
    ChangeRoleInfo   	    = '11005';          --个人签名修改
    
    EndGameShowPai          = '10032';          --清理台面请求

	ResLoaded 				= '10022';			--房间资源加载完毕
	OfflinePush     		= '10024';			--玩家离线、重连
	GetNoitceInfo   		= '13001';      	--拉取公告列表
	AddNoitceInfo   		= '13002';      	--添加公告列表
	DelNoitceInfo   		= '13003';      	--删除公告列表
	GetVersionNoitceInfo  	= '16001'; 			--拉取版本公告
	ApplyDisRoomOperation 	= '10021';			--申请解散房间操作
	ZhanJiInfo		  		= '12001';			--拉取战绩信息
	ZhanJiDetailInfo  		= '12002';			--拉取详细战绩 
	
	Card_Init         		= '10009';			--初始化牌；
	Card_Get          		= '10012';          --摸牌；
	LookSumScore      		= '10019';			--查看总成绩
	ChatInfo        		= '11001';			--聊天表情
	OneEndShow		  		= '10016';			--每局结算
	Card_Play         		= '10011';          --打牌
	ReLoad					= '10018';			--断线重连
	Card_PushSign     		= '10010';  		--提示碰杠胡标签
	Card_PushSignOperate 	= '10013';     		--麻将标签操作
	StartGame         		= '10017';			--开始游戏
	DealOver				= '10023';			-- 发牌完成

	WatchPlayer             = '10028';			--观战玩家进入

	Card_Ting        		= '17001';          --听牌提示

	SecondLevel 			= '10031';			--获取底注等信息

	--邮件相关协议
	MailInfo                = '14006';      --请求接收邮件
	MailGoods               = '14007';      --请求接收邮件里的物品

	
	DiamondChange			= '15001';			--房卡变化
	FriendGift    			= '15002';			--房卡赠送
	StringPara				= '11002';			--GM命令

	ConvertCoin             = '15005';           --元宝兑换金币


	LoginOut          		= '18001';          --退出到登录界面
	Card_Init_GM      		= '10025';          --通过GM命令改变手牌
	LouHu					= '10026';			--漏胡
	GenZhuang				= '10027';			--跟庄

	PlayBack          		= '12003';          --战绩回放
	Location				= '11004';			--位置信息广播
	ShareFriendster 		= '19001';			--分享好友以及朋友圈
	GetShareState			= '19002';			--获取分享状态

	--十点半相关协议
	TenHalfReady                = '30014';      --十点半准备         
	CreateTenHalfRoom  			= '30001';    	--创建十点半房间；
	TenHalfStartGame    		= '30002';		--开始游戏；
	TenHalfBet    				= '30004';		--下注
	TenHalfTurn    				= '30005';		--翻牌
	TenHalfBuCard    			= '30006';		--补牌
	TenHalfVSCard    			= '30008';		--比牌
	TenHalfSingleSettlement    	= '30009';		--每局结算
	TenHalfSettlementStartGame 	= '30010';		--每局结算之后开始游戏
	TenHalfIsBanker     		= '30011';		--当庄
	TenHalfIsQiangBanker    	= '30012';		--抢庄
	TenHalfTotalSettlement    	= '30013';		--总结算

	--扎金花相关协议
	GoldFlowerReady             = '32009';      --炸金花准备
	CreateGoldFlowerRoom		= '31001';		--创建扎金花房间
	GoldStartGame				= '31002';		--开始游戏 (inttype)
	GoldDisCards				= '31003';		--弃牌 
	GoldAddBet					= '31004';		--加注
	GoldLookCard				= '31005';		--看牌
	GoldVSCard					= '31006';		--比牌
	GoldSingleSettlement		= '31007';		--单局结算
	GoldSettlementStartGame		= '31008';		--单局结算开始游戏
	GoldTotalSettlement			= '31009';		--总结算

	--比赛场相关协议
	VsJoin						= '10501';		--加入比赛场
	VsQuit						= '10502';		--退出比赛场
	VsStart                     = '10503';		--比赛开始
	VsWait						= '10504'; 		--排名等待
	VsEnd						= '10505';		--比赛结束
	VsLog						= '10506';		--比赛记录
	VsGetJoinCount				= '10507';		--获取比赛加入人数
	VsTrusteeship				= '10508';		--比赛托管
	
	--捉麻子相关协议
	CreateCatchPockRoom 		= '32001';		--创建房间
	CatchPockRoomReady	 		= '32002';		--准备开始 = 单局结算开始游戏
	CatchPockDeal				= '32003';		--发牌
	CatchPopCard				= '32004';		--打牌		
	CatchSingleSettlement		= '32005';		--单局结算		
	--CatchSettlementStartGame	= '32006';		--单局结算开始游戏
	CatchTotalSettlement		= '32007';		--总结算
	CatchPockTips				= '32008';		--提示

	--牛牛相关协议
	CreateNiuRoom				= '33001';		--创建牛牛房间
	NiuRoomReady				= '33014';		--准备
	NiuDeal						= '33003';		--发牌
	NiuHuan						= '33004';		--换牌
	NiuIsQiangBanker			= '33005';		--是否抢庄
	NiuIsBanker					= '33006';		--是否当庄
	NiuBet						= '33007';		--下注
	NiuTurn						= '33008';		--翻牌
	NiuShow						= '33009';		--亮牌
	NiuSingleSettlement			= '33010';		--每局结算
	NiuSettlementStartGame		= '33011';		--每局结算开始游戏
	NiuTotalSettlement			= '33012';		--总结算
	NiuTimeClock				= '33013';		--计时器
	NiuBuCards					= '33015';		--补牌

	--夺宝相关协议
	CardIndianaInfo				= '40001';		--拉取房卡夺宝信息
	StartIndiana				= '40002';		--开始夺宝
	JoinRoleNotice				= '40003';		--玩家参与那期的通知
	CloseCardIndiana			= '40004';		--关闭夺宝面板

	--大厅相关协议
	AutoMateRoom                = '50001';		--自动匹配房间
	GoldcoinChange              = '15003';		--金币改变
	WingChange                  = '15004';		--元宝改变
	QuitMateRoom				= '50002';		--退出匹配房间
    
    --闹钟协议开始倒计时
    CurStartGameTime            = '50010';      --游戏开始前的倒计时
    
    --房间锁定
    LockRoom                    = '50013';       --收到这个消息不能退出游戏

    --签到协议
	DalyCheck                   = '60001';

	--转盘协议
	RotaryTable                 = '60002';

	--五子棋相关协议
	CreateWuziqiRoom            = '72001';		--创建五子棋房间
	WuZiQiReday					= '72002';		--准备游戏
	WuZiQiStay					= '72003';		--开始游戏
	WuZiQiBet					= '72004';		--五子棋下注
	WuZiQiPlayChess				= '72005';		--玩家落子
	WuZiQiPlayLose				= '72006';		--玩家认输

	--排行榜
	RankList                    = '80000';
	RankRoleInfo                = '80001';      --单个玩家信息

	CreateRedDragonRoom			= '90001';			--创建红中麻将

	--斗地主
	CreateLandRoom 				= '34001';			-- 创建斗地主房间
	DouDiZhuPlayRead  			= '34007';			-- 准备
	OpenCard 					= '34002'; 			-- 明牌开始 or 开始后明牌
	CallLandlord				= '34004';			-- 叫地主
	SnatchLandlord				= '34005'; 			-- 抢地主
	DouDiZhuPockDeal 			= '34003';	  		-- 发牌
	AddMultiple					= '34006';			-- 加倍

	--血战麻将
	CreateBloodFightRoom        = '90002';          --创建血战麻将房间
	
    BloodFightCardInit            = '90003';      --
    BloodFightCardGet             = '90004';      -- 血战麻将摸牌  MoChess
    BloodFightCardPlay            = '90005';      -- 血战麻将打牌 PlayChess
    BloodFightCardPushSign        = '90006';      -- 提示碰杠胡标签             BloodFightPushSign
    BloodFightCardPushSignOperate = '90007';      -- 麻将标签操作  BloodFightPushSignOperate
    BloodFightStartGame           = '90008';      -- 开始游戏
    BloodFightDealOver            = '90009';	  -- 弹出定缺标签
    BloodFightRejectCard          = '90010';      -- 不能胡的牌、定缺牌    BloodFightReferCard
    BloodFightDingQue             = '90011';      -- 血战麻将定缺  BloodFightDingQue
    BloodFightOneEndShow	      = '90012';      -- 血战麻将每局结算 BloodFightOneEndShow
    BloodFightAllEndShow          = '90013';      -- 血战麻将总结算 BloodFightAllEndShow


	--实名认证
	RealName 					= '80002';
}