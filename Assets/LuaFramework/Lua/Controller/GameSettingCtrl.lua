GameSettingCtrl = {}
setbaseclass(GameSettingCtrl, {BaseCtrl})

--启动事件--
function GameSettingCtrl:OnCreate(obj)
	BaseCtrl.OnCreate(self,obj)
	obj.transform.localPosition = Vector3.New(640,0,40)
	self:AddClick(GameSettingPanel.btnWaitQuitRoom,self.OnWaitQuitRoomBtnClick)
	self:AddClick(GameSettingPanel.btnHideUp,self.OnHidePanelClick)
	self:AddClick(GameSettingPanel.QuitHideButton,self.OnHidePanelClick)
	self:AddClick(GameSettingPanel.btnSettingSystem,self.OnSetSystemBtnClick)
	self:AddClick(GameSettingPanel.btnGameMainQuitRoom,self.OnQuitBtnClick)
    self:InitPanel()
end

--初始化面板--
function GameSettingCtrl:InitPanel()
	GameSettingPanel.imgNotWaitQuitRoom:SetActive(true)
	GameSettingPanel.btnWaitQuitRoom:SetActive(true)
	GameSettingPanel.imgNotGameMainQuitRoom:SetActive(true)
	GameSettingPanel.btnGameMainQuitRoom:SetActive(true)
	GameSettingPanel.btnSettingSystem:SetActive(true)
	GameSettingPanel.btnShowTips:SetActive(true)
	GameSettingPanel.btnHideUp:SetActive(true)
end

function GameSettingCtrl.OnSetSystemBtnClick(go)
	Game.MusicEffect(Game.Effect.joinRoom)
	SetSystemCtrl:GetInfo(global.userVo.name,global.userVo.roleId,global.userVo.roleIp,
		OB_GameMainPanel.btnHeadIconD)
	SetSystemCtrl:Open('SetSystem')
end

--发送退出房间消息
function GameSettingCtrl.OnWaitQuitRoomBtnClick(go)
    Game.MusicEffect(Game.Effect.buttonBack)
    DissolutionRoomTipsCtrl:Open('DissolutionRoomTips')
end

function GameSettingCtrl.OnHidePanelClick(go)
	local self = GameSettingCtrl
    self:Close()
end

--申请解散房间--
function GameSettingCtrl.OnQuitBtnClick(go)
	Game.MusicEffect(Game.Effect.buttonBack)
	local self = OB_GameMainCtrl
	OB_GameMainPanel.imgQuitTips:SetActive(true)
	if gameRoom.isOnes then
		self:SetText(OB_GameMainPanel.txtQuitTips,"解散房间不扣房卡，是否确定解散？")
	else
		self:SetText(OB_GameMainPanel.txtQuitTips,"是否确认解散房间")
	end

end