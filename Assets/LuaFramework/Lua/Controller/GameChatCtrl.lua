
GameChatCtrl = { }
setbaseclass(GameChatCtrl, { BaseCtrl })

-- 启动事件--
function GameChatCtrl:OnCreate(obj)
	BaseCtrl.OnCreate(self, obj)
	self:AddClick(GameChatPanel.imgMaskBG, self.OnImgMaskBGClick)
	self:AddClick(GameChatPanel.btnChat, self.OnChatBtnClick)
	self:AddClick(GameChatPanel.btnFaceIcon, self.OnFaceIconBtnClick)
	self:AddClick(GameChatPanel.btnMusic, self.OnMusicBtnClick)
	-- 普通话聊天点击事件
	self:AddClick(GameChatPanel.btnPChat1, self.OnPChat1BtnClick)
	self:AddClick(GameChatPanel.btnPChat2, self.OnPChat2BtnClick)
	self:AddClick(GameChatPanel.btnPChat3, self.OnPChat3BtnClick)
	self:AddClick(GameChatPanel.btnPChat4, self.OnPChat4BtnClick)
	self:AddClick(GameChatPanel.btnPChat5, self.OnPChat5BtnClick)
	self:AddClick(GameChatPanel.btnPChat6, self.OnPChat6BtnClick)
	self:AddClick(GameChatPanel.btnPChat7, self.OnPChat7BtnClick)
	-- 方言聊天点击事件
	self:AddClick(GameChatPanel.btnChat1, self.OnChat1BtnClick)
	self:AddClick(GameChatPanel.btnChat2, self.OnChat2BtnClick)
	self:AddClick(GameChatPanel.btnChat3, self.OnChat3BtnClick)
	self:AddClick(GameChatPanel.btnChat4, self.OnChat4BtnClick)
	self:AddClick(GameChatPanel.btnChat5, self.OnChat5BtnClick)
	self:AddClick(GameChatPanel.btnChat6, self.OnChat6BtnClick)
	self:AddClick(GameChatPanel.btnChat7, self.OnChat7BtnClick)
	self:AddClick(GameChatPanel.btnChat8, self.OnChat8BtnClick)
	self:AddClick(GameChatPanel.btnChat9, self.OnChat9BtnClick)
	self:AddClick(GameChatPanel.btnChat10, self.OnChat10BtnClick)
	self:AddClick(GameChatPanel.btnChat11, self.OnChat11BtnClick)
	self:AddClick(GameChatPanel.btnChat12, self.OnChat12BtnClick)
	self:AddClick(GameChatPanel.btnChat13, self.OnChat13BtnClick)
	self:AddClick(GameChatPanel.btnChat14, self.OnChat14BtnClick)
	self:AddClick(GameChatPanel.btnChat15, self.OnChat15BtnClick)
	-- 表情点击事件
	self:AddClick(GameChatPanel.imgE1, self.OnImgE1BtnClick)
	self:AddClick(GameChatPanel.imgE2, self.OnImgE2BtnClick)
	self:AddClick(GameChatPanel.imgE3, self.OnImgE3BtnClick)
	self:AddClick(GameChatPanel.imgE4, self.OnImgE4BtnClick)
	self:AddClick(GameChatPanel.imgE5, self.OnImgE5BtnClick)
	self:AddClick(GameChatPanel.imgE6, self.OnImgE6BtnClick)
	self:AddClick(GameChatPanel.imgE7, self.OnImgE7BtnClick)
	self:AddClick(GameChatPanel.imgE8, self.OnImgE8BtnClick)
	self:AddClick(GameChatPanel.imgE9, self.OnImgE9BtnClick)
	self:AddClick(GameChatPanel.imgE10, self.OnImgE10BtnClick)
	self:AddClick(GameChatPanel.imgE11, self.OnImgE11BtnClick)
	self:AddClick(GameChatPanel.imgE12, self.OnImgE12BtnClick)
	self:AddClick(GameChatPanel.imgE13, self.OnImgE13BtnClick)
	self:AddClick(GameChatPanel.imgE14, self.OnImgE14BtnClick)
	self:AddClick(GameChatPanel.imgE15, self.OnImgE15BtnClick)
	self:AddClick(GameChatPanel.imgE16, self.OnImgE16BtnClick)
	self:AddClick(GameChatPanel.imgE17, self.OnImgE17BtnClick)
	self:AddClick(GameChatPanel.imgE18, self.OnImgE18BtnClick)
	self:AddClick(GameChatPanel.imgE19, self.OnImgE19BtnClick)
	self:AddClick(GameChatPanel.imgE20, self.OnImgE20BtnClick)
	self:AddClick(GameChatPanel.imgE21, self.OnImgE21BtnClick)
	self:AddClick(GameChatPanel.imgE22, self.OnImgE22BtnClick)
	self:AddClick(GameChatPanel.imgE23, self.OnImgE23BtnClick)
	self:AddClick(GameChatPanel.imgE24, self.OnImgE24BtnClick)
	-- 音乐点击事件
	self:AddClick(GameChatPanel.btnRow1, self.OnRow1BtnClick)
	self:AddClick(GameChatPanel.btnRow2, self.OnRow2BtnClick)
	self:AddClick(GameChatPanel.btnRow3, self.OnRow3BtnClick)
	self:AddClick(GameChatPanel.btnRow4, self.OnRow4BtnClick)
	self:AddClick(GameChatPanel.btnRow5, self.OnRow5BtnClick)
	self:AddClick(GameChatPanel.btnRow6, self.OnRow6BtnClick)
	self:AddClick(GameChatPanel.btnRow7, self.OnRow7BtnClick)
	self:AddClick(GameChatPanel.btnRow8, self.OnRow8BtnClick)
	self:AddClick(GameChatPanel.btnRow9, self.OnRow9BtnClick)
	self:AddClick(GameChatPanel.btnRow10, self.OnRow10BtnClick)
	self:AddClick(GameChatPanel.btnRow11, self.OnRow11BtnClick)
	self:AddClick(GameChatPanel.btnRow12, self.OnRow12BtnClick)
	self:AddClick(GameChatPanel.btnRow13, self.OnRow13BtnClick)
	self:AddClick(GameChatPanel.btnRow14, self.OnRow14BtnClick)

	self:AddClick(GameChatPanel.btnSendChat, self.OnSendChatBtnClick)
	self:InitPanel()
