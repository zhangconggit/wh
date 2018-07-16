GameMatchSettleCtrl = {}
setbaseclass(GameMatchSettleCtrl, {BaseCtrl})

--启动事件--
function GameMatchSettleCtrl:OnCreate(obj)
    BaseCtrl.OnCreate(self, obj)
	self:AddClick(GameMatchSettlePanel.btnFanhuidating,self.OnFanhuidatingBtnClick)
	self:AddClick(GameMatchSettlePanel.btnShareMatch,self.OnShareMatchBtnClick)
	self:AddClick(GameMatchSettlePanel.btnJixucansai,self.OnJixucansaiBtnClick)
	self:InitPanel()
end

--初始化面板--
function GameMatchSettleCtrl:InitPanel()
end

function GameMatchSettleCtrl.OnFanhuidatingBtnClick(go)
	DissolutionRoomCtrl.gameOver = false
	GameRoomCardMatchCtrl.joinOK = false
	Game.MusicEffect(Game.Effect.buttonBack)
	local self = GameMatchSettleCtrl
    gameRoom.curJushu = 0
    global.roomVo = {}
    global.joinRoomUserVos = {}
    global.gpsMsgInfo = {}
	Event.Brocast(MsgDefine.Room_Exit)
	self:Close()
	SingleSettlementCtrl:Close()
	GameMatchRankListCtrl:Close()
	GameQuitMatchHintCtrl:Close()
	OB_GameMainCtrl:CancelInvoke("CardTime")
	OB_GameMainCtrl:Close()
	Network.ClearCtrs()
	Game.LoadScene("main")
end

function GameMatchSettleCtrl.OnShareMatchBtnClick(go)
	Game.MusicEffect(Game.Effect.joinRoom)
	if(AppConst.getCurrentPlatform() == 'PC') then
		MessageTipsCtrl:ShowInfo("当前不能分享！ ")
        return
	end
	weChatFunction.ShareBattleBtnClick()
end

function GameMatchSettleCtrl.OnJixucansaiBtnClick(go)
	DissolutionRoomCtrl.gameOver = false
	GameRoomCardMatchCtrl.joinOK = false
	Game.MusicEffect(Game.Effect.buttonBack)
	local self = GameMatchSettleCtrl
	self.isOpenGameMatch = true
    gameRoom.curJushu = 0
    global.roomVo = {}
    global.joinRoomUserVos = {}
    global.gpsMsgInfo = {}
	Event.Brocast(MsgDefine.Room_Exit)
	self:Close()
	SingleSettlementCtrl:Close()
	GameMatchRankListCtrl:Close()
	GameQuitMatchHintCtrl:Close()
	OB_GameMainCtrl:CancelInvoke("CardTime")
	OB_GameMainCtrl:Close()
	Network.ClearCtrs()
	Game.LoadScene("main")
end