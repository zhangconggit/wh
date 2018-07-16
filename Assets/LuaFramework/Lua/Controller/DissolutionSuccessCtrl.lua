
DissolutionSuccessCtrl = { };
setbaseclass(DissolutionSuccessCtrl, { BaseCtrl })

-- 启动事件--
function DissolutionSuccessCtrl:OnCreate(obj)
	BaseCtrl.OnCreate(self, obj)
	self:AddClick(DissolutionSuccessPanel.btnConfirm, self.OnConfirmBtnClick);
	self:InitPanel();
end

-- 初始化面板--
function DissolutionSuccessCtrl:InitPanel()
	self:SetText(DissolutionSuccessPanel.txtDissolutionSuccess, '已解散房间');
end


function DissolutionSuccessCtrl.OnConfirmBtnClick(go)
	Game.MusicEffect(Game.Effect.buttonBack)
	local self = DissolutionSuccessCtrl;
	self:Close();
	if Room.gameType == RoomType.Tenharf or Room.gameType == RoomType.GoldFlower then
		TH_GameMainCtrl:Close();
	else
		GameMainCtrl:Close();
	end
	-- 退出房间把断线重连状态去除
	Game.isReloadBattle = false
	Network.ClearCtrs()
	Game.LoadScene("main")
end