end


-- 初始化面板--
function GameChatCtrl:InitPanel()
	-- 申请苹果审核
	if IS_APP_STORE_CHECK then
		GameChatPanel.inputChatText:SetActive(false)
		GameChatPanel.btnSendChat:SetActive(false)
	end
	GameChatPanel.btnChat:SetActive(false)
	GameChatPanel.btnChatDown:SetActive(true)
	GameChatPanel.btnFaceIcon:SetActive(true)
	GameChatPanel.btnFaceIconDown:SetActive(false)
	GameChatPanel.btnMusic:SetActive(true)
	GameChatPanel.btnMusicDown:SetActive(false)
	if AppConst.getPlayerPrefs('isNXFYOn') == '' then
		global.systemVo.isNXFYOn = '1'
	else
		global.systemVo.isNXFYOn = AppConst.getPlayerPrefs('isNXFYOn')
	end

	if Room.gameType == RoomType.Mahjong then
		if global.systemVo.isNXFYOn == '0' then
			GameChatPanel.imgPTChat:SetActive(true)
			GameChatPanel.scrbFYChat:SetActive(false)
			self:SetText(GameChatPanel.btnPChat2Text, "你的牌打得太好了")
			self:SetText(GameChatPanel.btnPChat7Text, "让我再想想")
		else
			GameChatPanel.scrbFYChat:SetActive(true)
			GameChatPanel.imgPTChat:SetActive(false)
		end
	elseif Room.gameType == RoomType.Tenharf or Room.gameType == RoomType.GoldFlower or Room.gameType == RoomType.CatchPock
		or Room.gameType == RoomType.NiuNiu then
		GameChatPanel.imgPTChat:SetActive(true)
		GameChatPanel.scrbFYChat:SetActive(false)
		self:SetText(GameChatPanel.btnPChat2Text, "不要走决战到天亮")
		self:SetText(GameChatPanel.btnPChat7Text, "我有的可不只是美貌吆")
	end
	GameChatPanel.imgFaceIcon:SetActive(false)
	GameChatPanel.scrbMusic:SetActive(false)

end

function GameChatCtrl.OnChatBtnClick(go)
	local self = GameChatCtrl
	Game.MusicEffect(Game.Effect.joinRoom)
	GameChatPanel.btnChat:SetActive(false)
	GameChatPanel.btnChatDown:SetActive(true)
	GameChatPanel.btnFaceIcon:SetActive(true)
	GameChatPanel.btnFaceIconDown:SetActive(false)
	GameChatPanel.btnMusic:SetActive(true)
	GameChatPanel.btnMusicDown:SetActive(false)
	GameChatPanel.imgFaceIcon:SetActive(false)
	GameChatPanel.scrbMusic:SetActive(false)
	if Room.gameType == RoomType.Mahjong then
		if global.systemVo.isNXFYOn == '0' then
			GameChatPanel.imgPTChat:SetActive(true)
			GameChatPanel.scrbFYChat:SetActive(false)
			self:SetText(GameChatPanel.btnPChat2Text, "你的牌打得太好了")
			self:SetText(GameChatPanel.btnPChat7Text, "让我再想想")
		else
			GameChatPanel.scrbFYChat:SetActive(true)
			GameChatPanel.imgPTChat:SetActive(false)
		end
	elseif Room.gameType == RoomType.Tenharf or Room.gameType == RoomType.GoldFlower or Room.gameType == RoomType.CatchPock
		or Room.gameType == RoomType.NiuNiu then
		GameChatPanel.imgPTChat:SetActive(true)
		GameChatPanel.scrbFYChat:SetActive(false)
		self:SetText(GameChatPanel.btnPChat2Text, "不要走决战到天亮")
		self:SetText(GameChatPanel.btnPChat7Text, "我有的可不只是美貌吆")
	end
end

function GameChatCtrl.OnFaceIconBtnClick(go)
	Game.MusicEffect(Game.Effect.joinRoom)
	GameChatPanel.btnChat:SetActive(true)
	GameChatPanel.btnChatDown:SetActive(false)
	GameChatPanel.btnFaceIcon:SetActive(false)
	GameChatPanel.btnFaceIconDown:SetActive(true)
	GameChatPanel.btnMusic:SetActive(true)
	GameChatPanel.btnMusicDown:SetActive(false)
	GameChatPanel.imgPTChat:SetActive(false)
	GameChatPanel.imgFaceIcon:SetActive(true)
	GameChatPanel.scrbMusic:SetActive(false)
	GameChatPanel.scrbFYChat:SetActive(false)
end

function GameChatCtrl.OnMusicBtnClick(go)
	local self = GameChatCtrl
	Game.MusicEffect(Game.Effect.joinRoom)
	GameChatPanel.btnChat:SetActive(true)
	GameChatPanel.btnChatDown:SetActive(false)
	GameChatPanel.btnFaceIcon:SetActive(true)
	GameChatPanel.btnFaceIconDown:SetActive(false)
	GameChatPanel.btnMusic:SetActive(false)
	GameChatPanel.btnMusicDown:SetActive(true)
	GameChatPanel.imgPTChat:SetActive(false)
	GameChatPanel.imgFaceIcon:SetActive(false)
	GameChatPanel.scrbMusic:SetActive(true)
	GameChatPanel.scrbFYChat:SetActive(false)
	if Room.gameType == RoomType.Mahjong then
		self:SetText(GameChatPanel.btnRow9Text, "来来来，快来杠上花开")
	elseif Room.gameType == RoomType.Tenharf or Room.gameType == RoomType.GoldFlower or Room.gameType == RoomType.CatchPock
		or Room.gameType == RoomType.NiuNiu then
		self:SetText(GameChatPanel.btnRow9Text, "可惜不是你,陪我到最后")
	end
end

