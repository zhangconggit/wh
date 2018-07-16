GameQuitMatchHintCtrl = {}
setbaseclass(GameQuitMatchHintCtrl, {BaseCtrl})

--启动事件--
function GameQuitMatchHintCtrl:OnCreate(obj)
    BaseCtrl.OnCreate(self, obj)
	self:AddClick(GameQuitMatchHintPanel.btnConfirm,self.OnConfirmBtnClick)
	self:AddClick(GameQuitMatchHintPanel.btnCancel,self.OnCancelBtnClick)
	self:InitPanel()
end

--初始化面板--
function GameQuitMatchHintCtrl:InitPanel()
end

function GameQuitMatchHintCtrl.OnConfirmBtnClick(go)
	local self = GameQuitMatchHintCtrl
	Game.MusicEffect(Game.Effect.joinRoom)
	local msg = ""
    Game.SendProtocal(Protocal.VsEnd, msg)
    self:Close()
end

function GameQuitMatchHintCtrl.OnCancelBtnClick(go)
	local self = GameQuitMatchHintCtrl
	Game.MusicEffect(Game.Effect.joinRoom)
	self:Close()
end