-- 文件：消息提示面板

MessageTipsCtrl = { }
setbaseclass(MessageTipsCtrl, { BaseCtrl })

-- local masg
-- local label				--文本提示
-- local info				--服务器返回错误码

-- 启动事件--
function MessageTipsCtrl:OnCreate(obj)
	BaseCtrl.OnCreate(self, obj)
	self:AddClick(MessageTipsPanel.btnConfim, self.OnQuitBtnClick)
	self:InitPanel()
end

-- 初始化面板--
function MessageTipsCtrl:InitPanel(objs)

end

-- 显示错误信息--
function MessageTipsCtrl:ShowInfo(msg)
	self:UsualOpen("MessageTips", function()
		print("-- 显示错误信息--",msg)
		self:SetText(MessageTipsPanel.txtMessageTips, msg)
	end )
end

function MessageTipsCtrl.OnQuitBtnClick(go)
	--Game.MusicEffect(Game.Effect.buttonBack)
	local self = MessageTipsCtrl
	self:Close()
	if Room.gameType == RoomType.NiuNiu then
		local myPlayer = NiuNiuRoom:GetPlayer(NiuNiuRoom.myIndex)
		if myPlayer ~= nil then
			if myPlayer.isLook then
				TH_TotalSettlementCtrl.OnQuitBtnClick()
			end
		end
	end
	if Network.isServerStop or Game.hasNewVersion then
		Application.Quit()
		return
	end
	if Game.needUpdate then
		Game.needUpdate = false
		Game.LoadScene("update")
		return
	end
end