function GameChatCtrl.OnImgMaskBGClick(go)
	Game.MusicEffect(Game.Effect.joinRoom)
	local self = GameChatCtrl
	self:SetInputText(GameChatPanel.inputChatText, '')
	self:Close()
end

function GameChatCtrl.OnPChat1BtnClick(go)
	local self = GameChatCtrl
	self:PTChatAndFYChatAndEmoticonInfoShow(1, "p01")
end

function GameChatCtrl.OnPChat2BtnClick(go)
	local self = GameChatCtrl
	if Room.gameType == RoomType.Mahjong then
		self:PTChatAndFYChatAndEmoticonInfoShow(1, "p02")
	elseif Room.gameType == RoomType.Tenharf or Room.gameType == RoomType.GoldFlower or Room.gameType == RoomType.CatchPock
		or Room.gameType == RoomType.NiuNiu then
		self:PTChatAndFYChatAndEmoticonInfoShow(1, "p08")
	end
end

function GameChatCtrl.OnPChat3BtnClick(go)
	local self = GameChatCtrl
	self:PTChatAndFYChatAndEmoticonInfoShow(1, "p03")
end

function GameChatCtrl.OnPChat4BtnClick(go)
	local self = GameChatCtrl
	self:PTChatAndFYChatAndEmoticonInfoShow(1, "p04")
end

function GameChatCtrl.OnPChat5BtnClick(go)
	local self = GameChatCtrl
	self:PTChatAndFYChatAndEmoticonInfoShow(1, "p05")
end

function GameChatCtrl.OnPChat6BtnClick(go)
	local self = GameChatCtrl
	self:PTChatAndFYChatAndEmoticonInfoShow(1, "p06")
end

function GameChatCtrl.OnPChat7BtnClick(go)
	local self = GameChatCtrl
	if Room.gameType == RoomType.Mahjong then
		self:PTChatAndFYChatAndEmoticonInfoShow(1, "p07")
	elseif Room.gameType == RoomType.Tenharf or Room.gameType == RoomType.GoldFlower or Room.gameType == RoomType.CatchPock
		or Room.gameType == RoomType.NiuNiu then
		self:PTChatAndFYChatAndEmoticonInfoShow(1, "p09")
	end

end

function GameChatCtrl.OnChat1BtnClick(go)
	local self = GameChatCtrl
	self:PTChatAndFYChatAndEmoticonInfoShow(2, "f01")
end

function GameChatCtrl.OnChat2BtnClick(go)
	local self = GameChatCtrl
	self:PTChatAndFYChatAndEmoticonInfoShow(2, "f02")
end

function GameChatCtrl.OnChat3BtnClick(go)
	local self = GameChatCtrl
	self:PTChatAndFYChatAndEmoticonInfoShow(2, "f03")
end

function GameChatCtrl.OnChat4BtnClick(go)
	local self = GameChatCtrl
	self:PTChatAndFYChatAndEmoticonInfoShow(2, "f04")
end

function GameChatCtrl.OnChat5BtnClick(go)
	local self = GameChatCtrl
	self:PTChatAndFYChatAndEmoticonInfoShow(2, "f05")
end

function GameChatCtrl.OnChat6BtnClick(go)
	local self = GameChatCtrl
	self:PTChatAndFYChatAndEmoticonInfoShow(2, "f06")
end

function GameChatCtrl.OnChat7BtnClick(go)
	local self = GameChatCtrl
	self:PTChatAndFYChatAndEmoticonInfoShow(2, "f07")
end

function GameChatCtrl.OnChat8BtnClick(go)
	local self = GameChatCtrl
	self:PTChatAndFYChatAndEmoticonInfoShow(2, "f08")
end

function GameChatCtrl.OnChat9BtnClick(go)
	local self = GameChatCtrl
	self:PTChatAndFYChatAndEmoticonInfoShow(2, "f09")
end

function GameChatCtrl.OnChat10BtnClick(go)
	local self = GameChatCtrl
	self:PTChatAndFYChatAndEmoticonInfoShow(2, "f10")
end

function GameChatCtrl.OnChat11BtnClick(go)
	local self = GameChatCtrl
	self:PTChatAndFYChatAndEmoticonInfoShow(2, "f11")
end

function GameChatCtrl.OnChat12BtnClick(go)
	local self = GameChatCtrl
	self:PTChatAndFYChatAndEmoticonInfoShow(2, "f12")
end

function GameChatCtrl.OnChat13BtnClick(go)
	local self = GameChatCtrl
	self:PTChatAndFYChatAndEmoticonInfoShow(2, "f13")
end

function GameChatCtrl.OnChat14BtnClick(go)
	local self = GameChatCtrl
	self:PTChatAndFYChatAndEmoticonInfoShow(2, "f14")
end

function GameChatCtrl.OnChat15BtnClick(go)
	local self = GameChatCtrl
	self:PTChatAndFYChatAndEmoticonInfoShow(2, "f15")
end

function GameChatCtrl.OnImgE1BtnClick(go)
	local self = GameChatCtrl
	local emoticonImageName = GameChatPanel.imgE1:GetComponent('Image').sprite.name
	self:PTChatAndFYChatAndEmoticonInfoShow(3, emoticonImageName)
end

function GameChatCtrl.OnImgE2BtnClick(go)
	local self = GameChatCtrl
	local emoticonImageName = GameChatPanel.imgE2:GetComponent('Image').sprite.name
	self:PTChatAndFYChatAndEmoticonInfoShow(3, emoticonImageName)
end

function GameChatCtrl.OnImgE3BtnClick(go)
	local self = GameChatCtrl
	local emoticonImageName = GameChatPanel.imgE3:GetComponent('Image').sprite.name
	self:PTChatAndFYChatAndEmoticonInfoShow(3, emoticonImageName)
end

function GameChatCtrl.OnImgE4BtnClick(go)
	local self = GameChatCtrl
	local emoticonImageName = GameChatPanel.imgE4:GetComponent('Image').sprite.name
	self:PTChatAndFYChatAndEmoticonInfoShow(3, emoticonImageName)
end

