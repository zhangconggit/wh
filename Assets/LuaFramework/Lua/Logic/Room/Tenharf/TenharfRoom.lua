TenharfRoom = {
	gameUI = nil,
	RoomMsg = { },
	moveFlag = false,
	rotateFlag = false,
	isAdd = false,
	curJushu = 1,
	totalJushu = 1,
	operateIndex = 0,
}
setbaseclass(TenharfRoom, { RoomObject })

-- 缓存
function TenharfRoom.SaveGameObj(objs, name)
	local self = TenharfRoom
	if self.loadObjList[name] then return end
	self.loadObjList[name] = objs[0]
	print("====SaveGameObj====:", self.loadObjList[name])
end

-- 加载
function TenharfRoom:LoadGameObj(objs)
	-- Game.MusicBG("bgm6")
	print("====LoadGameObj====")
	local GuiCamera = find('Canvas/GuiCamera')
	self.imgHead = BasePanel:GOChild(obj, "Mask/img")

	TenharfRoom.gameUI = newObject(objs)
	TenharfRoom.gameUI.transform:SetParent(GuiCamera.transform)
	TenharfRoom.gameUI.transform.localScale = Vector3.one
	TenharfRoom.gameUI.transform.localPosition = Vector3.zero
	local table = find("Canvas/GuiCamera/Game(Clone)/Table/TenHalfTable/imgTable")
	local tenHalfTable = find("Canvas/GuiCamera/Game(Clone)/Table/TenHalfTable")
	tenHalfTable:SetActive(true)
	self.playerPanel = find("Canvas/GuiCamera/Game(Clone)/Players")
	self.playerPanel:SetActive(false)
	self.txtWanFa = BasePanel:GOChild(table, "imgRoomMessageBG/txtWanFa")
	self.imgJuShu = BasePanel:GOChild(table, "imgJuShu")
	self.txtJuShu = BasePanel:GOChild(table, "imgRoomMessageBG/txtJuShu")
	self.txtRoomMessage = BasePanel:GOChild(table, "imgRoomMessageBG/txtRoomMessage")
	self.txtRoomNum = BasePanel:GOChild(table, "imgRoomMessageBG/txtRoomNum")
	self.txtMessage = BasePanel:GOChild(table, "imgRoomMessageBG/txtMessage")
	TH_GameMainCtrl:Open("TH_GameMain", function()
		for i = 1, 5 do
			local obj = self.playerPanel.transform:FindChild("TH_imgHead" .. i).gameObject
			obj:SetActive(false)
		end
		print("====LoadGameObj=111221212121238881TenharfRoom")
		self:ResourceCheckOver()
		print("====LoadGameObj====222222222TenharfRoom")
		local gamePanel = find("Canvas/GuiCamera/TH_GameMainPanel")
		gamePanel.transform:SetParent(self.playerPanel.transform)
		gamePanel.transform:SetSiblingIndex(7)
	end )
	print("====LoadGameObj====33333333333TenharfRoom")
	self.watchPlayers = { }
end

