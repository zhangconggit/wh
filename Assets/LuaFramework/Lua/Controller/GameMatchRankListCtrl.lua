GameMatchRankListCtrl = {}
setbaseclass(GameMatchRankListCtrl, {BaseCtrl})

--启动事件--
function GameMatchRankListCtrl:OnCreate(obj)
    BaseCtrl.OnCreate(self, obj)
	self:AddClick(GameMatchRankListPanel.btnFangQiMatch,self.OnFangQiMatchBtnClick)
	self:InitPanel()
end

--初始化面板--
function GameMatchRankListCtrl:InitPanel()
end

function GameMatchRankListCtrl.OnFangQiMatchBtnClick(go)
	Game.MusicEffect(Game.Effect.joinRoom)
	GameQuitMatchHintCtrl:Open("GameQuitMatchHint")
end