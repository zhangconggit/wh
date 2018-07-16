CatchPockRoom = {
	RoomMsg = { },
	curPopTips = { },
	clickNum = 0,
	btnCheck = 0,
	NextCardGo = { },
}

setbaseclass(CatchPockRoom, { RoomObject })
-- 缓存
function CatchPockRoom.SaveGameObj(objs, name)
	local self = CatchPockRoom
	if self.loadObjList[name] then return end
	self.loadObjList[name] = objs[0]
	print("====SaveGameObj====:", self.loadObjList[name])
end

-- 加载
function CatchPockRoom:LoadGameObj(objs)
	print("====LoadGameObj====", Room.gameType)
	local GuiCamera = find('Canvas/GuiCamera')
	self.imgHead = BasePanel:GOChild(obj, "Mask/img")
	-- 获取数据
	CatchPockRoom.gameUI = newObject(objs)
	CatchPockRoom.gameUI.transform:SetParent(GuiCamera.transform)
	CatchPockRoom.gameUI.transform.localScale = Vector3.one
	CatchPockRoom.gameUI.transform.localPosition = Vector3.zero
	local table = find("Canvas/GuiCamera/Sence(Clone)/Desk/CHTable/imgTHBG")
	local CHTable = find("Canvas/GuiCamera/Sence(Clone)/Desk/CHTable")
	CHTable:SetActive(true)
	self.playerPanel = find("Canvas/GuiCamera/Sence(Clone)/Players")

	self.playerPanel:SetActive(false)
	self.allJushu = CatchPockRoom.RoomMsg.catchTotal
	self.txtWanFa = BasePanel:GOChild(table, "imgRoomMessageBG/txtWanFa")
	self.imgJuShu = BasePanel:GOChild(table, "imgJuShu")
	self.txtJuShu = BasePanel:GOChild(table, "imgRoomMessageBG/txtJuShu")
	self.txtRoomNum = BasePanel:GOChild(table, "imgRoomMessageBG/txtRoomNum")
	self.common = BasePanel:GOChild(self.playerPanel, "Common")
	self.empty = BasePanel:GOChild(self.playerPanel, "Empty")
	self.cardBg = BasePanel:GOChild(self.playerPanel, "CardBg")
	CH_GameMainCtrl:Open("CH_GameMain", function()
		for i = 1, 3 do
			local obj = self.playerPanel.transform:FindChild("CH_Player" .. i).gameObject
			obj:SetActive(false)
		end
		print("====LoadGameObj=111221212121238881TenharfRoom")
		self:ResourceCheckOver()
		print("====LoadGameObj====222222222TenharfRoom")
		local gamePanel = find("Canvas/GuiCamera/CH_GameMainPanel")
		gamePanel.transform:SetParent(self.playerPanel.transform)
		gamePanel.transform:SetSiblingIndex(6)
	end )
	self.btnCheck = 0
end