function TenharfRoom:InitPlayers()
	print("=============InitPlayers===", #self.players)
	--TH_GameMainPanel.imgHTGameMain:SetActive(true)
	for _, v in ipairs(self.players) do
		if v.obj ~= nil then
			v:Destroy()
		end
	end
	self.players = { }
	for i = 1, 5 do
		local obj = self.playerPanel.transform:FindChild("TH_imgHead" .. i).gameObject
		obj:SetActive(false)
	end

	for i = 1, self.playerCount do
		local obj = self.playerPanel.transform:FindChild("TH_imgHead" .. self:GetRoomIndexByIndex(i)).gameObject
		local playerObj = TenharfPlayer:New(self.playersData[i], obj)
		table.insert(self.players, playerObj)
		if self.myIndex ~= playerObj.index then
			TH_GameMainCtrl:RemoveClick(playerObj.imgHead)
			TH_GameMainCtrl:AddClick(playerObj.imgHead, TH_GameMainCtrl.OnClickHead)
		else
			if not self.isAdd then
				TH_GameMainCtrl:AddClick(playerObj.imgHead, TH_GameMainCtrl.OnClickHead)
				self.isAdd = true
			end
		end
		playerObj.obj:SetActive(true)
	end
	for i, v in ipairs(self.players) do
		v.obj:SetActive(true)
		TH_GameMainCtrl:SetText(v.txtName, v.name)
		TH_GameMainCtrl:SetText(v.txtScore, v.jifen)
		-- v.imgOK:SetActive(false)
		v.imgZhuang:SetActive(false)
		v.imgChat:SetActive(false)
		v.imgFaceIcon:SetActive(false)
		v.imgCardType:SetActive(false)
		v.imgBet:SetActive(false)
		v.imgCur:SetActive(false)
		v.imgDeng:SetActive(false)
		v.imgAnim:SetActive(false)
		v.imgYuanbao:SetActive(false)
		v.imgJinbi:SetActive(false)
		print('TenharfRoom:InitPlayers111111111', v.goldcoin, v.wing)
		if self.RoomMsg.moneyType == RoomMode.goldMode then
			v.imgJinbi:SetActive(true)
			TH_GameMainCtrl:SetText(v.txtScore, formatNumber(v.goldcoin))
		elseif self.RoomMsg.moneyType == RoomMode.wingMode then
			v.imgYuanbao:SetActive(true)
			TH_GameMainCtrl:SetText(v.txtScore, formatNumber(v.wing))
		end
	end
	if self.myIndex == 1 and #self.players > 1 then
		if self.RoomMsg.moneyType ~= 0 then
			TH_GameMainPanel.btnGameStart:SetActive(false)
		else
			TH_GameMainPanel.btnGameStart:SetActive(true)
			self:SetCurJushu(self.curJushu)
		end
	else
		TH_GameMainPanel.btnGameStart:SetActive(false)
	end
	self.playerPanel:SetActive(true)
	-- self.curJushu = 1
	if self.RoomMsg.moneyType == RoomMode.goldMode or self.RoomMsg.moneyType == RoomMode.wingMode then
		TH_GameMainCtrl:SetText(self.txtJuShu, "")
	else
		TH_GameMainCtrl:SetText(self.txtJuShu, '局数：--')
	end
	BlockLayerCtrl:CloseSpec()
	self.initPlayerEnd = true
	local quitPanel = TH_GameMainPanel.imgQuitTips
	local singlePanel = TH_GameMainPanel.imgHTSingleSettlement
	singlePanel.transform:SetParent(self.playerPanel.transform)
	singlePanel.transform:SetAsLastSibling()
	quitPanel.transform:SetParent(self.playerPanel.transform)
	quitPanel.transform:SetAsLastSibling()
	if Room.isStar then
		-- 如果在观战中显示观战
		TH_GameMainCtrl:SetText(self.txtRoomMessage, '观战中····')
	else
		if self.RoomMsg.moneyType == RoomMode.goldMode or self.RoomMsg.moneyType == RoomMode.wingMode then
			TH_GameMainCtrl:SetText(self.txtRoomMessage, '')
		end
	end
	self.canReceive = true
	-- 初始化的时候设置可以接收开始游戏消息
end

-- 发一轮牌
function TenharfRoom:DealCards(index)
	self.hasLoaded = false
	Room.btnStartClick = false
	TH_GameMainPanel.imgPublicCard:SetActive(true)
	-- 手牌张数，牌间距
	local k = index
	local state = TenHalfCardState.KouCard
	local num = #self.players
	local co = coroutine.start( function()
		for i = 1, num do
			k = k + 1
			if k > #self.players then
				k = 1
			end
			local flag = k
			print("--------->>", self.myIndex, k)
			self.players[flag]:GetPlayerCards(flag, { color = "" }, state)
			Game.MusicEffect(Game.Effect.thfapai)
			coroutine.wait(0.2)
		end
		-- 庄家的下一位显示分数面板
		if index >= num then
			index = 1
		else
			index = index + 1
		end
		TH_GameMainCtrl:FenShow(index == self.myIndex)
		self:KuangShow(index)
		self.hasLoaded = true
	end )
	table.insert(Network.crts, co)
	-- 新添加
	if self.RoomMsg.moneyType ~= 0 then
		TH_GameMainPanel.btnGameMainQuitRoom:SetActive(false)
		TH_GameMainPanel.imgHTWaitFriends:SetActive(false)
		TH_GameMainPanel.imgHTGameMain:SetActive(true)
	end
	if self.RoomMsg.moneyType == RoomMode.goldMode or self.RoomMsg.moneyType == RoomMode.wingMode then
		if TH_GameMainPanel.imgIsDangZhuang.activeSelf == true or TH_GameMainPanel.imgIsQiangZhuang.activeSelf == true then
			TH_GameMainPanel.imgIsDangZhuang:SetActive(false)
			TH_GameMainPanel.imgIsQiangZhuang:SetActive(false)
		end
	end
	print(">>>>>>>>>>>>>>发一轮牌")
end

-- 下一位
function TenharfRoom:GoNextPlayer(index)
	print("------------------------!!!1", index, self.operateIndex, self.myIndex, self.startGameZhuangIndex)
	if index ~= self.startGameZhuangIndex then
		self:ReSetOperate(0)
	end
	if self.operateIndex == self.startGameZhuangIndex and self.startGameZhuangIndex == self.myIndex then
		if self:IsSettlement() then
			self:KuangShow(self.operateIndex)
			return
		else
			self:KuangShow(self.operateIndex)
		end

	else
		self:KuangShow(self.operateIndex)
		TH_GameMainCtrl:FenShow(self.operateIndex == self.myIndex and self.startGameZhuangIndex ~= self.operateIndex)
	end
	self.isBuCardEnd = true
	print("------------------------!!!2", index, self.operateIndex, self.myIndex, self.startGameZhuangIndex)
end

-- 设置玩家手牌显示
function TenharfRoom:SetPlayerCards(index, card, cardType, over)
	local state = TenHalfCardState.KouCard
	local nextPlayer = false
	if cardType == 0 or cardType == 2 then
		state = TenHalfCardState.FanKaiCard
	elseif cardType == 1 then
		state = TenHalfCardState.BaoCard
		nextPlayer = true
	else
		state = TenHalfCardState.FanKaiCard
		nextPlayer = true
	end
	if over then
		self:GetPlayer(index):GetPlayerCards(index, card, state, over)
		self:ShowEffect(index, cardType, over)
	else
		self:GetPlayer(index):GetPlayerCards(index, card, state)
		self:ShowEffect(index, cardType, over)
		if nextPlayer then
			self:GoNextPlayer(index)
		end
	end
end

-- 根据牌型显示效果
function TenharfRoom:ShowEffect(index, cardType, over)
	local types = ""
	if cardType == 1 then
		types = "BAOPAI"
		self:GetPlayer(index).cardFlag = true
	elseif cardType == 3 then
		types = "SHIDIANBAN"
	elseif cardType == 4 then
		types = "WULEI"
	elseif cardType == 5 then
		types = "WUHUALEI"
	elseif cardType == 6 then
		types = "SHIDIANBANLEI"
	end
	if cardType ~= 0 and cardType ~= 2 then
		TH_GameMainCtrl.SetIconTips("小于5不停牌", false)
	end
	-- print("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!",TenharfRoom.voice)
	if not self.notVoice then
		if cardType == 1 or cardType == 2 then
			Game.MusicEffect(Game.Effect.thboom)
		elseif cardType == 3 then
			Game.MusicEffect(Game.Effect.thwulei)
		elseif cardType == 4 then
			Game.MusicEffect(Game.Effect.thwulei)
		elseif cardType == 5 then
			Game.MusicEffect(Game.Effect.thwulei)
		elseif cardType == 6 then
			Game.MusicEffect(Game.Effect.thwulei)
		end
	end
	if types ~= "" then
		self:GetPlayer(index):CardType(index, types, over)
	end
end

-- 转盘
function TenharfRoom:IconMove(zhuang, cards)
	local num = #self.players
	local k = 0
	local co = coroutine.start( function()
		TH_GameMainCtrl.SetIconTips("正在随机选庄", true)
		for i = 1, num * 2 + zhuang do
			k = k + 1
			if k > #self.players then
				k = 1
			end
			local flag = k
			local obj = self:GetPlayer(flag).imgDeng
			obj:SetActive(true)
			coroutine.wait(0.1)
			if i < num * 2 + zhuang then
				obj:SetActive(false)
			end
			coroutine.wait(0.15)
		end
		local deng = self:GetPlayer(zhuang)
		deng.imgZhuang:SetActive(true)
		-- self:GetPlayer(zhuang).imgZhuang:SetActive(true) --转圈完成后显示庄的图片
		-- coroutine.wait(1)
		-- if not self:GetPlayer(zhuang).imgZhuang.activeSelf then
		--    self:GetPlayer(zhuang).imgZhuang:SetActive(true)
		--    print("*************deng***************")
		--    print("**************zhuang**************",zhuang)
		--    print("****************************")
		-- end

		coroutine.wait(1)
		self:GetPlayer(zhuang).imgDeng:SetActive(false)
		cards:SetActive(true)
		TH_GameMainCtrl.SetIconTips("正在随机选庄", false)
		coroutine.wait(0.5)
		self:DealCards(zhuang)
	end )
	table.insert(Network.crts, co)
end

-- 重置当前索引位
function TenharfRoom:ReSetOperate(index)
	local curIndex = 0
	if index == 0 then
		curIndex = self.operateIndex + 1
	else
		curIndex = index
	end
	if curIndex > #self.players then
		curIndex = 1
	end
	self.operateIndex = curIndex
end

-- 显示操作框
function TenharfRoom:KuangShow(index, bool)
	local show = true
	if bool then
		show = false
	end
	for i, v in ipairs(self.players) do
		if v.index == index then
			v.imgCur:SetActive(show)
			local img = v.imgCur:GetComponent("Image")
			TH_GameMainCtrl:ChangeKuang(img, v.index)
		else
			v.imgCur:SetActive(not show)
		end
	end
end

function TenharfRoom:Reload(data)
	print("---------TenhalfReload------")
	-- 房间
	self.notVoice = true
	self.hasLoaded = false
	self.initPlayerEnd = false
	local roomVo = RoomTenHalfVo:New()
	roomVo.id = data.roomNum
	roomVo.tenHalfTotal = data.everyJushu
	roomVo.isTen2 = data.tenHalfRateDouble and 1 or 0
	roomVo.isFive3 = data.fiveRateThree and 1 or 0
	roomVo.isFive5 = data.fiveHuaRateFive and 1 or 0
	roomVo.isTen5 = data.tenHalfLeiRateFive and 1 or 0
	roomVo.isWang = data.king and 1 or 0
	roomVo.isMaster = data.leaderZhuang and 1 or 0
	-- 添加
	roomVo.baseNum = data.baseNum
	roomVo.qualified = data.qualified
	roomVo.moneyType = data.moneyType

	-- data.zhuang
	self.RoomMsg = roomVo
	-- 玩家
	self.playersData = { }
	self.players = { }
	self.watchPlayers = { }
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
	self.startGameZhuangIndex = data.zhuang

	-- 玩家的牌
	local co = coroutine.start( function()
		while not self.isPrefabLoaded do
			coroutine.step()
		end

		self:InitPlayers()
		self.curJushu = data.alreadyJuShu
		print("__++++++++++++++++++++", #self.players)
		TH_GameMainCtrl.OnStartGameInfoShow(self.curJushu .. '/' ..(self.playerCount * data.everyJushu))

		local cards, betCount
		for i, role in ipairs(data.roles) do
			local spInfo = ReLoad_pb.TenhalfRoleSpInfo()
			spInfo:ParseFromString(role.spInfoRes)

			self:SetPlayerCards(i, spInfo.roleCard, spInfo.result, true)
			if self.startGameZhuangIndex ~= i then
				self:SetPlayerBet(i, spInfo.betCount)
			end
			if i == self.myIndex then
				betCount = spInfo.betCount
				cards = spInfo.roleCard
			end
		end
		if self.RoomMsg.moneyType ~= 0 then
			TH_GameMainPanel.btnGameMainQuitRoom:SetActive(false)
			TH_GameMainPanel.imgHTWaitFriends:SetActive(false)
			TH_GameMainPanel.imgHTGameMain:SetActive(true)
		end
		TH_GameMainPanel.imgHTWaitFriends:SetActive(false)
		if self.startGameZhuangIndex > 0 then
			self:GetPlayer(self.startGameZhuangIndex).imgZhuang:SetActive(true)
		else
			-- 还没庄的时候要开始抢庄
			if data.zhuangFlag then
				TH_GameMainPanel.imgIsDangZhuang:SetActive(true)
			end
		end

		-- 当自己操作的时候，判断是下注还是补牌
		if self.myIndex == data.curIndex then
			if betCount == 0 and self.startGameZhuangIndex ~= self.myIndex then
				TH_GameMainCtrl:FenShow(true)
			else
				self:ShowCardNum(cards)
			end
		end
		if data.curIndex ~= 0 then
			self:ReSetOperate(data.curIndex)
			self:KuangShow(data.curIndex)
		end
		self.notVoice = false
		self.hasLoaded = true
		if self.RoomMsg.moneyType ~= 0 then
			TH_GameMainPanel.btnGameMainQuitRoom:SetActive(false)
		end
		if self.RoomMsg.moneyType == RoomMode.roomCardMode then
			Room:SetGps(data.roles)
		end
	end )
	table.insert(Network.crts, co)
end

-- 收到服务器开始游戏
function TenharfRoom.OnTenHalfStartGameRes(buffer)
	TH_GameMainPanel.btnWaitQuitRoom:SetActive(false) --亮色
	TH_GameMainPanel.imgNotWaitQuitRoom:SetActive(true) --灰色
	local self = TenharfRoom
	if self.canReceive == true then
		self.canReceive = false
		-- 设置只能接收一次此消息
		local data = buffer:ReadBuffer()
		local msg = TenHalfStartGame_pb.TenHalfStartGameRes()
		msg:ParseFromString(data)
		self.startGame = true
		self.singleSettlementStart = false
		local zhuangIndex = msg.zhuangIndex
		self.curJushu = msg.currJushu
		self.totalJushu = msg.totalJushu
		print("-- -- 收到服务器开始游戏", self.curJushu)
		self:SetCurJushu(self.curJushu)
		self.startGameZhuangIndex = zhuangIndex
		local isSuijiZhuang
		if TenharfRoom.RoomMsg.isMaster == 0 then
			isSuijiZhuang = true
		elseif TenharfRoom.RoomMsg.isMaster == 1 then
			isSuijiZhuang = false
		end
		for i, v in ipairs(self.players) do
			v.imgOK:SetActive(false)
			-- 游戏开始的时候隐藏准备图片
		end
		local co = coroutine.start( function()
			while self.resCount < self.needResCount do
				coroutine.step()
			end
			TH_GameMainCtrl:PlayGame(zhuangIndex, isSuijiZhuang)
			-- 调用随机庄的方法
			self:ReSetOperate(zhuangIndex + 1)
		end )
		table.insert(Network.crts, co)
		TH_GameMainCtrl:DisableClock()
	end
	self:NextGameStart()
end

-- 下注
function TenharfRoom.OnTenHalfBetRes(buffer)
	local self = TenharfRoom
	local data = buffer:ReadBuffer()
	local msg = TenHalfBet_pb.TenHalfBetRes()
	msg:ParseFromString(data)
	local roleIndex = msg.roleIndex
	local betConut = msg.betConut
	self:SetPlayerBet(roleIndex, betConut)
end

-- 筹码显示
function TenharfRoom:SetPlayerBet(index, betConut)
	-- print("SetPlayerBet",index,betConut)
	local sprite = nil
	if betConut == 2 then
		sprite = TH_GameMainPanel.btn2Fen:GetComponent("Image").sprite
	elseif betConut == 3 then
		sprite = TH_GameMainPanel.btn3Fen:GetComponent("Image").sprite
	elseif betConut == 4 then
		sprite = TH_GameMainPanel.btn4Fen:GetComponent("Image").sprite
	elseif betConut == 5 then
		if TH_GameMainPanel.btn5FenD.activeSelf then
			sprite = TH_GameMainPanel.btn5FenD:GetComponent("Image").sprite
		elseif TH_GameMainPanel.btn5FenG.activeSelf then
			sprite = TH_GameMainPanel.btn5FenG:GetComponent("Image").sprite
		end
	elseif betConut == 8 then
		sprite = TH_GameMainPanel.btn8Fen:GetComponent("Image").sprite
	elseif betConut == 10 then
		sprite = TH_GameMainPanel.btn10Fen:GetComponent("Image").sprite
	elseif betConut == 15 then
		sprite = TH_GameMainPanel.btn15Fen:GetComponent("Image").sprite
	end
	self:GetPlayer(index):BetShow(sprite)
	TH_GameMainPanel.imgFenShu:SetActive(false)
	TH_GameMainPanel.imgFenShu2:SetActive(false)
end

-- 判断除自己外是不是都结算了
function TenharfRoom:IsSettlement()
	local jiesuan = false
	for i, v in ipairs(self.players) do
		if v.index ~= self.startGameZhuangIndex then
			if not self:GetPlayer(v.index).cardFlag then
				jiesuan = false
				break
			else
				jiesuan = true
			end
		end
	end
	return jiesuan
end

-- 显示补牌按钮
function TenharfRoom:ShowCardNum(cards)
	print("=============TenharfRoom:ShowCardNum===", self:IsSettlement())
	if self:IsSettlement() then return end
	local num = 0
	for i, v in ipairs(cards) do
		if v.num == nil then return end
		if v.num == 14 then
			v.num = 1
		elseif v.num > 10 and v.num < 17 then
			v.num = 0.5
		end
		num = num + v.num
	end
	if num <= 5 then
		TH_GameMainCtrl.SetIconTips("小于5不停牌", true)
		TH_GameMainPanel.imgIsBuPai:SetActive(true)
		TH_GameMainPanel.btnBuBuPai:SetActive(false)
		if #self:GetPlayer(self.myIndex).cards == 5 then
			TH_GameMainCtrl.SetIconTips("小于5不停牌", false)
		end
	else
		TH_GameMainCtrl.SetIconTips("小于5不停牌", false)
		TH_GameMainPanel.imgIsBuPai:SetActive(true)
		TH_GameMainPanel.btnBuBuPai:SetActive(true)
	end
end

-- 翻牌
function TenharfRoom.OnTenHalfTurnRes(buffer)
	print("=============TenharfRoom.OnTenHalfTurnRes===")
	local self = TenharfRoom
	local data = buffer:ReadBuffer()
	local msg = TenHalfTurn_pb.TenHalfTurnRes()
	msg:ParseFromString(data)
	local roleIndex = msg.roleIndex
	local playerCards = self:GetPlayer(roleIndex).cards
	local isRepead = false
	for i, v in ipairs(msg.cardInfo) do
		if playerCards[i].id == v.id then
			isRepead = true
		end
	end

	if not isRepead then
		self:GetPlayer(roleIndex):TurnCard(msg.cardInfo, roleIndex, TenHalfCardState.FanKaiCard)
	end
end

-- 补牌返回信息
function TenharfRoom.OnTenHalfBuCardRes(buffer)
	local self = TenharfRoom
	self.isBuCardEnd = false
	local data = buffer:ReadBuffer()
	local msg = TenHalfBuCard_pb.TenHalfBuCardRes()
	msg:ParseFromString(data)
	local roleIndex = msg.roleIndex
	local cardType = msg.cardType
	local isBuCard = msg.isBuCard
	local cardInfo = msg.cardInfo
	local over = false
	print("OnTenHalfBuCardRes===========", isBuCard, cardType, roleIndex, self.startGameZhuangIndex, self.myIndex)
	if isBuCard then
		self:SetPlayerCards(roleIndex, cardInfo, cardType, false)
	else
		if cardType == 0 or cardType == 2 then
			soundMgr:PlayTalkSound(global.systemVo.CardSource, "ptaudiocard", "g_guopai")
		end
		if self.startGameZhuangIndex == self.myIndex and roleIndex == self.myIndex then
			self.startGameZhuangIndex = 0
			self.settlementStartGameLeaderIndex = 0
			-- TH_GameMainPanel.imgFenShu:SetActive(false)
			-- TH_GameMainPanel.imgIsBuPai:SetActive(false)
		else
			self:GoNextPlayer(roleIndex)
		end
		TH_GameMainPanel.imgIsBuPai:SetActive(false)
		TH_GameMainPanel.btnBuBuPai:SetActive(false)
		-- 如果不补隐藏
		------------------------------------------------------------
	end
end

function TenharfRoom:OpenAll(info)
	print("=============TenharfRoom.OpenAll===")
	local state = TenHalfCardState.FanKaiCard
	for i, v in ipairs(info) do
		if v.cardType == 0 or v.cardType == 2 then
			state = TenHalfCardState.FanKaiCard
		elseif v.cardType == 1 then
			state = TenHalfCardState.BaoCard
		else
			state = TenHalfCardState.FanKaiCard
		end
		self:GetPlayer(v.roleIndex):CreateListCards(v.roleIndex, v.cardInfo, state)
		-- self:ShowEffect(v.roleIndex,v.cardType,false)
	end
end

-- 比牌
function TenharfRoom.OnTenHalfVSCardRes(buffer)
	print("=============TenharfhRoom.OnTenHalfVSCardRes===")
	-- TH_GameMainPanel.imgFenShu:SetActive(false)
	local data = buffer:ReadBuffer()
	local msg = TenHalfVSCard_pb.TenHalfVSCardRes()
	msg:ParseFromString(data)

	TH_GameMainCtrl:FenShow(false)
	TH_GameMainPanel.imgPublicCard:SetActive(false)
	TH_GameMainPanel.imgIsBuPai:SetActive(false)
end

-- 每局结算
function TenharfRoom.OnTenHalfSingleSettlementRes(buffer)
	print("******************好迷啊***********************")
	local self = TenharfRoom
	self.canReceive = true
	-- 每局结算的时候设定可以接收发牌的消息
	self.singleSettlementStart = true
	print("=============TenharfRoom.OnTenHalfSingleSettlementRes===111", self.singleSettlementStart)
	local data = buffer:ReadBuffer()
	local msg = TenHalfSingleSettlement_pb.TenHalfSingleSettlementRes()
	msg:ParseFromString(data)
	local totalJushu = self.playerCount * TenharfRoom.RoomMsg.tenHalfTotal
	if DissolutionRoomCtrl.gameOver then
		TH_GameMainPanel.btnSettleStartGame:SetActive(false)
	end
	if self.curJushu == totalJushu then
		TH_GameMainPanel.btnSettleStartGame:SetActive(false)
	end
	print("******************self.RoomMsg.moneyType***********************",self.RoomMsg.moneyType)
	if self.RoomMsg.moneyType ~= 0 then --0房卡，1金币2元宝
		TH_GameMainPanel.imgHTWaitFriends:SetActive(true)
		-- TH_GameMainPanel.btnChat:SetActive(false)
		TH_GameMainPanel.btnSettleQuitGame:SetActive(true)
		self:NextGameStart()
		
	end
    print("******************有点看不懂啊***********************")
	TH_GameMainPanel.imgIsBuPai:SetActive(false)
	TH_GameMainCtrl:FenShow(false)
	TH_GameMainPanel.imgPublicCard:SetActive(false)
	TH_GameMainCtrl.SetIconTips("小于5不停牌", false)
	if DissolutionRoomCtrl.gameOver then return end
	local co = coroutine.start( function()
		self:OpenAll(msg.settlementInfo)
		coroutine.wait(1.5)

		-- 玩家积分赋值
		for i, v in ipairs(msg.settlementInfo) do
			local player = self:GetPlayer(v.roleIndex)
			if self.RoomMsg.moneyType == RoomMode.goldMode then
				player.jifen = formatNumber(player.goldcoin + v.curJiFen)
			elseif self.RoomMsg.moneyType == RoomMode.wingMode then
				player.jifen = formatNumber(player.wing + v.curJiFen)
			else
				player.jifen = v.jiFen
			end
			-- player.jifen = v.jiFen
			TH_GameMainCtrl:SetText(player.txtScore, player.jifen)
			print("OnTenHalfSingleSettlementRes==========", v.roleIndex, v.jiFen, v.curJiFen, self.myIndex, self:GetPlayer(v.roleIndex).cardFlag)
			if v.roleIndex == self.myIndex then
				if v.curJiFen > 0 then
					Game.MusicEffect(Game.Effect.shengli)
					TH_GameMainPanel.imgSettlementLost:SetActive(false)
					TH_GameMainPanel.imgSettlementWin:SetActive(true)
					TH_GameMainPanel.imgSettlementWin.transform.localScale = Vector3.zero
					self:DoScale(TH_GameMainPanel.imgSettlementWin)
				else
					Game.MusicEffect(Game.Effect.shibai)
					TH_GameMainPanel.imgSettlementWin:SetActive(false)
					TH_GameMainPanel.imgSettlementLost:SetActive(true)
					TH_GameMainPanel.imgSettlementLost.transform.localScale = Vector3.zero
					self:DoScale(TH_GameMainPanel.imgSettlementLost)
				end
				TH_GameMainCtrl:NumberShow(v.curJiFen)
			end
		end
		TH_GameMainPanel.imgHTSingleSettlement:SetActive(true)
	end )
	table.insert(Network.crts, co)
	TH_GameMainPanel.btnWaitQuitRoom:SetActive(true) --亮色
	TH_GameMainPanel.imgNotWaitQuitRoom:SetActive(false) --灰色
end

-- 每局结算之后开始游戏
function TenharfRoom.OnTenHalfSettlementStartGameRes(buffer)
	local self = TenharfRoom
	local data = buffer:ReadBuffer()
	local msg = TenHalfSettlementStartGame_pb.TenHalfSettlementStartGameRes()
	msg:ParseFromString(data)
	local roleIndex = msg.roleIndex
	-- 谁点了开始
	local leaderIndex = msg.leaderIndex
	-- 庄索引
	local readyList = msg.alreadyIndex
	-- 点了准备的玩家索引
	self.startGameZhuangIndex = leaderIndex
	self.curJushu = msg.currJushu
	print("-- 每局结算之后开始游戏-- 每局结算之后开始游戏", msg.currJushu)
	local allStart = msg.allStart
	-- true为所有人都点了开始
	if self.RoomMsg.moneyType ~= 0 then
		if self.hasLoaded then return end
	end
	if roleIndex == self.myIndex then
		TH_GameMainPanel.imgHTSingleSettlement:SetActive(false)
		TH_GameMainPanel.imgIsBuPai:SetActive(false)
		TH_GameMainCtrl:FenShow(false)
	end
	for i, v in ipairs(readyList) do
		self:GetPlayer(v).imgOK:SetActive(true)
	end
	self.singleSettlementStart = false
	if allStart then
		self:SetCurJushu(self.curJushu)

		if leaderIndex == self.myIndex then
			TH_GameMainPanel.imgIsDangZhuang:SetActive(true)
		else
			TH_GameMainCtrl.SetIconTips("等待其他人当庄", true)
		end
		self:NextGameStart()
		self:ReSetOperate(leaderIndex + 1)
		-- self:DealCards(curIndex)
	end
	print("NextGameStart", #self.players, allStart)
end

-- 确认按钮返回
function TenharfRoom.TenharfSureRes(buffer)
	local self = TenharfRoom
	if self.RoomMsg.moneyType == 0 then return end
	local data = buffer:ReadBuffer()
	local msg = TenHalfSettlementStartGame_pb.TenHalfSettlementStartGameRes()
	msg:ParseFromString(data)
	local readyList = msg.alreadyIndex
	-- 点了准备的玩家的索引
	local allStart = msg.allStart
	for k, v in pairs(readyList) do
		local curCache = self:GetPlayer(v)
		if curCache ~= nil then
			curCache.isReady = true
			if curCache.imgOK.activeSelf == false then
				curCache.imgOK:SetActive(true)
			end
			if v == self.myIndex then
				TH_GameMainPanel.btnPrepareButton:SetActive(false)
			else
			end
			if self:GetPlayer(v) ~= nil then
				self:GetPlayer(v).imgOK:SetActive(true)
			end
		end
	end
	if allStart then
		self:OnReadyGame()
		self:NextGameStart()
	end
end

function TenharfRoom:SetCurJushu(curJushu)
	local self = TenharfRoom
	if self.RoomMsg.moneyType == RoomMode.roomCardMode then
		print('局数：' .. curJushu .. '/' .. self.totalJushu .. '局')
		if self.txtJuShu.activeSelf == false then
			self.txtJuShu:SetActive(true)
		end
		TH_GameMainCtrl:SetText(self.txtJuShu, '局数：' .. curJushu .. '/' .. self.totalJushu .. '局')
	else
		if self.txtJuShu.activeSelf then
			self.txtJuShu:SetActive(false)
		end
	end
end

-- 初始化
function TenharfRoom:NextGameStart()
	self.operateIndex = 0
	for i, v in ipairs(self.players) do
		v.obj:SetActive(true)
		v.imgOK:SetActive(false)
		v.imgZhuang:SetActive(false)
		v.imgChat:SetActive(false)
		v.imgFaceIcon:SetActive(false)
		v.imgCardType:SetActive(false)
		v.imgBet:SetActive(false)
		v.imgCur:SetActive(false)
		v.cardFlag = false
		for i, v in ipairs(v.cards) do
			v:Destroy()
		end
		v.cards = { }
	end
	print("===================>>>>>NextGameStart", #self.players)
end

-- 抢庄Res
function TenharfRoom.OnTenHalfIsQiangBankerRes(buffer)
	local self = TenharfRoom
	local data = buffer:ReadBuffer()
	local msg = TenHalfIsQiangBanker_pb.TenHalfIsQiangBankerRes()
	msg:ParseFromString(data)
	local zhuangIndex = msg.zhuangIndex
	-- 最终的庄索引
	-- TH_GameMainPanel.imgIsQiangZhuang:SetActive(false)
	self:GetPlayer(zhuangIndex).imgZhuang:SetActive(true)
	self:DealCards(zhuangIndex)
	self.startGameZhuangIndex = zhuangIndex
	self:ReSetOperate(zhuangIndex + 1)
	-- print("===========QiangBankerRes|--:",TenharfRoom.myIndex,zhuangIndex)
	TH_GameMainCtrl.SetIconTips("等待其他人抢庄", false)
	print(">>>>>>>>>>抢庄>>>>>>>>>>>>")
end

-- 当庄
function TenharfRoom.OnTenHalfIsBankerRes(buffer)
	local self = TenharfRoom
	local data = buffer:ReadBuffer()
	local msg = TenHalfIsBanker_pb.TenHalfIsBankerRes()
	msg:ParseFromString(data)
	local isBanker = msg.isBanker
	-- 是否当庄
	local zhuangIndex = msg.zhuangIndex
	-- 庄索引
	-- TH_GameMainPanel.imgIsDangZhuang:SetActive(false)
	self.startGameZhuangIndex = zhuangIndex
	if isBanker then
		self:GetPlayer(zhuangIndex).imgZhuang:SetActive(true)
		self:DealCards(zhuangIndex)
		self:ReSetOperate(zhuangIndex + 1)
		TH_GameMainCtrl.SetIconTips("等待其他人当庄", false)
	else
		if zhuangIndex ~= self.myIndex then
			TH_GameMainPanel.imgIsQiangZhuang:SetActive(true)
			self:NextGameStart()
			TH_GameMainCtrl.SetIconTips("等待其他人当庄", false)
		else
			TH_GameMainCtrl.SetIconTips("等待其他人抢庄", true)
		end
	end
	print(">>>>>>>>>>当庄>>>>>>>>>>>>")
end

-- 总结算
function TenharfRoom.OnTenHalfTotalSettlementRes(buffer)
	local self = TenharfRoom
	local data = buffer:ReadBuffer()
	local msg = TenHalfTotalSettlement_pb.TenHalfTotalSettlementRes()
	msg:ParseFromString(data)
	TH_RoleInfoCtrl:Close()
	TH_GameMainPanel.imgHTSingleSettlement:SetActive(false)
	if DissolutionRoomCtrl.gameOver then
		TH_TotalSettlementCtrl:Open("TH_TotalSettlement", function()
			-- 生成预制--
			resMgr:LoadPrefab('th_totalsettlement', { 'th_totalplayer' }, function(objs)
				TH_TotalSettlementCtrl:InitPanel(objs, msg)
			end )
		end )
	else
		TH_GameMainPanel.imgHTSingleSettlement.transform:DOScale(Vector3.zero, 0.2):SetDelay(3):OnComplete(
		function()
			TH_TotalSettlementCtrl:Open("TH_TotalSettlement", function()
				-- 生成预制--
				resMgr:LoadPrefab('th_totalsettlement', { 'th_totalplayer' }, function(objs)
					TH_TotalSettlementCtrl:InitPanel(objs, msg)
				end )
			end )
		end )
	end
end

-- 下注
function TenharfRoom.TenHalfBetReq(info)
	local data = TenHalfBet_pb.TenHalfBetReq()
	data.betConut = info
	local msg = data:SerializeToString()
	Game.SendProtocal(Protocal.TenHalfBet, msg)
	TH_GameMainCtrl:FenShow(false)
end

-- 补牌
function TenharfRoom.TenHalfBuCardReq(info)
	local data = TenHalfBuCard_pb.TenHalfBuCardReq()
	data.isBuCard = info
	local msg = data:SerializeToString()
	Game.SendProtocal(Protocal.TenHalfBuCard, msg)
	TH_GameMainPanel.imgIsBuPai:SetActive(false)
end

-- 抢庄
function TenharfRoom.TenHalfIsQiangBankerReq(info)
	TH_GameMainCtrl.SetIconTips("等待其他人抢庄", true)
	local data = TenHalfIsQiangBanker_pb.TenHalfIsQiangBankerReq()
	data.isQiangBanker = info
	local msg = data:SerializeToString()
	Game.SendProtocal(Protocal.TenHalfIsQiangBanker, msg)
	-- print("===========QiangZhuangREQ|--:",TenharfRoom.myIndex,info)
	TH_GameMainPanel.imgIsQiangZhuang:SetActive(false)
end

-- 当庄
function TenharfRoom.TenHalfIsBankerReq(info)
	local data = TenHalfIsBanker_pb.TenHalfIsBankerReq()
	data.isBanker = info
	local msg = data:SerializeToString()
	Game.SendProtocal(Protocal.TenHalfIsBanker, msg)
	-- print("===========DangZHUangREQ|--:",TenharfRoom.myIndex,info)
	TH_GameMainPanel.imgIsDangZhuang:SetActive(false)
end

-- 收到别人断线重连消息
function TenharfRoom:OfflinePush(msg)
	if not TH_GameMainCtrl.isCreate then return end
	local roleId = msg.roleId
	-- 断线（重连）roleId
	local state = msg.state
	-- true=上线  false=离线
	for i, v in ipairs(self.players) do
		if v.id == roleId then
			v.imgOffLine:SetActive(not state)
			break
		end
	end
end

-- 清理房间数据
function TenharfRoom:ClearRoomInfo()
	for _, v in ipairs(self.players) do
		if v.obj ~= nil then
			v:Destroy()
		end
	end
	self.players = { }
end

-- 清理观战玩家数据
function TenharfRoom:ClaernWatchPlayer()
	for _, v in ipairs(self.watchPlayers) do
		if v.obj ~= nil then
			v:ClearnImgLayer()
			v.obj:SetActive(false)
			-- v.ClearnData()
		end
	end
	self.watchPlayers = { }
end

-- 生成观战玩家数据
function TenharfRoom:CreateWatchPlayer(data)
	print("---------CreateWatchPlayer----------", #data, self:GetRoomIndexByIndex(data[1].index))
	for i, v in ipairs(data) do
		local obj = self.playerPanel.transform:FindChild("TH_imgHead" .. self:GetRoomIndexByIndex(v.index)).gameObject

		local playerObj = TenharfPlayer:New(v, obj)
		table.insert(self.watchPlayers, playerObj)
		if self.myIndex ~= playerObj.index then
			TH_GameMainCtrl:RemoveClick(playerObj.imgHead)
			TH_GameMainCtrl:AddClick(playerObj.imgHead, TH_GameMainCtrl.OnClickHead)
		else
			if not self.isAdd then
				print("---------TH_GameMainCtrl----------", TH_GameMainPanel.btnBuHuan.name)
				TH_GameMainCtrl:AddClick(playerObj.imgHead, TH_GameMainCtrl.OnClickHead)
				self.isAdd = true
			end
		end
		playerObj.obj:SetActive(true)
	end
	for i, v in ipairs(self.watchPlayers) do
		v.obj:SetActive(true)
		TH_GameMainCtrl:SetText(v.txtName, v.name)
		TH_GameMainCtrl:SetText(v.txtScore, v.jifen)
		v.imgOK:SetActive(false)
		v.imgZhuang:SetActive(false)
		v.imgChat:SetActive(false)
		v.imgFaceIcon:SetActive(false)
		v.imgCardType:SetActive(false)
		v.imgBet:SetActive(false)
		v.imgCur:SetActive(false)
		v.imgDeng:SetActive(false)
		v.imgAnim:SetActive(false)
		v.imgYuanbao:SetActive(false)
		v.imgJinbi:SetActive(false)
		v.imgOffLine:SetActive(false)
		if self.RoomMsg.moneyType == RoomMode.goldMode then
			v.imgJinbi:SetActive(true)
			TH_GameMainCtrl:SetText(v.txtScore, formatNumber(v.goldcoin))
		elseif self.RoomMsg.moneyType == RoomMode.wingMode then
			v.imgYuanbao:SetActive(true)
			TH_GameMainCtrl:SetText(v.txtScore, formatNumber(v.wing))
		end
	end
end