function GameChatCtrl.OnImgE5BtnClick(go)
	local self = GameChatCtrl
	local emoticonImageName = GameChatPanel.imgE5:GetComponent('Image').sprite.name
	self:PTChatAndFYChatAndEmoticonInfoShow(3, emoticonImageName)
end

function GameChatCtrl.OnImgE6BtnClick(go)
	local self = GameChatCtrl
	local emoticonImageName = GameChatPanel.imgE6:GetComponent('Image').sprite.name
	self:PTChatAndFYChatAndEmoticonInfoShow(3, emoticonImageName)
end

function GameChatCtrl.OnImgE7BtnClick(go)
	local self = GameChatCtrl
	local emoticonImageName = GameChatPanel.imgE7:GetComponent('Image').sprite.name
	self:PTChatAndFYChatAndEmoticonInfoShow(3, emoticonImageName)
end

function GameChatCtrl.OnImgE8BtnClick(go)
	local self = GameChatCtrl
	local emoticonImageName = GameChatPanel.imgE8:GetComponent('Image').sprite.name
	self:PTChatAndFYChatAndEmoticonInfoShow(3, emoticonImageName)
end

function GameChatCtrl.OnImgE9BtnClick(go)
	local self = GameChatCtrl
	local emoticonImageName = GameChatPanel.imgE9:GetComponent('Image').sprite.name
	self:PTChatAndFYChatAndEmoticonInfoShow(3, emoticonImageName)
end

function GameChatCtrl.OnImgE10BtnClick(go)
	local self = GameChatCtrl
	local emoticonImageName = GameChatPanel.imgE10:GetComponent('Image').sprite.name
	self:PTChatAndFYChatAndEmoticonInfoShow(3, emoticonImageName)
end

function GameChatCtrl.OnImgE11BtnClick(go)
	local self = GameChatCtrl
	local emoticonImageName = GameChatPanel.imgE11:GetComponent('Image').sprite.name
	self:PTChatAndFYChatAndEmoticonInfoShow(3, emoticonImageName)
end

function GameChatCtrl.OnImgE12BtnClick(go)
	local self = GameChatCtrl
	local emoticonImageName = GameChatPanel.imgE12:GetComponent('Image').sprite.name
	self:PTChatAndFYChatAndEmoticonInfoShow(3, emoticonImageName)
end

function GameChatCtrl.OnImgE13BtnClick(go)
	local self = GameChatCtrl
	local emoticonImageName = GameChatPanel.imgE13:GetComponent('Image').sprite.name
	self:PTChatAndFYChatAndEmoticonInfoShow(3, emoticonImageName)
end

function GameChatCtrl.OnImgE14BtnClick(go)
	local self = GameChatCtrl
	local emoticonImageName = GameChatPanel.imgE14:GetComponent('Image').sprite.name
	self:PTChatAndFYChatAndEmoticonInfoShow(3, emoticonImageName)
end

function GameChatCtrl.OnImgE15BtnClick(go)
	local self = GameChatCtrl
	local emoticonImageName = GameChatPanel.imgE15:GetComponent('Image').sprite.name
	self:PTChatAndFYChatAndEmoticonInfoShow(3, emoticonImageName)
end

function GameChatCtrl.OnImgE16BtnClick(go)
	local self = GameChatCtrl
	local emoticonImageName = GameChatPanel.imgE16:GetComponent('Image').sprite.name
	self:PTChatAndFYChatAndEmoticonInfoShow(3, emoticonImageName)
end

function GameChatCtrl.OnImgE17BtnClick(go)
	local self = GameChatCtrl
	local emoticonImageName = GameChatPanel.imgE17:GetComponent('Image').sprite.name
	self:PTChatAndFYChatAndEmoticonInfoShow(3, emoticonImageName)
end

function GameChatCtrl.OnImgE18BtnClick(go)
	local self = GameChatCtrl
	local emoticonImageName = GameChatPanel.imgE18:GetComponent('Image').sprite.name
	self:PTChatAndFYChatAndEmoticonInfoShow(3, emoticonImageName)
end

function GameChatCtrl.OnImgE19BtnClick(go)
	local self = GameChatCtrl
	local emoticonImageName = GameChatPanel.imgE19:GetComponent('Image').sprite.name
	self:PTChatAndFYChatAndEmoticonInfoShow(3, emoticonImageName)
end

function GameChatCtrl.OnImgE20BtnClick(go)
	local self = GameChatCtrl
	local emoticonImageName = GameChatPanel.imgE20:GetComponent('Image').sprite.name
	self:PTChatAndFYChatAndEmoticonInfoShow(3, emoticonImageName)
end

function GameChatCtrl.OnImgE21BtnClick(go)
	local self = GameChatCtrl
	local emoticonImageName = GameChatPanel.imgE21:GetComponent('Image').sprite.name
	self:PTChatAndFYChatAndEmoticonInfoShow(3, emoticonImageName)
end

function GameChatCtrl.OnImgE22BtnClick(go)
	local self = GameChatCtrl
	local emoticonImageName = GameChatPanel.imgE22:GetComponent('Image').sprite.name
	self:PTChatAndFYChatAndEmoticonInfoShow(3, emoticonImageName)
end

function GameChatCtrl.OnImgE23BtnClick(go)
	local self = GameChatCtrl
	local emoticonImageName = GameChatPanel.imgE23:GetComponent('Image').sprite.name
	self:PTChatAndFYChatAndEmoticonInfoShow(3, emoticonImageName)
end

function GameChatCtrl.OnImgE24BtnClick(go)
	local self = GameChatCtrl
	local emoticonImageName = GameChatPanel.imgE24:GetComponent('Image').sprite.name
	self:PTChatAndFYChatAndEmoticonInfoShow(3, emoticonImageName)
end

function GameChatCtrl.OnRow1BtnClick(go)
	local self = GameChatCtrl
	self:PTChatAndFYChatAndEmoticonInfoShow(4, "s01")
end

function GameChatCtrl.OnRow2BtnClick(go)
	local self = GameChatCtrl
	self:PTChatAndFYChatAndEmoticonInfoShow(4, "s02")