-- 初始化
function CatchPockRoom:InitPlayers()
	print("=============InitPlayers===", #self.players, self.playerCount, self.myIndex, self.playersData, global.systemVo.EffectSource.volume)
	self.curJushu = 0
	self:SetCurJushu(self.curJushu)

	-- 清理手牌和玩家
	if self.players ~= nil then
		for _, v in ipairs(self.players) do
			if v.obj ~= nil then
				v:Destroy()
			end
		end
		self.players = { }
	end
	for i = 1, 3 do
		local obj = self.playerPanel.transform:FindChild("CH_Player" .. i).gameObject
		obj:SetActive(false)
	end


	-- 初始化玩家信息
	for i = 1, self.playerCount do
		print("------------------CH_Player---", self:GetRoomIndexByIndex(i))
		local obj = self.playerPanel.transform:FindChild("CH_Player" .. self:GetRoomIndexByIndex(i)).gameObject
		local playerObj = CatchPockPlayer:New(self.playersData[i], obj)
		table.insert(self.players, playerObj)
		if self.myIndex ~= playerObj.index then
			CH_GameMainCtrl:RemoveClick(playerObj.imgHead)
			CH_GameMainCtrl:AddClick(playerObj.imgHead, CH_GameMainCtrl.OnClickHead)
		else
			if not self.isAdd then
				CH_GameMainCtrl:AddClick(playerObj.imgHead, CH_GameMainCtrl.OnClickHead)
				self.isAdd = true
			end
		end
		playerObj.obj:SetActive(true)
	end
	print("--------------------------", #self.players)
	for i, v in ipairs(self.players) do
		v.obj:SetActive(true)
		CH_GameMainCtrl:SetText(v.txtName, v.name)
		CH_GameMainCtrl:SetText(v.txtScore, v.jifen)
		v.imgOK:SetActive(false)
		v.imgZhuang:SetActive(false)
		v.imgChat:SetActive(false)
		v.imgFaceIcon:SetActive(false)
		v.imgDeng:SetActive(false)
		v.imgAnim:SetActive(false)
		v.imgCur:SetActive(false)
		v.imgCard:SetActive(false)
		v:PopType(0, 0)
		-- 新添加
		v.imgYuanbao:SetActive(false)
		v.imgJinbi:SetActive(false)
		if self.RoomMsg.moneyType == RoomMode.goldMode then
			v.imgJinbi:SetActive(true)
			CH_GameMainCtrl:SetText(v.txtScore, formatNumber(v.goldcoin))
		elseif self.RoomMsg.moneyType == RoomMode.wingMode then
			v.imgYuanbao:SetActive(true)
			CH_GameMainCtrl:SetText(v.txtScore, formatNumber(v.wing))
		end
	end
	CH_GameMainPanel.btnGameStart:SetActive(true)
	-- 新添加
	-- if self.RoomMsg.moneyType == RoomMode.goldMode then
	--    CH_GameMainPanel.btnGameStart:SetActive(false)
	-- elseif self.RoomMsg.moneyType == RoomMode.wingMode then
	--    CH_GameMainPanel.btnGameStart:SetActive(false)
	-- end
	self.playerPanel:SetActive(true)
	self.btnObjList = {
		btnBuChu =
		{
			btn = CH_GameMainPanel.btnBuChu:GetComponent("Button"),
			img = CH_GameMainPanel.btnBuChu:GetComponent("Image"),
			txt = BasePanel:GOChild(CH_GameMainPanel.btnBuChu,"Text"):GetComponent("Text"),
			spr = nil,
			color = nil
		},
		btnChuPai =
		{
			btn = CH_GameMainPanel.btnChuPai:GetComponent("Button"),
			img = CH_GameMainPanel.btnChuPai:GetComponent("Image"),
			txt = BasePanel:GOChild(CH_GameMainPanel.btnChuPai,"Text"):GetComponent("Text"),
			spr = nil,
			color = nil
		},
		btnTiShi =
		{
			btn = CH_GameMainPanel.btnTiShi:GetComponent("Button"),
			txt = BasePanel:GOChild(CH_GameMainPanel.btnTiShi,"Text")
		},
	}
	self.spr_gray = CH_GameMainPanel.btn_gray:GetComponent("Image").sprite
	self.txt_gray = Color.New(0, 0, 0, 0.7)

	-- 准备状态
	if self.RoomMsg.readyIndex ~= nil then
		for i, v in ipairs(self.RoomMsg.readyIndex) do
			local curCache = self:GetPlayerById(v)
			print("-------", curCache)
			curCache.imgOK:SetActive(true)
			-- 可以看到其他玩家的准备情况
			if curCache.index == self.myIndex then
				CH_GameMainPanel.btnGameStart:SetActive(false)
			end
		end
	end
	local quitPanel = CH_GameMainPanel.imgQuitTips
	local singlePanel = CH_GameMainPanel.panel_SingleSettlement
	singlePanel.transform:SetParent(self.playerPanel.transform)
	singlePanel.transform:SetAsLastSibling()
	quitPanel.transform:SetParent(self.playerPanel.transform)
	quitPanel.transform:SetAsLastSibling()
	BlockLayerCtrl:CloseSpec()
	self.initPlayerEnd = true
	self.btnStart = false
end

function CatchPockRoom:Reload(data)
	-- 接收数据
	self.notVoice = true
	self.hasLoaded = false
	self.initPlayerEnd = false
	self.btnStart = false
	local roomVo = RoomCatchVo:New()
	roomVo.id = data.roomNum
	roomVo.catchTotal = data.catchTotal
	-- 添加
	roomVo.baseNum = data.baseNum
	roomVo.qualified = data.qualified
	roomVo.moneyType = data.moneyType

	self.RoomMsg = roomVo
	self.playersData = { }
	self.players = { }
	self.btnCheck = 0
	local curEnd = data.curEnd
	self:ClearRoomInfo()
	for i, v in ipairs(data.roles) do
		local joinRoomUserVo = JoinRoomUserVo:New()
		joinRoomUserVo.index = v.roleIndex;
		joinRoomUserVo.roleId = v.roleId;
		joinRoomUserVo.name = v.name;
		joinRoomUserVo.ip = v.ip;
		joinRoomUserVo.headImg = v.headImg;
		joinRoomUserVo.jifen = v.jifen;
		joinRoomUserVo.gender = v.gender;
		joinRoomUserVo.diamond = v.diamond;
		joinRoomUserVo.isOnline = v.isOnline;
		-- 新添加
		joinRoomUserVo.goldcoin = v.goldcoin
		-- 金币数量
		joinRoomUserVo.wing = v.wing
		-- 元宝数量
		local placeMsg = v.locationInfo;
		local strArray
		strArray = string_split(placeMsg, "/")
		global.gpsMsgInfo[tostring(v.roleId)] = { strArray[1], tonumber(strArray[2]), tonumber(strArray[3]) }
		self.playersData[v.roleIndex] = joinRoomUserVo
		if v.roleId == global.userVo.roleId then
			self.myIndex = v.roleIndex
		end
	end
	self.playerCount = #self.playersData

	-- 重连设置
	local co = coroutine.start( function()
		while not self.isPrefabLoaded do
			coroutine.step()
		end
		-- 设置房间信息
		print("====Reload==SetRoom==", data.roomNum, data.alreadyJuShu, data.curIndex)
		CH_GameMainPanel.panel_WaitFriend:SetActive(false)
		CH_GameMainPanel.imgCHGameMain:SetActive(true)
		CH_GameMainPanel.btnGameMainQuitRoom:SetActive(true)
		-- 新添加
		if self.RoomMsg.moneyType == RoomMode.goldMode then
			CH_GameMainPanel.btnGameMainQuitRoom:SetActive(false)
		elseif self.RoomMsg.moneyType == RoomMode.wingMode then
			CH_GameMainPanel.btnGameMainQuitRoom:SetActive(false)
		end
		CH_GameMainPanel.btnSetSystem:SetActive(true)
		CH_GameMainPanel.btnChat:SetActive(true)
		CH_GameMainPanel.imgSignalBG:SetActive(false)

		self:InitPlayers()
		self.curJushu = data.alreadyJuShu
		self.allJushu = data.catchTotal
		self.alreadyJuShu = data.alreadyJuShu
		self:SetCurJushu(self.curJushu)

		local curIndex = data.curIndex
		local curEnd = data.curEnd
		local firstIndex = data.firstIndex
		local lastIndex = curIndex

		-- 把自己的头像放在左边
		for i, v in ipairs(self.players) do
			if self.myIndex == v.index then
				v.obj.transform.localPosition = Vector3.New(-525, -113, 0)
			end
		end
		-- 设置玩家信息
		if not curEnd then
			for i, role in ipairs(data.roles) do
				local curCache = self:GetPlayer(i)
				local spInfo = ReLoad_pb.CatchPockRoleSpInfo()
				spInfo:ParseFromString(role.spInfoRes)
				curCache.cardsCount = spInfo.leftCount
				print("player----cardtype-----------", i, #spInfo.popCards, spInfo.buttonTips, #spInfo.tips)
				-- 最后出的牌
				if i ~= curIndex then
					self:ClearLastCards(i, spInfo.popCards)
					self:CardType(i, spInfo.popCardType, spInfo.popCards)
				end
				-- 给自己生成手牌
				if i == self.myIndex then
					for j, k in ipairs(spInfo.handCards) do
						curCache:GetOneCard(i, k, 2, false)
					end
					print("!!!!!!!!!!!!!!!!!!!!!!!!!!---------------------self", curCache.cardsCount)
				end

				-- 提示
				if curIndex == self.myIndex and curIndex == i then
					self.TipFunc(curIndex, spInfo.buttonTips, spInfo.tips)
				end
				curCache.imgCard:SetActive(true)
			end
		end
		lastIndex = lastIndex - 1
		if lastIndex <= 0 then
			lastIndex = 3
		end
		self:GoNextPlayer(lastIndex)
		self.notVoice = false
		self.hasLoaded = true
		if self.RoomMsg.moneyType == RoomMode.roomCardMode then
			Room:SetGps(data.roles)
		end
		print("ReLoad---------------------", curIndex, self.myIndex)
	end )
	table.insert(Network.crts, co)
end

-- 按钮变灰
function CatchPockRoom:BtnShow(name, bool)
	if bool then
		if self.btnObjList[name].spr == nil then
			self.btnObjList[name].spr = self.btnObjList[name].img.sprite
			self.btnObjList[name].color = self.btnObjList[name].txt.color
		else
			self.btnObjList[name].img.sprite = self.btnObjList[name].spr
			self.btnObjList[name].txt.color = self.btnObjList[name].color
		end
	else
		if self.btnObjList[name].spr == nil then
			self.btnObjList[name].spr = self.btnObjList[name].img.sprite
			self.btnObjList[name].color = self.btnObjList[name].txt.color
		end
		self.btnObjList[name].img.sprite = self.spr_gray
		self.btnObjList[name].txt.color = self.txt_gray
	end
	self.btnObjList[name].btn.interactable = bool
end

-- 发牌
function CatchPockRoom:DealCard(roleIndex, cardInfo, firstIndex)
	CH_GameMainPanel.panel_WaitFriend:SetActive(false)
	CH_GameMainPanel.btnGameMainQuitRoom:SetActive(true)
	CH_GameMainPanel.imgSignalBG:SetActive(false)
	CH_GameMainPanel.btnChat:SetActive(true)
	CH_GameMainPanel.imgCHGameMain:SetActive(true)
	CH_GameMainPanel.btnSetSystem:SetActive(true)
	CH_GameMainPanel.imgBtn:SetActive(false)
	CH_GameMainPanel.imgClock:SetActive(false)
	self.curJushu = self.curJushu + 1
	self:SetCurJushu(self.curJushu)
	self.btnStart = false
	self.hasLoaded = false
	-- 新添加
	if self.RoomMsg.moneyType ~= 0 then
		CH_GameMainPanel.btnGameMainQuitRoom:SetActive(false)
		self:NextGame()
	end
	print("-----------DealCard------", roleIndex, #cardInfo, firstIndex)
	for i, v in ipairs(self.players) do
		v.imgCard:SetActive(true)
		if self.myIndex == v.index then
			v.obj.transform.localPosition = Vector3.New(-525, -113, 0)
		end
	end
	-- 手牌张数，牌间距
	local co = coroutine.start( function()
		local curCache = self:GetPlayer(roleIndex)
		for i, v in ipairs(cardInfo) do
			curCache:GetOneCard(roleIndex, v, 2, false)
			coroutine.wait(0.01)
		end
		Game.MusicEffect(Game.Effect.thfapai1)
		CH_GameMainPanel.imgPublicCard:SetActive(false)
		self.hasLoaded = true
		if firstIndex == self.myIndex then
			CH_GameMainPanel.imgBtn:SetActive(true)
		end
		self:KuangShow(firstIndex)
		local clockIndex = self:GetPlayer(firstIndex).sitIndex
		CH_GameMainCtrl:CountDown(clockIndex)
	end )
	table.insert(Network.crts, co)

end

-- 设置局数
function CatchPockRoom:SetCurJushu(curJushu)
	local totalJushu = self.allJushu
	local txt = curJushu .. '/' .. tostring(totalJushu)
	CH_GameMainCtrl:SetText(self.txtJuShu, txt)
	-- 新添加
	local textCatchPockBasenum = '底分：' .. tostring(CatchPockRoom.RoomMsg.baseNum)
	local textCatchPockQualified = tostring(CatchPockRoom.RoomMsg.qualified) .. '进' .. tostring(CatchPockRoom.RoomMsg.qualified) .. '出'
	if self.RoomMsg.moneyType == RoomMode.goldMode then
		CH_GameMainCtrl:SetText(self.txtJuShu, textCatchPockBasenum)
	elseif self.RoomMsg.moneyType == RoomMode.wingMode then
		CH_GameMainCtrl:SetText(self.txtJuShu, textCatchPockBasenum)
	end
end

-- 准备消息返回
function CatchPockRoom.ReadyGameRes(buffer)
	print("=====ReadyGame=====1")
	local self = CatchPockRoom
	local data = buffer:ReadBuffer()
	local msg = CatchSettlementStartGame_pb.CatchSettlementStartGameRes()
	msg:ParseFromString(data)
	print("=====ReadyGame=====2", #msg.alreadyIndex)
	local readyIndex = msg.alreadyIndex
	local allStart = msg.allStart
	-- for i,v in ipairs(readyIndex) do
	--      print("=====ReadyGame=====3",readyIndex,v)
	--     local curCache = self:GetPlayer(v)
	--     curCache.imgOK:SetActive(true)
	--     if v == self.myIndex then
	--         CH_GameMainPanel.btnGameStart:SetActive(false)
	--     end
	-- end
	for i, v in ipairs(readyIndex) do
		print("=====CatchSettlementStartGameRes=====:", readyIndex, v)
		local curCache = self:GetPlayer(v)
		curCache.imgOK:SetActive(true)
		-- 这句经测试必须要有（否则进去看不到别人的状态）
		if v == self.myIndex then
			CH_GameMainPanel.imgBtn:SetActive(false)
			CH_GameMainPanel.btnBuChu:SetActive(true)
			CH_GameMainPanel.btnChuPai:SetActive(true)
			CH_GameMainCtrl.SetIconTips("没有牌大过上家", false)
			CH_GameMainCtrl:SetText(self.btnObjList.btnTiShi.txt, "提  示")
			CH_GameMainPanel.panel_SingleSettlement:SetActive(false)
			if self.curJushu == 0 then
				CH_GameMainPanel.btnGameStart:SetActive(false)
			end
		end
	end
	if allStart then
		self:NextGame()
	end
	if self.curJushu ~= 0 then
		CH_GameMainPanel.panel_WaitFriend:SetActive(false)
	end
end

-- 发牌消息返回
function CatchPockRoom.CatchPockDealRes(buffer)
	local self = CatchPockRoom
	local data = buffer:ReadBuffer()
	local msg = CatchPockDeal_pb.CatchPockDealRes()
	msg:ParseFromString(data)
	local roleIndex = msg.roleIndex
	local cardInfo = msg.cardInfo
	local firstIndex = msg.firstIndex
	print("=====CatchPockDeal=====", roleIndex, cardInfo, firstIndex)
	self:DealCard(roleIndex, cardInfo, firstIndex)
	-- 发牌

	for i, v in ipairs(self.players) do
		-- 准备图片消失
		v.imgOK:SetActive(false)
	end
	CH_GameMainPanel.btnWaitQuitRoom:SetActive(false)     --发牌过后就不能退出房间了
    CH_GameMainPanel.imgNotWaitQuitRoom:SetActive(true) --暗的显示
end

-- 打牌消息--
function CatchPockRoom.CatchPopCardReq()
	Game.MusicEffect(Game.Effect.joinRoom)
	local self = CatchPockRoom
	print("-----------------!!!!!!!!-------------D1--", self.btnCheck)
	if self.btnCheck == 1 then return end
	self.btnCheck = 1
	local popCardInfo = CatchPopCard_pb.CatchPopCardReq()
	local curCache = self:GetPlayer(self.myIndex)
	local strList = ""
	-- print("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!",curCache.cards[1].gameObject.transform.localPosition.y)
	for i, v in ipairs(curCache.cards) do
		if v.selectNum == 1 and v.gameObject.transform.localPosition.y == 0 then
			v.selectNum = 0
		end
		if v.selectNum == 1 then
			v:PickUp()
			strList = strList .. v.id .. ","
		end
	end
	print("--------CatchPopCardReq----------", strList)
	if strList == "" then
		self.btnCheck = 0
		CH_GameMainCtrl.SetIconTips("您选择的牌不符合规则")
		return
	end
	popCardInfo.handCard = strList
	local msg = popCardInfo:SerializeToString()
	Game.SendProtocal(Protocal.CatchPopCard, msg)
end

-- 打牌消息返回--
function CatchPockRoom.CatchPopCardRes(buffer)
	local self = CatchPockRoom
	local data = buffer:ReadBuffer()
	local msg = CatchPopCard_pb.CatchPopCardRes()
	msg:ParseFromString(data)
	local roleIndex = msg.roleIndex
	local cardInfo = msg.cardInfo
	local cardType = msg.cardType
	print("---------CatchPopCardRes----------", roleIndex, #cardInfo, cardType)

	self:ClearLastCards(roleIndex, cardInfo)
	self:CardType(roleIndex, cardType, cardInfo)
	self:GoNextPlayer(roleIndex)
end

-- 收到返回清理手牌
function CatchPockRoom:ClearLastCards(roleIndex, cardInfo, isEnd)
	local curCache = self:GetPlayer(roleIndex)
	if roleIndex ~= self.myIndex then
		for j, k in ipairs(cardInfo) do
			print("-------------------------每次出牌      結束時出牌")
			curCache:GetOneCard(roleIndex, k, 2, true, isEnd)
		end
	else
		for i, v in ipairs(cardInfo) do
			for j, k in ipairs(curCache.cards) do
				if v.id == k.id then
					curCache:PopCard(k)
					table.remove(curCache.cards, j)
				end
			end
		end
	end
end

-- 判断牌型
function CatchPockRoom:CardType(index, cardType, cardInfo)
	print("===========CardType", index, cardType)
	local curCache = self:GetPlayer(index)
	local animType = 0
	if self.hasLoaded then
		curCache.cardsCount = curCache.cardsCount - #cardInfo
		local curCount = curCache.cardsCount
		if curCache.cardsCount <= 3 then
			curCache.warning:SetActive(true)
			CH_GameMainCtrl:SetText(curCache.txtOverNum, curCount)
			if curCount == 1 then
				curCache:PlaySound("one")
			elseif curCount == 2 then
				curCache:PlaySound("two")
			else
				curCache:PlaySound(cardType, cardInfo)
			end
		else
			curCache:PlaySound(cardType, cardInfo)
		end
	end
	-- 判断牌型
	if cardType == 2 or cardType == 3 then
		cardType = 2
		animType = 2
	elseif cardType == 9 then
		animType = 1
	elseif cardType == 1 then
		animType = 0
	elseif cardType == 10 then
		animType = 1
	elseif cardType == 11 or cardType == 12 or cardType == 13 then
		cardType = 11
		animType = 3
	else
		cardType = 0
	end
	print("===========CardType11", index, cardType, animType)
	curCache:PopType(index, cardType, animType)
end

-- 提示--
function CatchPockRoom.CatchPopTips()
	local self = CatchPockRoom

	if #self.curPopTips == 0 then
		CH_GameMainCtrl.SetIconTips("暂无提示，请手动出牌")
	end
	self.clickNum = self.clickNum - 1
	local curCache = self:GetPlayer(self.myIndex)
	print("========CatchPopTips======", #self.curPopTips, self.clickNum, #curCache.cards)
	for a, b in ipairs(curCache.cards) do
		b.selectNum = 0
		b:PickDown()
		b.pickUp = false
	end

	if self.clickNum <= #self.curPopTips and self.clickNum > 0 then
		for i, v in ipairs(self.curPopTips[self.clickNum].cardInfo) do
			for j, k in ipairs(curCache.cards) do
				if v.id == k.id then
					k.selectNum = 1
					k:PickUp()
					k.pickUp = true
				end
			end
		end
		Game.MusicEffect(Game.Effect.joinRoom)
	else
		self.clickNum = #self.curPopTips
		if #self.curPopTips == 0 then
			CatchPockRoom.CatchNoPop()
			return
		end
		for i, v in ipairs(self.curPopTips[self.clickNum].cardInfo) do
			for j, k in ipairs(curCache.cards) do
				if v.id == k.id then
					k.selectNum = 1
					k:PickUp()
					k.pickUp = true
				end
			end
		end
		Game.MusicEffect(Game.Effect.joinRoom)
	end
end

-- 提示消息返回--
function CatchPockRoom.CatchPockTipsRes(buffer)
	local data = buffer:ReadBuffer()
	local msg = CatchPockTips_pb.CatchPockTipsRes()
	msg:ParseFromString(data)
	local roleIndex = msg.roleIndex
	local buttonTips = msg.buttonTips
	local tips = msg.tips
	CatchPockRoom.TipFunc(roleIndex, buttonTips, tips)
end

function CatchPockRoom.TipFunc(roleIndex, buttonTips, tips)
	local self = CatchPockRoom
	self.btnCheck = 0
	self.clickNum = #tips + 1
	self.curPopTips = { }
	for i, v in ipairs(tips) do
		for m, n in ipairs(v.cardInfo) do
			print(m, n.id, n.num, n.color)
		end
	end
	local atLast = false
	local curCache = self:GetPlayer(self.myIndex)
	print("=====CatchPockTipsRes====", roleIndex, buttonTips, #tips)
	if roleIndex == self.myIndex then
		if buttonTips == 0 then
			if #tips == 0 then
				CH_GameMainCtrl.SetIconTips("没有牌大过上家", true)
				self.curPopTips = { }
				self:BtnShow("btnChuPai", false)
				print("-----------------!!!!!!!!--------------1--", self.btnCheck)
				-- local co = coroutine.start(function()
				--     coroutine.wait(1)
				--     if self.btnCheck == 0 then

				--         CatchPockRoom.CatchNoPop()
				--     end
				-- end)
				-- table.insert(Network.crts, co)
			else
				self.curPopTips = tips
			end
			-- return
		elseif buttonTips == 1 then
			print("-----------------!!!!!!!!buttonTips1", #tips, #tips[1].cardInfo, curCache.cardsCount)
			if #tips == 1 and #tips[1].cardInfo == 1 and curCache.cardsCount == 1 then
				atLast = true
			elseif #tips == 1 and #tips[1].cardInfo == curCache.cardsCount then
				atLast = true
			end
			self:BtnShow("btnBuChu", false)
			self.curPopTips = tips
		else
			print("-----------------!!!!!!!!buttonTips2", #tips, #tips[1].cardInfo, curCache.cardsCount)
			if #tips == 1 and #tips[1].cardInfo == 1 and curCache.cardsCount == 1 then
				atLast = true
			elseif #tips == 1 and #tips[1].cardInfo == curCache.cardsCount then
				atLast = true
			end
			-- self:BtnShow("btnChuPai",true)
			self:BtnShow("btnBuChu", true)
			self.curPopTips = tips
		end
		if atLast then
			local co = coroutine.start( function()
				if self.hasLoaded ~= true then
					coroutine.wait(1)
				end
				for i, v in ipairs(curCache.cards) do
					v.selectNum = 1
					v:PickUp()
				end
				self.CatchPopCardReq()
			end )
			table.insert(Network.crts, co)
		end
		CH_GameMainPanel.imgBtn:SetActive(true)
	end
	print("-----------------------------22222", #self.curPopTips)
end

-- 不出--
function CatchPockRoom.CatchNoPop()
	local self = CatchPockRoom
	print("-----------------!!!!!!!!!!!-------------2---", self.btnCheck)
	if self.btnCheck == 1 then return end
	self.btnCheck = 1
	Game.MusicEffect(Game.Effect.joinRoom)
	local strList = ""
	local popCardInfo = CatchPopCard_pb.CatchPopCardReq()
	local msg = popCardInfo:SerializeToString()
	Game.SendProtocal(Protocal.CatchPopCard, msg)
	print("--------CatchNoPop----------", strList)

	local curCache = self:GetPlayer(self.myIndex)
	CH_GameMainPanel.imgBtn:SetActive(false)
	CH_GameMainPanel.btnTiShi:SetActive(true)
	CH_GameMainPanel.btnChuPai:SetActive(true)
	CH_GameMainPanel.btnBuChu:SetActive(true)
	CH_GameMainCtrl.SetIconTips("没有牌大过上家", false)
	for a, b in ipairs(curCache.cards) do
		b.selectNum = 0
		b:PickDown()
	end
	print("-----------------!!!!!!!!!!!-------------3---", self.btnCheck)
end

-- 设置房间局数
function CatchPockRoom:SetCurJushu(curJushu)
	local self = CatchPockRoom
	local totalJushu = self.RoomMsg.catchTotal
	CH_GameMainCtrl:SetText(self.txtJuShu, "局数：" .. curJushu .. '/' .. tostring(totalJushu))
	-- 新添加
	local textCatchPockBasenum = '底分：' .. tostring(CatchPockRoom.RoomMsg.baseNum)
	local textCatchPockQualified = tostring(CatchPockRoom.RoomMsg.qualified) .. '进' .. tostring(CatchPockRoom.RoomMsg.qualified) .. '出'
	if self.RoomMsg.moneyType == RoomMode.goldMode then
		CH_GameMainCtrl:SetText(self.txtJuShu, textCatchPockBasenum)
	elseif self.RoomMsg.moneyType == RoomMode.wingMode then
		CH_GameMainCtrl:SetText(self.txtJuShu, textCatchPockBasenum)
	end
end

-- 单局结算
function CatchPockRoom.CatchSingleSettlementRes(buffer)
	print("==================CatchSingleSettlementRes==================", buffer)
	local self = CatchPockRoom
	local data = buffer:ReadBuffer()
	local msg = CatchSingleSettlement_pb.CatchSingleSettlementRes()
	msg:ParseFromString(data)
	local playerInfo = msg.settlementInfo
	local endType = msg.endType

	CH_GameMainPanel.imgCHGameMain:SetActive(false)
	print("==================CatchSingleSettlementRes==================", #msg.settlementInfo, msg.endType)
	local co = coroutine.start( function()
		if endType == 3 or endType == 4 or self.curJushu == self.RoomMsg.catchTotal then
			CH_GameMainPanel.btnSettleStartGame:SetActive(false)
		else
			coroutine.wait(1.5)
		end
		if self.RoomMsg.moneyType ~= 0 then
			CH_GameMainPanel.panel_WaitFriend:SetActive(true)
			CH_GameMainPanel.btnSetSystem:SetActive(false)
			CH_GameMainPanel.btnChat:SetActive(false)
			CH_GameMainPanel.btnGameMainQuitRoom:SetActive(false)
			self:NextGame()
		end
		-- 玩家积分赋值
		for i, v in ipairs(msg.settlementInfo) do
			local player = self:GetPlayer(v.roleIndex)
			if player ~= nil then
				if self.RoomMsg.moneyType == RoomMode.goldMode then
					player.jifen = formatNumber(player.goldcoin + v.curJiFen)
				elseif self.RoomMsg.moneyType == RoomMode.wingMode then
					player.jifen = formatNumber(player.wing + v.curJiFen)
				else
					player.jifen = v.jiFen
				end
			end
			CH_GameMainCtrl:SetText(player.txtScore, player.jifen)
			print("----------CatchSingleSettlementRes---------", v.roleIndex, v.curJiFen, v.jiFen, #v.leftCardInfo)
			for m, n in ipairs(player.cardTypeList) do
				n.obj:SetActive(false)
			end
			for i, v in ipairs(player.popList) do
				v:Destroy()
			end
			if v.roleIndex == self.myIndex then
				if v.curJiFen > 0 then
					-- 积分大于0，判断赢
					Game.MusicEffect(Game.Effect.shengli)
					CH_GameMainPanel.imgSettlementLost:SetActive(false)
					CH_GameMainPanel.imgSettlementWin:SetActive(true)
					CH_GameMainPanel.imgSettlementWin.transform.localScale = Vector3.zero
					self:DoScale(CH_GameMainPanel.imgSettlementWin)
					CH_GameMainCtrl:SetText(CH_GameMainPanel.txtWin, "+" .. v.curJiFen)
				else
					-- 积分小于0，判断输
					Game.MusicEffect(Game.Effect.shibai)
					CH_GameMainPanel.imgSettlementWin:SetActive(false)
					CH_GameMainPanel.imgSettlementLost:SetActive(true)
					CH_GameMainPanel.imgSettlementLost.transform.localScale = Vector3.zero
					self:DoScale(CH_GameMainPanel.imgSettlementLost)
					CH_GameMainCtrl:SetText(CH_GameMainPanel.txtLose, "" .. v.curJiFen)
				end
				-- CH_GameMainCtrl:NumberShow(v.curJiFen)
				if #player.cards == 0 then
					for j, k in ipairs(v.leftCardInfo) do
						player:GetOneCard(v.roleIndex, k, 2, false)
					end
				end
				player.warning:SetActive(false)
				player.imgCard:SetActive(true)
			else
				self:ClearLastCards(v.roleIndex, v.leftCardInfo, true)
				-- 这行代码显示玩家未打出的牌
				print("***************v.leftCardInfo******************", #v.leftCardInfo)
				print("***************v.leftCardInfo******************", #v.leftCardInfo)
				print("***************v.leftCardInfo******************", #v.leftCardInfo)
				player.imgCard:SetActive(false)
				player.warning:SetActive(false)
				player.txtOverNum:SetActive(false)
			end
		end
		CH_GameMainPanel.panel_SingleSettlement:SetActive(true)
	end )
	table.insert(Network.crts, co)
	CH_GameMainPanel.btnWaitQuitRoom:SetActive(true) --亮的显示--每局结束时下局开始前是可以退出游戏的
    CH_GameMainPanel.imgNotWaitQuitRoom:SetActive(false) --暗的隐藏
end

-- 每局结算后点击开始
function CatchPockRoom.OnSettleStartGameReq()
	local self = CatchPockRoom
	if self.btnStart then return end
	local msg = ""
	Game.SendProtocal(Protocal.CatchPockRoomReady, msg)
	self.btnStart = true
	for i, v in ipairs(self.NextCardGo) do
		-- /***********清理别人未打出显示到桌面的牌****************/--
		if v ~= nil then
			print("清理玩家的手牌.....")
			v:Destroy()
		end
	end
	self.NextCardGo = { }
end 

function CatchPockRoom.OnSettleQuitGameReq()
	Game.MusicEffect(Game.Effect.buttonBack)
	Game.SendProtocal(Protocal.QuitMateRoom)
end 

-- --单局结算开始游戏
-- function CatchPockRoom.CatchSettlementStartGameRes(buffer)
--     local self = CatchPockRoom
--     local data   = buffer:ReadBuffer()
--     local msg    = CatchSettlementStartGame_pb.CatchSettlementStartGameRes()
--     msg:ParseFromString(data)
--     print("==================CatchSettlementStartGameRes==================")
--     local readyIndex = msg.alreadyIndex
--     local allStart   = msg.allStart
--     for i,v in ipairs(readyIndex) do
--         print("=====CatchSettlementStartGameRes=====:",readyIndex,v)
--         local curCache = self:GetPlayer(v)
--         curCache.imgOK:SetActive(true)
--         if v == self.myIndex then
--             CH_GameMainPanel.imgBtn:SetActive(false)
--             CH_GameMainPanel.btnBuChu:SetActive(true)
--             CH_GameMainPanel.btnChuPai:SetActive(true)
--             CH_GameMainCtrl.SetIconTips("没有牌大过上家",false)
--             CH_GameMainCtrl:SetText(self.btnObjList.btnTiShi.txt,"提  示")
--             CH_GameMainPanel.panel_SingleSettlement:SetActive(false)
--             self:NextGame()
--         end
--     end
--     CH_GameMainPanel.panel_WaitFriend:SetActive(false)
-- end

-- 下局清理
function CatchPockRoom:NextGame()
	self.curPopTips = { }
	self.btnCheck = 0
	for i, v in ipairs(self.players) do
		print("-------------------------", v.index, #v.popList)
		v.imgCard:SetActive(false)
		v.warning:SetActive(false)
		v.cardsCount = 16
		v.txtOverNum:SetActive(true)
		CH_GameMainCtrl:SetText(v.txtOverNum, "")
		v:PopType(0, 0)
		for j, k in ipairs(v.popList) do
			k:Destroy()
		end
		v.popList = { }
		if v.index == self.myIndex then
			for j, k in ipairs(v.cards) do
				k:Destroy()
			end
		end
		v.cards = { }
		v.soundOne = false
		v.soundTwo = false
	end
end

-- 总结算
function CatchPockRoom.CatchTotalSettlementRes(buffer)
	print("------------", buffer)
	local self = CatchPockRoom
	local data = buffer:ReadBuffer()
	local msg = CatchTotalSettlement_pb.CatchTotalSettlementRes()
	msg:ParseFromString(data)
	print("==================CatchTotalSettlementRes==================", msg.roomNum, msg.totalJushu)
	msg.totalJushu = self.allJushu
	TH_RoleInfoCtrl:Close()
	MessageTipsCtrl:Close()

	if DissolutionRoomCtrl.gameOver then
		CH_GameMainPanel.panel_SingleSettlement:SetActive(false)
		TH_TotalSettlementCtrl:Open("TH_TotalSettlement", function()
			-- 生成预制--
			resMgr:LoadPrefab('th_totalsettlement', { 'th_totalplayer' }, function(objs)
				TH_TotalSettlementCtrl:InitPanel(objs, msg)
			end )
		end )
	else
		CH_GameMainPanel.panel_SingleSettlement.transform:DOScale(Vector3.zero, 0.2):SetDelay(1):OnComplete(
		function()
			CH_GameMainPanel.panel_SingleSettlement:SetActive(false)
			TH_TotalSettlementCtrl:Open("TH_TotalSettlement", function()
				-- 生成预制--
				resMgr:LoadPrefab('th_totalsettlement', { 'th_totalplayer' }, function(objs)
					TH_TotalSettlementCtrl:InitPanel(objs, msg)
				end )
			end )
		end )
	end
end

-- 清理房间数据
function CatchPockRoom:ClearRoomInfo()
	for _, v in ipairs(self.players) do
		if v.obj ~= nil then
			v:Destroy()
		end
	end
	self.players = { }
end

-- 下一位
function CatchPockRoom:GoNextPlayer(index)
	index = index + 1
	if index > 3 then
		index = 1
	end
	if index == self.myIndex then
		self.btnCheck = 0
		CH_GameMainPanel.imgBtn:SetActive(true)
	else
		CH_GameMainPanel.imgBtn:SetActive(false)
	end
	self:BtnShow("btnChuPai", true)
	self:BtnShow("btnBuChu", true)
	-- 显示框
	self:KuangShow(index)
	-- 清理上一次出的牌
	local curCache = self:GetPlayer(index)
	print("-------------------------", curCache.index, #curCache.popList)
	for i, v in ipairs(curCache.popList) do
		v:Destroy()
	end
	curCache.popList = { }
	curCache:PopType(0, 0)
	CH_GameMainCtrl:CountDown(curCache.sitIndex)
end

-- 显示操作框
function CatchPockRoom:KuangShow(index, bool)
	local show = true
	if bool then
		show = false
	end
	for i, v in ipairs(self.players) do
		if v.index == index then
			v.imgCur:SetActive(show)
			local img = v.imgCur:GetComponent("Image")
			CH_GameMainCtrl:ChangeKuang(img, v.index)
		else
			v.imgCur:SetActive(not show)
		end
	end
end

function CatchPockRoom:ErrorCodeShow(code)
	self.btnCheck = 0
	if code == 1091 then
		CH_GameMainCtrl.SetIconTips("不符合出牌规则")
	elseif code == 1092 then
		CH_GameMainCtrl.SetIconTips("红桃3先出哦")
	elseif code == 1093 then
		CH_GameMainCtrl.SetIconTips("下家报单了,可不要放水哦")
	elseif code == 1094 then
		CH_GameMainCtrl.SetIconTips("最大不能连到2")
	elseif code == 1107 then
		CH_GameMainCtrl.SetIconTips("天炸送分啦,还在等什么")
	end
	CH_GameMainPanel.imgBtn:SetActive(true)
	print("-----------------!!!!!!!!-------------D2--", self.btnCheck)
end

-- 收到别人断线重连消息
function CatchPockRoom:OfflinePush(msg)
	if not CH_GameMainCtrl.isCreate then return end
	local roleId = msg.roleId
	-- 断线（重连）roleId
	local state = msg.state
	-- true=上线  false=离线
	print("========OfflinePush======", roleId, state)
	for i, v in ipairs(self.players) do
		if v.id == roleId then
			v.imgOffLine:SetActive(not state)
			break
		end
	end
end