end

function GameChatCtrl.OnRow3BtnClick(go)
	local self = GameChatCtrl
	self:PTChatAndFYChatAndEmoticonInfoShow(4, "s03")
end

function GameChatCtrl.OnRow4BtnClick(go)
	local self = GameChatCtrl
	self:PTChatAndFYChatAndEmoticonInfoShow(4, "s04")
end

function GameChatCtrl.OnRow5BtnClick(go)
	local self = GameChatCtrl
	self:PTChatAndFYChatAndEmoticonInfoShow(4, "s05")
end

function GameChatCtrl.OnRow6BtnClick(go)
	local self = GameChatCtrl
	self:PTChatAndFYChatAndEmoticonInfoShow(4, "s06")
end

function GameChatCtrl.OnRow7BtnClick(go)
	local self = GameChatCtrl
	self:PTChatAndFYChatAndEmoticonInfoShow(4, "s07")
end

function GameChatCtrl.OnRow8BtnClick(go)
	local self = GameChatCtrl
	self:PTChatAndFYChatAndEmoticonInfoShow(4, "s08")
end

function GameChatCtrl.OnRow9BtnClick(go)
	local self = GameChatCtrl
	if Room.gameType == RoomType.Mahjong then
		self:PTChatAndFYChatAndEmoticonInfoShow(4, "s09")
	elseif Room.gameType == RoomType.Tenharf or Room.gameType == RoomType.GoldFlower or Room.gameType == RoomType.CatchPock
		or Room.gameType == RoomType.NiuNiu then
		self:PTChatAndFYChatAndEmoticonInfoShow(4, "s15")
	end
end

function GameChatCtrl.OnRow10BtnClick(go)
	local self = GameChatCtrl
	self:PTChatAndFYChatAndEmoticonInfoShow(4, "s10")
end

function GameChatCtrl.OnRow11BtnClick(go)
	local self = GameChatCtrl
	self:PTChatAndFYChatAndEmoticonInfoShow(4, "s11")
end

function GameChatCtrl.OnRow12BtnClick(go)
	local self = GameChatCtrl
	self:PTChatAndFYChatAndEmoticonInfoShow(4, "s12")
end

function GameChatCtrl.OnRow13BtnClick(go)
	local self = GameChatCtrl
	self:PTChatAndFYChatAndEmoticonInfoShow(4, "s13")
end

function GameChatCtrl.OnRow14BtnClick(go)
	local self = GameChatCtrl
	self:PTChatAndFYChatAndEmoticonInfoShow(4, "s14")
end

function GameChatCtrl.OnSendChatBtnClick(go)
	local self = GameChatCtrl
	local chatText = self:GetInputText(GameChatPanel.inputChatText)
	self:PTChatAndFYChatAndEmoticonInfoShow(8, chatText)
end

function GameChatCtrl:PTChatAndFYChatAndEmoticonInfoShow(chatType, chatInfo)
	local self = GameChatCtrl
	if Room.gameType == RoomType.Mahjong then
		if OB_GameMainPanel.imgFaceIconBGD.activeSelf == true or OB_GameMainPanel.imgChatD.activeSelf == true then
			OB_GameMainCtrl.SetIconTips("您说话太快了，休息一下吧！")
		else
			local GameChat = Chat_pb.ChatReq()
			GameChat.chatType = chatType
			GameChat.chatText = chatInfo
			-- 本端的roleid
			local myRoleId = global.userVo.roleId
			-- 获取当前端的索引
			local myIndex = getRoleIndexById(myRoleId)
			GameChat.chatSelfIndex = myIndex

			local msg = GameChat:SerializeToString()
			Game.SendProtocal(Protocal.ChatInfo, msg)
		end
	elseif Room.gameType == RoomType.Tenharf then
		GameChatCtrl.SendChatApplyCard(TenharfRoom, chatType, chatInfo)
	elseif Room.gameType == RoomType.GoldFlower then
		GameChatCtrl.SendChatApplyCard(GoldFlowerRoom, chatType, chatInfo)
	elseif Room.gameType == RoomType.CatchPock then
		GameChatCtrl.SendChatApplyCard(CatchPockRoom, chatType, chatInfo)
	elseif Room.gameType == RoomType.NiuNiu then
		GameChatCtrl.SendChatApplyCard(NiuNiuRoom, chatType, chatInfo)
	end

	self:SetInputText(GameChatPanel.inputChatText, '')
	self:Close()
end

function GameChatCtrl.SendChatApplyCard(roomType, chatType, chatInfo)
	if roomType:GetPlayer(roomType.myIndex).imgFaceIcon.activeSelf == true or roomType:GetPlayer(roomType.myIndex).imgChat.activeSelf == true then
		if Room.gameType == RoomType.CatchPock then
			CH_GameMainCtrl.SetIconTips("您说话太快了，休息一下吧！")
		else
			TH_GameMainCtrl.SetIconTips("您说话太快了，休息一下吧！")
		end
	else
		local GameChat = Chat_pb.ChatReq()
		GameChat.chatType = chatType
		GameChat.chatText = chatInfo
		GameChat.chatSelfIndex = roomType.myIndex

		local msg = GameChat:SerializeToString()
		Game.SendProtocal(Protocal.ChatInfo, msg)
	end
end

-- 关闭事件--
-- function GameChatCtrl.Close()
-- 	panelMgr:ClosePanel(CtrlNames.GameChat)
-- end

function GameChatCtrl.OnChatInfoRes(buffer)
	local self = GameChatCtrl
	local data = buffer:ReadBuffer()
	local msg = Chat_pb.ChatReq()
	msg:ParseFromString(data)

	local chatType = msg.chatType
	local chatText = msg.chatText
	local chatSelfIndex = msg.chatSelfIndex
	if Room.gameType == RoomType.Mahjong then
		local location = getOtherPlayerLocation(chatSelfIndex)
		if chatType ~= 5 then
			if not OB_GameMainCtrl.isCreate then
				return
			end
		end
		if location == 'D' then
			if chatType == 1 or chatType == 2 or chatType == 4 then
				global.systemVo.BGSource.volume = 0
			end
		end
		if OB_GameMainCtrl.isCreate then
			self:playYuYin(chatType, chatText, chatSelfIndex)
		elseif OB_GameMainPanel.isCreate then
			self:playYuYin(chatType, chatText, chatSelfIndex)
		end
		self:ShowPTChatAndFYChat(chatType, chatText, chatSelfIndex)
		self:PlayMusic(chatType, chatText, chatSelfIndex)
		self:showEmoticon(chatType, chatText, chatSelfIndex)
		self:showChatInfo(chatType, chatText, chatSelfIndex)
	else
		if Room.gameType == RoomType.Tenharf then
			if not TH_GameMainCtrl.isCreate or not TenharfRoom.initPlayerEnd then
				return
			end
		elseif Room.gameType == RoomType.GoldFlower then
			if not TH_GameMainCtrl.isCreate or not GoldFlowerRoom.initPlayerEnd then
				return
			end
		elseif Room.gameType == RoomType.CatchPock then
			if not CH_GameMainCtrl.isCreate or not CatchPockRoom.initPlayerEnd then
				return
			end
		elseif Room.gameType == RoomType.NiuNiu then
			if not TH_GameMainCtrl.isCreate or not NiuNiuRoom.initPlayerEnd then
				return
			end
		end
		self:playYuYin(chatType, chatText, chatSelfIndex)
		self:ShowPTChatAndFYChat(chatType, chatText, chatSelfIndex)
		self:PlayMusic(chatType, chatText, chatSelfIndex)
		self:showEmoticon(chatType, chatText, chatSelfIndex)
		self:showChatInfo(chatType, chatText, chatSelfIndex)
		if chatType == 6 then
			local chatText = msg.chatText
			local myIndex = string.sub(chatText, 1, 1)
			local targetIndex = string.sub(chatText, 2, 2)
			local faceName = string.sub(chatText, 3, #chatText)
			TH_RoleInfoCtrl.AnimationShow(myIndex, targetIndex, faceName)
		end
	end
end

local emoticonText;
local chatSelfIndexs;

function GameChatCtrl:playYuYin(chatType, yuYinUrl, chatSelfIndex)
	if chatType == 5 then
		chatSelfIndexs = chatSelfIndex
		weChatFunction.yuYinDown(yuYinUrl)
	end
end

-- 语音下载完成播放时在出现语音输出框
function GameChatCtrl.OnPlayYuYin()
	local self = GameChatCtrl
	if Room.gameType == RoomType.Mahjong then
		local location = getOtherPlayerLocation(chatSelfIndexs)
		if location == 'D' then
			emoticonText = tostring('e25')
			resMgr:LoadPrefab('faceicon', { 'e25' }, self.selfEmoticon)
		elseif location == 'R' then
			emoticonText = tostring('e26')
			resMgr:LoadPrefab('faceicon', { 'e26' }, self.rightEmoticon)
		elseif location == 'L' then
			emoticonText = tostring('e25')
			resMgr:LoadPrefab('faceicon', { 'e25' }, self.leftEmoticon)
		elseif location == 'U' then
			emoticonText = tostring('e26')
			resMgr:LoadPrefab('faceicon', { 'e26' }, self.upEmoticon)
		else
			logWarn('--------------------------->位置信息错误')
		end
	elseif Room.gameType == RoomType.Tenharf then
		self.OnPlayYuYinApplyCard(TenharfRoom)
	elseif Room.gameType == RoomType.GoldFlower then
		self.OnPlayYuYinApplyCard(GoldFlowerRoom)
	elseif Room.gameType == RoomType.CatchPock then
		self.OnPlayYuYinApplyCard(CatchPockRoom)
	elseif Room.gameType == RoomType.NiuNiu then
		self.OnPlayYuYinApplyCard(NiuNiuRoom)
	end
end

function GameChatCtrl.OnPlayYuYinApplyCard(roomType)
	local self = GameChatCtrl
	local sitNum = roomType:GetRoomIndexByIndex(chatSelfIndexs)
	if sitNum == 1 or sitNum == 4 or sitNum == 5 then
		emoticonText = tostring('e25')
		resMgr:LoadPrefab('faceicon', { 'e25' }, self.playYuYinsAndEmoticon)
	elseif sitNum == 2 or sitNum == 3 then
		emoticonText = tostring('e26')
		resMgr:LoadPrefab('faceicon', { 'e26' }, self.playYuYinsAndEmoticon)
	end
end

function GameChatCtrl.playYuYinsAndEmoticon(objs)
	local self = GameChatCtrl
	if Room.gameType == RoomType.Tenharf then
		self.playYuYinsAndEmoticonApplyCard(TenharfRoom, objs)
	elseif Room.gameType == RoomType.GoldFlower then
		self.playYuYinsAndEmoticonApplyCard(GoldFlowerRoom, objs)
	elseif Room.gameType == RoomType.CatchPock then
		self.playYuYinsAndEmoticonApplyCard(CatchPockRoom, objs)
	elseif Room.gameType == RoomType.NiuNiu then
		self.playYuYinsAndEmoticonApplyCard(NiuNiuRoom, objs)
	end
end

function GameChatCtrl.playYuYinsAndEmoticonApplyCard(roomType, objs)
	local parent = nil
	parent = roomType:GetPlayer(chatSelfIndexs).imgFaceIcon.transform
	local go = newObject(objs[0])
	go.name = emoticonText
	go.transform:SetParent(parent)
	go.transform.localScale = Vector3.one
	go.transform.localPosition = Vector3.zero
	-- if roomType == CatchPockRoom then
	CH_GameMainCtrl.FaceIconBGD(chatSelfIndexs, true, go, roomType)
	-- else
	TH_GameMainCtrl.FaceIconBGD(chatSelfIndexs, true, go, roomType)
	-- end
end

function GameChatCtrl:showEmoticon(chatType, chatText, chatSelfIndex)
	-- 生成预制--
	if chatType ~= 3 then
		return
	end
	local self = GameChatCtrl
	emoticonText = chatText
	if Room.gameType == RoomType.Mahjong then
		local location = getOtherPlayerLocation(chatSelfIndex)
		if location == 'D' then
			if (chatType == 3) then
				resMgr:LoadPrefab('faceicon', { chatText }, self.selfEmoticon)
			end
		elseif location == 'R' then
			if (chatType == 3) then
				resMgr:LoadPrefab('faceicon', { chatText }, self.rightEmoticon)
			end
		elseif location == 'L' then
			if (chatType == 3) then
				resMgr:LoadPrefab('faceicon', { chatText }, self.leftEmoticon)
			end
		elseif location == 'U' then
			if (chatType == 3) then
				resMgr:LoadPrefab('faceicon', { chatText }, self.upEmoticon)
			end
		else
			logWarn('--------------------------->位置信息错误')
		end
	else
		if (chatType == 3) then
			chatSelfIndexs = chatSelfIndex
			resMgr:LoadPrefab('faceicon', { chatText }, self.playYuYinsAndEmoticon)
		end
	end
end

function GameChatCtrl.selfEmoticon(objs)
	local parent = nil
	if OB_GameMainCtrl.isCreate then
		OB_GameMainCtrl.FaceIconBGD(true)
		parent = OB_GameMainPanel.imgFaceIconBGDGrid.transform
	elseif OB_GameMainPanel.isCreate then
		OB_GameMainPanel.FaceIconBGD(true)
		parent = OB_GameMainPanel.waitImgFaceIconBGDGrid.transform
	end
	local go = newObject(objs[0])
	go.name = emoticonText
	go.transform:SetParent(parent)
	go.transform.localScale = Vector3.one
	go.transform.localPosition = Vector3.zero
	gameRoom.selfEmoticonObject = go
end

function GameChatCtrl.rightEmoticon(objs)
	local parent = nil
	if OB_GameMainCtrl.isCreate then
		OB_GameMainCtrl.FaceIconBGR(true)
		parent = OB_GameMainPanel.imgFaceIconBGRGrid.transform
	elseif OB_GameMainPanel.isCreate then
		OB_GameMainPanel.FaceIconBGR(true)
		parent = OB_GameMainPanel.waitImgFaceIconBGRGrid.transform
	end
	local go = newObject(objs[0])
	go.name = emoticonText
	go.transform:SetParent(parent)
	go.transform.localScale = Vector3.one
	go.transform.localPosition = Vector3.zero
	gameRoom.rightEmoticonObject = go
end

function GameChatCtrl.upEmoticon(objs)
	local parent = nil
	if OB_GameMainCtrl.isCreate then
		OB_GameMainCtrl.FaceIconBGU(true)
		parent = OB_GameMainPanel.imgFaceIconBGUGrid.transform
	elseif OB_GameMainPanel.isCreate then
		OB_GameMainPanel.FaceIconBGU(true)
		parent = OB_GameMainPanel.waitImgFaceIconBGUGrid.transform
	end
	local go = newObject(objs[0])
	go.name = emoticonText
	go.transform:SetParent(parent)
	go.transform.localScale = Vector3.one
	go.transform.localPosition = Vector3.zero
	gameRoom.upEmoticonObject = go
end

function GameChatCtrl.leftEmoticon(objs)
	local parent = nil
	if OB_GameMainCtrl.isCreate then
		OB_GameMainCtrl.FaceIconBGL(true)
		parent = OB_GameMainPanel.imgFaceIconBGLGrid.transform
	elseif OB_GameMainPanel.isCreate then
		OB_GameMainPanel.FaceIconBGL(true)
		parent = OB_GameMainPanel.waitImgFaceIconBGLGrid.transform
	end
	local go = newObject(objs[0])
	go.name = emoticonText
	go.transform:SetParent(parent)
	go.transform.localScale = Vector3.one
	go.transform.localPosition = Vector3.zero
	gameRoom.leftEmoticonObject = go
end

function GameChatCtrl:PlayMusic(chatType, chatText, chatSelfIndex)
	if chatType ~= 4 then
		return
	end
	if Room.gameType == RoomType.Mahjong then
		local location = getOtherPlayerLocation(chatSelfIndex)
		local text = GameChatCtrl.GetTextMsg(chatType, chatText)
		OB_GameMainCtrl.ChatLength(text, location)
	elseif Room.gameType == RoomType.Tenharf then
		local text = GameChatCtrl.GetTextMsg(chatType, chatText)
		if (chatType == 4) then
			TH_GameMainCtrl.ChatWindow(chatSelfIndex, text, TenharfRoom)
		end
	elseif Room.gameType == RoomType.GoldFlower then
		local text = GameChatCtrl.GetTextMsg(chatType, chatText)
		if (chatType == 4) then
			TH_GameMainCtrl.ChatWindow(chatSelfIndex, text, GoldFlowerRoom)
		end
	elseif Room.gameType == RoomType.CatchPock then
		local text = GameChatCtrl.GetTextMsg(chatType, chatText)
		if (chatType == 4) then
			CH_GameMainCtrl.ChatWindow(chatSelfIndex, text, CatchPockRoom)
		end
	elseif Room.gameType == RoomType.NiuNiu then
		local text = GameChatCtrl.GetTextMsg(chatType, chatText)
		if (chatType == 4) then
			TH_GameMainCtrl.ChatWindow(chatSelfIndex, text, NiuNiuRoom)
		end
	end

	if (chatType == 4) then
		if (chatText == "s01") then
			Game.Sing("01")
		elseif (chatText == "s02") then
			Game.Sing("02")
		elseif (chatText == "s03") then
			Game.Sing("03")
		elseif (chatText == "s04") then
			Game.Sing("04")
		elseif (chatText == "s05") then
			Game.Sing("05")
		elseif (chatText == "s06") then
			Game.Sing("06")
		elseif (chatText == "s07") then
			Game.Sing("07")
		elseif (chatText == "s08") then
			Game.Sing("08")
		elseif (chatText == "s09") then
			Game.Sing("09")
		elseif (chatText == "s10") then
			Game.Sing("10")
		elseif (chatText == "s11") then
			Game.Sing("11")
		elseif (chatText == "s12") then
			Game.Sing("12")
		elseif (chatText == "s13") then
			Game.Sing("13")
		elseif (chatText == "s14") then
			Game.Sing("14")
		elseif (chatText == "s15") then
			Game.Sing("15")
		end
	end
end

function GameChatCtrl:ShowPTChatAndFYChat(chatType, chatText, chatSelfIndex)
	local self = GameChatCtrl
	if not(chatType == 1 or chatType == 2) then
		return
	end

	if AppConst.getPlayerPrefs('isNXFYOn') == '' then
		global.systemVo.isNXFYOn = '1'
	else
		global.systemVo.isNXFYOn = AppConst.getPlayerPrefs('isNXFYOn')
	end

	if Room.gameType == RoomType.Mahjong then

		local location = getOtherPlayerLocation(chatSelfIndex)
		local text = GameChatCtrl.GetTextMsg(chatType, chatText)
		OB_GameMainCtrl.ChatLength(text, location)
	elseif Room.gameType == RoomType.Tenharf then
		global.systemVo.isNXFYOn = '0'
		local text = GameChatCtrl.GetTextMsg(chatType, chatText)
		if chatType == 1 or chatType == 2 then
			TH_GameMainCtrl.ChatWindow(chatSelfIndex, text, TenharfRoom)
		end
	elseif Room.gameType == RoomType.GoldFlower then
		global.systemVo.isNXFYOn = '0'
		local text = GameChatCtrl.GetTextMsg(chatType, chatText)
		if chatType == 1 or chatType == 2 then
			TH_GameMainCtrl.ChatWindow(chatSelfIndex, text, GoldFlowerRoom)
		end
	elseif Room.gameType == RoomType.CatchPock then
		global.systemVo.isNXFYOn = '0'
		local text = GameChatCtrl.GetTextMsg(chatType, chatText)
		if chatType == 1 or chatType == 2 then
			CH_GameMainCtrl.ChatWindow(chatSelfIndex, text, CatchPockRoom)
		end
	elseif Room.gameType == RoomType.NiuNiu then
		global.systemVo.isNXFYOn = '0'
		local text = GameChatCtrl.GetTextMsg(chatType, chatText)
		if chatType == 1 or chatType == 2 then
			TH_GameMainCtrl.ChatWindow(chatSelfIndex, text, NiuNiuRoom)
		end
	end

	if (chatType == 1) then
		if (chatText == "p01") then
			Game.Speak("g_buhaoyisi")
		elseif (chatText == "p02") then
			Game.Speak("g_dadehao")
		elseif (chatText == "p03") then
			Game.Speak("g_dajiahao")
		elseif (chatText == "p04") then
			Game.Speak("g_qingshanbugai")
		elseif (chatText == "p05") then
			Game.Speak("g_kuaidian")
		elseif (chatText == "p06") then
			Game.Speak("g_nishimeimei")
		elseif (chatText == "p07") then
			Game.Speak("g_zaixiangxiang")
		elseif (chatText == "p08") then
			Game.Speak("g_buyaozou")
		elseif (chatText == "p09") then
			Game.Speak("g_buzhishimeimao")
		end
	end

	if (chatType == 2) then
		if (chatText == "f01") then
			Game.Speak("phrase_001")
		elseif (chatText == "f02") then
			Game.Speak("phrase_002")
		elseif (chatText == "f03") then
			Game.Speak("nv_007")
		elseif (chatText == "f04") then
			Game.Speak("nv_002")
		elseif (chatText == "f05") then
			Game.Speak("phrase_005")
		elseif (chatText == "f06") then
			Game.Speak("phrase_003")
		elseif (chatText == "f07") then
			Game.Speak("phrase_010")
		elseif (chatText == "f08") then
			Game.Speak("nv_005")
		elseif (chatText == "f09") then
			Game.Speak("nv_006")
		elseif (chatText == "f10") then
			Game.Speak("nv_001")
		elseif (chatText == "f11") then
			Game.Speak("nv_004")
		elseif (chatText == "f12") then
			Game.Speak("phrase_007")
		elseif (chatText == "f13") then
			Game.Speak("phrase_008")
		elseif (chatText == "f14") then
			Game.Speak("nv_009")
		elseif (chatText == "f15") then
			Game.Speak("phrase_017")
		end
	end
end

function GameChatCtrl.GetTextMsg(chatType, chatText)
	local text = nil
	if chatType == 1 then
		for k, v in pairs(Game.putongText) do
			if chatText == k then
				text = v
				break
			end
		end
	elseif chatType == 2 then
		for k, v in pairs(Game.fangyanText) do
			if chatText == k then
				text = v
				break
			end
		end
	elseif chatType == 4 then
		for k, v in pairs(Game.singText) do
			if chatText == k then
				text = v
				break
			end
		end
	end
	return text
end

function GameChatCtrl:showChatInfo(chatType, chatText, chatSelfIndex)
	local self = GameChatCtrl
	if chatType ~= 8 then
		return
	end

	if Room.gameType == RoomType.Mahjong then
		local location = getOtherPlayerLocation(chatSelfIndex)
		local text = chatText
		OB_GameMainCtrl.ChatLength(text, location)
	elseif Room.gameType == RoomType.Tenharf then
		local text = chatText
		if chatType == 8 then
			TH_GameMainCtrl.ChatWindow(chatSelfIndex, chatText, TenharfRoom)
		end
	elseif Room.gameType == RoomType.GoldFlower then
		local text = chatText
		if chatType == 8 then
			TH_GameMainCtrl.ChatWindow(chatSelfIndex, chatText, GoldFlowerRoom)
		end
	elseif Room.gameType == RoomType.CatchPock then
		local text = chatText
		if chatType == 8 then
			CH_GameMainCtrl.ChatWindow(chatSelfIndex, chatText, CatchPockRoom)
		end
	elseif Room.gameType == RoomType.NiuNiu then
		local text = chatText
		if chatType == 8 then
			TH_GameMainCtrl.ChatWindow(chatSelfIndex, chatText, NiuNiuRoom)
		end
	end
end